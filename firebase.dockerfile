FROM node:lts-alpine

RUN apk update
RUN npm install -g firebase-tools
