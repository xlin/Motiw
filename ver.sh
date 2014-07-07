#!/bin/bash

motiw_maj_new_ver="19"
motiw_maj_ver="15"
major_update="1"

while [ $motiw_maj_ver -lt $[motiw_maj_new_ver+1] ]
do
	echo "Патчим до последней $motiw_maj_ver версии"
	temp=$motiw_maj_ver
        ./patch_db.sh $temp ${motiw_maj_ver} ${major_update} /var/Motiw/db/motiw.fdb
	motiw_maj_ver=$[$motiw_maj_ver+1]
done
