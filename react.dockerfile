FROM node:lts-alpine

RUN apk update
RUN npm install firebase
