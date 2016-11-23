#!/bin/bash
#
#
#
git pull
sleep 5s
docker-compose rm -f
docker-compose build --no-cache
docker-compose up