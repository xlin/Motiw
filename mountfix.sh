#!/bin/bash

IP_WEB=192.168.1.108 # IP адрес шары
PID_TOM="/var/run/tomcat6.pid"
WRITELOCK="/var/lib/tomcat6/solr_home/data/index/write.lock"
DIR_IN=/var/Motiw/scripts
DIR_OUT="${IP_WEB}:/var/Motiw/scripts"

filecount=`find $DIR_IN -type f | wc -l`
date=`date "+%Y-%m-%d %k:%M"`

if [ $filecount -eq 0 ]; then
echo "Error. Not mount script NFS"
#Монтируем /var/Motiw/scripts для tomcat
/bin/mount $DIR_OUT $DIR_IN
        if [ $? -ne 0 ]; then
                echo ERROR
        else
                sleep 3
                #Проверяем PID tomcat. Если запущен, рестаруем
                # и удаляем возможно подвисший write.lock
                if [ -e $PID_TOM ]; then
                        if [ -e $WRITELOCK ]; then rm $WRITELOCK && /etc/init.d/tomcat6 restart
                        else
                                 echo "${WRITELOCK} отсутствует" && /etc/init.d/tomcat6 restart
                        fi
                else
                        if [ -e $WRITELOCK ]; then
                                rm $WRITELOCK && /etc/init.d/tomcat6 start
                        else
                                echo "${WRITELOCK} отсутствует" && /etc/init.d/tomcat6 start
                        fi
                fi
        fi
echo "${date} mount OK" >> /var/log/mountfix.log
else
#Если все смонтировано, ничего не делаем
echo "${date} mount OK" >> /var/log/mountfix.log

# Проверяем  дату write.lock. Если меньше чем сегодняшнее число, то удаляем
DATE_LOCK=`ls -lt ${WRITELOCK} | awk '{print $7}'`
DATE_TOMO=`date +%d`

        if [[ ! $DATE_LOCK == $DATE_TOMO ]]; then
                echo "${date} Зависший файл write.lock, удаляем и перезапускаем tomcat" >> /var/log/mountfix.log
                rm $WRITELOCK
        fi
fi
