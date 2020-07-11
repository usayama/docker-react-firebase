FROM node:lts-alpine

RUN apk update
RUN npm cache clean && yarn cache clean
