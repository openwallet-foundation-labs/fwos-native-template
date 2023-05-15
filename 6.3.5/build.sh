#!/bin/bash
say building android project
cd ./prj/android
JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64 ANDROID_SDK_ROOT=/home/skullquake/Android/ ./gradlew -x lint assembleDev
EXITCODE=$?
cd ../../
test $EXITCODE -eq 0 && say "build complete" || say "build failed"
exit $EXITCODE
