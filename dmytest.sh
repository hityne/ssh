#!/bin/sh

# 定义颜色变量, 还记得吧, \033、\e和\E是等价的
RED='\E[1;31m'       # 红
GREEN='\E[1;32m'    # 绿
YELLOW='\E[1;33m'    # 黄
BLUE='\E[1;34m'     # 蓝
PINK='\E[1;35m'     # 粉红
RES='\E[0m'          # 清除颜色

clear

echo ""
echo -e "${BLUE}[1]系统版本号：${RES}"
cat /etc/debian_version
echo ""
echo -e "${BLUE}[2]系统内核：${RES}"
uname -r
echo ""
echo -e "${BLUE}[3]查看BBR是否启动：${RES}"
sysctl net.ipv4.tcp_congestion_control
echo ""
echo -e "${BLUE}[4]上次启动时间：${RES}"
date -d "$(awk -F. '{print $1}' /proc/uptime) second ago" +"%Y-%m-%d %H:%M:%S"
echo ""
echo -e "${BLUE}[5]系统运行时间：${RES}"
cat /proc/uptime| awk -F. '{run_days=$1 / 86400;run_hour=($1 % 86400)/3600;run_minute=($1 % 3600)/60;run_second=$1 % 60;printf("%d天%d时%d分%d秒\n",run_days,run_hour,run_minute,run_second)}'
echo ""
echo -e "${BLUE}[7]内存信息：${RES}"
info_free=$(free -m)
echo $info_free | awk '{print $7 "\t"$9"/" $8}'
echo $info_free | awk '{print $14 "\t"$16"/" $15}'
echo ""
echo -e "${BLUE}[8]硬盘信息：${RES}"
df -h
echo ""
echo -e "${BLUE}[9]防火墙状态：${RES}"
ufw status
echo ""
# echo -e "${BLUE}[10]SELinux状态：${RES}"
# # getenforce
# echo ""
echo -e "${BLUE}[10]上次登录信息：${RES}"
last | awk 'NR==2'
echo ""