//
//  EMMainScreenViewController.h
//  Kirkos
//
//  Created by Rui Peres on 17/10/2013.
//  Copyright (c) 2013 Emov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/ALAsset.h>
#import "GAITrackedViewController.h"

@class FXBlurView;

@interface EMMainScreenViewController : GAITrackedViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic,weak)IBOutlet UIView *actionsView;
@property (nonatomic,weak)IBOutlet UIView *cameraTools;
@property (nonatomic,weak)IBOutlet UIView *sliderView;

@property (nonatomic,weak)IBOutlet UIButton *acceptPhotoButton;
@property (nonatomic,weak)IBOutlet UIButton *sharePhotoButton;
@property (nonatomic,weak)IBOutlet UIButton *cancelButton;
@property (nonatomic, weak)IBOutlet UIImageView *topImage;
@property (nonatomic, weak)IBOutlet UIImageView *botImage;

@property (nonatomic,weak)IBOutlet UISlider *blurSlider;
@property (nonatomic,strong)UIBarButtonItem *closeBarButton;

@property (nonatomic,weak)IBOutlet UIButton *takePhotoButton;
@property (nonatomic,weak)IBOutlet UIButton *galleryButton;
@property (nonatomic,weak)IBOutlet UIButton *enableCircleButton;
@property (nonatomic,weak)IBOutlet UIButton *switchCameraMode;
@property (nonatomic,weak)IBOutlet UIButton *flashButton;

@property (nonatomic,strong, readonly)UIImageView *selectedImageView;

@property (nonatomic,strong,readonly)UIImagePickerController *photoImagePicker;
@property (nonatomic,strong,readonly)UIView *circle;
@property (nonatomic,strong,readonly)FXBlurView *blurredView;

- (void)handleEditionToPickingPhoto;

@end
