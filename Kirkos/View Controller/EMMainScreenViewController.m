//
//  EMMainScreenViewController.m
//  Kirkos
//
//  Created by Rui Peres on 17/10/2013.
//  Copyright (c) 2013 Emov. All rights reserved.
//

#import "EMMainScreenViewController.h"

#import "EMMainScreenViewController+Style.h"
#import "EMMainScreenViewController+ViewsFactory.h"
#import "EMMainScreenViewController+ControllersFactory.h"
#import "EMMainScreenViewController+Animations.h"

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

- (void)viewDidAppear:(BOOL)animated
{
    [self animateOpenObjectiveWithCompletionBlock:^{}];
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
    
    [self.cancelButton addTarget:self action:@selector(handleEditionToPickingPhoto) forControlEvents:UIControlEventTouchUpInside];
    
    [self orderViews];
}

#pragma mark - Handle transictions

- (void)handlePickingPhotoToEdition
{
    [self animatePhotoPickingToEdition];
    
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
    
    [self animateEditionToPhotoPicking];
    
    [self.selectedImageView removeFromSuperview];
    [self.photoImagePicker.view setHidden:NO];
    self.selectedImageView = nil;
    
    [self.blurredView removeFromSuperview];
    
    id<GAITracker> defaultTracker = [[GAI sharedInstance] defaultTracker];
    [defaultTracker send:[[[GAIDictionaryBuilder createAppView]
                           set:@"Photo Mode" forKey:kGAIScreenName] build]];
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
        
        [self animateOpenObjectiveWithCompletionBlock:^{}];
        
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
