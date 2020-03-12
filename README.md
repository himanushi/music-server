# music-server
apple music と spotify で聞ける音楽を検索するサーバーサイド機能

# コマンド

イメージ作成
```console
docker-compose build
```

起動
```console
docker-compose up
```

サーバーデバッグ
起動中に
```console
docker attach <コンテナID>
```

コンソール実行
```console
docker-compose run web bash
bundle exec rails c
```
