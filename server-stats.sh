#!/bin/sh

#Showing CPU usage
echo "-----------------"
echo "----CPU Usage----"

top -b -n 1 | awk '
/Cpu\(s\)/ || /%Cpu/ {
   for (i=1; i <= NF; i++) {
	if ($i == "id," || $i == "id") {
	   idle = $(i-1)
	   printf "Total CPU Usage: %.1f%%\n", 100 - idle
	   exit
	}
   }
}'

echo "------------------"
echo "\n"
#Memory usage
echo "------------------"
echo "---Memory Usage---"

free -h | awk 'NR==1 {print $1,$2,$3} /^Mem:/ {print $2,$3,$4}'

echo "------------------"

echo "\n"
#Disk Usage
echo "------------------"
echo "----Disk Usage----"

df -h --total -x tmpfs -x devtmpfs

echo "------------------"

echo "\n"

echo "     ------------------      "
echo "----Top 5 processes by CPU usage----"

ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6

echo "     ------------------      "
echo "\n"

echo "     ------------------      "
echo "----Top 5 processes by memory usage----"
ps -eo pid,comm,%mem --sort=-%mem | head -n 6
echo "     ------------------      "
echo "\n"
