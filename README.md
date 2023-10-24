# Mendix React Native Template for Farmworker Wallet OS Project

## Native Template - Android

This native template is located in directory `source` in this source tree.

Tools used:

* npm: 8.19.2
* node: v16.18.0
* java: openjdk 11.0.11 2021-04-20
* javac: javac 11.0.11

Ensure you have NDK installed by using the `sdkmanager` tool

```
~/Android/cmdline-tools/tools/bin/sdkmanager --list_installed
```

If none are installed, select a candidate from the output ...

```
~/Android/cmdline-tools/tools/bin/sdkmanager --list
```

... and install a version, e.g.

```
~/Android/cmdline-tools/tools/bin/sdkmanager --install ndk;23.2.8568313
```

Using an existing or newly installed version of ndk, edit `android/build.gradle` ensuring the following

```
buildscript {
    ext {
        ...
        minSdkVersion = 21
	ndkVersion = "23.2.8568313"
        ...
    }
}
```

Add the Sovrin maven repository to `android/build.gradle`

```
allprojects {
    repositories {
        ...
        maven {
            url 'https://repo.sovrin.org/repository/maven-public'
        }
        ...
    }
}
```

Edit `android/app/build.gradle` and add JNA as follows

```
dependencies {
    ...
    implementation 'net.java.dev.jna:jna:5.2.0'
    ...
}
```

For `@aries-framework/cheqd` to work, the Hermes engine needs to be used instead of JSCore. To do so, ammend `android/app/build.gradle` as follows

```
project.ext.react = [
	bundleForVariant: { def variant -> false },
	enableHermes : true
]
```

```
def enableHermes = project.ext.react.get("enableHermes", true);
```

```
if (enableHermes) {
	implementation("com.facebook.react:hermes-engine:+") {
		exclude group:'com.facebook.fbjni'
	}
} else {
	implementation jscFlavor
}
```

```
implementation "org.webkit:android-jsc:r174650"
```

For smaller APK sizes, limit the buildTypes by editing `android/app/build.gradle` and add abiFilters as follows [reference](https://developer.android.com/ndk/guides/abis)

```
...
     buildTypes {
        release {
            ...
            ndk {
                abiFilters "armeabi-v7a", "arm64-v8a"
            }
        }
        debug {
            ndk {
                abiFilters "armeabi-v7a", "arm64-v8a"
            }
        }
    }
...
```

Install the node modules by running the following

```
npm install --legacy-peer-deps
npm install @aries-framework/react-native@^0.4.1
npm install @aries-framework/core@^0.4.1
npm install @aries-framework/anoncreds@^0.4.1
npm install @aries-framework/anoncreds-rs@^0.4.1
npm install @hyperledger/anoncreds-react-native@^0.1.0
npm install @hyperledger/aries-askar-react-native@^0.1.0
npm install @aries-framework/indy-vdr@0.4.1
npm install @hyperledger/indy-vdr-shared@0.1.0
npm install @hyperledger/indy-vdr-react-native@^0.1.0
npm install react-native-sensitive-info@next
npm install react-native-fs
npm install react-native-get-random-values
npm install react-native-camera
npm install react-native-argon2 --save
```
## Native Template - iOS

Install the node modules by running the following

```
npm install --legacy-peer-deps
npm install @aries-framework/react-native@^0.4.0
npm install @aries-framework/core@^0.4.0
npm install @aries-framework/anoncreds@^0.4.0
npm install @aries-framework/anoncreds-rs@^0.4.0
npm install @hyperledger/anoncreds-react-native@^0.1.0
npm install @hyperledger/aries-askar-react-native@^0.1.0
npm install @aries-framework/indy-vdr@0.4.0
npm install @hyperledger/indy-vdr-shared@0.1.0
npm install @hyperledger/indy-vdr-react-native@^0.1.0
npm install react-native-sensitive-info@next
npm install react-native-fs
npm install react-native-get-random-values
npm install react-native-camera
```

Ensure the following sources are listed in `ios/Podfile`

```
source 'https://cdn.cocoapods.org'
```

Install the pods as follows

```
cd ios
pod install
```

Open the project in `Xcode` using the following

```
open ./NativeTemplate.xcworkspace
```

With `nativeTemplate` selected, under `Signing & Capabilities`, under the section `All`, configure your signing configuration.

With `nativeTemplate` selected in the tree view, for both `Project` `nativeTemplate` as well as `Target` `nativeTemplate`, under the `Build Settings` tab, under the `All` subtab, configure option `Build Libraries for Distribution` to `yes`.

With `nativeTemplate` selected in the tree view, for both `Project` `nativeTemplate` as well as `Target` `nativeTemplate`, under the `Build Settings` tab, under the `Customized` subtab, configure option `Enable Bitcode` to `no`.

| :exclamation:  Issues   |
|-------------------------|

If you get the following error message

```
using bridging headers with module interfaces is unsupported
```

Set `Build Libraries for Distribution` to `no`. This issue has not been resolved as of yet.
