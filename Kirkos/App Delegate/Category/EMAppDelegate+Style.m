//
//  EMAppDelegate+Style.m
//  Kirkos
//
//  Created by Rui Peres on 18/10/2013.
//  Copyright (c) 2013 Emov. All rights reserved.
//

#import "EMAppDelegate+Style.h"
#import "UIColor+Hex.h"

@implementation EMAppDelegate (Style)

- (void)setupUI
{
    [[UINavigationBar appearance] setTitleTextAttributes:
        @{NSForegroundColorAttributeName: [UIColor whiteColor],
                     NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size:19.0]}];
}


@end
