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
	    //ndkVersion = "23.2.8568313"
        ndkVersion = "25.1.8937393"
        ...
    }
}
```

Add conditional logic for `repo.url`

```
allprojects {
    repositories {
        all { repo ->
            if (repo.hasProperty('url')) {
                println repo.url.toString()
                if (repo.url.toString().contains("jcenter.bintray.com") || repo.url.toString().contains("jitpack.io")) {
                    project.logger.warn "Repository ${repo.url} removed."
                    remove repo
                    google()
                    mavenLocal()
                    mavenCentral()
                }
            }
        }
   ...

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
    //Required by Credo (Formerly Aries Framework JavaScript)
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

Be sure to comment out the `jsc` implementation line

```
//implementation "org.webkit:android-jsc:r245459
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
npm run configure
```

## Native Template - iOS

This native template is located in directory `source/prj` in this source tree.

Install the node modules by running the following

```
npm install --legacy-peer-deps
npm run configure
```

Ensure the following sources are listed in `ios/Podfile`

```
source 'https://cdn.cocoapods.org'
```

For `@aries-framework/cheqd` to work, the Hermes engine needs to be used instead of JSCore. To do so, ammend `ios/Podfile` as follows:

```
  use_react_native!(
    :path => config[:reactNativePath],
    # Hermes is disabled by default to avoid incompatibilities and slowness with Mendix Runtime.
    :hermes_enabled => true,
    :fabric_enabled => false,
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
