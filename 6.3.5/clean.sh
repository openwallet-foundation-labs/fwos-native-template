#!/bin/bash
say cleaning android project
cd ./prj/android
JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64 ANDROID_SDK_ROOT=/home/skullquake/Android/ ./gradlew -x lint clean
EXITCODE=$?
cd ../../
test $EXITCODE -eq 0 && say "cleaning complete" || say "cleaning failed"
exit $EXITCODE
