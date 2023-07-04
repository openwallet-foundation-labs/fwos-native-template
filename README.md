# Mendix React Native Template for AriesJS Project

## Native Template Version 7.0.1 - AFJ 0.4.0 - Android

This native template is located in directory `7.0.1_0.4.0` in this source tree.

Tools used:

* npm: 8.19.2
* node: v16.18.0
* java: openjdk 11.0.11 2021-04-20
* javac: javac 11.0.11

The following part around the NDK differs from [Native Template Version 6.3.5 - AFJ 0.3.4 - Android](https://github.com/Entidad/mendix-native-template-ariesjs#native-template-version-635---afj-034---android). The rest of the steps are very much the same.

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

Edit `android/app/build.gradle` and add abiFilters as follows [reference](https://developer.android.com/ndk/guides/abis)

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
Create a directory as follows `mkdir android/app/src/main/jniLibs` as follows:

```
mkdir android/app/src/main/jniLibs
```

Create the following subdirectories in the above created directory:

```
mkdir android/app/src/main/jniLibs/arm64-v8a
mkdir android/app/src/main/jniLibs/armeabi-v7a
mkdir android/app/src/main/jniLibs/x86
mkdir android/app/src/main/jniLibs/x86_64
```

Download the indy-sdk libraries and deploy to the above created directories as follows

```
curl --insecure https://repo.sovrin.org/android/libindy/stable/1.16.0/libindy_android_arm64_1.16.0.zip --output arm64.zip
unzip arm64.zip
mv libindy_arm64/lib/libindy.so android/app/src/main/jniLibs/arm64-v8a/libindy.so
rm -rf libindy_arm64
rm arm64.zip

curl --insecure https://repo.sovrin.org/android/libindy/stable/1.16.0/libindy_android_armv7_1.16.0.zip --output armv7.zip
unzip armv7.zip
mv libindy_armv7/lib/libindy.so android/app/src/main/jniLibs/armeabi-v7a/libindy.so
rm -rf libindy_armv7
rm armv7.zip

curl --insecure https://repo.sovrin.org/android/libindy/stable/1.16.0/libindy_android_x86_1.16.0.zip --output x86.zip
unzip x86.zip
mv libindy_x86/lib/libindy.so android/app/src/main/jniLibs/x86/libindy.so
rm -rf libindy_x86
rm x86.zip

curl --insecure https://repo.sovrin.org/android/libindy/stable/1.16.0/libindy_android_x86_64_1.16.0.zip --output x86_64.zip
unzip x86_64.zip
mv libindy_x86_64/lib/libindy.so android/app/src/main/jniLibs/x86_64/libindy.so
rm -rf libindy_x86_64
rm x86_64.zip
```

Download the JNA libraries and deploy to `android/app/src/main/jniLibs/` as follows

```
curl --insecure -LO https://github.com/java-native-access/jna/raw/5.5.0/lib/native/android-aarch64.jar
jar xf android-aarch64.jar
mv libjnidispatch.so android/app/src/main/jniLibs/arm64-v8a/libjnidispatch.so
rm android-aarch64.jar

curl --insecure -LO https://github.com/java-native-access/jna/raw/5.5.0/lib/native/android-armv7.jar
jar xf android-armv7.jar
mv libjnidispatch.so android/app/src/main/jniLibs/armeabi-v7a/libjnidispatch.so
rm android-armv7.jar

curl --insecure -LO https://github.com/java-native-access/jna/raw/5.5.0/lib/native/android-x86.jar
jar xf android-x86.jar
mv libjnidispatch.so android/app/src/main/jniLibs/x86/libjnidispatch.so
rm android-x86.jar

curl --insecure -LO https://github.com/java-native-access/jna/raw/5.5.0/lib/native/android-x86-64.jar
jar xf android-x86-64.jar
mv libjnidispatch.so android/app/src/main/jniLibs/x86_64/libjnidispatch.so
rm android-x86-64.jar
```

Edit `android/app/src/appstore/java/com/mendix/nativetemplate/MainActivity.java` / `android/app/src/dev/java/com/mendix/nativetemplate/MainActivity.java` to load the relevant library

```
...
import android.os.Bundle;
import android.system.ErrnoException;
import android.system.Os;
import java.io.File;
...

public class MainActivity extends ReactActivity {
  ...

  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);

    try {
      Os.setenv("EXTERNAL_STORAGE", getExternalFilesDir(null).getAbsolutePath(), true);
      System.loadLibrary("indy");
    } catch (ErrnoException e) {
      e.printStackTrace();
    }
  }
}
```

Install the node modules by running the following

```
npm install @aries-framework/react-native@^0.4.0
npm install @aries-framework/core@^0.4.0
npm install @aries-framework/indy-sdk@^0.4.0
npm install @aries-framework/anoncreds@^0.4.0
npm install @aries-framework/anoncreds-rs@^0.4.0
npm install @hyperledger/anoncreds-react-native@^0.1.0
npm install indy-sdk-react-native@^0.3.1
npm install --save-dev @types/indy-sdk-react-native@npm:@types/indy-sdk
npm install react-native-fs
npm install react-native-get-random-values
npm install react-native-camera
```

Ensure the following sources are listed in `ios/Podfile`

```
source 'https://github.com/hyperledger/indy-sdk-react-native'
source 'https://cdn.cocoapods.org'
```

Install the pods as follows

```
cd ios
pod install
pod update Indy
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

## Native Template Version 6.3.5 - AFJ 0.4.0 - Android

This native template is located in directory `6.3.5_0.4.0` in this source tree.

Tools used:

* npm: 8.19.2
* node: v16.18.0
* java: openjdk 11.0.11 2021-04-20
* javac: javac 11.0.11

The following part around the NDK differs from [Native Template Version 6.3.5 - AFJ 0.3.4 - Android](https://github.com/Entidad/mendix-native-template-ariesjs#native-template-version-635---afj-034---android). The rest of the steps are very much the same.

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

Edit `android/app/build.gradle` and add abiFilters as follows [reference](https://developer.android.com/ndk/guides/abis)

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
Create a directory as follows `mkdir android/app/src/main/jniLibs` as follows:

```
mkdir android/app/src/main/jniLibs
```

Create the following subdirectories in the above created directory:

```
mkdir android/app/src/main/jniLibs/arm64-v8a
mkdir android/app/src/main/jniLibs/armeabi-v7a
mkdir android/app/src/main/jniLibs/x86
mkdir android/app/src/main/jniLibs/x86_64
```

Download the indy-sdk libraries and deploy to the above created directories as follows

```
curl --insecure https://repo.sovrin.org/android/libindy/stable/1.16.0/libindy_android_arm64_1.16.0.zip --output arm64.zip
unzip arm64.zip
mv libindy_arm64/lib/libindy.so android/app/src/main/jniLibs/arm64-v8a/libindy.so
rm -rf libindy_arm64
rm arm64.zip

curl --insecure https://repo.sovrin.org/android/libindy/stable/1.16.0/libindy_android_armv7_1.16.0.zip --output armv7.zip
unzip armv7.zip
mv libindy_armv7/lib/libindy.so android/app/src/main/jniLibs/armeabi-v7a/libindy.so
rm -rf libindy_armv7
rm armv7.zip

curl --insecure https://repo.sovrin.org/android/libindy/stable/1.16.0/libindy_android_x86_1.16.0.zip --output x86.zip
unzip x86.zip
mv libindy_x86/lib/libindy.so android/app/src/main/jniLibs/x86/libindy.so
rm -rf libindy_x86
rm x86.zip

curl --insecure https://repo.sovrin.org/android/libindy/stable/1.16.0/libindy_android_x86_64_1.16.0.zip --output x86_64.zip
unzip x86_64.zip
mv libindy_x86_64/lib/libindy.so android/app/src/main/jniLibs/x86_64/libindy.so
rm -rf libindy_x86_64
rm x86_64.zip
```

Download the JNA libraries and deploy to `android/app/src/main/jniLibs/` as follows

```
curl --insecure -LO https://github.com/java-native-access/jna/raw/5.5.0/lib/native/android-aarch64.jar
jar xf android-aarch64.jar
mv libjnidispatch.so android/app/src/main/jniLibs/arm64-v8a/libjnidispatch.so
rm android-aarch64.jar

curl --insecure -LO https://github.com/java-native-access/jna/raw/5.5.0/lib/native/android-armv7.jar
jar xf android-armv7.jar
mv libjnidispatch.so android/app/src/main/jniLibs/armeabi-v7a/libjnidispatch.so
rm android-armv7.jar

curl --insecure -LO https://github.com/java-native-access/jna/raw/5.5.0/lib/native/android-x86.jar
jar xf android-x86.jar
mv libjnidispatch.so android/app/src/main/jniLibs/x86/libjnidispatch.so
rm android-x86.jar

curl --insecure -LO https://github.com/java-native-access/jna/raw/5.5.0/lib/native/android-x86-64.jar
jar xf android-x86-64.jar
mv libjnidispatch.so android/app/src/main/jniLibs/x86_64/libjnidispatch.so
rm android-x86-64.jar
```

Edit `android/app/src/appstore/java/com/mendix/nativetemplate/MainActivity.java` / `android/app/src/dev/java/com/mendix/nativetemplate/MainActivity.java` to load the relevant library

```
...
import android.os.Bundle;
import android.system.ErrnoException;
import android.system.Os;
import java.io.File;
...

public class MainActivity extends ReactActivity {
  ...

  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);

    try {
      Os.setenv("EXTERNAL_STORAGE", getExternalFilesDir(null).getAbsolutePath(), true);
      System.loadLibrary("indy");
    } catch (ErrnoException e) {
      e.printStackTrace();
    }
  }
}
```

Install the node modules by running the following

```
npm install @aries-framework/react-native@^0.4.0
npm install @aries-framework/core@^0.4.0
npm install @aries-framework/indy-sdk@^0.4.0
npm install @aries-framework/anoncreds@^0.4.0
npm install @aries-framework/anoncreds-rs@^0.4.0
npm install @hyperledger/anoncreds-react-native@^0.1.0
npm install indy-sdk-react-native@^0.3.1
npm install --save-dev @types/indy-sdk-react-native@npm:@types/indy-sdk
```

Ensure the following sources are listed in `ios/Podfile`

```
source 'https://github.com/hyperledger/indy-sdk-react-native'
source 'https://cdn.cocoapods.org'
```

Install the pods as follows

```
cd ios
pod install
pod update Indy
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

