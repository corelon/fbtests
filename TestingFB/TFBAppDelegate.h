//
//  TFBAppDelegate.h
//  TestingFB
//
//  Created by Nikos Tzanos on 6/2/13.
//  Copyright (c) 2013 Nikos Tzanos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

@class TFBViewController;

@interface TFBAppDelegate : UIResponder <UIApplicationDelegate>

extern NSString *const FBSessionStateChangedNotification;
@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) TFBViewController *viewController;
- (BOOL)openSessionWithAllowLoginUI:(BOOL)allowLoginUI;
- (void)closeSession;
- (void)sendRequest;

@end
