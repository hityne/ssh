#!/bin/bash

[[ $(id -u) != 0 ]] && echo -e " 请使用root用户运行此脚本！" && exit 1

echo ""
echo "This script will install python3.10.11 and virtualenv on Debian 10/11."
echo ""
read -s -n1 -p "Press any key to continue..." 

apt update
apt install -y build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libsqlite3-dev libreadline-dev libffi-dev curl libbz2-dev

wget https://www.python.org/ftp/python/3.10.11/Python-3.10.11.tgz
tar -xf Python-3.10.11.tgz

cd Python-3.10.11
./configure --enable-optimizations

#编译安装
make -j $(nproc)
echo "please select install option:"

read -p "which command you want to run: [0] make altinstall(python3.10)[default] or [1] make install(python3) " py_option

if [ "$py_option" -ne "1" ]; then

    make altinstall

    cd ..
    rm -rf Python-3.10.11
    rm -f Python-3.10.11.tgz

    echo ""
    python3.10 --version
    pip3.10 --version


    echo ""
    echo "The script is going to install virtualenv."
    echo ""

    read -s -n1 -p "Press any key to continue..." 

    #为python3.10安装virtualenv
    pip3.10 install virtualenv

    # #检查是否安装成功
    virtualenv --version
else
    make install

    cd ..
    rm -rf Python-3.10.11
    rm -f Python-3.10.11.tgz

    echo ""
    python3 --version
    pip3 --version


    echo ""
    echo "The script is going to install virtualenv."
    echo ""

    read -s -n1 -p "Press any key to continue..." 

    #为python3安装virtualenv
    pip3 install virtualenv

    # #检查是否安装成功
    virtualenv --version
fi

echo ""
echo "The script runs to end."
