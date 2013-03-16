//
//  AllHoursReportBottomCell.m
//  PsyTrack Clinician Tools
//  Version: 1.05
//
//  Created by Daniel Boice on 9/5/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import "AllHoursReportBottomCell.h"
#import "InterventionTypeSubtypeEntity.h"
#import "MonthlyPracticumLogTopCell.h"
#import "QuartzCore/QuartzCore.h"
#import "ClinicianEntity.h"

@implementation AllHoursReportBottomCell

@synthesize trackTypeWithTotalTimesObject = trackTypeWithTotalTimesObject_;
@synthesize cellSubTypeLabel;

@synthesize hoursTotalHoursLabel;
@synthesize cellsContainerView;

- (void) willDisplay
{
    [super willDisplay];

    self.cellSubTypeLabel.text = self.trackTypeWithTotalTimesObject.typeLabelText;

    self.layer.borderWidth = 0;
    self.accessoryType = UITableViewCellAccessoryNone;
}


- (void) performInitialization
{
}


- (void) loadBindingsIntoCustomControls
{
    [super loadBindingsIntoCustomControls];

    self.trackTypeWithTotalTimesObject = (TrackTypeWithTotalTimes *)self.boundObject;

    self.cellSubTypeLabel.text = trackTypeWithTotalTimesObject_.typeLabelText;

    self.hoursTotalHoursLabel.text = trackTypeWithTotalTimesObject_.totalToDateStr;
}


- (id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // Initialization code
    }

    return self;
}


@end
