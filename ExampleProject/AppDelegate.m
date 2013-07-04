//
//  AppDelegate.m
//  MKDSlideViewController
//
//  Created by Marcel Dierkes on 03.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "MKDSlideViewController.h"

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [AppDelegate lang];
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    if ([[NSString stringWithFormat:@"%@",[defaults objectForKey:@"curentLangSection"]] length] == 0) {
//        [[NSUserDefaults standardUserDefaults] setInteger:2 forKey:@"curentLangSection"];
//        [[NSUserDefaults standardUserDefaults] setInteger:1 forKey:@"curentLangRow"];
//    }
    
    _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
    
    UIViewController * mainViewController = [storyboard instantiateViewControllerWithIdentifier:@"NewMainViewController"];
    UIViewController * leftViewController = [storyboard instantiateViewControllerWithIdentifier:@"LeftViewController"];
    UIViewController * rightViewController = [storyboard instantiateViewControllerWithIdentifier:@"RightViewController"];
    
    _slideViewController = [[MKDSlideViewController alloc] initWithMainViewController:mainViewController];
    _slideViewController.leftViewController = leftViewController;
    _slideViewController.rightViewController = rightViewController;
    
    self.window.rootViewController = self.slideViewController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
}

- (void)applicationWillTerminate:(UIApplication *)application
{
}

+(void)lang{

    NSLog(@"System language: %@",[[NSLocale preferredLanguages] objectAtIndex:0]);
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([[defaults objectForKey:@"Language"] length] == 0){
            NSString * language = [[NSLocale preferredLanguages] objectAtIndex:0];
            if ([language isEqualToString:@"ru"]){
                LocalizationSetLanguage(@"ru");
                [defaults setObject:@"Русский" forKey:@"Language"];
            }
            if ([language isEqualToString:@"en"]){
                LocalizationSetLanguage(@"en");
                [defaults setObject:@"English" forKey:@"Language"];
            }
            if ([language isEqualToString:@"de"]){
                LocalizationSetLanguage(@"de");
                [defaults setObject:@"Deutsch" forKey:@"Language"];
            }
    }
    else{
        NSString *Lang = [defaults objectForKey:@"Language"];
        if ([Lang isEqualToString:@"Русский"]){
            LocalizationSetLanguage(@"ru");
        }
        if ([Lang isEqualToString:@"Deutsch"]){
            LocalizationSetLanguage(@"de");
        }
        if ([Lang isEqualToString:@"English"]){
            LocalizationSetLanguage(@"en");
        }
    }
}

@end
