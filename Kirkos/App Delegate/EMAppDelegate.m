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

static NSString *const kMainScreenViewController35Inches = @"EMMainScreenViewController4Inches";
static NSString *const kMainScreenViewController4Inches = @"EMMainScreenViewController35Inches";

@implementation EMAppDelegate

- (NSString *)nibNameToBeUsed
{
    NSString *nibNameToBeUsed = nil;
    if (isiPhone5)
    {
        nibNameToBeUsed = kMainScreenViewController4Inches;
    }
    else
    {
        nibNameToBeUsed = kMainScreenViewController35Inches;
    }
 
    return nibNameToBeUsed;
}

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
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    EMMainScreenViewController *mainScreenViewController = [[EMMainScreenViewController alloc] initWithNibName:[self nibNameToBeUsed] bundle:nil];
    UINavigationController *controller = [[UINavigationController alloc] initWithRootViewController:mainScreenViewController];
    
    [self setupUI];
    [[self window] setRootViewController:controller];

    return YES;
}

@end
