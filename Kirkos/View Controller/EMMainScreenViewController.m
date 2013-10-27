//
//  EMMainScreenViewController.m
//  Kirkos
//
//  Created by Rui Peres on 17/10/2013.
//  Copyright (c) 2013 Emov. All rights reserved.
//

#import "EMMainScreenViewController.h"
#import "EMMainScreenViewController+Style.h"
#import "EMMainScreenViewController+TakePicture.h"
#import "UIImage+Orientation.h"
#import "EMConstants.h"
#import "FXBlurView.h"

#import "GAI.h"
#import "GAIFields.h"
#import "GAITracker.h"
#import "GAIDictionaryBuilder.h"

static CGRect cameraFrame = {{0.0f,0.0f},{320.0f,384.0f}};

@interface EMMainScreenViewController ()

@property (nonatomic,strong)UIImagePickerController *photoImagePicker;
@property (nonatomic,strong)NSDictionary *metadata;
@property (nonatomic,strong)UIView *circle;
@property (nonatomic,strong)FXBlurView *blurredView;
@property (nonatomic,strong)UIImageView *selectedImageView;

@end

@implementation EMMainScreenViewController

#pragma mark - UIView lifecycle

- (void)openObjectiveWithCompletionBlock:(void(^)())completionBlock
{
    [UIView animateWithDuration:0.1f animations:^{
        
        [self.topImage setFrame:CGRectMake(0.0f, -self.topImage.frame.size.height, self.topImage.frame.size.width, self.topImage.frame.size.height)];
        
        [self.botImage setFrame:CGRectMake(0.0f, 320.0f, self.botImage.frame.size.width, self.botImage.frame.size.height)];
    }completion:^(BOOL finished) {
        completionBlock();
    }];
}

- (void)closeObjectiveWithCompletionBlock:(void(^)())completionBlock
{
    [UIView animateWithDuration:0.1f animations:^{
        
        [self.topImage setFrame:CGRectMake(0.0f, 0.0f, self.topImage.frame.size.width, self.topImage.frame.size.height)];
        
        [self.botImage setFrame:CGRectMake(0.0f, 160.0f, self.botImage.frame.size.width, self.botImage.frame.size.height)];
    }
    completion:^(BOOL finished)
    {
         completionBlock();
    }];
}

- (void)viewDidAppear:(BOOL)animated
{
    [self openObjectiveWithCompletionBlock:^{
    }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupUI];
    
    self.photoImagePicker = [EMMainScreenViewController buildPhotoPickerController];
    [self.photoImagePicker setDelegate:self];
    [[self view]addSubview:[self.photoImagePicker view]];
    [self.photoImagePicker.view setFrame:cameraFrame];
    
    self.circle = [EMMainScreenViewController buildCircleWithCenter:self.photoImagePicker.view.center];
    [self.photoImagePicker setCameraOverlayView:self.circle];
    self.photoImagePicker.cameraFlashMode = UIImagePickerControllerCameraFlashModeOn;
    
    [[self view] bringSubviewToFront:self.flashButton];
    [[self view] bringSubviewToFront:self.switchCameraMode];
    
    [[self view] bringSubviewToFront:self.topImage];
    [[self view] bringSubviewToFront:self.botImage];
    
    [[self view] bringSubviewToFront:self.actionsView];
    [[self view] bringSubviewToFront:self.cameraTools];
}

#pragma mark - Animations

