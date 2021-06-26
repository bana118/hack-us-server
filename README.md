# hack-us-server

チーム開発マッチングアプリ「Hack Us」のサーバー

# How to get started

## Set environment variables

```
cp .env.example .env
```

.env ファイルの環境変数を適切に設定

## Launch server

```
# 必要な gem をインストール
bundle install

# 初回時のみデータベース作成
rails db:create

# データベースに変更がある場合に実行
rails db:migrate

# サーバーを起動
rails server -p 3001 -b 0.0.0.0
```

ローカルで開発していて mysql を起動していない場合は以下を実行

```
mysql.server start
```

## Database

```
Table users {
  id int [pk, increment]
  name varchar [not null]
  uid varchar [not null, unique]
  description varchar [not null]
  github_id varchar [not null]
  github_icon_url varchar [not null]
  contribution_info json [not null]
  created_at timestamp [not null]
  updated_at timestamp [not null]
}

Table projects {
  id int [pk, increment]
  owner_id int [not null]
  name varchar [not null]
  description varchar
  github_url varchar
  starts_at timestamp
  ends_at timestamp
  technology1 varchar
  technology2 varchar
  technology3 varchar
  technology4 varchar
  technology5 varchar
  recruitment_numbers int
  tool_link varchar
  contribution varchar
  created_at timestamp [not null]
  updated_at timestamp [not null]
}

Ref: projects.owner_id > users.id

Table participants {
  id int [pk, increment]
  user_id int [not null]
  project_id int [not null]
  created_at timestamp [not null]
}

Ref: participants.user_id > users.id
Ref: participants.project_id > projects.id

Table favorites {
  user_id bigint [not null]
  project_id bigint [not null]
  created_at timestamp [not null]
  updated_at timestamp [not null]
}

Ref: favorites.user_id > users.id
Ref: favorites.project_id > projects.id
```

- [dbdiagram](https://dbdiagram.io/home) で作成

## Request example

<img width="50%" alt="スクリーンショット 2021-06-15 15 56 16" src="https://user-images.githubusercontent.com/51741264/122006794-39c62a00-cdf2-11eb-8bde-42071aa2cad0.png">
