#! /usr/bin/env bash

sed -i "s/API_SERVER/192.168.1.111/g" /usr/local/taiga/taiga-front/dist/js/conf.json
nginx -g "daemon off;"
