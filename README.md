

## アプリケーション名
sharestudy

## アプリケーションの概要
- ユーザーの作成

## URL
https://sharestudy-34876.herokuapp.com/

## テスト用アカウント
記事投稿用ユーザー
Email     aaaa@aa.com
password  aaa111

お気に入り登録用ユーザー
Email     bbbb@bb.com
password  bbb111

## 利用方法
1. 新規登録を行う
2. 新規作成後、ヘッダー部分の自分の名前をクリックすると自分の詳細画面に遷移する
3. ユーザー詳細画面右下にある編集ボタンから、自分のプロフィールを編集する
4. 「所属グループ」を押すとグループ一覧画面に遷移する
5. 画面右下の「作成」ボタンを押すとグループ作成画面に遷移する
6. グループの名前とパスワードを設定しグループを作成する
7. 作成したグループの名前をクリックするとグループ詳細画面に遷移する
8. 画面右下の作成ボタンを押すと記事作成画面遷移する
9. タイトル、タグ、グループ、記事内容を入力し記事を作成する
10. 投稿した記事をクリックすると記事詳細ページに遷移する
11. 右下の編集ボタンを押すと記事を編集することができる
12. 下の方にスクロールするとコメント送信する場所がある。内容を入力し送信ボタンを押すとコメントを送信することができる
13. 他のユーザーでログインしなおす
14. もう一度記事詳細画面に遷移する
15. 記事内容の右下に記事お気に入りボタンがありボタンを押すと、その記事をお気に入り登録する。同じ場所にお気に入り解除ボタンが表示される。
16. お気に入り解除ボタンを押すとお気に入りが解除される
17. ヘッダー部分の「ShareStudy」を押すとトップページに戻る
18. 投稿されている記事の作成者の名前をクリックすると、そのユーザーの詳細画面に遷移する
19. ユーザー情報にある「お気に入り登録」を押すと、そのユーザーをお気に入り登録する。同じ場所にお気に入り解除ボタンが表示される
20. お気に入り解除ボタンを押すと、お気に入りを解除する


## 目指した課題解決
私が大学に通っていた頃、同じ学科の仲間で授業の内容を復習したりしていた。
コロナウイルスが広がっている今。人と直接会って話し合うのは、しばしば憚られる。
そのため、会わずとも仲間と授業の内容を復習したりできるアプリがあると便利だと思った。
また、自分自身アウトプットする場所が欲しいと考えた。
失敗してしまったことは、作りたいWebサービスがあることを事前に調べなかったこと。

## 洗い出した要件
- ユーザー管理機能
- ユーザー情報編集機能
- 記事投稿機能
- 記事編集機能
- コメント機能
- 絞り込み検索機能
- タグ付け機能
- 記事へのお気に入り機能
- ユーザーへのお気に入り機能
- グループ機能
- グループ検索機能

## 実装した機能についての画像やGIF及びその説明
- 記事投稿機能
- コメント機能
- 絞り込み検索機能
- タグ付け機能
- 記事へのお気に入り機能
- ユーザーへのお気に入り機能
- グループ機能

## 実装予定の機能
- グループに投稿した記事は記事の作成者だけでなく、グループに参加しているメンバーも編集できるようにする。
- ユーザーへのお気に入り登録及び解除を非同期通信にする
- 記事へのお気に入り登録及び解除を非同期通信にする


## データベース設計

### users

| Column             | Type   | Option      |
| ------------------ | ------ | ----------- |
| nickname           | string | null: false |
| email              | string | null: false |
| encrypted_password | string | null: false |
| introduction       | text   |             |
| image              | file   |             |

#### association
- has_many :articles
- has_many :comments
- has_many :like_articles
- has_many :like_users
- has_many :user_groups


### articles

| Column  | Type       | Option                         |
| ------- | ---------- | ------------------------------ |
| title   | string     | null: false                    |
| content | text       | null: false                    |
| user    | references | null: false, foreign_key: true |

#### association
- belongs_to :user
- has_many: comments
- has_many: like_articles
- has_many: article_tags
- has_many: article_groups

### like_article

| Column  | Type       | Option                         |
| ------- | ---------- | ------------------------------ |
| user    | references | null: false, foreign_key: true |
| article | references | null: false, foreign_key: true |

#### association
- belongs_to :user
- belongs_to :article

### comments

| Column  | Type       | Option                         |
| ------- | ---------- | ------------------------------ |
| content | string     | null: false                    |
| user    | references | null: false, foreign_key: true |
| article | references | null: false, foreign_key: true |

#### association
- belongs_to :user
- belongs_to :article

### tags

| Column | Type | Option |
| ------ | ---- | ------ |
| name   |      |        |

#### association
- has_many :article_tags

### article_tags(中間テーブル)

| Column  | Type       | Option                         |
| ------- | ---------- | ------------------------------ |
| article | references | null: false, foreign_key: true |
| tag     | references | null: false, foreign_key: true |

#### association
- belongs_to :article
- belongs_to :tag

### like_user

| Column       | Type       | Option                                         |
| ------------ | ---------- | ---------------------------------------------- |
| give_user    | references | null: false, foreign_key: { to_table: "users"} |
| receive_user | references | null: false, foreign_key: { to_table: "users"} |

#### association
- has_many: user

### groups

| Column   | Type       | Option                         |
| -------- | ---------- | ------------------------------ |
| name     | string     | null: false                    |
| password | string     | null: false                    |
| user     | references | null: false, foreign_key: true |

#### association
- has_many :user_groups
- has_many :article_groups

### user_groups(中間テーブル)

| Column | Type       | Option                         |
| ------ | ---------- | ------------------------------ |
| user   | references | null: false, foreign_key: true |
| group  | references | null: false, foreign_key: true |

#### association
- belongs_to: user
- belongs_to: groups

### article_groups(中間テーブル)

| Column  | Type       | Option                         |
| ------- | ---------- | ------------------------------ |
| article | references | null: false, foreign_key: true |
| group   | references | null: false, foreign_key: true |

#### association
- belongs_to: article
- belongs_to: groups


## ローカルでの動作方法
ターミナルで以下を実行してください
- cd アプリをクローンするフォルダ名
- git clone https://github.com/appletea946/sharestudy-34876.git
- cd sharestudy-34876
- bundle install
- yarn install 
- rails db:create
- rails db:migrate
- rails s