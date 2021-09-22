#!/bin/bash

if systemctl is-active docker &>/dev/null ;then
		echo "docker已经启动"
		echo "现在开始安装docer aria2..."
		echo ""
		echo "Please open port 6800, 6880 and 6888 on the host."

		echo ""
		read -p "Please set your token: " token
		echo ""


		docker run -d \
				  --name aria2-pro \
				  --restart unless-stopped \
				  --log-opt max-size=1m \
				  -e PUID=$UID \
				  -e PGID=$GID \
				  -e UMASK_SET=022 \
				  -e RPC_SECRET=$token \
				  -e RPC_PORT=6800 \
				  -p 6800:6800 \
				  -e LISTEN_PORT=6888 \
				  -p 6888:6888 \
				  -p 6888:6888/udp \
				  -v $PWD/aria2-config:/config \
				  -v $PWD/aria2-downloads:/downloads \
				  p3terx/aria2-pro

		echo ""
		
		echo "现在开始安装docer ariaNG..."

		docker run -d \
				  --name ariang \
				  --log-opt max-size=1m \
				  --restart unless-stopped \
				  -p 6880:6880 \
				  p3terx/ariang

		echo ""
		echo "Aria2 and AriaNG has been set up on your host."
		echo "Vist http://yourip:6880 and config Aria2 RPC token."
		echo "And then you can do your downloads freely."
		echo ""

else
		echo "docker未启动"
		echo "请先启动docker服务"
		echo ""
		exit 0
fi