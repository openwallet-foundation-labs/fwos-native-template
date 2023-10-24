#!/bin/bash
DEVICE=$1
ADB=/mnt/c/usr/bin/adb.exe 
SAY=sam
SAY=say
SAY=echo
find ./prj|grep "app-appstore-debug.apk"|while read APK;do
	echo installing $APK
	if [ -z "$DEVICE" ]
	then
		$ADB devices|grep -v attached|grep device|cut -f1|while read DEVICE;do
			./android_install_debug.sh "$DEVICE"
		done
	else
		$SAY installing android application
		$ADB -s "$DEVICE" install -g "$APK"
	fi
done
