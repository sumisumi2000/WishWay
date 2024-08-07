# WishWay

![top_page](/app/assets/images/top_page.png)

## サービス URL

https://wish-way.com

## サービス概要

「死ぬまでにやりたいことリスト」（通称：バケットリスト）の作成と共有ができるアプリです。<br>
Qiita 開発記事：https://qiita.com/sumisumi2000/items/9e5184c7f5616961e5e2

## サービスへの想い、作りたい理由

開発者がバケットリストの存在を初めて知った時に「自分だけのリストを作って、達成していけば人生を楽しめるのではないか」と思いました。<br>
なぜなら、働き方やライフスタイルが多様化し、個人が尊重されるようになりつつある世の中で「自分らしく生きる手助けになる」「自分の本当にやりたいことを把握する」ことはとても難しいと感じているからです。<br>

そこで開発者は「バケットリスト」を作成しようとしたのですが、わずか 10 個程度しかやりたいことが思いつきませんでした。<br>
人生でやりたいことが 10 個程度というのはなんとも面白味のない人生だと思い、もっともっと増やさないと後悔の残る人生になると思いました。<br>
そんな時に以前、X（旧 Twitter）である方が Note にバケットリストを投稿していたのを思い出し、やりたいことを作るきっかけとさせていただきました。<br>

その際に、自分以外の人が作成した「バケットリスト」を見ることができるサービスがあったらいいなと思ったことが作成のきっかけです。<br>
ユーザーにとって「人生で本当にやりたいこと」を考え、達成していく手助けができるサービスにしていきたいです。

## 想定されるユーザー層

- 自分のやりたいことを視覚化し、明確に認識したい人
- 他の人のバケットリストを見てみたい人

## サービスの利用イメージ

レスポンシブ対応を実装することでスマホ、PC どちらからでも使うことができます。

ユーザーは「やりたいこと」**Wish** を作成し、自分だけのバケットリストを作成します。
他のユーザーのバケットリストはログイン無しでも閲覧が可能です。<br>

バケットリストを他のユーザーに見られたくないユーザーは非公開にすることができます。
また、他のユーザーのリストから「やりたいこと」**Wish** を自分のリストに追加することでより多くの **Wish** を作成できるようになります。

## ユーザーの獲得について

- X を用いた宣伝
- [Qiita の開発記事](https://qiita.com/sumisumi2000/items/9e5184c7f5616961e5e2)による宣伝

## サービスの差別化ポイント・推しポイント

「バケットリスト」を作成するツールは、アナログデジタル問わずたくさんありますが、「バケットリストの共有」というコンセプトが最も大きな差別化ポイントになると考えています。
また本リリースの際の機能の予定ですが、達成状況をグラフや図などで視覚化することにより、継続のモチベーションにも繋げられると思います。

##### アナログ（ノートや手帳）

- 通知機能により、定期的に見直すきっかけをユーザーに提供できる。

##### デジタル（Note や Notion）

- バケットリストの枠組みを提供することで、ユーザーはただ「やりたいこと」を入力するだけで作成ができる。
- 達成した **Wish** を削除するのではなく、視覚的に表現することで達成感を感じられる。

## 機能一覧

- バケットリストの閲覧機能
- ユーザー登録機能
- ログイン機能
- Google 認証
- バケットリスト
  - 作成機能
    - ユーザー作成の際に自動的にリストも作成
  - 編集機能
    - リストのタイトル（一覧ページへの表示名）を編集
  - 削除機能
    - リストを削除すると、ユーザーも自動的に削除
  - 公開設定
    一覧ページに公開するかどうかを設定
  - お気に入り機能
- 「やりたいこと」**Wish** の作成機能
  - 編集機能
  - 削除機能
  - 作成日と達成日の表示
  - 追加機能
- X（旧 Twitter）へのシェア機能
- パスワードリセット
- グラフによる達成状況の可視化
- 検索のオートコンプリート機能
- メールによる通知機能

## 技術構成

### 使用技術

| カテゴリ       | 技術                                                |
| -------------- | --------------------------------------------------- |
| フロントエンド | Rails 7.1.3.2 (Hotwire/Turbo), TailwindCSS, DaisyUI |
| バックエンド   | Rails 7.1.3.2 (Ruby 3.2.2 )                         |
| データベース   | PostgreSQL                                          |
| インフラ       | Render.com                                          |

## 画面遷移図

Figma: https://www.figma.com/design/IQUIPcJ1QIrySjsy9sx5DF/WishWay?node-id=0%3A1&t=6yFjfdAsLn03NBHY-1

## ER 図

![](https://i.gyazo.com/d16f39677fe775661822ba839110c0df.png)
