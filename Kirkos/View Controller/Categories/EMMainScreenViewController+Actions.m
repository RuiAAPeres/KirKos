//
//  EMMainScreenViewController+Actions.m
//  Kirkos
//
//  Created by Rui Peres on 05/11/2013.
//  Copyright (c) 2013 Emov. All rights reserved.
//

#import "EMMainScreenViewController+Actions.h"
#import "EMMainScreenViewController+Animations.h"
#import "EMMainScreenViewController+TakePicture.h"
#import "EMMainScreenViewController+ControllersFactory.h"
#import "FXBlurView.h"

#import "GAI.h"
#import "GAIDictionaryBuilder.h"
#import "GAIFields.h"

@implementation EMMainScreenViewController (Actions)

#pragma mark - IBAction methods

-(IBAction)takePictureAction:(id)sender
{
    [[self actionsView] setUserInteractionEnabled:NO];
    
    [self animateCloseObjectiveWithCompletionBlock:^{
        [self.photoImagePicker takePicture];
    }];
}

- (IBAction)sharePhotoAction:(id)sender
{
    UIImage *screenShot = [self screenshot];
    
    UIActivityViewController *activityController =[[UIActivityViewController alloc]initWithActivityItems:@[screenShot] applicationActivities:nil];
    
    [activityController setCompletionHandler:^(NSString *activityType, BOOL completed)
     {
         if (completed && activityType)
         {
             id<GAITracker> defaultTracker = [[GAI sharedInstance] defaultTracker];
             [defaultTracker send:[[[GAIDictionaryBuilder createAppView]
                                    set:[NSString stringWithFormat:@"Photo shared -> %@",activityType] forKey:kGAIEventAction] build]];
         }
     }];
    
    [self presentViewController:activityController animated:YES completion:nil];
}

-(IBAction)galleryAction:(id)sender
{
    UIImagePickerController *galleryPicker = [EMMainScreenViewController buildGalleryPickerController];
    [galleryPicker setDelegate:self];
    
    [self presentViewController:galleryPicker animated:YES completion:NULL];
}

- (IBAction)toogleCircleAction:(id)sender
{
    BOOL toggleValue = ![self.circle isHidden];
    [self.circle setHidden:toggleValue];
    [self.enableCircleButton setSelected:toggleValue];
}

- (IBAction)saveImageAction:(id)sender
{
    UIImage *screenShot = [self screenshot];
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    
    [library writeImageToSavedPhotosAlbum:screenShot.CGImage orientation:ALAssetOrientationUp completionBlock:^(NSURL *assetURL, NSError *error)
     {
         if (error)
         {
             //TODO: Should be handled. 
         }
         else
         {
             [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"title_success", nil) message:NSLocalizedString(@"body_sucesss", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"ok_button", nil) otherButtonTitles:nil] show];
             
             id<GAITracker> defaultTracker = [[GAI sharedInstance] defaultTracker];
             [defaultTracker send:[[[GAIDictionaryBuilder createAppView]
                                    set:@"Photo saved!" forKey:kGAIEventAction] build]];
         }
     }];
}

- (IBAction)changeCameraOrientationAction:(id)sender
{
    if (self.photoImagePicker.cameraDevice == UIImagePickerControllerCameraDeviceFront)
    {
        self.photoImagePicker.cameraDevice = UIImagePickerControllerCameraDeviceRear;
    }
    else
    {
        self.photoImagePicker.cameraDevice = UIImagePickerControllerCameraDeviceFront;
    }
    
}

- (IBAction)changeCameraFlashAction:(id)sender
{
    if (self.photoImagePicker.cameraFlashMode == UIImagePickerControllerCameraFlashModeOn)
    {
        self.photoImagePicker.cameraFlashMode = UIImagePickerControllerCameraFlashModeOff;
        [self.flashButton setSelected:NO];
    }
    else
    {
        self.photoImagePicker.cameraFlashMode = UIImagePickerControllerCameraFlashModeOn;
        [self.flashButton setSelected:YES];
    }
}

- (IBAction)sliderAction:(UISlider *)slider
{
    [self.blurredView setBlurRadius:slider.value];
}

- (IBAction)closeAction:(id)sender{
    [self handleEditionToPickingPhoto];
}
@end
