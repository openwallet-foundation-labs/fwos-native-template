#!/bin/bash
DEVICE=$1
ADB=/mnt/c/usr/bin/adb.exe 
APKTOOL=apktool
OUTDIR=./tmp/apk
find ./prj|grep "app-appstore-debug.apk"|while read APK;do
	APKNAME=$(basename $APK .apk)
	APKOUTDIR=./tmp/apk/$APKNAME
	rm -rf "$APKOUTDIR"
	mkdir -p "$APKOUTDIR"
	echo "extracting $APK to $APKOUTDIR ..."
	$APKTOOL decode "$APK"  -f -o "$APKOUTDIR"
done
