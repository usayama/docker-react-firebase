#!/bin/sh
set -e

echo '🚀処理を開始します'


echo 'docker-composeをビルドします'
docker-compose build
echo 'docker-composeのビルドが完了しました。'
wait $!


sleep 5
echo 'yarnのキャッシュをクリアします'
docker-compose run --rm environ yarn cache clean
echo 'yarnのキャッシュをクリアしました'
wait $!


sleep 5
echo 'Reactアプリを作成します'
docker-compose run --rm environ npx create-react-app . --template typescript  --use-npm
echo 'Reactアプリの作成が完了しました'
wait $!


sleep 5
echo 'パッケージをインストールします'
docker-compose run --rm environ npm install
echo 'パッケージのインストールが完了しました'
wait $!


sleep 5
echo 'react-router-dom をインストールします'
docker-compose run --rm environ npm install react-router-dom @types/react-router-dom
echo 'パッケージのインストールが完了しました'
wait $!


echo '👍すべての処理が完了しました！'
