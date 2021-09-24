#!/bin/bash

mkdir /filerun /filerun/html /filerun/user-files /filerun/db

cd /filerun

wget -O docker-compose.yml https://raw.githubusercontent.com/hityne/centos/ur/docker-compose.yml


filerun_root_passwd=$(cat /proc/sys/kernel/random/uuid|cut -f1 -d"-")
filerun_user_passwd=$(cat /proc/sys/kernel/random/uuid|cut -f1 -d"-")

sed -i "s/filerun_root_passwd/$filerun_root_passwd/" docker-compose.yml
sed -i "s/filerun_used-passwd/$filerun_user_passwd/g" docker-compose.yml
echo ""
echo "please check /filerun/docker-compose.yml to get more configurations."
echo ""
docker-compose up -d

