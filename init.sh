#!/bin/sh
set -e

echo '🚀処理を開始します'


echo 'docker-composeをビルドします'
docker-compose build
echo 'docker-composeのビルドが完了しました。'
wait $!


sleep 3
echo 'yarnのキャッシュをクリアします'
docker-compose run --rm react yarn cache clean
echo 'yarnのキャッシュをクリアしました'
wait $!


sleep 3
echo 'Reactアプリを作成します'
docker-compose run --rm react npx create-react-app . --template typescript  --use-npm
echo 'Reactアプリの作成が完了しました'
wait $!


sleep 3
echo 'パッケージをインストールします'
docker-compose run --rm react npm install
echo 'パッケージのインストールが完了しました'
wait $!


sleep 3
echo 'react-router-dom をインストールします'
docker-compose run --rm react npm install react-router-dom @types/react-router-dom
echo 'パッケージのインストールが完了しました'
wait $!

sleep 3
echo 'tsconfig.json から jsx の行を探して、下に行を挿入します'
gsed -i '/"jsx":/i \    "baseUrl": "src",' app/tsconfig.json
echo '行の挿入が完了しました'
wait $!

echo '👍すべての処理が完了しました！'
