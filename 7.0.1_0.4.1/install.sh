#!/bin/bash
SAY=sam
SAY=say
$SAY installing
cd ./prj
#npm install @aries-framework/cheqd
npm install --legacy-peer-deps && \
npm install @aries-framework/react-native@^0.4.1 && \
npm install @aries-framework/core@^0.4.1 && \
npm install @aries-framework/anoncreds@^0.4.1 && \
npm install @aries-framework/anoncreds-rs@^0.4.1 && \
npm install @hyperledger/anoncreds-react-native@^0.1.0 && \
npm install @hyperledger/aries-askar-react-native@0.1.0 && \
npm install @aries-framework/indy-vdr@0.4.1 && \
npm install @hyperledger/indy-vdr-shared@0.1.0 && \
npm install @hyperledger/indy-vdr-react-native@^0.1.0 && \
npm install react-native-sensitive-info@next && \
npm install react-native-fs && \
npm install react-native-get-random-values && \
npm install react-native-camera && \
npm install react-native-argon2 --save && \
npm install react-native-device-info
$SAY installation complete
