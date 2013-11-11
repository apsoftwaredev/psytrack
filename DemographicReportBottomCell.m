//
//  DemographicReportBottomCell.m
//  PsyTrack Clinician Tools
//  Version: 1.5.5
//
//  Created by Daniel Boice on 9/16/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import "DemographicReportBottomCell.h"
#import "QuartzCore/QuartzCore.h"

@implementation DemographicReportBottomCell

@synthesize variableLabel;
@synthesize variableCountLabel;
@synthesize containerView;
@synthesize demVariableAndCount = demVariableAndCount_;

- (void) willDisplay
{
    [super willDisplay];

    self.variableLabel.text = self.demVariableAndCount.variableStr;

    self.layer.borderWidth = 0;
    self.accessoryType = UITableViewCellAccessoryNone;
}


- (void) performInitialization
{
}


- (void) loadBindingsIntoCustomControls
{
    [super loadBindingsIntoCustomControls];

    self.demVariableAndCount = (DemographicVariableAndCount *)self.boundObject;

    self.variableLabel.text = demVariableAndCount_.variableStr;

    self.variableCountLabel.text = demVariableAndCount_.variableCountStr;
}


@end
