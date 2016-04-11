#! /usr/bin/env bash
mv conf.exemple.json conf.exemple112.json
sed -i "s/API_SERVER/192.168.1.111/g" /usr/local/taiga/taiga-front/dist/conf.json
nginx -g "daemon off;"
