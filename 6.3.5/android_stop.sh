#!/bin/bash
/mnt/c/usr/bin/say.exe stopping android application
find ./prj|grep "app-dev-debug.apk"|while read APK;do
	PACKAGENAME=$(aapt dump badging "$APK"|grep package | awk '{print $2}' | sed s/name=//g | sed s/\'//g)
	echo stopping $PACKAGENAME
	/mnt/c/usr/bin/adb.exe shell "am force-stop $PACKAGENAME"
done
