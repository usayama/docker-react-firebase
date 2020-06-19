FROM node:lts-alpine

RUN apk update

# 2回目以降はビルドに含めない
# RUN npx create-react-app . --template typescript
# RUN npm install firebase
