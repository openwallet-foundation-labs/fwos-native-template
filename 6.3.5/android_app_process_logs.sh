#!/bin/bash
find ./prj|grep "app-dev-debug.apk"|while read APK;do
	PACKAGENAME=$(aapt dump badging "$APK"|grep package | awk '{print $2}' | sed s/name=//g | sed s/\'//g)
	echo 'logcat|grep $(ps -eo pid,args|grep '$PACKAGENAME'|grep -v grep|sed "s/^\ *//g"|cut -f1 -d" ")'|/mnt/c/usr/bin/adb.exe shell
done
