# sinatra-practice

sinatra で作成したメモアプリのリポジトリです。

## git clone

`git clone`を用いて、リポジトリをクローンしてください。

```
$ git clone https://github.com/nakaji25/sinatra-practice.git
```

## gem install

Gemfile を作成し、以下を記載してください。

```
group :development do
    gem 'erb_lint', require: false
    gem 'rubocop-fjord', require: false
do
gem 'sinatra'
gem 'rackup'
gem 'puma'
gem 'sinatra-contrib'
gem 'webrick'
```

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
