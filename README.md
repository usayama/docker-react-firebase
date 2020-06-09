# docker-react-firebase
React + TypeScript + Firebaseの環境をすぐつくれる

## Create App

##### ビルド

```bash
$ docker-compose build
```

##### Reactアプリを作成

-  `rm` オプションでコンテナをすぐ削除

```bash
$ docker-compose run --rm react npx create-react-app . --template typescript
```

## Serve App

##### コンテナを起動すると、reactアプリを起動するコマンドが実行される

```bash
$ docker-compose up
```

## Init Firebase

##### index.htmlにFirebaseのコードを追加

- Setting / 全般 / Firebase SDK snippet

##### コンテナをバックグラウンドで起動

```bash
$ docker-compose up -d
```

##### Firebaseのコンテナに入る

```bash
$ docker-compose exec firebase ash
```

##### Fireabaseログイン

```
# firebase login --no-localhost
```

- `--no-localhost` はローカルホストではないDocker環境では必須

##### Firebaseを初期化

```
# firebase init
```

- publicディレクトリを使うかは `build`
- SPAにするかは `No`

- index.htmlを上書きするかは `No`

##### Firebaseのコンテナを落としてもOK

```bash
$ docker-compose down
```

## Deploy

##### Reactアプリをビルドする

```bash
$ docker-compose run --rm react npm run build
```

##### コンテナをバックグラウンドで立ち上げる

```bash
$ docker-compose up -d
```

##### Firebaseのコンテナに入る

```bash
$ docker-compose exec firebase ash
```

##### Firebaseログイン

```
# firebase login --no-localhost
```

##### Firebaseデプロイ

```
# firebase deploy
```

#### ★トークンでログインしてデプロイする方法

##### Firebaseログインのときに `:ci` をつけてトークンを発行

```
# firebase login:ci --no-localhost
```

##### docker-compose.ymlの環境変数にFirebaseのトークンを追加

```yaml
services:
  firebase:
    environment: 
      - FIREBASE_TOKEN=トークン
```

##### Firebaseデプロイ

```bash
$ docker-compose run --rm firebase firebase deploy
```
