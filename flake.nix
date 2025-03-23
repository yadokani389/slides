{
  description = "My slides";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    typix = {
      url = "github:loqusion/typix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    typst-packages = {
      url = "github:typst/packages";
      flake = false;
    };
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    git-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      imports = with inputs; [
        git-hooks.flakeModule
        treefmt-nix.flakeModule
      ];

      perSystem =
        {
          config,
          pkgs,
          lib,
          system,
          ...
        }:
        let
          typixLib = inputs.typix.lib.${system};

          typstPackagesSrc = pkgs.symlinkJoin {
            name = "typst-packages-src";
            paths = [
              "${inputs.typst-packages}/packages"
            ];
          };

          typstPackagesCache = pkgs.stdenvNoCC.mkDerivation {
            name = "typst-packages-cache";
            src = typstPackagesSrc;
            dontBuild = true;
            installPhase = ''
              mkdir -p "$out/typst/packages"
              cp -LR --reflink=auto --no-preserve=mode -t "$out/typst/packages" "$src"/*
            '';
          };

          commonArgs = {
            typstSource = "main.typ";

            fontPaths = [
              "${pkgs.ipaexfont}/share/fonts/opentype"
            ];
          };

          build-drv =
            src:
            typixLib.buildTypstProject (
              commonArgs
              // {
                src = typixLib.cleanTypstSource src;
                virtualPaths = [ src ];
                env = lib.optionalAttrs pkgs.stdenv.hostPlatform.isLinux {
                  XDG_CACHE_HOME = typstPackagesCache;
                };
                preBuild = lib.optionalString pkgs.stdenv.hostPlatform.isDarwin ''
                  export HOME=$TMPDIR
                  mkdir -p $HOME/Library/Caches
                  cp -r ${typstPackagesCache}/typst $HOME/Library/Caches
                '';
              }
            );
        in
        {
          legacyPackages = {
            k-sec-lt = build-drv ./contents/k-sec-lt;
          };

          packages.default = pkgs.runCommandNoCCLocal "slides" { } ''
            mkdir -p $out/k-sec-lt
            cp ${config.legacyPackages.k-sec-lt} $out/k-sec-lt/main.pdf
            echo '<embed src="./main.pdf" width="100%" height="100%" type="application/pdf">' > $out/k-sec-lt/index.html
          '';

          devShells.default = typixLib.devShell {
            inherit (commonArgs) fontPaths;
            packages = [
              pkgs.pympress
            ];
            shellHook = config.pre-commit.installationScript;
          };

          pre-commit = {
            check.enable = true;
            settings = {
              src = ./.;
              hooks = {
                actionlint.enable = true;
                treefmt.enable = true;
                typos = {
                  enable = true;
                  excludes = [
                    ".svg$"
                  ];
                  settings.ignored-words = [
                    "typ"
                  ];
                };
              };
            };
          };

          treefmt = {
            projectRootFile = "flake.nix";
            programs = {
              nixfmt.enable = true;
            };
            settings.formatter = {
              typstyle = {
                command = "${lib.getExe pkgs.typstyle}";
                includes = [ "*.typ" ];
              };
            };
          };
        };
    };
}
