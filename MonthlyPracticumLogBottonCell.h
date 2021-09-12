/*
 *  MonthlyPracticumLogBottonCell.h
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
 *  Created by Daniel Boice on 6/26/12.
 *  Copyright (c) 2011 PsycheWeb LLC. All rights reserved.
 *
 *
 *	This notice may not be removed from this file.
 *
 */

#import "ClinicianEntity.h"
#import "TrackTypeWithTotalTimes.h"

@interface MonthlyPracticumLogBottonCell : SCCustomCell {
    ClinicianEntity *clinician_;
    NSDate *monthToDisplay_;
    TrackTypeWithTotalTimes *trackTypeWithTotalTimesObject_;
}

//@property (nonatomic, strong)  TrackTypeWithTotalTimes *trackTypeWithTotalTimesObject;
@property (nonatomic, weak) IBOutlet UIView *cellsContainerView;
@property (nonatomic, weak) IBOutlet UILabel *cellSubTypeLabel;
@property (nonatomic, weak) IBOutlet UILabel *hoursWeek1Label;
@property (nonatomic, weak) IBOutlet UILabel *hoursWeek2Label;
@property (nonatomic, weak) IBOutlet UILabel *hoursWeek3Label;
@property (nonatomic, weak) IBOutlet UILabel *hoursWeek4Label;
@property (nonatomic, weak) IBOutlet UILabel *hoursWeek5Label;
@property (nonatomic, weak) IBOutlet UILabel *hoursWeekUndefinedLabel;
@property (nonatomic, weak) IBOutlet UILabel *hoursMonthTotalLabel;
@property (nonatomic, weak) IBOutlet UILabel *hoursCumulativeLabel;
@property (nonatomic, weak) IBOutlet UILabel *hoursTotalHoursLabel;

@end
