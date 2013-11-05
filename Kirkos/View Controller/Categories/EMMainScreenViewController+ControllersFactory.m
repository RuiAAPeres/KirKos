//
//  EMMainScreenViewController+ControllersFactory.m
//  Kirkos
//
//  Created by Rui Peres on 05/11/2013.
//  Copyright (c) 2013 Emov. All rights reserved.
//

#import "EMMainScreenViewController+ControllersFactory.h"
#import "EMConstants.h"
#import "UIColor+Hex.h"

@implementation EMMainScreenViewController (ControllersFactory)

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

@end
