#!/bin/bash
DEVICE=$1
ADB=/mnt/c/usr/bin/adb.exe 
find ./prj|grep "app-appstore-debug.apk"|while read APK;do
	PACKAGENAME=$(aapt dump badging "$APK"|grep package | awk '{print $2}' | sed s/name=//g | sed s/\'//g)
	if [ -z "$DEVICE" ]
	then
		$ADB devices|grep -v attached|grep device|cut -f1|while read DEVICE;do
			./android_app_process_logs_debug.sh "$DEVICE"
		done
	else
		echo 'logcat -T "$(date "+%Y-%m-%d %H:%M:%S.0")"|grep $(ps -eo pid,args|grep '$PACKAGENAME'|grep -v grep|sed "s/^\ *//g"|cut -f1 -d" ")'|$ADB -s "$DEVICE" shell
	fi
done

