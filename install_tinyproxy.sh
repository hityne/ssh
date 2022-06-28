
clear
echo ""

#read -s -n1 -p "Press any key to continue..." 

echo "  1.Install tinyproxy                           2.Uninstall tinyproxy"
echo "  3.reset tinyproxy                             4.Modify configuire"


echo ""
read -p "Please input the number you choose:" tiny_no

if [ "$tiny_no" = "1" ]; then
    apt update
    apt install -y tinyproxy
    sed -i "s/Allow 127.0.0.1/#Allow 127.0.0.1/" /etc/tinyproxy/tinyproxy.conf
      
    clear
    echo ""
    echo "Tinyproxy has been installed."
    echo "#Allow 127.0.0.1 ----> Allow 127.0.0.1"    
                                               #"
    read -p "Please input your port:" myport
    sed -i "s/Port 8888/Port $myport/" /etc/tinyproxy/tinyproxy.conf
    echo "Port 8888 ----> Port $myport"  
    echo ""  
    service tinyproxy restart
    service tinyproxy status
elif [ "$tiny_no" = "2" ]; then
    apt remove -y tinyproxy

elif [ "$tiny_no" = "3" ]; then
    echo "before"
    ps -ef | grep tinyproxy | grep -v grep| awk '{print "kill -9 "$2}' | bash
    echo "after"
    sleep 1
    service tinyproxy start
    service tinyproxy status
elif [ "$tiny_no" = "4" ]; then
    vim /etc/tinyproxy/tinyproxy.conf
else
    exit 0
fi