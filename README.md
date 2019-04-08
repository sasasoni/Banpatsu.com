# Banpatsu.com

番発情報をサークル側が登録して、様々なサークルが開催する番発情報を集めることができるイベント管理アプリケーションです。
今後も需要があったらアップデートをしていきます。

## 使い方
ローカル環境で試してみたい方はリポジトリをクローンして以下の事を実行してください。

gemのインストール

```
$ bundle install --without production
```

データベースのマイグレーション

```
$ rails db:migrate
```

テストの実行

```
$ rails test
```

テストをパスしたら、サーバーを起動

```
$ rails s　# だめだったら -b 0.0.0.0 を加える
```
