//
//  AddViewABLinkButtonCell.m
//  PsyTrack Clinician Tools
//  Version: 1.0.6
//
//  Created by Daniel Boice on 5/15/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import "AddViewABLinkButtonCell.h"

@implementation AddViewABLinkButtonCell

- (void) performInitialization
{
    NSString *buttonOneStr = @"Edit Address Book Record";
    NSString *buttonTwoStr = @"Add to Address Book";

    self.buttonText = buttonOneStr;
    self.buttonTwoText = buttonTwoStr;
    [super performInitialization];
}


/*
   // Only override drawRect: if you perform custom drawing.
   // An empty implementation adversely affects performance during animation.
   - (void)drawRect:(CGRect)rect
   {
    // Drawing code
   }
 */

@end
