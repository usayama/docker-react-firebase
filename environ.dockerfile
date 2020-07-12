FROM node:lts-alpine

RUN apk update
RUN yarn cache clean
