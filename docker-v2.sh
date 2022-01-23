#!/bin/sh


function check_config(){

	cat $1

	rows=$(awk 'END {print NR}' $1 )
	
	if [ $rows == 32 ]; then
		echo ""
		echo "vmess+tcp"
		echo ""
		ip=$(curl -s https://ipinfo.io/ip)
		port=$(cat $1 | awk 'NR==3 {print substr($2,0,length($2)-1)}')
		userid=$(cat $1 | awk 'NR==8 {print substr($2,0,length($2)-1)}')
		alterid=$(cat $1 | awk 'NR==10 {print $2}')

		cat >/v2ray/vmess_qr.json << EOF
				{
					"v": "2",
					"ps": "",
					"add": "$ip",
					"port": "$port",
					"id": $userid,
					"aid": "$alterid",
					"net": "tcp",
					"type": "none",
					"host": "",
					"path": "",
					"tls": ""
				} 
EOF
	elif [ $rows == 47 ]; then
		echo ""
		echo "vmess+ws+tls"
		echo ""
		port=$(cat $1 | awk 'NR==4 {print substr($2,0,length($2)-1)}')
		userid=$(cat $1 | awk 'NR==9 {print substr($2,0,length($2)-1)}')
		alterid=$(cat $1 | awk 'NR==11 {print $2}')
		urpath=$(cat $1 | awk 'NR==18 {print $2}')
		urdomain=$(cat /v2ray/domain.txt)

		cat >/v2ray/vmess_qr.json << EOF
				{
					"v": "2",
					"ps": "",
					"add": "$urdomain",
					"port": "443",
					"id": $userid,
					"aid": "$alterid",
					"net": "ws",
					"type": "none",
					"host": "",
					"path": $urpath,
					"tls": "tls"
				} 
EOF
	else
		echo ""
		echo "Please check your config."
		exit 0
	fi

	vmess="vmess://$(cat /v2ray/vmess_qr.json | base64 -w 0)"
	echo $vmess
	echo ""

}


clear
if systemctl is-active docker &>/dev/null ;then
	echo "docker已经启动"
else
	echo "docker未启动"
	echo "请先启动docker服务"
	echo ""
	exit 0
fi

echo "本脚本安装docker v2ray。请选择协议："
echo "  1.Install v2ray tcp"
echo "  2.Install v2ray ws+tls+web"
echo ""
read -p "Please input the number you choose:" v2ray_no

if [ "$v2ray_no" = "1" ]; then

	mkdir /v2ray
	wget https://github.com/hityne/centos/raw/ur/config.json  -O -> /v2ray/config.json

	userid=$(cat /proc/sys/kernel/random/uuid)
	sed -i "8s/7966c347-b5f5-46a0-b720-ef2d76e1836a/$userid/" /v2ray/config.json

	read -p "请设置端口号（默认24380）： " port
	[ "$port" != "" ] && sed -i "3s/24380/$port/" /v2ray/config.json
	[ "$port" = "" ] && port=24380

	read -p "请输入alterid（默认0）: " alterid
	[ "$alterid" != "" ] && sed -i "10s/0/$alterid/" /v2ray/config.json

	docker run -d --name v2ray_tcp --restart=always -v /v2ray:/etc/v2ray -p $port:$port v2fly/v2fly-core  v2ray -config=/etc/v2ray/config.json
	
	echo "生成客户端配置二维码"
	check_config "/v2ray/config.json"

elif [ "$v2ray_no" = "2" ]; then

	mkdir /v2ray
	wget https://github.com/hityne/centos/raw/ur/config2.json  -O -> /v2ray/config2.json
		
	sed -i "5s/127.0.0.1/0.0.0.0/" /v2ray/config2.json

	read -p "请输入你的域名: " urdomain
	[ "$urdomain" == "" ] && read -p "请输入你的域名: " urdomain
	echo $urdomain > /v2ray/domain.txt

	userid=$(cat /proc/sys/kernel/random/uuid)
	sed -i "9s/7966c347-b5f5-46a0-b720-ef2d76e1836a/$userid/" /v2ray/config2.json

	read -p "请设置端口号（默认35367）: " port
	[ "$port" != "" ] && sed -i "4s/35367/$port/" v2ray/config2.json
	[ "$port" = "" ] && port=35367

	read -p "请输入alterid（默认0）: " alterid
	[ "$alterid" != "" ] && sed -i "11s/0/$alterid/" /v2ray/config2.json

	read -p "请输入path（默认"down"）: " urpath
	[ "$urpath" != "" ] && sed -i "18s/down/$urpath/" /v2ray/config2.json

	docker run -d --name v2ray_ws_tls --restart=always -v /v2ray:/etc/v2ray -p 127.0.0.1:$port:$port v2fly/v2fly-core  v2ray -config=/etc/v2ray/config2.json
		
	echo ""
	echo "*******************"
	echo "请开通端口 $port"
	echo "请为$urdomain申请SSL认证"
	wget https://github.com/hityne/centos/raw/ur/site.config  -O -> /v2ray/site.config
	echo "网站配置文件添加以下内容(/v2ray/site.config)："
	cat /v2ray/site.config
	echo "*******************"
	echo ""
	read -s -n1 -p "按任意键继续 ... "
	echo "生成客户端配置二维码"
	check_config "/v2ray/config2.json"


else
exit 0
fi
