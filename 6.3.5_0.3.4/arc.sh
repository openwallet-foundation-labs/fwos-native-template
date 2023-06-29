#!/bin/bash
DIRNAM=$(date +"%Y_%m_%d_%H_%M_%S")
CURDIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
ARCDIR=$CURDIR/arc/$DIRNAM
DEVDIR=$CURDIR/prj/android
mkdir -p $ARCDIR
find $DEVDIR|grep "\.apk$"|while read APK;do
	APKNAM=$(filename $APK)
	echo archiving $APKNAM
	cp $APK $ARCDIR
done
