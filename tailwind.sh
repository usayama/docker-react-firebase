#!/bin/sh
set -e

echo 'パッケージをインストールします'
docker-compose run --rm react npm install tailwindcss postcss-cli autoprefixer
echo 'パッケージのインストールが完了しました'
wait $!

sleep 3
echo 'Tailwindcssを初期化します'
docker-compose run --rm react npx tailwindcss init
echo 'Tailwindcssを初期化しました'
wait $!

sleep 3
echo 'さっき作られたTailwind設定ファイルに書き込みます'
gsed -i -e "/purge/c\  purge: ['./src/**/*.ts', './src/**/*.tsx']," app/tailwind.config.js
echo '書き込みが完了しました'
wait $!

sleep 3
echo 'postcss.config.jsを作成して書き込みます'
touch app/postcss.config.js
wait
cat << 'EOS' > app/postcss.config.js
module.exports = {
  plugins: [require('tailwindcss'), require('autoprefixer')]
}
EOS
echo '作成と書き込みが完了しました'
wait $!

sleep 3
echo 'tailwind-import.cssを作成して書き込みます'
touch app/src/tailwind-import.css
wait
cat << 'EOS' > app/src/tailwind-import.css
@tailwind base;
@tailwind components;
@tailwind utilities;
EOS
echo '作成と書き込みが完了しました'
wait $!

sleep 3
echo 'package.json から build の行を探して、下に行を挿入します'
gsed -i '/"test":/a \    "tailwind": "npx tailwindcss build src/tailwind-import.css -o src/tailwind.css",' app/package.json
echo '行の挿入が完了しました'
wait $!

sleep 3
echo 'package.json から build の行を探して、書き換えます'
gsed  -i '/"build":/c\    "build": "NODE_ENV=production npm run tailwind && craco build",' app/package.json
echo '行の書き換えが完了しました'
wait $!

sleep 3
echo 'TailwindのCSSファイルを作成するためのビルドをします'
docker-compose run --rm react npm run tailwind
echo 'TailwindのCSSファイルを作成しました'
wait $!

sleep 3
echo 'index.tsx から import App の行を探して、下に行を挿入します'
gsed -i "/import App/a import './tailwind.css'" app/src/index.tsx
echo '行の挿入が完了しました'
wait $!

echo '👍すべての処理が終了しました！'
