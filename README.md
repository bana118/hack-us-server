# hack-us-server

チーム開発マッチングアプリ「Hack Us」のサーバー

# How to get started

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

ローカルで開発していてmysql を起動していない場合は以下を実行
```
mysql.server start
```

## Database

* [dbdiagram](https://dbdiagram.io/home) で作成
* `./database.pdf` に記載<br>

## Request example

<img width="50%" alt="スクリーンショット 2021-06-15 15 56 16" src="https://user-images.githubusercontent.com/51741264/122006794-39c62a00-cdf2-11eb-8bde-42071aa2cad0.png">
