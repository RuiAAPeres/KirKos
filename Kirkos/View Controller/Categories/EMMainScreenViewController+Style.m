//
//  EMMainScreenViewController+Style.m
//  Kirkos
//
//  Created by Rui Peres on 17/10/2013.
//  Copyright (c) 2013 Emov. All rights reserved.
//

#import "EMMainScreenViewController+Style.h"
#import "EMConstants.h"
#import "UIColor+Hex.h"

static NSString *const kTakePhotoImageHighlighted = @"btn_ShutterHighlighted";
static NSString *const kTakePhotoImageNormal = @"btn_Shutter";

static NSString *const kEditPhotoImageHighlighted = @"btn_ShutterOkHighlighted";
static NSString *const kEditPhotoImageNormal = @"btn_ShutterOk";

static NSString *const kGalleryImageHighlighted = @"btn_PhotoLibraryHighlighted";
static NSString *const kGalleryImageNormal = @"btn_PhotoLibrary";

static NSString *const kSwitchModeImageHighlighted = @"btn_SwitchCameraHighlighted";
static NSString *const kSwitchModeImageNormal = @"btn_SwitchCamera";

static NSString *const kCircleOn = @"btn_CircleFrame_on";
static NSString *const kCircleOff = @"btn_CircleFrame_off";

static NSString *const kFlashOn = @"btn_FlashOn";
static NSString *const kFlashOff = @"btn_FlashOff";

static NSString *const kDeleteButtonImageHighlighted = @"btn_deleteHighlighted";
static NSString *const kDeleteButtonImage = @"btn_delete";

static NSString *const kCheckButtonImageHighlighted = @"btn_checkHighlighted";
static NSString *const kCheckButtonImage = @"btn_check";

static NSString *const kShareButtonImageHighlighted = @"btn_shareHighlighted";
static NSString *const kShareButtonImage = @"btn_share";

static NSString *const kKirKosTitleImage = @"KirKos_Logo";

static CGRect buttonFrame = {{0.0f,0.0f},{44.0f,44.0f}};

@implementation EMMainScreenViewController (Style)

#pragma mark - Setup UI Methods

- (void)setupUI
{
    
    BOOL isFlashAvailabel = [UIImagePickerController isFlashAvailableForCameraDevice:UIImagePickerControllerCameraDeviceRear];
    
    if (!isFlashAvailabel)
    {
        [self.flashButton removeFromSuperview];
    }
    
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:kKirKosTitleImage]];
    
    {
        [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithHexString:NAVBAR_GREY]];
        [[self actionsView] setBackgroundColor:[UIColor colorWithHexString:NAVBAR_GREY]];
        [[self cameraTools] setBackgroundColor:[UIColor colorWithHexString:NAVBAR_GREY]];
        [[self sliderView] setBackgroundColor:[UIColor colorWithHexString:LIGHT_GREY]];
    }
    
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.navigationController.navigationBar.translucent = NO;
    }
    
    {
        [self.galleryButton setImage:[UIImage imageNamed:kGalleryImageHighlighted] forState:UIControlStateHighlighted];
        [self.galleryButton setImage:[UIImage imageNamed:kGalleryImageNormal] forState:UIControlStateNormal];
        
        [self.enableCircleButton setImage:[UIImage imageNamed:kCircleOn] forState:UIControlStateNormal];
        [self.enableCircleButton setImage:[UIImage imageNamed:kCircleOff] forState:UIControlStateSelected];
        
        [self.switchCameraMode setImage:[UIImage imageNamed:kSwitchModeImageNormal] forState:UIControlStateNormal];
        [self.switchCameraMode setImage:[UIImage imageNamed:kSwitchModeImageHighlighted] forState:UIControlStateHighlighted];
        
        [self.flashButton setImage:[UIImage imageNamed:kFlashOn] forState:UIControlStateSelected];
        [self.flashButton setImage:[UIImage imageNamed:kFlashOff] forState:UIControlStateNormal];
        [self.flashButton setSelected:YES];
        
        [self.cancelButton setImage:[UIImage imageNamed:kDeleteButtonImageHighlighted] forState:UIControlStateHighlighted];
        [self.cancelButton setImage:[UIImage imageNamed:kDeleteButtonImage] forState:UIControlStateNormal];
        
        [self.sharePhotoButton setImage:[UIImage imageNamed:kShareButtonImageHighlighted] forState:UIControlStateHighlighted];
        [self.sharePhotoButton setImage:[UIImage imageNamed:kShareButtonImage] forState:UIControlStateNormal];
        
        [self.acceptPhotoButton setImage:[UIImage imageNamed:kCheckButtonImageHighlighted] forState:UIControlStateHighlighted];
        [self.acceptPhotoButton setImage:[UIImage imageNamed:kCheckButtonImage] forState:UIControlStateNormal];
        
        [self.takePhotoButton setImage:[UIImage imageNamed:kTakePhotoImageHighlighted] forState:UIControlStateHighlighted];
        [self.takePhotoButton setImage:[UIImage imageNamed:kTakePhotoImageNormal] forState:UIControlStateNormal];
    }
    
    {
        UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [closeButton setFrame:buttonFrame];
        
        UIImage *normalImage = [UIImage imageNamed:kDeleteButtonImage];
        [closeButton setBackgroundImage:normalImage forState:UIControlStateNormal];
        
        UIImage *highlightedImage = [UIImage imageNamed:kDeleteButtonImageHighlighted];
        [closeButton setBackgroundImage:highlightedImage forState:UIControlStateHighlighted];
                
        self.closeBarButton = [[UIBarButtonItem alloc] initWithCustomView:closeButton];
    }
}

- (void)orderViews
{
    [[self view] bringSubviewToFront:self.flashButton];
    [[self view] bringSubviewToFront:self.switchCameraMode];
    
    [[self view] bringSubviewToFront:self.topImage];
    [[self view] bringSubviewToFront:self.botImage];
    
    [[self view] bringSubviewToFront:self.actionsView];
    [[self view] bringSubviewToFront:self.cameraTools];
}


@end
