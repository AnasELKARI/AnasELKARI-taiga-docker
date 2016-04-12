#! /usr/bin/env bash
mv conf.exemple.json conf.exemple112.json
sed -i "s/API_SERVER/$API_NAME/g" /usr/local/taiga/taiga-front/dist/conf.json
nginx -g "daemon off;"
