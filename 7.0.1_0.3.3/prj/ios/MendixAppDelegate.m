// DO NOT EDIT BY HAND. THIS FILE IS AUTO-GENERATED
#import <Foundation/Foundation.h>
#import <MendixNative.h>
#import "MendixAppDelegate.h"
#import <RNCPushNotificationIOS.h>

@implementation MendixAppDelegate

static UIResponder<UIApplicationDelegate, UNUserNotificationCenterDelegate> *_Nullable delegate;

+ (void) application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
  center.delegate = MendixAppDelegate.delegate;
}

+ (void) application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {

}

+ (void) application:(UIApplication *)application didReceiveRemoteNotification:(nonnull NSDictionary *)userInfo
fetchCompletionHandler:(nonnull void (^)(UIBackgroundFetchResult))completionHandler{

}

+ (void) application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {

}

+ (BOOL) application:(UIApplication *)application openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
  return YES;
}

+ (void) application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {

}

+ (void) userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler {
  completionHandler(UNNotificationPresentationOptionSound | UNNotificationPresentationOptionAlert | UNNotificationPresentationOptionBadge);
}

+ (void) userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler {
  [RNCPushNotificationIOS didReceiveNotificationResponse:response];
  completionHandler();
}

+ (UIResponder<UIApplicationDelegate, UNUserNotificationCenterDelegate> *_Nullable) delegate {
  return delegate;
}

+ (void) setDelegate:(UIResponder<UIApplicationDelegate, UNUserNotificationCenterDelegate> *_Nonnull)value {
  delegate = value;
}

+ (NSURL *) getJSBundleFile {

  return [ReactNative.instance getJSBundleFile];
}

@end
