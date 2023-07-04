#!/bin/bash
DEVICE=$1
ADB=/mnt/c/usr/bin/adb.exe 
find ./prj|grep "app-dev-debug.apk"|while read APK;do
	ls -lh "$APK"
done
