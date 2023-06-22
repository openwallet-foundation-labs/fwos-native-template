#!/bin/bash
DEVICE=$1
ADB=/mnt/c/usr/bin/adb.exe
SAY=sam
SAY=say
if [ -z "$DEVICE" ]
then
	$ADB devices|grep -v attached|grep device|cut -f1|while read DEVICE;do
		./android_reverseproxy.sh "$DEVICE"
	done
else
	$SAY setting android reverse proxy
	$ADB -s "$DEVICE" reverse tcp:8080 tcp:8080
	$ADB -s "$DEVICE" reverse tcp:8083 tcp:8083
fi
