#!/bin/bash
DEVICE=$1
ADB=/mnt/c/usr/bin/adb.exe 
SAY=sam
SAY=say
find ./prj|grep "app-dev-debug.apk"|while read APK;do
	PACKAGENAME=$(aapt dump badging "$APK"|grep package | awk '{print $2}' | sed s/name=//g | sed s/\'//g)
	echo starting $PACKAGENAME
        if [ -z "$DEVICE" ]
        then
		$ADB devices|grep -v attached|grep device|cut -f1|while read DEVICE;do
			echo $ADB -s "$DEVICE" shell "monkey -p $PACKAGENAME -c android.intent.category.LAUNCHER 1 > /dev/null 2>&1"
			./android_start.sh "$DEVICE"
		done
        else
		$SAY starting android application
		$ADB -s "$DEVICE" shell "monkey -p $PACKAGENAME -c android.intent.category.LAUNCHER 1 > /dev/null 2>&1"
        fi
done
