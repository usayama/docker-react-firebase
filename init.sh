#!/bin/sh
set -e
# ビルド
docker-compose build
wait
sleep 5
# アプリをクリエイト
docker-compose run --rm environ npx create-react-app . --template typescript
wait
sleep 5
# パッケージをインストール
docker-compose run --rm environ yarn install
wait
sleep 5
# ファイルを移動
docker cp firebase.js environ:/app/src && docker cp craco.config.js environ:/app && docker cp package.json environ:/app
wait
sleep 5
# 移動後のファイルを削除
rm firebase.js && rm craco.config.js && rm package.json
wait
sleep 5
# ファイルを移動
docker cp .env environ:/app && docker cp .env environ:/app
wait
sleep 5
# 移動後のファイルを削除
rm .env && rm .env.local
wait
sleep 5
# パッケージをインストール
docker-compose run --rm environ yarn install
