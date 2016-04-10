#! /usr/bin/env bash

docker build -t originals/taiga-back ./back
docker build -t originals/taiga-front ./front
docker-compose up