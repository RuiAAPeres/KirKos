//
//  UIImage+Orientation.m
//  Kirkos
//
//  Created by Rui Peres on 19/10/2013.
//  Copyright (c) 2013 Emov. All rights reserved.
//

#import "UIImage+Orientation.h"

@implementation UIImage (Orientation)

+ (UIImage*)rotate:(UIImage*)image andOrientation:(UIImageOrientation)orientation;
{
    UIGraphicsBeginImageContext(image.size);
    
    CGContextRef context=(UIGraphicsGetCurrentContext());
    
    if (orientation == UIImageOrientationRight) {
        CGContextRotateCTM (context, 90/180*M_PI) ;
    } else if (orientation == UIImageOrientationLeft) {
        CGContextRotateCTM (context, -90/180*M_PI);
    } else if (orientation == UIImageOrientationDown) {
        // NOTHING
    } else if (orientation == UIImageOrientationUp) {
        CGContextRotateCTM (context, 90/180*M_PI);
    }
    
    [image drawAtPoint:CGPointMake(0, 0)];
    UIImage *img=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}


@end
