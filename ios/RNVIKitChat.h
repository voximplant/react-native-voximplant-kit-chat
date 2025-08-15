/*
 * Copyright (c) 2011 - 2025, Voximplant, Inc. All rights reserved.
 */

#ifdef RCT_NEW_ARCH_ENABLED

#import <VoximplantKitChatSpec/VoximplantKitChatSpec.h>
@interface RNVIKitChat : NSObject <NativeVoximplantKitChatSpec>

+ (void)configureNavigationWithRootViewController:(UIViewController *)rootViewController;

@end

#else

#import <React/RCTBridgeModule.h>
@interface RNVIKitChat: NSObject <RCTBridgeModule>

+ (void)configureNavigationWithRootViewController:(UIViewController *)rootViewController;

@end

#endif
