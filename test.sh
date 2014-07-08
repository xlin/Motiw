#!/bin/bash

motiw_maj_new_ver="19"
motiw_maj_ver="18"
major_update="1"

#if [ $motiw_maj_ver == $[motiw_maj_new_ver] ]; then
#    echo "./patch_db.sh $temp ${motiw_maj_ver} ${major_update} /var/Motiw/db/motiw.fdb"
#fi
rm patch/index.new
while [ $motiw_maj_ver -lt $motiw_maj_new_ver ]
do
#    motiw_maj_ver=$[$motiw_maj_ver+1]
#    echo "$motiw_maj_ver test"
    if [ $motiw_maj_ver == 19 ]; then
	motiw_maj_ver="109"
	while ! [ $motiw_maj_ver == $motiw_maj_new_ver ]
	do
	    motiw_maj_ver=$[$motiw_maj_ver+1]
	    echo $motiw_maj_ver
	done
    fi
#    if [ ${motiw_maj_ver} -ge 110 ]; then
#	cat patch/index19 >> patch/index.new	
#	cat patch/index19 | sed -n '2p' | awk '{print $1}' >> patch/index.new
#	break
#    fi
    cat patch/index${motiw_maj_ver} >> patch/index.new
    motiw_maj_ver=$[$motiw_maj_ver+1]
#    cat patch/index$motiw_maj_ver
#    cat patch/index$[motiw_maj_ver-1] >> patch/index.new
done
#./patch_db.sh $motiw_maj_ver .new 1 /var/Motiw/db/motiw.fdb
