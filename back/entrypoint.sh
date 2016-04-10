#!/bin/bash

set -e

public_hostname=${PUBLIC_HOSTNAME:-'magnusdev'}

default_from=${default_from:-'smtp@magnusdev.ma'}

database_host=${POSTGRES_HOST:-'taiga-postgres'}
database_name=${POSTGRES_DB:-'taiga'}
database_user=${POSTGRES_USER:-'taiga'}
database_password=${POSTGRES_PASSWORD:-'123456'}
database_port=${POSTGRES_PORT:-'5432'}

smtp_host=${EMAIL_HOST:-'smtp'}
smtp_port=${EMAIL_PORT:-'25'}

secret_key=${SECRET_KEY:-'123546'}

sed_script=""
for var in public_hostname default_from database_host database_name database_user database_password database_port smtp_host smtp_port secret_key; do
  sed_script+="s,{{$var}},${!var},g;"
done

echo "create local.py"
#cat /usr/local/taiga/settings/local.py.model | sed -e "$sed_script" > /usr/local/taiga/settings/local.py
bash /usr/local/taiga/local.py.env

chown -R taiga /usr/local/taiga/media /usr/local/taiga/static /usr/local/taiga/logs

echo "create static"
cd  /usr/local/taiga/taiga-back
python manage.py collectstatic --noinput


echo "Waiting for Postgresql to be available..."
while ! nc -z $POSTGRES_PORT_5432_TCP_ADDR 5432; do
  sleep 1
done




echo "migrate database"
python manage.py migrate --noinput

#echo "starting django $@"
#exec "$@"


python manage.py runserver 0.0.0.0:8000