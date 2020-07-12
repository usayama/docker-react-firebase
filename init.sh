#!/bin/sh
set -e
docker-compose build
wait

sleep 5
docker-compose run --rm environ npx create-react-app . --template typescript
wait

sleep 5
docker-compose run --rm environ yarn install
wait

sleap 5
mv firebase.js app/src && mv craco.config.js app && mv package.json app
wait
mv .env app && mv .env.local app
wait

sleep 5
docker-compose run --rm environ yarn install