- (void)handlePickingPhotoToEdition
{
    [self.cameraTools setFrame:CGRectMake(320.0f, self.cameraTools.frame.origin.y, self.cameraTools.frame.size.width, self.cameraTools.frame.size.height)];
    [self.cameraTools setHidden:NO];
    
    [UIView animateWithDuration:0.2f animations:^{
        [self.actionsView setFrame:CGRectMake(-self.actionsView.frame.size.width, self.actionsView.frame.origin.y, self.actionsView.frame.size.width, self.actionsView.frame.size.height)];
        
        [self.cameraTools setFrame:CGRectMake(0.0f, self.cameraTools.frame.origin.y, self.cameraTools.frame.size.width, self.cameraTools.frame.size.height)];
    }
                     completion:^(BOOL finished) {
                         [self.actionsView setHidden:YES];
                     }];
    
    self.blurredView = [EMMainScreenViewController buildBlurView];
    [[self selectedImageView] addSubview:self.blurredView];
    
    
    id<GAITracker> defaultTracker = [[GAI sharedInstance] defaultTracker];
    [defaultTracker send:[[[GAIDictionaryBuilder createAppView]
                           set:@"Edition Mode" forKey:kGAIScreenName] build]];
}

- (void)handleEditionToPickingPhoto
{
    [self.actionsView setHidden:NO];
    [self.blurSlider setValue:25.0f];
    
    [UIView animateWithDuration:0.2f animations:^{
        [self.cameraTools setFrame:CGRectMake(self.cameraTools.frame.size.width, self.cameraTools.frame.origin.y, self.cameraTools.frame.size.width, self.cameraTools.frame.size.height)];
        
        [self.actionsView setFrame:CGRectMake(0.0f, self.actionsView.frame.origin.y, self.actionsView.frame.size.width, self.actionsView.frame.size.height)];
    }completion:^(BOOL finished)
     {
                         [self.cameraTools setHidden:YES];
     }];
        
    [self.selectedImageView removeFromSuperview];
    [self.photoImagePicker.view setHidden:NO];
    self.selectedImageView = nil;
    
    [self.blurredView removeFromSuperview];
    
    id<GAITracker> defaultTracker = [[GAI sharedInstance] defaultTracker];
    [defaultTracker send:[[[GAIDictionaryBuilder createAppView]
                           set:@"Photo Mode" forKey:kGAIScreenName] build]];
}

#pragma mark - IBAction methods

-(IBAction)takePictureAction:(id)sender
{
    [[self actionsView] setUserInteractionEnabled:NO];

    [self closeObjectiveWithCompletionBlock:^{
        [self.photoImagePicker takePicture];
    }];

}

- (IBAction)sharePhoto:(id)sender
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
    [[self circle] setHidden:toggleValue];
    [[self enableCircleButton] setSelected:toggleValue];
}

- (IBAction)saveImageAction:(id)sender
{
    UIImage *screenShot = [self screenshot];
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    
    [library writeImageToSavedPhotosAlbum:screenShot.CGImage orientation:ALAssetOrientationUp completionBlock:^(NSURL *assetURL, NSError *error)
     {
         if (error)
         {
             
         }
         else
         {
             [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"title_alert", nil) message:NSLocalizedString(@"body_alert", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"ok_button", nil) otherButtonTitles:nil] show];
             
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

- (IBAction)closeAction:(id)sender
{
    [self handleEditionToPickingPhoto];
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
#pragma mark - UIImagePickerDelegate Implementation

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *imageTaken = nil;
    
    if (info)
    {
        self.metadata = info[UIImagePickerControllerMediaMetadata];
        if (info[UIImagePickerControllerEditedImage])
        {
            imageTaken = info[UIImagePickerControllerEditedImage];
            [picker dismissViewControllerAnimated:YES completion:NULL];
        }
        else
        {
            imageTaken = info[UIImagePickerControllerOriginalImage];
            imageTaken = [UIImage rotate:imageTaken andOrientation:UIImageOrientationUp];
        }
        
        self.selectedImageView = [EMMainScreenViewController buildImageViewWithImage:imageTaken];
        [[self view] addSubview:self.selectedImageView];
        [[self view] insertSubview:self.selectedImageView belowSubview:self.botImage];
        [[self view] insertSubview:self.selectedImageView belowSubview:self.topImage];

        [self openObjectiveWithCompletionBlock:^{
            
        }];
        
        [[self actionsView] setUserInteractionEnabled:YES];
        [[self.photoImagePicker view] setHidden:YES];
        
        [self handlePickingPhotoToEdition];
    }
    
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
}


@end
