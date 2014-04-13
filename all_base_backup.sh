#!/bin/bash

BASE_DIR="/home/xlin/base"
mysqlshow -u root > base.txt

cat base.txt | grep -v "+" | tr '|' ' '  | while read line
do
        echo -e "${line}"
        if ! [[ $line == "Databases" || $line == "information_schema" || $line == "performance_schema" ]]; then
                mysqldump -u root -f $line > ${BASE_DIR}/${line}.sql
        else
                echo "NOT"
        fi
done
