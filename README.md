# Mendix React Native Template for AriesJS Project

## Native Template Version 6.3.5 - Android

This native template is located in directory `6.3.5` in this source tree.

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

Build the Android APK using the following 

```
cd ./android
./gradlew -x lint assembleDev
```

## Native Template Version 6.3.5 - iOS

Todo ...

