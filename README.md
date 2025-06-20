## アプリケーションについて

このアプリケーションは、目標の習慣化を目的としたRuby on Railsプロジェクトです。
名前は「やるる」です。

## バージョン
- Ruby: 3.2.8
- Rails: 7.1.5
- PostgreSQL: 15

## DB準備
```
bin/rails db:create
bin/rails db:migrate
bin/rails db:seed
```

## 使用ライブラリ・ツール
- importmap-rails: JavaScriptをESM形式（＝JavaScript パッケージの標準的な読み込み方法）で管理するための仕組み
- factory_bot_rails: テスト用のデータを生成するプログラム言語
- faker: ランダムなテストデータを生成するライブラリ
- rspec-rails: RSpecテストフレームワーク
- rubocop, rubocop-rails: Ruby / Rails の静的コード解析ツール

