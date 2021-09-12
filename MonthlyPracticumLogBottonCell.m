/*
 *  MonthlyPracticumLogBottonCell.m
 *  psyTrack
 *  Version: 1.0
 *
 *
 The MIT License (MIT)
 Copyright © 2011- 2021 Daniel Boice
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 *
 *  Created by Daniel Boice on  6/26/12.
 *  Copyright (c) 2011 PsycheWeb LLC. All rights reserved.
 *
 *
 *	This notice may not be removed from this file.
 *
 */

#import "MonthlyPracticumLogBottonCell.h"
#import "InterventionTypeSubtypeEntity.h"
#import "MonthlyPracticumLogTopCell.h"
#import "QuartzCore/QuartzCore.h"
#import "ClinicianEntity.h"

@implementation MonthlyPracticumLogBottonCell

//@synthesize trackTypeWithTotalTimesObject=trackTypeWithTotalTimesObject_;
@synthesize cellSubTypeLabel;
@synthesize hoursWeek1Label;
@synthesize hoursWeek2Label;
@synthesize hoursWeek3Label;
@synthesize hoursWeek4Label;
@synthesize hoursWeek5Label;
@synthesize hoursWeekUndefinedLabel;
@synthesize hoursMonthTotalLabel;
@synthesize hoursCumulativeLabel;
@synthesize hoursTotalHoursLabel;
@synthesize cellsContainerView;

- (void) willDisplay
{
    [super willDisplay];

    self.cellSubTypeLabel.text = trackTypeWithTotalTimesObject_.typeLabelText;

    self.layer.borderWidth = 0;
    self.accessoryType = UITableViewCellAccessoryNone;
}


- (void) performInitialization
{
}


- (void) loadBindingsIntoCustomControls
{
    [super loadBindingsIntoCustomControls];

    trackTypeWithTotalTimesObject_ = (TrackTypeWithTotalTimes *)self.boundObject;

    self.cellSubTypeLabel.text = trackTypeWithTotalTimesObject_.typeLabelText;

    if (!monthToDisplay_ || !clinician_)
    {
        monthToDisplay_ = (NSDate *)trackTypeWithTotalTimesObject_.monthToDisplay;
    }

    self.hoursWeek1Label.text = trackTypeWithTotalTimesObject_.totalWeek1Str;
    self.hoursWeek2Label.text = trackTypeWithTotalTimesObject_.totalWeek2Str;
    self.hoursWeek3Label.text = trackTypeWithTotalTimesObject_.totalWeek3Str;
    self.hoursWeek4Label.text = trackTypeWithTotalTimesObject_.totalWeek4Str;
    self.hoursWeek5Label.text = trackTypeWithTotalTimesObject_.totalWeek5Str;

    if (self.hoursWeekUndefinedLabel)
    {
        self.hoursWeekUndefinedLabel.text = trackTypeWithTotalTimesObject_.totalWeekUndefinedStr;
    }

    self.hoursMonthTotalLabel.text = trackTypeWithTotalTimesObject_.totalForMonthStr;
    self.hoursCumulativeLabel.text = trackTypeWithTotalTimesObject_.totalCummulativeStr;
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
