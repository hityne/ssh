#!/bin/bash

if systemctl is-active docker &>/dev/null ;then
		echo "docker已经启动"
		echo "现在开始安装filebrowser..."
		echo ""
		mkdir -p /var/www/filebrowser
		echo "工作目录/var/www/html/fb"
		echo ""

		docker pull filebrowser/filebrowser
		docker run \
				--restart=always
			    -v /var/www/filebrowser/srv:/srv \
			    -v /var/www/filebrowser/filebrowser.db:/database.db \
			    -v /var/www/filebrowser/.filebrowser.json:/.filebrowser.json \
			    -p 8001:80 \
			    filebrowser/filebrowser

		echo ""
		echo "Filebrowser docker 已安装成功，默认账号密码为：admin。"
		echo "端口映射： 8001 -> 80"
		echo ""

else
		echo "docker未启动"
		echo "请先启动docker服务"
		echo ""
		exit 0
fi