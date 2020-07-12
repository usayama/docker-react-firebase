# ビルド
docker-compose build
wait
# アプリをクリエイト
docker-compose run --rm environ npx create-react-app . --template typescript
wait
# パッケージをインストール
docker-compose run --rm environ yarn install
wait
# ファイルを移動
docker cp firebase.js environ:/app && docker cp craco.config.js environ:/app && docker cp package.json environ:/app
wait
# 移動後のファイルを削除
rm firebase.js && rm craco.config.js && rm package.json
wait
# ファイルを移動
docker cp .env environ:/app && docker cp .env environ:/app
wait
# 移動後のファイルを削除
rm .env && rm .env.local
wait
# パッケージをインストール
docker-compose run --rm environ yarn install