## Native Template Version 6.3.5 - AFJ 0.4.0 - iOS
Todo...

## Native Template Version 6.3.5 - AFJ 0.3.4 - Android

This native template is located in directory `6.3.5_0.3.4` in this source tree.

Tools used:

* npm: 8.19.2
* node: v16.18.0
* java: openjdk 11.0.11 2021-04-20
* javac: javac 11.0.11


Edit `android/build.gradle` as follows

```
buildscript {
    ext {
        ...
        minSdkVersion = 21
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

Edit `android/app/build.gradle` and add abiFilters as follows [reference](https://developer.android.com/ndk/guides/abis)

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
Create a directory as follows `mkdir android/app/src/main/jniLibs` as follows:

```
mkdir android/app/src/main/jniLibs
```

Create the following subdirectories in the above created directory:

```
mkdir android/app/src/main/jniLibs/arm64-v8a
mkdir android/app/src/main/jniLibs/armeabi-v7a
mkdir android/app/src/main/jniLibs/x86
mkdir android/app/src/main/jniLibs/x86_64
```

Download the indy-sdk libraries and deploy to the above created directories as follows

```
curl --insecure https://repo.sovrin.org/android/libindy/stable/1.16.0/libindy_android_arm64_1.16.0.zip --output arm64.zip
unzip arm64.zip
mv libindy_arm64/lib/libindy.so android/app/src/main/jniLibs/arm64-v8a/libindy.so
rm -rf libindy_arm64
rm arm64.zip

