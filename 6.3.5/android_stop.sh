#!/bin/bash
DEVICE=$1
ADB=/mnt/c/usr/bin/adb.exe
find ./prj|grep "app-dev-debug.apk"|while read APK;do
	PACKAGENAME=$(aapt dump badging "$APK"|grep package | awk '{print $2}' | sed s/name=//g | sed s/\'//g)
	echo stopping $PACKAGENAME
        if [ -z "$DEVICE" ]
        then
		$ADB devices|grep -v attached|grep device|cut -f1|while read DEVICE;do
			./android_stop.sh $DEVICE
		done
        else
		/mnt/c/usr/bin/say.exe stopping android application
		$ADB -s "$DEVICE" shell "am force-stop $PACKAGENAME"
        fi

done
