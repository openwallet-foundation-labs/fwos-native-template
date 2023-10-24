#!/bin/bash
DEVICE=$1
ADB=/mnt/c/usr/bin/adb.exe 
SCRCPY=/mnt/c/opt/scrcpy/scrcpy.exe
SAY=sam
SAY=say
find ./prj|grep "app-dev-debug.apk"|while read APK;do
	echo mirroring
	if [ -z "$DEVICE" ]
	then
		$ADB devices|grep -v attached|grep device|cut -f1|while read DEVICE;do
			./android_mirror.sh "$DEVICE"
		done
	else
		$SAY mirroring
		$SCRCPY -s "$DEVICE" --legacy-paste &
	fi
done
