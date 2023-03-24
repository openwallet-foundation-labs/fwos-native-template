#!/bin/bash
/mnt/c/usr/bin/say.exe starting android application
find ./prj|grep "app-dev-debug.apk"|while read APK;do
	PACKAGENAME=$(aapt dump badging "$APK"|grep package | awk '{print $2}' | sed s/name=//g | sed s/\'//g)
	echo starting $PACKAGENAME
	/mnt/c/usr/bin/adb.exe shell "monkey -p $PACKAGENAME -c android.intent.category.LAUNCHER 1 > /dev/null 2>&1"
done
