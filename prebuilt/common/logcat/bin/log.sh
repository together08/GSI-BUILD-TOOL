#!/system/bin

if [ -e /data/logs/log ];then
 cat /data/logs/log >> /data/media/0/logcat.txt
fi
