//
//  UIImage+Orientation.h
//  Kirkos
//
//  Created by Rui Peres on 19/10/2013.
//  Copyright (c) 2013 Emov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Orientation)

+ (UIImage*)rotate:(UIImage*)image andOrientation:(UIImageOrientation)orientation;

@end
