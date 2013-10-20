//
//  EMMainScreenViewController+TakePicture.m
//  Kirkos
//
//  Created by Rui Peres on 19/10/2013.
//  Copyright (c) 2013 Emov. All rights reserved.
//

#import "EMMainScreenViewController+TakePicture.h"

@implementation EMMainScreenViewController (TakePicture)

- (UIImage *)screenshot
{
    UIGraphicsBeginImageContextWithOptions(self.selectedImageView.frame.size, YES, 0);
    [self.selectedImageView drawViewHierarchyInRect:self.selectedImageView.frame afterScreenUpdates:NO];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
