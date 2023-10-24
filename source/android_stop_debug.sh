#!/bin/bash
DEVICE=$1
ADB=/mnt/c/usr/bin/adb.exe
SAY=sam
SAY=say
SAY=echo
find ./prj|grep "app-appstore-debug.apk"|while read APK;do
	PACKAGENAME=$(aapt dump badging "$APK"|grep package | awk '{print $2}' | sed s/name=//g | sed s/\'//g)
	echo stopping $PACKAGENAME
        if [ -z "$DEVICE" ]
        then
		$ADB devices|grep -v attached|grep device|cut -f1|while read DEVICE;do
			./android_stop_debug.sh $DEVICE
		done
        else
		$SAY stopping android application
		$ADB -s "$DEVICE" shell "am force-stop $PACKAGENAME"
        fi

done
