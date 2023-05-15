#!/bin/bash
DEVICE=$1
ADB=/mnt/c/usr/bin/adb.exe
find ./prj|grep "app-dev-debug.apk"|while read APK;do
	echo uninstalling $APK
	PACKAGENAME=$(aapt dump badging "$APK"|grep package | awk '{print $2}' | sed s/name=//g | sed s/\'//g)
        if [ -z "$DEVICE" ]
        then
		$ADB devices|grep -v attached|grep device|cut -f1|while read DEVICE;do
			./android_uninstall.sh "$DEVICE"
		done
        else
		say uninstalling android application
		$ADB -s "$DEVICE" uninstall $PACKAGENAME> /dev/null 2>&1
        fi

done
