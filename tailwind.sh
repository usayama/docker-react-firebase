#!/bin/sh
set -e

echo 'パッケージをインストールします'
docker-compose run --rm environ npm install tailwindcss postcss-cli autoprefixer
echo 'パッケージのインストールが完了しました'
wait $!

sleep 3
echo 'Tailwindcssを初期化します'
docker-compose run --rm environ npx tailwindcss init
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
echo 'styles.cssを作成して書き込みます'
touch app/src/styles.css
wait
cat << 'EOS' > app/src/styles.css
@tailwind base;
@tailwind components;
@tailwind utilities;
EOS
echo '作成と書き込みが完了しました'
wait $!

sleep 3
echo 'package.json から build の行を探して、下に行を挿入します'
gsed -i '/"test":/a \    "tailwind": "npx tailwindcss build src/styles.css -o src/tailwind.css",' app/package.json
echo '行の挿入が完了しました'
wait $!

sleep 3
echo 'TailwindのCSSファイルを作成するためのビルドをします'
docker-compose run --rm react npm run tailwind
echo 'TailwindのCSSファイルを作成しました'
wait $!

echo '👍すべての処理が終了しました！'
