#!/bin/bash
say installing
cd ./prj
npm install --legacy-peer-deps
npm install @aries-framework/core @aries-framework/react-native react-native-fs react-native-get-random-values indy-sdk-react-native @react-native-community/netinfo
#npm install indy-sdk-react-native --save
#mkdir -p ./prj/android/app/libs/
#wget -nc https://github.com/hyperledger/indy-sdk-react-native/releases/download/0.2.2/android-indy-sdk-release-device-1.15.0.aar -O ./prj/android/app/libs/android-indy-sdk-release-device-1.15.0.aar 
say installation complete
