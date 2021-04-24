//
//  AppDelegate.m
//  Class
//
//  Created by Tony Wang on 11/22/16.
//  Copyright © 2016 TonyWang. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "DataKeeper.h"
@import GoogleMaps;
@import Firebase;

@interface AppDelegate ()
{
    ViewController* viCtrlFirst;
    DataKeeper* dataKeeper;
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [GMSServices provideAPIKey:GOOGLE_MAP_API_KEY];
    [FIRApp configure];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    viCtrlFirst = (ViewController*)[[ViewController alloc] viewFromStoryboard];
    UINavigationController* navRoot = [[UINavigationController alloc] initWithRootViewController:viCtrlFirst];
    [navRoot setNavigationBarHidden:YES];
    
    UIBarButtonItem *navBarButtonAppearance = [UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil];
    [navBarButtonAppearance setTitleTextAttributes:@{
                                                     NSFontAttributeName:            [UIFont systemFontOfSize:0.1],
                                                     NSForegroundColorAttributeName: [UIColor clearColor] }
                                          forState:UIControlStateNormal];
    
    self.window.rootViewController = navRoot;
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
