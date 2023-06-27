#!/bin/bash
SAY=sam
SAY=say
$SAY installing
cd ./prj
npm install --legacy-peer-deps
# 0.3.0 
#npm install @aries-framework/core
#npm install @aries-framework/react-native
#npm install react-native-fs
#npm install react-native-get-random-values
#npm install indy-sdk-react-native
# 0.4.0 
npm install @aries-framework/react-native@^0.4.0
npm install @aries-framework/core@^0.4.0
npm install @aries-framework/indy-sdk@^0.4.0
npm install @aries-framework/anoncreds@^0.4.0
npm install indy-sdk-react-native@^0.3.1
npm install --save-dev @types/indy-sdk-react-native@npm:@types/indy-sdk
$SAY installation complete
