#!/bin/bash

mkdir /filerun /filerun/html /filerun/user-files /filerun/db

cd /filerun

wget -O docker-compose.yml https://raw.githubusercontent.com/hityne/centos/ur/docker-compose.yml

docker-compose up -d