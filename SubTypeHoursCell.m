//
//  SubTypeHoursCell.m
//  PsyTrack
//
//  Created by Daniel Boice on 6/26/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import "SubTypeHoursCell.h"

@implementation SubTypeHoursCell
@synthesize subTypeTextLabel,weekOneLabel,weekTwoLabel,weekThreeLabel,weekFourLabel,weekFiveLabel,weekTotalLabel,cumulativeHoursLabel,totalHoursToDateLabel;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
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

@end
