#!/bin/bash
ADB=
find ./prj|grep "app-dev-debug.apk"|while read APK;do
	PACKAGENAME=`aapt dump badging "$APK"|grep package | awk '{print $2}' | sed s/name=//g | sed s/\'//g`
	DATADIR=`/mnt/c/usr/bin/adb.exe shell "run-as $PACKAGENAME pwd"`
	rm -rf ./tmp/$PACKAGENAME
	mkdir -p ./tmp
	/mnt/c/usr/bin/adb.exe shell 'mkdir -p /sdcard/Download/'$PACKAGENAME''
	/mnt/c/usr/bin/adb.exe shell "run-as $PACKAGENAME cp -r ./ /sdcard/Download/$PACKAGENAME"
	/mnt/c/usr/bin/adb.exe pull /sdcard/Download/$PACKAGENAME ./tmp
	/mnt/c/usr/bin/adb.exe shell 'rm -rf /sdcard/Download/'$PACKAGENAME''
done
