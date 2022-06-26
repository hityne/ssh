apt update
apt install tinyproxy


sed -i "s/Allow 127.0.0.1/#Allow 127.0.0.1/" /etc/tinyproxy/tinyproxy.conf

clear
echo ""
echo "Tinyproxy has been installed."
echo "#Allow 127.0.0.1 ----> Allow 127.0.0.1"                                                     #"
read -p "Please input your port:" myport
sed -i "s/Port 8888/Port $myport/" /etc/tinyproxy/tinyproxy.conf
echo "Port 8888 ----> Port $myport"    
ps -ef | grep tinyproxy | grep -v grep| awk '{print "kill -9 "$2}' | sh
service tinyproxy start
service tinyproxy status