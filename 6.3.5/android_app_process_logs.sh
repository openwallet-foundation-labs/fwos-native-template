#!/bin/bash
DEVICE=$1
find ./prj|grep "app-dev-debug.apk"|while read APK;do
	PACKAGENAME=$(aapt dump badging "$APK"|grep package | awk '{print $2}' | sed s/name=//g | sed s/\'//g)
	if [ -z "$DEVICE" ]
	then
		echo 'logcat|grep $(ps -eo pid,args|grep '$PACKAGENAME'|grep -v grep|sed "s/^\ *//g"|cut -f1 -d" ")'|/mnt/c/usr/bin/adb.exe shell
	else
		echo 'logcat|grep $(ps -eo pid,args|grep '$PACKAGENAME'|grep -v grep|sed "s/^\ *//g"|cut -f1 -d" ")'|/mnt/c/usr/bin/adb.exe -s "$DEVICE" shell
	fi
done
