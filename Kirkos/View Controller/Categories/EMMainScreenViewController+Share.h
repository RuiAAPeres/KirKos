//
//  EMMainScreenViewController+Share.h
//  Kirkos
//
//  Created by Tiago Almeida on 1/11/14.
//  Copyright (c) 2014 Emov. All rights reserved.
//

#import "EMMainScreenViewController.h"

@interface EMMainScreenViewController (Share)<UIActionSheetDelegate, UIDocumentInteractionControllerDelegate>

@property (nonatomic, strong) UIDocumentInteractionController* documentsController;

-(void) openShareWithOrWithoutInstagram;

@end
