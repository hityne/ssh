ps -ef | grep tinyproxy | grep -v grep| awk '{print "kill -9 "$2}' | sh
service tinyproxy start
service tinyproxy status