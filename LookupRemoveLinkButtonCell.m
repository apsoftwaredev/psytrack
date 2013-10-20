//
//  LookupRemoveLinkButtonCell.m
//  PsyTrack Clinician Tools
//  Version: 1.5.3
//
//  Created by Daniel Boice on 5/15/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import "LookupRemoveLinkButtonCell.h"

@implementation LookupRemoveLinkButtonCell

- (void) performInitialization
{
    NSString *buttonOneStr = @"Remove Address Book Link";
    NSString *buttonTwoStr = @"Look Up In Address Book";

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
