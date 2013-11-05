//
//  EMMainScreenViewController+Animations.m
//  Kirkos
//
//  Created by Rui Peres on 05/11/2013.
//  Copyright (c) 2013 Emov. All rights reserved.
//

#import "EMMainScreenViewController+Animations.h"

@implementation EMMainScreenViewController (Animations)

- (void)animateOpenObjectiveWithCompletionBlock:(void(^)())completionBlock
{
    [UIView animateWithDuration:0.1f animations:^{
        
        [self.topImage setFrame:CGRectMake(0.0f, -self.topImage.frame.size.height, self.topImage.frame.size.width, self.topImage.frame.size.height)];
        
        [self.botImage setFrame:CGRectMake(0.0f, 320.0f, self.botImage.frame.size.width, self.botImage.frame.size.height)];
    }completion:^(BOOL finished) {
        completionBlock();
    }];
}

- (void)animateCloseObjectiveWithCompletionBlock:(void(^)())completionBlock
{
    [UIView animateWithDuration:0.1f animations:^{
        
        [self.topImage setFrame:CGRectMake(0.0f, 0.0f, self.topImage.frame.size.width, self.topImage.frame.size.height)];
        
        [self.botImage setFrame:CGRectMake(0.0f, 160.0f, self.botImage.frame.size.width, self.botImage.frame.size.height)];
    }
                     completion:^(BOOL finished)
     {
         completionBlock();
     }];
}

- (void)animatePhotoPickingToEdition
{
    [self.cameraTools setFrame:CGRectMake(320.0f, self.cameraTools.frame.origin.y, self.cameraTools.frame.size.width, self.cameraTools.frame.size.height)];
    [self.cameraTools setHidden:NO];
    
    [UIView animateWithDuration:0.2f animations:^
     {
         [self.actionsView setFrame:CGRectMake(-self.actionsView.frame.size.width, self.actionsView.frame.origin.y, self.actionsView.frame.size.width, self.actionsView.frame.size.height)];
         
         [self.cameraTools setFrame:CGRectMake(0.0f, self.cameraTools.frame.origin.y, self.cameraTools.frame.size.width, self.cameraTools.frame.size.height)];
     }
                     completion:^(BOOL finished)
     {
         [self.actionsView setHidden:YES];
     }];
}

- (void)animateEditionToPhotoPicking
{
    [UIView animateWithDuration:0.2f animations:^{
        [self.cameraTools setFrame:CGRectMake(self.cameraTools.frame.size.width, self.cameraTools.frame.origin.y, self.cameraTools.frame.size.width, self.cameraTools.frame.size.height)];
        
        [self.actionsView setFrame:CGRectMake(0.0f, self.actionsView.frame.origin.y, self.actionsView.frame.size.width, self.actionsView.frame.size.height)];
    }completion:^(BOOL finished)
     {
         [self.cameraTools setHidden:YES];
     }];
}




@end
