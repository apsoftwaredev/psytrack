//
//  MonthlyPracticumLogBottonCell.m
//  PsyTrack
//
//  Created by Daniel Boice on 6/26/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import "MonthlyPracticumLogBottonCell.h"
#import "InterventionTypeSubtypeEntity.h"
@implementation MonthlyPracticumLogBottonCell


@synthesize cellSubTypeLabel;
@synthesize hoursWeek1Label;
@synthesize hoursWeek2Label;
@synthesize hoursWeek3Label;
@synthesize hoursWeek4Label;
@synthesize hoursWeek5Label;
@synthesize hoursMonthTotalLabel;
@synthesize hoursCumulativeLabel;
@synthesize hoursTotalHoursLabel;
@synthesize cellsContainerView;



-(void)willDisplay{

NSLog(@"self bound object is %@",self.boundObject);
    InterventionTypeSubtypeEntity *interventionTypeSubtype=(InterventionTypeSubtypeEntity *)self.boundObject;
    [interventionTypeSubtype willAccessValueForKey:@"interventionSubtype"];
    
    cellSubTypeLabel.text=interventionTypeSubtype.interventionSubType;
    [interventionTypeSubtype didAccessValueForKey:@"interventionSubtype"];
    self.accessoryType=UITableViewCellAccessoryNone;

}

-(void)performInitialization{


   

}

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
