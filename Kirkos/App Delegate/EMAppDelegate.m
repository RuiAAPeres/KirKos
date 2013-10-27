//
//  EMAppDelegate.m
//  Kirkos
//
//  Created by Rui Peres on 17/10/2013.
//  Copyright (c) 2013 Emov. All rights reserved.
//

#import "EMAppDelegate.h"
#import "EMMainScreenViewController.h"
#import "EMAppDelegate+Style.h"

#import "GAI.h"
#import "GAIDictionaryBuilder.h"
#import "GAIFields.h"

@implementation EMAppDelegate


- (void)setGoogleAnalytics
{
    [GAI sharedInstance].trackUncaughtExceptions = YES;
    
    
    static NSString *kGaPropertyId = @"UA-44995350-1";
    id tracker = [[GAI sharedInstance] trackerWithTrackingId:kGaPropertyId];
    [tracker set:kGAIUseSecure value:[@NO stringValue]];
    [[GAI sharedInstance] setDefaultTracker:tracker];
    [GAI sharedInstance].dispatchInterval = 1;

    [tracker send:[[[GAIDictionaryBuilder createEventWithCategory:@"UX"
                                                           action:@"appstart"
                                                            label:nil
                                                            value:nil] set:@"start" forKey:kGAISessionControl] build]];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self setGoogleAnalytics];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    NSString *nibToBeUsed = nil;
    if (isiPhone5)
    {
        nibToBeUsed = @"EMMainScreenViewController5Inches";
    }
    else
    {
        nibToBeUsed = @"EMMainScreenViewController4Inches";
    }
    
    EMMainScreenViewController *mainScreenViewController = [[EMMainScreenViewController alloc] initWithNibName:nibToBeUsed bundle:nil];
    UINavigationController *controller = [[UINavigationController alloc] initWithRootViewController:mainScreenViewController];
    
    [self setupUI];
    [[self window] setRootViewController:controller];

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [[GAI sharedInstance] dispatch];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
