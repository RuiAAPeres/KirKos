//
//  EMMainScreenViewController+ControllersFactory.h
//  Kirkos
//
//  Created by Rui Peres on 05/11/2013.
//  Copyright (c) 2013 Emov. All rights reserved.
//

#import "EMMainScreenViewController.h"

@interface EMMainScreenViewController (ControllersFactory)

+ (UIImagePickerController *)buildPhotoPickerController;
+ (UIImagePickerController *)buildGalleryPickerController;

@end
