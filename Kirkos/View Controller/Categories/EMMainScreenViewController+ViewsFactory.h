//
//  EMMainScreenViewController+ViewsFactory.h
//  Kirkos
//
//  Created by Rui Peres on 05/11/2013.
//  Copyright (c) 2013 Emov. All rights reserved.
//

#import "EMMainScreenViewController.h"

@class FXBlurView;

@interface EMMainScreenViewController (ViewsFactory)

+ (UIView *)buildCircleWithCenter:(CGPoint)center;
+ (UIImageView *)buildImageViewWithImage:(UIImage *)image;
+ (FXBlurView *)buildBlurView;

@end
