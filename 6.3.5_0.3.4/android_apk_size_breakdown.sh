#!/bin/bash
DEVICE=$1
OUTDIR=./tmp/apk
TREE=tree
find ./prj|grep "app-dev-debug.apk"|while read APK;do
	APKNAME=$(basename $APK .apk)
	OUTDIR=./tmp/apk/$APKNAME
	OUTFILE=$OUTDIR/breakdown.txt
	$TREE $OUTDIR --du -shan > $OUTFILE
	cat $OUTFILE
done
