/*
 *  StopwatchCell.h
 *  psyTrack Clinician Tools
 *  Version: 1.5.4
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
 *  Created by Daniel Boice on 10/11/11.
 *  Copyright (c) 2011 PsycheWeb LLC. All rights reserved.
 *
 *
 *	This notice may not be removed from this file.
 *
 */
#import <UIKit/UIKit.h>

@interface StopwatchCell : SCCustomCell {
    NSManagedObject *managedObject;
    NSDate *pauseTime;
    NSDate *addStopwatch;
    NSTimeInterval pauseInterval;
    BOOL stopwatchRestartAfterStop;
    NSDate *stopwatchStartTime;

    NSTimer *timer;
    NSDateFormatter *stopwatchFormat;
    NSDateFormatter *fullDateFormat;

    NSNumber *stopwatchRunning;
    BOOL stopwatchIsRunningBool;
    BOOL viewControllerOpen;
    NSDate *referenceDate;
    NSDate *returnDate;
    NSDate *now;
}
@property (strong, nonatomic) IBOutlet NSDate *pauseTime;
@property (strong, nonatomic) IBOutlet NSDate *addStopwatch;
@property (readwrite, nonatomic)  NSTimeInterval pauseInterval;
@property (readwrite, nonatomic)  BOOL stopwatchRestartAfterStop;
@property (strong, nonatomic) IBOutlet NSDate *stopwatchStartTime;

@property (strong, nonatomic)  NSDateFormatter *stopwatchFormat;
@property (strong, nonatomic)  NSDateFormatter *fullDateFormat;

@property (strong, nonatomic) IBOutlet NSNumber *stopwatchRunning;
@property (assign, nonatomic)  BOOL stopwatchIsRunningBool;
@property (assign, nonatomic) BOOL viewControllerOpen;
@property (strong, nonatomic) IBOutlet NSDate *referenceDate;
@property (strong, nonatomic) IBOutlet NSManagedObject *managedObject;

@property (nonatomic, weak, readonly) IBOutlet UIButton *startButton;
@property (nonatomic, weak, readonly) IBOutlet UIButton *stopButton;
@property (nonatomic, weak, readonly) IBOutlet UIButton *resetButton;
@property (nonatomic, weak) IBOutlet UITextField *stopwatchTextField;

- (IBAction) resetButtonTapped:(id)sender;
- (IBAction) startButtonTapped:(id)sender;
- (IBAction) stopButtonTapped:(id)sender;
- (void) runStopwatch;

- (void) stopTheStopwatchTimer;
- (void) resetValuesToDefault;

- (void) toggleStartStopButtons;
- (void) invalidateTheTimer;

@end
