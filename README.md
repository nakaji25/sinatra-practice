# sinatra-practice

sinatra で作成したメモアプリのリポジトリです。

## git clone

`git clone`を用いて、リポジトリをクローンしてください。

```
$ git clone https://github.com/nakaji25/sinatra-practice.git
```

## PostgreSQL のインストール（Mac)

本アプリで DB を使用するため、PostgreSQL をインストールします。

```
$ brew install postgresql
```

### 起動

```
$ brew services start postgresql
```

### 停止

```
$ brew services stop postgresql
```

### DB への接続

PostgreSQL でデフォルトで存在する postgres に接続します。

```
$ psql postgres
```

### ユーザ作成

OS のログインユーザーをそのまま利用するのは、セキュリティ的に問題があるため、以下のコマンドで DB 作成権限等を持ったユーザを作ります。

```
postgres=# create user ユーザ名 with SUPERUSER;
CREATE ROLE
```

### DB の作成

作成したユーザをオーナーとして、メモアプリで使用する BD である`sinatra_db`を作成します。

```
createdb sinatra_db -o ユーザー名
```

以下のコマンドを実行し、作成されているかを確認します。

```
psql -U ユーザー名 sinatra_db
```

以下のようになれば問題ありません。（14.17 は PostgreSQL のバージョン）

```
psql (14.17 (Homebrew))
Type "help" for help.

sinatra_db=#
```

## gem install

Gemfile を作成し、以下を記載してください。

```
gem 'erb_lint'
gem 'rubocop-fjord'
gem 'sinatra'
gem 'rackup'
gem 'puma'
gem 'sinatra-contrib'
gem 'webrick'
gem 'pg'
```

Bundler の機能をつかって、まとめて読み込みを行う場合は、`erb_lint`と`rubocop-fjord`を group 指定や`require: false`を追記してください。

その後、以下のコマンドで Bundler を使ってインストールしてください。

```
bundle install
```

## アプリの立ち上げ

以下のコマンドを実行することでアプリを実行できます。

```
ruby memo_app.rb
```

アプリを立ち上げた後は、`http://localhost:4567/`にアクセスすることでメモアプリを利用するくとができます。
