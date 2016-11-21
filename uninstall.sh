#!/bin/bash

docker-compose stop
docker-compose rm -f
docker rmi jt2016ucospa_nginx jt2016ucospa_php jt2016ucospa_application
docker volume rm jt2016ucospa_data

rm docker/nginx/Dockerfile
rm docker/php7-fpm/Dockerfile
