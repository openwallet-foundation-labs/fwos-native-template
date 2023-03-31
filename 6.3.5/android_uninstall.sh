#!/bin/bash
/mnt/c/usr/bin/say.exe uninstalling android application
find ./prj|grep "app-dev-debug.apk"|while read APK;do
	echo uninstalling $APK
	PACKAGENAME=$(aapt dump badging "$APK"|grep package | awk '{print $2}' | sed s/name=//g | sed s/\'//g)
	/mnt/c/usr/bin/adb.exe uninstall $PACKAGENAME> /dev/null 2>&1
done
