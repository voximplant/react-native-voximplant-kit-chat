/*
 * Copyright (c) 2011 - 2025, Voximplant, Inc. All rights reserved.
 */

#import "RNVIKitChat.h"

#if __has_include("react_native_voximplant_kit_chat-Swift.h")
#import "react_native_voximplant_kit_chat-Swift.h"
#else
#import "react_native_voximplant_kit_chat/react_native_voximplant_kit_chat-Swift.h"
#endif

@implementation RNVIKitChat {
  RNVIKitChatImpl *impl;
}

+ (void)configureNavigationWithRootViewController:(UIViewController *)rootViewController {
  [RNVIKitChatImpl setRootViewController:rootViewController];
}

#ifdef RCT_NEW_ARCH_ENABLED
- (std::shared_ptr<facebook::react::TurboModule>)getTurboModule:
    (const facebook::react::ObjCTurboModule::InitParams &)params
{
    return std::make_shared<facebook::react::NativeVoximplantKitChatSpecJSI>(params);
}

+ (NSString *)moduleName {
  return @"VoximplantKitChat";
}
#else
RCT_EXPORT_MODULE(VoximplantKitChat)
#endif


- (instancetype)init {
    if (self = [super init]) {
      impl = [[RNVIKitChatImpl alloc] init];
    }
    return self;
}

RCT_EXPORT_METHOD(initialize:(nonnull NSString *)region
                  channelUuid:(nonnull NSString *)channelUuid
                        token:(nonnull NSString *)token
                     clientId:(nonnull NSString *)clientId
                      resolve:(nonnull RCTPromiseResolveBlock)resolve
                       reject:(nonnull RCTPromiseRejectBlock)reject) {
    [impl initializeWithRegion:region channelUuid:channelUuid token:token
                      clientId:clientId completion:^(NSString * _Nullable errorCode, NSString * _Nullable errorMessage) {
      if (errorCode && errorMessage) {
        dispatch_async(dispatch_get_main_queue(), ^{
          reject(errorCode, errorMessage, nil);
        });
      } else {
        dispatch_async(dispatch_get_main_queue(), ^{
          resolve([NSNull null]);
        });
      }
    }];
}

RCT_EXPORT_METHOD(openChat:(nonnull RCTPromiseResolveBlock)resolve reject:(nonnull RCTPromiseRejectBlock)reject) {
  [impl openChatWithCompletion:^(NSString * _Nullable errorCode, NSString * _Nullable errorMessage) {
    if (errorCode && errorMessage) {
      dispatch_async(dispatch_get_main_queue(), ^{
        reject(errorCode, errorMessage, nil);
      });
    } else {
      dispatch_async(dispatch_get_main_queue(), ^{
        resolve([NSNull null]);
      });
    }
  }];
}

RCT_EXPORT_METHOD(registerPushToken:(nonnull NSString *)token isDevelopment:(BOOL)isDevelopment resolve:(nonnull RCTPromiseResolveBlock)resolve reject:(nonnull RCTPromiseRejectBlock)reject) {
  [impl registerPushTokenWithToken:token isDevelopment:isDevelopment completion:^(NSString * _Nullable errorCode, NSString * _Nullable errorMessage) {
    if (errorCode) {
      dispatch_async(dispatch_get_main_queue(), ^{
        reject(errorCode, errorMessage, nil);
      });
    } else {
      dispatch_async(dispatch_get_main_queue(), ^{
        resolve([NSNull null]);
      });
    }
  }];
}

RCT_EXPORT_METHOD(setClientData:(nonnull NSDictionary *)clientData resolve:(nonnull RCTPromiseResolveBlock)resolve reject:(nonnull RCTPromiseRejectBlock)reject) {
  [impl setClientData:clientData completion:^(NSString * _Nullable errorCode, NSString * _Nullable errorMessage) {
    if (errorCode) {
      dispatch_async(dispatch_get_main_queue(), ^{
        reject(errorCode, errorMessage, nil);
      });
    } else {
      dispatch_async(dispatch_get_main_queue(), ^{
        resolve([NSNull null]);
      });
    }
  }];
}

RCT_EXPORT_METHOD(unregisterPushToken:(nonnull NSString *)token isDevelopment:(BOOL)isDevelopment resolve:(nonnull RCTPromiseResolveBlock)resolve reject:(nonnull RCTPromiseRejectBlock)reject) {
  [impl unregisterPushTokenWithToken:token isDevelopment:isDevelopment completion:^(NSString * _Nullable errorCode, NSString * _Nullable errorMessage) {
    if (errorCode) {
      dispatch_async(dispatch_get_main_queue(), ^{
        reject(errorCode, errorMessage, nil);
      });
    } else {
      dispatch_async(dispatch_get_main_queue(), ^{
        resolve([NSNull null]);
      });
    }
  }];
}

RCT_EXPORT_METHOD(customizeColors:(nonnull NSDictionary *)colorScheme) {
  [impl customizeColorsWithColorScheme:colorScheme];
}

RCT_EXPORT_METHOD(customizeStrings:(nonnull NSDictionary *)customizableStrings) {
  [impl customizeStrings:customizableStrings];
}

RCT_EXPORT_METHOD(customizeIcons:(nonnull NSDictionary *)customizableIcons) {
  [impl customizeIcons:customizableIcons];
}

@end