curl --insecure https://repo.sovrin.org/android/libindy/stable/1.16.0/libindy_android_armv7_1.16.0.zip --output armv7.zip
unzip armv7.zip
mv libindy_armv7/lib/libindy.so android/app/src/main/jniLibs/armeabi-v7a/libindy.so
rm -rf libindy_armv7
rm armv7.zip

curl --insecure https://repo.sovrin.org/android/libindy/stable/1.16.0/libindy_android_x86_1.16.0.zip --output x86.zip
unzip x86.zip
mv libindy_x86/lib/libindy.so android/app/src/main/jniLibs/x86/libindy.so
rm -rf libindy_x86
rm x86.zip

curl --insecure https://repo.sovrin.org/android/libindy/stable/1.16.0/libindy_android_x86_64_1.16.0.zip --output x86_64.zip
unzip x86_64.zip
mv libindy_x86_64/lib/libindy.so android/app/src/main/jniLibs/x86_64/libindy.so
rm -rf libindy_x86_64
rm x86_64.zip
```

Download the JNA libraries and deploy to `android/app/src/main/jniLibs/` as follows

```
curl --insecure -LO https://github.com/java-native-access/jna/raw/5.5.0/lib/native/android-aarch64.jar
jar xf android-aarch64.jar
mv libjnidispatch.so android/app/src/main/jniLibs/arm64-v8a/libjnidispatch.so
rm android-aarch64.jar

