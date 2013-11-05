//
//  EMMainScreenViewController+ViewsFactory.m
//  Kirkos
//
//  Created by Rui Peres on 05/11/2013.
//  Copyright (c) 2013 Emov. All rights reserved.
//

#import "EMMainScreenViewController+ViewsFactory.h"
#import "FXBlurView.h"

static CGRect imageViewFrame = {{0.0f,0.0f},{320.0f,320.0f}};
static CGRect circleFrame = {{180.0f,180.0f},{300.0f,300.0f}};
static CGFloat imagePickerViewControllerOffset = 32.0f;

@implementation EMMainScreenViewController (ViewsFactory)

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

@end
