//
//  EMMainScreenViewController+Animations.h
//  Kirkos
//
//  Created by Rui Peres on 05/11/2013.
//  Copyright (c) 2013 Emov. All rights reserved.
//

#import "EMMainScreenViewController.h"

@interface EMMainScreenViewController (Animations)

- (void)animateOpenObjectiveWithCompletionBlock:(void(^)())completionBlock;
- (void)animateCloseObjectiveWithCompletionBlock:(void(^)())completionBlock;

- (void)animatePhotoPickingToEdition;
- (void)animateEditionToPhotoPicking;

@end
