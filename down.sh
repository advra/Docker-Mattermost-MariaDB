#!/bin/bash

# DOWN With NGINX
# sudo docker-compose -f docker-compose.yml -f docker-compose.nginx.yml down

# DOWN Without NGINX
docker-compose -f docker-compose.yml -f docker-compose.without-nginx.yml up -d