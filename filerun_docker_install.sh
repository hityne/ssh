#!/bin/bash

mkdir /filerun /filerun/html /filerun/user-files /filerun/db

cd /filerun

wget -O docker-compose.yml https://github.com/hityne/ssh/raw/master/docker-compose.yml


filerun_root_passwd=$(cat /proc/sys/kernel/random/uuid|cut -f1 -d"-")
filerun_user_passwd=$(cat /proc/sys/kernel/random/uuid|cut -f1 -d"-")

touch /filerun/note.txt
echo "filerun_root_passwd: $filerun_root_passwd" >> /filerun/note.txt
echo "filerun_user_passwd: $filerun_user_passwd" >> /filerun/note.txt

sed -i "s/filerun_root_passwd/$filerun_root_passwd/" docker-compose.yml
sed -i "s/filerun_user_passwd/$filerun_user_passwd/g" docker-compose.yml
echo ""
echo "please check /filerun/docker-compose.yml to get more configurations."
echo ""
docker-compose up -d

