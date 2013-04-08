//
//  BigProgressViewWithBlockedView.m
//  PsyTrack Clinician Tools
//  Version: 1.5.1
//
//  Created by Daniel Boice on 7/19/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import "BigProgressViewWithBlockedView.h"

@implementation BigProgressViewWithBlockedView

- (id) initWithFrame:(CGRect)frame blockedView:(UIView *)blockedView
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // Initialization code

        sendingViewToBlock = blockedView;
    }

    return self;
}


/*
   // Only override drawRect: if you perform custom drawing.
   // An empty implementation adversely affects performance during animation.
   - (void)drawRect:(CGRect)rect
   {
   // Drawing code
   }
 */

- (void) startAnimatingProgressInBackground
{
    if (sendingViewToBlock)
    {
        [self startAnimatingOverView:sendingViewToBlock];
    }
}


@end
