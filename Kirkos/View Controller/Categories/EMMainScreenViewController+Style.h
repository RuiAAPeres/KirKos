//
//  EMMainScreenViewController+Style.h
//  Kirkos
//
//  Created by Rui Peres on 17/10/2013.
//  Copyright (c) 2013 Emov. All rights reserved.
//

#import "EMMainScreenViewController.h"

@class FXBlurView;

@interface EMMainScreenViewController (Style)

- (void)setupUI;

+ (UIImagePickerController *)buildPhotoPickerController;
+ (UIImagePickerController *)buildGalleryPickerController;
+ (UIView *)buildCircleWithCenter:(CGPoint)center;
+ (UIImageView *)buildImageViewWithImage:(UIImage *)image;

+ (FXBlurView *)buildBlurView;

@end
