#!/bin/sh

# 更新和升级
apt update && apt dist-upgrade -y

# 安装必要包
apt install -y git wget curl vim screen ufw ntp ntpdate

# 降低IPv6优先级，有限使用IPv4
res=$(sed -n '/^precedence.*100$/p' /etc/gai.conf)
if [ -z "$res" ]; then 
    read -p "Do you want to prior to use IPv4 instead of IPv6? [n] no (defaut) [y] yes: " if_option
	if [ "$if_option" = "y" ]; then
        echo "precedence ::ffff:0:0/96 100" >>/etc/gai.conf
    fi

fi

# vim右键复制粘贴
wget https://raw.githubusercontent.com/hityne/others/main/vimrc.local && mv vimrc.local /etc/vim/

# ssh控制台添加颜色
sed -i "\$a\alias ls='ls --color=auto'" /etc/profile