curl --insecure -LO https://github.com/java-native-access/jna/raw/5.5.0/lib/native/android-armv7.jar
jar xf android-armv7.jar
mv libjnidispatch.so android/app/src/main/jniLibs/armeabi-v7a/libjnidispatch.so
rm android-armv7.jar

curl --insecure -LO https://github.com/java-native-access/jna/raw/5.5.0/lib/native/android-x86.jar
jar xf android-x86.jar
mv libjnidispatch.so android/app/src/main/jniLibs/x86/libjnidispatch.so
rm android-x86.jar

curl --insecure -LO https://github.com/java-native-access/jna/raw/5.5.0/lib/native/android-x86-64.jar
jar xf android-x86-64.jar
mv libjnidispatch.so android/app/src/main/jniLibs/x86_64/libjnidispatch.so
rm android-x86-64.jar
```

Edit `android/app/src/appstore/java/com/mendix/nativetemplate/MainActivity.java` / `android/app/src/dev/java/com/mendix/nativetemplate/MainActivity.java` to load the relevant library

```
...
import android.os.Bundle;
import android.system.ErrnoException;
import android.system.Os;
import java.io.File;
...

public class MainActivity extends ReactActivity {
  ...

  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);

    try {
      Os.setenv("EXTERNAL_STORAGE", getExternalFilesDir(null).getAbsolutePath(), true);
      System.loadLibrary("indy");
    } catch (ErrnoException e) {
      e.printStackTrace();
    }
  }
}
```

Install the node modules by running the following

```
npm install --legacy-peer-deps
npm install @aries-framework/core
npm install @aries-framework/react-native
npm install react-native-fs
npm install react-native-get-random-values
npm install indy-sdk-react-native
```

For AriesTest, for the barcode scanner, also install the following

```
npm install react-native-camera 
npm install react-native-sensitive-info@next
```

Build the Android APK using the following 

```
cd ./android
./gradlew -x lint assembleDev
```

## Native Template Version 6.3.5 - AFJ 0.3.4 - iOS

Install the node modules by running the following

```
npm install --legacy-peer-deps
npm install @aries-framework/core
npm install @aries-framework/react-native
npm install react-native-fs
npm install react-native-get-random-values
npm install indy-sdk-react-native
```

Ensure the following sources are listed in `ios/Podfile`

```
source 'https://github.com/hyperledger/indy-sdk-react-native'
source 'https://cdn.cocoapods.org'
```

Install the pods as follows

```
cd ios
pod install
pod update Indy
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


