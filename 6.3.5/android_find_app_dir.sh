#!/bin/bash
find ./prj|grep "app-dev-debug.apk"|while read APK;do
	PACKAGENAME=$(aapt dump badging "$APK"|grep package | awk '{print $2}' | sed s/name=//g | sed s/\'//g)
	echo $PACKAGENAME
	/mnt/c/usr/bin/adb.exe shell 'file $(find $(dirname $(pm path '$PACKAGENAME'|cut -f2- -d'"'"':'"'"')))'
done
