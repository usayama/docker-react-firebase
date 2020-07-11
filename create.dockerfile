FROM node:lts-alpine

RUN apk update
RUN ash -c "npx create-react-app . --template typescript"
