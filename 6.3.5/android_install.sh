#!/bin/bash
/mnt/c/usr/bin/say.exe installing android application
find ./prj|grep "app-dev-debug.apk"|while read APK;do
	echo installing $APK
	/mnt/c/usr/bin/adb.exe install -g "$APK"
done
