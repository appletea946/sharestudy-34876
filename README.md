

## アプリケーション名
sharestudy

## アプリケーションの概要
勉強した内容を共有するためのアプリケーションである。<br>


## URL
https://sharestudy-34876.herokuapp.com/<br>
*ログイン画面右下にあるボタンからテストログインが可能です<br>
*記事投稿画面右下にあるサンプル記事作成を押すと、タイトル・タグ・記事内容が自動で入力されます。

## テスト用アカウント
記事投稿用ユーザー<br>
Email     aaaa@aa.com<br>
password  aaa111<br>

お気に入り登録用ユーザー<br>
Email     bbbb@bb.com<br>
password  bbb111<br>

## 特徴的な機能
タイトル・タグ・グループ・記事内容を記入し投稿ボタンを押すと、記事が投稿される
![記事投稿動画](https://user-images.githubusercontent.com/79189488/114826959-10dde480-9e03-11eb-89ea-596c36e4ba20.gif)

記事詳細画面の下にあるコメントフォームからコメントを送信することができる
![コメント動画](https://user-images.githubusercontent.com/79189488/114826910-04598c00-9e03-11eb-8209-8705b6b87105.gif)


## 目指した課題解決
私が大学に通っていた頃、同じ学科の仲間で授業の内容を復習したりしていた。<br>
コロナウイルスが広がっている今。人と直接会って話し合うのは、しばしば憚られる。<br>
そのため、会わずとも仲間と授業の内容を復習したりできるアプリがあると便利だと思った。<br>
また、自分自身アウトプットする場所が欲しいと考えた。<br>
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

| Column | Type   | Option      |
| ------ | ------ | ----------- |
| name   | string | null: false |

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

| Column       | Type    | Option      |
| ------------ | ------- | ----------- |
| give_user    | integer | null: false |
| receive_user | integer | null: false |

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