## Speeding Up Build Process

When compiling the Android APK, all abis are included (`armeabi-v7a`, `arm64-v8a, x86`, `x86_64`). For local development, you can build a single abi as follows using the `PreactNativeArchitectures` flag with a comma seperated list of architectures for faster builds and smaller APKs.

```
./gradlew :app:assembleDebug -PreactNativeArchitectures=armeabi-v7a,arm64-v8a
```

or

```
./gradlew -x lint assembleDev -PreactNativeArchitectures=armeabi-v7a,arm64-v8a
```

Alternatively, edit `gradle.properties` as follows

```
reactNativeArchitectures=armeabi-v7a,arm64-v8a
```

With the above modifications to `gradle.properties` you can build as usual, no special flags have to be passed to `gradlew`.

If the above does not work, try using `abiFilters` by edting `android/app/build.gradle` as follows

```
buildTypes {
	release {
		ndk {
			abiFilters "armeabi-v7", "armeabi"
		}
	}
	debug {
		ndk {
			abiFilters "armeabi-v7", "armeabi"
		}
	}
}
```

You can create a separate apk for each architecture  by editing `android/app/build.gradle` as follows

```
def enableSeparateBuildPerCPUArchitecture = true
```

This will result in seperate APKs that are smaller, e.g.

```
android/app/build/outputs/apk/dev/debug/app-dev-arm64-v8a-debug.apk
android/app/build/outputs/apk/dev/debug/app-dev-armeabi-v7a-debug.apk
android/app/build/outputs/apk/dev/debug/app-dev-x86-debug.apk
android/app/build/outputs/apk/dev/debug/app-dev-x86_64-debug.apk
android/app/build/outputs/apk/dev/release/app-dev-arm64-v8a-release-unsigned.apk
android/app/build/outputs/apk/dev/release/app-dev-armeabi-v7a-release-unsigned.apk
android/app/build/outputs/apk/dev/release/app-dev-x86-release-unsigned.apk
android/app/build/outputs/apk/dev/release/app-dev-x86_64-release-unsigned.apk
```


## References

* [https://aries.js.org/guides/0.4/getting-started](https://aries.js.org/guides/0.4/getting-started)
* [https://reactnative.dev/docs/next/build-speed](https://reactnative.dev/docs/next/build-speed)
* [https://stackoverflow.com/questions/62511110/apk-file-size-is-big-in-react-native](https://stackoverflow.com/questions/62511110/apk-file-size-is-big-in-react-native)
* [https://stackoverflow.com/questions/54096295/how-do-i-exclude-abi-from-android-app-bundle](https://stackoverflow.com/questions/54096295/how-do-i-exclude-abi-from-android-app-bundle)
* [https://www.folio3.com/mobile/blog/how-to-reduce-apk-size-in-react-native/](https://www.folio3.com/mobile/blog/how-to-reduce-apk-size-in-react-native/)
* [https://dev.to/riteshshukla04/reduce-apk-size-in-react-native-aj6](https://dev.to/riteshshukla04/reduce-apk-size-in-react-native-aj6)
* [https://developer.android.com/build/shrink-code#groovy](https://developer.android.com/build/shrink-code#groovy)
* [https://dev.to/riteshshukla04/reduce-apk-size-in-react-native-aj6](https://dev.to/riteshshukla04/reduce-apk-size-in-react-native-aj6)
* [https://stackoverflow.com/questions/54096295/how-do-i-exclude-abi-from-android-app-bundle](https://stackoverflow.com/questions/54096295/how-do-i-exclude-abi-from-android-app-bundle)
* [https://stackoverflow.com/questions/30794584/exclude-jnilibs-folder-from-production-apk](https://stackoverflow.com/questions/30794584/exclude-jnilibs-folder-from-production-apk)
* [https://stackoverflow.com/questions/53322169/how-to-override-defaultconfig-abifilters-in-buildtypes](https://stackoverflow.com/questions/53322169/how-to-override-defaultconfig-abifilters-in-buildtypes)
