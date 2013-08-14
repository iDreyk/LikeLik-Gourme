//
//  AppDelegate.m
//  MKDSlideViewController
//
//  Created by Ilya Tsarev on 03.04.13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "MKDSlideViewController.h"

@implementation AppDelegate

+(BOOL)isiPhone5{
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        CGSize result = [[UIScreen mainScreen] bounds].size;
        if (result.height < 500)
            return NO;  // iPhone 4S / 4th Gen iPod Touch or earlier
        else
            return YES;  // iPhone 5
    }
    else
    {
        return NO; // iPad
    }
}

+(UIFont *)OpenSansRegular:(CGFloat)size{
    UIFont* font = [UIFont fontWithName:@"OpenSans" size:size/2];
    return font;
}
+(UIFont *)OpenSansSemiBold:(CGFloat)size{
    UIFont* font = [UIFont fontWithName:@"OpenSans-Semibold" size:size/2];
    // //    nslog(@"%@",font);
    return font;
    
}

+(UIFont *)OpenSansBoldwithSize:(CGFloat)size{
    UIFont* font = [UIFont fontWithName:@"OpenSans-Bold" size:size/2];
    return font;
}

+(UIFont *)OpenSansLight:(CGFloat)size{
    UIFont *font = [UIFont fontWithName:@"OpenSans" size:size/2];
    // //    nslog(@"Light 26 = %@",font);
    return font;
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    // attempt to extract a token from the url
    return [FBAppCall handleOpenURL:url
                  sourceApplication:sourceApplication
                        withSession:self.session];
}

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
    UIViewController * blackView = [storyboard instantiateViewControllerWithIdentifier:@"BlackViewController"];
    
    _slideViewController = [[MKDSlideViewController alloc] initWithMainViewController:mainViewController];
    _slideViewController.leftViewController = leftViewController;
    _slideViewController.rightViewController = rightViewController;
    _slideViewController.blackViewController = blackView;
    
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
    [FBAppEvents activateApp];
    
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
    
    // FBSample logic
    // We need to properly handle activation of the application with regards to SSO
    //  (e.g., returning from iOS 6.0 authorization dialog or from fast app switching).
    [FBAppCall handleDidBecomeActiveWithSession:self.session];

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
