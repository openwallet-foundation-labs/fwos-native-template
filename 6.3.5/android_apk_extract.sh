#!/bin/bash
DEVICE=$1
ADB=/mnt/c/usr/bin/adb.exe 
APKTOOL=apktool
OUTDIR=./tmp/apk
find ./prj|grep "app-dev-debug.apk"|while read APK;do
	APKNAME=$(basename $APK .apk)
	OUTDIR=./tmp/apk/$APKNAME
	rm -rf "$OUTDIR"
	mkdir -p "$OUTDIR"
	echo "extracting $APK to $OUTDIR ..."
	$APKTOOL decode "$APK"  -f -o "$OUTDIR"
done
