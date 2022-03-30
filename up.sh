#!/bin/bash

# Up With NGINX
# sudo docker-compose -f docker-compose.yml -f docker-compose.nginx.yml up -d
# Up Without NGINX
docker-compose -f docker-compose.yml -f docker-compose.without-nginx.yml up -d

