#!/bin/bash
DEVICE=$1
ADB=/mnt/c/usr/bin/adb.exe 
find ./prj|grep "app-dev-debug.apk"|while read APK;do
	echo installing $APK
	if [ -z "$DEVICE" ]
	then
		$ADB devices|grep -v attached|grep device|cut -f1|while read DEVICE;do
			./android_install.sh "$DEVICE"
		done
	else
		say installing android application
		$ADB -s "$DEVICE" install -g "$APK"
	fi
done
