//
//  EMMainScreenViewController+Style.m
//  Kirkos
//
//  Created by Rui Peres on 17/10/2013.
//  Copyright (c) 2013 Emov. All rights reserved.
//

#import "EMMainScreenViewController+Style.h"
#import "FXBlurView.h"
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


static CGRect imageViewFrame = {{0.0f,0.0f},{320.0f,320.0f}};
static CGRect circleFrame = {{180.0f,180.0f},{300.0f,300.0f}};
static CGRect buttonFrame = {{0.0f,0.0f},{44.0f,44.0f}};

static CGFloat imagePickerViewControllerOffset = 32.0f;

@implementation EMMainScreenViewController (Style)

#pragma mark - Build Methods

+ (FXBlurView *)buildBlurView
{
    FXBlurView *blurView = [[FXBlurView alloc] initWithFrame:imageViewFrame];
    blurView.dynamic = NO;
    blurView.blurRadius = 25.0f;
    [blurView setTintColor:[UIColor clearColor]];
    
    int radius = circleFrame.size.width/2.0f;
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:imageViewFrame cornerRadius:0];
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(10.0f, 10.0f, 2.0*radius, 2.0*radius) cornerRadius:radius];
    [path appendPath:circlePath];
    [path setUsesEvenOddFillRule:YES];
    
    CAShapeLayer *fillLayer = [CAShapeLayer layer];
    fillLayer.path = path.CGPath;
    fillLayer.fillRule = kCAFillRuleEvenOdd;
    fillLayer.fillColor = [UIColor whiteColor].CGColor;
    
    blurView.layer.mask = fillLayer;
    
    return blurView;
}


+ (UIImagePickerController *)buildPhotoPickerController;
{
    UIImagePickerController *imagePicker= [[UIImagePickerController alloc] init];
    [imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
    [imagePicker setShowsCameraControls:NO];
    
    return imagePicker;
}

+ (UIImagePickerController *)buildGalleryPickerController
{
    UIImagePickerController *imagePicker= [[UIImagePickerController alloc] init];
    [imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    imagePicker.navigationBar.barTintColor = [UIColor colorWithHexString:NAVBAR_GREY];
    [imagePicker.navigationBar setTintColor:[UIColor whiteColor]];
    imagePicker.navigationBar.translucent = NO;
    [imagePicker setAllowsEditing:YES];
    
    return imagePicker;
}

+ (UIView *)buildCircleWithCenter:(CGPoint)center
{
    UIView *circleView = [[UIView alloc] initWithFrame:circleFrame];
    
    [circleView.layer setCornerRadius:circleView.frame.size.width/2.0f];
    [circleView setBackgroundColor:[UIColor clearColor]];
    [circleView.layer setBorderWidth:1.0f];
    [circleView.layer setBorderColor:[UIColor whiteColor].CGColor];
    [circleView setCenter:CGPointMake(center.x, center.y - imagePickerViewControllerOffset)];
    
    return circleView;
}


+ (UIImageView *)buildImageViewWithImage:(UIImage *)imageTaken
{
    UIImageView *selectedImageView = [[UIImageView alloc] initWithFrame:imageViewFrame];

    CGImageRef imageRef = CGImageCreateWithImageInRect([imageTaken CGImage], CGRectMake(0.0f, 0.0f, imageTaken.size.width, imageTaken.size.width));
    [selectedImageView setImage:[UIImage imageWithCGImage:imageRef]];
    CGImageRelease(imageRef);
    
    return selectedImageView;
}

#pragma mark - Setup UI Methods

- (void)setupUI
{
    
    BOOL isFlashAvailabel = [UIImagePickerController isFlashAvailableForCameraDevice:UIImagePickerControllerCameraDeviceRear];
    
    if (!isFlashAvailabel)
    {
        [self.flashButton removeFromSuperview];
    }
    
    {
        self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:kKirKosTitleImage]];
    }
    
    // Colour
    {
        [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithHexString:NAVBAR_GREY]];
        [[self actionsView] setBackgroundColor:[UIColor colorWithHexString:NAVBAR_GREY]];
        [[self cameraTools] setBackgroundColor:[UIColor colorWithHexString:NAVBAR_GREY]];
        [[self sliderView] setBackgroundColor:[UIColor colorWithHexString:LIGHT_GREY]];
    }
    
    // NavigationBar
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.navigationController.navigationBar.translucent = NO;
    }
    
    // Button's Images
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
        
        [closeButton addTarget:self action:@selector(closeAction:) forControlEvents:UIControlEventTouchUpInside];
        
        self.closeBarButton = [[UIBarButtonItem alloc] initWithCustomView:closeButton];
    }
}

@end
