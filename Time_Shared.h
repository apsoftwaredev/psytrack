/*
 *  Time_Shared.h
 *  psyTrack Clinician Tools
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
 *  Created by Daniel Boice on 10/5/11.
 *  Copyright (c) 2011 PsycheWeb LLC. All rights reserved.
 *
 *
 *	This notice may not be removed from this file.
 *
 */
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import "StopwatchCell.h"

@interface Time_Shared : SCViewController <SCViewControllerDelegate, SCTableViewModelDataSource, SCTableViewModelDelegate,UIGestureRecognizerDelegate>{
    NSTimer *timer;

    UITextField *stopwatchTextField;
    StopwatchCell *stopwatchCell;
    SCTableViewSection *timeSection;
    UILabel *footerLabel;
    UILabel *totalTimeHeaderLabel;

    BOOL viewControllerOpen;
    NSDate *startTime;
    NSDate *endTime;
    NSDate *additionalTime;
    NSDate *timeToSubtract;
    NSDateFormatter *counterDateFormatter;
    NSDate *referenceDate;
    NSDate *totalTimeDate;
    NSDate *addStopwatch;
    UILabel *breakTimeTotalHeaderLabel;
    SCTableViewSection *breakTimeSection;
}

//@property (strong, nonatomic) IBOutlet SCTableViewModel *detailTableModel;
@property (strong, nonatomic) IBOutlet UILabel *totalTimeHeaderLabel;
@property (strong, nonatomic) IBOutlet UILabel *footerLabel;
@property (strong, nonatomic)   NSDate *totalTimeDate;

//@property (readwrite, nonatomic) IBOutlet NSTimeInterval pauseInterval;
//@property (readwrite, nonatomic) IBOutlet BOOL stopwatchRestartAfterStop;
//@property (strong, nonatomic) IBOutlet NSDate *stopwatchStartTime;
//@property (strong, nonatomic) IBOutlet NSDate *totalTime;
//
//@property (strong, nonatomic) IBOutlet NSDateFormatter *stopwatchFormat;
//@property (strong, nonatomic) IBOutlet NSDateFormatter *fullDateFormat;
//
//@property (strong, nonatomic) IBOutlet NSNumber *stopwatchRunning;
//@property (readwrite, nonatomic) IBOutlet BOOL stopwatchIsRunningBool;
//@property (readwrite, nonatomic) IBOutlet BOOL viewControllerOpen;
//@property (strong, nonatomic) IBOutlet NSDate *referenceDate;
//@property (strong, nonatomic) IBOutlet  NSManagedObject *managedObject;

@property (strong, nonatomic) IBOutlet SCEntityDefinition *timeDef;
- (id) setupTheTimeViewUsingSTV;
- (void) calculateTime;
- (NSString *) tableViewModel:(SCTableViewModel *)tableViewModel calculateBreakTimeForRowAtIndexPath:(NSIndexPath *)indexPath withBoundValues:(BOOL)useBoundValues;
- (IBAction) stopwatchStop:(id)sender;
- (IBAction) stopwatchReset:(id)sender;
- (void) willDisappear;
- (NSTimeInterval) totalBreakTimeInterval;

@end
