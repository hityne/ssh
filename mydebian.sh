#!/bin/sh

# 更新和升级
apt update && apt dist-upgrade -y

# 安装必要包
apt install -y git wget curl vim ufw

# vim右键复制粘贴
wget https://raw.githubusercontent.com/hityne/others/main/vimrc.local && mv vimrc.local /etc/vim/

# ssh控制台添加颜色
sed -i "\$a\alias ls='ls --color=auto'" /etc/profile