# テーブル設計

## users

| Column             | Type   | Option      |
| ------------------ | ------ | ----------- |
| nickname           | string | null: false |
| email              | string | null: false |
| encrypted_password | string | null: false |
| introduction       | text   |             |
| image              | file   |             |

### association
- has_many :articles
- has_many :comments
- has_many :like_articles
- has_many :like_users
- has_many :user_groups


## articles

| Column  | Type       | Option                         |
| ------- | ---------- | ------------------------------ |
| title   | string     | null: false                    |
| content | text       | null: false                    |
| user    | references | null: false, foreign_key: true |

### association
- belongs_to :user
- has_many: comments
- has_many: like_articles
- has_many: article_tags
- has_many: article_groups

## like_article

| Column  | Type       | Option                         |
| ------- | ---------- | ------------------------------ |
| user    | references | null: false, foreign_key: true |
| article | references | null: false, foreign_key: true |

### association
- belongs_to :user
- belongs_to :article

## comments

| Column  | Type       | Option                         |
| ------- | ---------- | ------------------------------ |
| content | string     | null: false                    |
| user    | references | null: false, foreign_key: true |
| article | references | null: false, foreign_key: true |

### association
- belongs_to :user
- belongs_to :article

## tags

| Column | Type | Option |
| ------ | ---- | ------ |
| name   |      |        |

### association
- has_many :article_tags

## article_tags(中間テーブル)

| Column  | Type       | Option                         |
| ------- | ---------- | ------------------------------ |
| article | references | null: false, foreign_key: true |
| tag     | references | null: false, foreign_key: true |

### association
- belongs_to :article
- belongs_to :tag

## like_user

| Column       | Type       | Option                                         |
| ------------ | ---------- | ---------------------------------------------- |
| give_user    | references | null: false, foreign_key: { to_table: "users"} |
| receive_user | references | null: false, foreign_key: { to_table: "users"} |

### association
- has_many: user

## groups

| Column   | Type       | Option                         |
| -------- | ---------- | ------------------------------ |
| name     | string     | null: false                    |
| password | string     | null: false                    |
| user     | references | null: false, foreign_key: true |

### association
- has_many :user_groups
- has_many :article_groups

## user_groups(中間テーブル)

| Column | Type       | Option                         |
| ------ | ---------- | ------------------------------ |
| user   | references | null: false, foreign_key: true |
| group  | references | null: false, foreign_key: true |

### association
- belongs_to: user
- belongs_to: groups

## article_groups(中間テーブル)

| Column  | Type       | Option                         |
| ------- | ---------- | ------------------------------ |
| article | references | null: false, foreign_key: true |
| group   | references | null: false, foreign_key: true |

### association
- belongs_to: article
- belongs_to: groups
