set -e

echo '🚀処理を開始します'

echo 'Emotion関連パッケージをインストールします'
docker-compose run --rm environ npm install @emotion/core @craco/craco @emotion/babel-preset-css-prop
echo 'Emotion関連パッケージのインストールが完了しました'
wait $!

sleep 5
echo 'craco.config.jsを作成し、内容を記述します'
touch app/craco.config.js
wait
cat <<EOS > app/craco.config.js
const emotionPresetOptions = {}
const emotionBabelPreset = require("@emotion/babel-preset-css-prop").default(
  undefined,
  emotionPresetOptions
)
module.exports = {
  babel: {
    plugins: [
      ...emotionBabelPreset.plugins
    ]
  }
}
EOS
echo 'craco.config.jsが完了しました'
wait $!

echo '👍すべての処理が完了しました！'
