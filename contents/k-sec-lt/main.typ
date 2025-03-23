#import "@preview/touying:0.6.1": *
#import themes.metropolis: *

#show: metropolis-theme.with(
  aspect-ratio: "16-9",
  config-common(show-notes-on-second-screen: right),
  config-colors(secondary: rgb("#1fabd4ff")),
  config-info(
    title: [トップオブトップス交流会],
    author: [吉田宗司],
    date: [2025-03-26],
    institution: [東京工業高等専門学校],
    logo: emoji.flag,
  ),
)

#title-slide()

== 自己紹介

#slide[
  - 名前: 吉田宗司
  - 所属: 東京工業高等専門学校
    - プロコンゼミ
  - 好きな技術
    - Rust
    - Nix
  - 各種SNS: yadokani389
][
  #image("assets/yadokani.png")

  #speaker-note[
    東京工業高等専門学校所属の吉田宗司です。よろしくお願いします。
    プロコンゼミに入っています。
    インターネットではこのアイコンで「yadokani」として生活しています。
    githubとかtwitterもyadoka389です。
    好きな技術はRustとNixで、好きではないものはwindowsとpythonです。
    RustとかNixやってる人いたら語りたいです。興味ある人も話しかけてください。
  ]
]

== CTFの経験

- 初めてのCTF: 2024年
- 参加したコンテスト
  - PicoCTF
  - KOSEN セキュリティコンテスト
- 印象に残った問題
  - プログラム
  - フォレンジック

#speaker-note[
  CTFを始めたのは2024年だと思います。とは言ってもPicoCTFをちょっとやってたくらいです。
  ずっとLinux使ってて、多少はそういう知識あるかなと思ったというのと普通にCTFに興味があったので今回のコンテスト参加しました。
  印象に残った問題はプログラムとフォレンジックですね。
  競技プログラミングを少ししていたので、プログラムやったんですが解いてて楽しかったです。
  ですが、四則演算を大量にやる問題ではPython使ってpwntools以外で解く方法を知らなかったので、Rustで解けるようになりたいです。
  あと、フォレンジック系のバラバラになった画像でパズルみたいなことする問題めっちゃ楽しかったです。
]

== 今後の目標

- 目標
  - リバースエンジニアリングしたい
  - Webエクスプロイト
- 参加したいコンテスト
  - AlpacaHack
  - SECCON

#speaker-note[
  目標はリバースエンジニアリングとWebエクスプロイトです。
  リバースエンジニアリングには、とても強い憧れがあるので、できるようになりたいです。
  アセンブリとかリンカとか、詳しいわけではないですが好きなので知っていきたいです。
  Webエクスプロイトは、最近Webアプリケーションのバックエンドを作っているので、セキュリティの知識をつけたいなと思っています。
  AlpacaHackとSECCONは名前しか知らないですが、いつか参加してみたいです。
]
