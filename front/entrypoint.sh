#! /usr/bin/env bash

sed -i "s/API_SERVER/$TAIGA_BACK_PORT_8000_TCP_ADDR/g" /usr/local/taiga/taiga-front/dist/js/conf.json
nginx -g "daemon off;"
