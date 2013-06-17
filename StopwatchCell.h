/*
 *  StopwatchCell.h
 *  psyTrack Clinician Tools
 *  Version: 1.5.2
 *
 *
 *	THIS SOURCE CODE AND ANY ACCOMPANYING DOCUMENTATION ARE PROTECTED BY UNITED STATES
 *	INTELLECTUAL PROPERTY LAW AND INTERNATIONAL TREATIES. UNAUTHORIZED REPRODUCTION OR
 *	DISTRIBUTION IS SUBJECT TO CIVIL AND CRIMINAL PENALTIES.
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
