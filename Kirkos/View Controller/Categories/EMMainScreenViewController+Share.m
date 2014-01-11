//
//  EMMainScreenViewController+Share.m
//  Kirkos
//
//  Created by Tiago Almeida on 1/11/14.
//  Copyright (c) 2014 Emov. All rights reserved.
//

#import "EMMainScreenViewController+Share.h"
#import "EMMainScreenViewController+TakePicture.h"

#import "GAI.h"
#import "GAIDictionaryBuilder.h"
#import "GAIFields.h"


static NSString* const kInstagramSchemeURL = @"instagram://";

NS_ENUM(NSInteger, ActionSheetOption) {
    OpenInstagramActionSheetOption,
    ShareActionSheetOption
};

@implementation EMMainScreenViewController (Share)

@dynamic documentsController;

-(void) openShareWithOrWithoutInstagram {
    //If the user has instagram we show an actionsheet with open on instagram + share
    NSURL *instagramURL = [NSURL URLWithString:kInstagramSchemeURL];
    
    if ([[UIApplication sharedApplication] canOpenURL:instagramURL]) {
        
        UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:NSLocalizedString(@"select_action_sheet_option", nil)
                                                           delegate:self
                                                  cancelButtonTitle:NSLocalizedString(@"cancel", nil)
                                             destructiveButtonTitle:nil
                                                  otherButtonTitles:NSLocalizedString(@"open_instagram", nil),
                                                                    NSLocalizedString(@"share", nil), nil ];
        
        [popup showInView:[UIApplication sharedApplication].keyWindow];
    } else {
        [self share];
    }
}

#pragma mark - ActionSheet delegate

- (void)actionSheet:(UIActionSheet *)popup clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case OpenInstagramActionSheetOption:
            [self openPhotoInInstagram];
            break;
        case ShareActionSheetOption:
            [self share];
            break;
        default:
            break;
    }
}

#pragma mark - ActionSheet options

-(void) share {
    UIImage *screenShot = [self screenshot];
    
    UIActivityViewController *activityController =[[UIActivityViewController alloc]initWithActivityItems:@[screenShot] applicationActivities:nil];
    
    [activityController setCompletionHandler:^(NSString *activityType, BOOL completed)
     {
         if (completed && activityType) {
             id<GAITracker> defaultTracker = [[GAI sharedInstance] defaultTracker];
             [defaultTracker send:[[[GAIDictionaryBuilder createAppView]
                                    set:[NSString stringWithFormat:@"Photo shared -> %@",activityType] forKey:kGAIEventAction] build]];
         }
     }];
    
    [self presentViewController:activityController animated:YES completion:nil];
}

-(void) openPhotoInInstagram {
    NSURL *instagramURL = [NSURL URLWithString:kInstagramSchemeURL];
    if ([[UIApplication sharedApplication] canOpenURL:instagramURL]) {
        NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        NSString *savedImagePath = [documentsDirectory stringByAppendingPathComponent:@"Image.igo"];
        
        UIImage *screenShot = [self screenshot];
        
        NSData *imageData = UIImagePNGRepresentation(screenShot);
        [imageData writeToFile:savedImagePath atomically:YES];
        NSURL *imageUrl = [NSURL fileURLWithPath:savedImagePath];
        
        self.documentsController = [[UIDocumentInteractionController alloc] init];
        self.documentsController.delegate = self;
        self.documentsController.UTI = @"com.instagram.exclusivegram";
        self.documentsController.URL = imageUrl;
        
        [self.documentsController presentOpenInMenuFromRect:CGRectZero inView:self.view animated:YES];
    }
}

@end
