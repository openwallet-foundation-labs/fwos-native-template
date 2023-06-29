#!/bin/bash
SAY=sam
SAY=say
$SAY building android project
cd ./prj/android
JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64 ANDROID_SDK_ROOT=/home/skullquake/Android/ ./gradlew -x lint assembleDev -PreactNativeArchitectures=armeabi-v7a
EXITCODE=$?
cd ../../
test $EXITCODE -eq 0 && $SAY "build complete" || $SAY "build failed"
exit $EXITCODE
