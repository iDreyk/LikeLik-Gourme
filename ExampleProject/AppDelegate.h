//
//  AppDelegate.h
//  MKDSlideViewController
//
//  Created by Ilya Tsarev on 03.04.13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
#import "GAI.h"
@class MKDSlideViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property(nonatomic, strong) id<GAITracker> tracker;
@property (nonatomic, strong) UIWindow * window;
@property (nonatomic, strong) MKDSlideViewController * slideViewController;
+(BOOL)isiPhone5;

+(UIFont *)OpenSansRegular:(CGFloat)size;
+(UIFont *)OpenSansSemiBold:(CGFloat)size;
+(UIFont *)OpenSansBoldwithSize:(CGFloat)size;
@property (strong, nonatomic) FBSession *session;

@end
