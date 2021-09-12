/*
 *  StopwatchCell.m
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
#import "StopwatchCell.h"

@implementation StopwatchCell

@synthesize pauseTime,addStopwatch,stopwatchStartTime,referenceDate;
@synthesize stopwatchFormat,fullDateFormat;
@synthesize pauseInterval;

@synthesize stopwatchRestartAfterStop,stopwatchIsRunningBool,viewControllerOpen;
@synthesize stopwatchRunning;
@synthesize startButton,stopButton,resetButton;
@synthesize stopwatchTextField;

@synthesize managedObject;

- (void) performInitialization
{
    [super performInitialization];

    // place any initialization code here

    startButton.highlighted = TRUE;
    stopwatchFormat = [[NSDateFormatter alloc]init];
    [stopwatchFormat setDateFormat:@"HH:mm:ss"];
    [stopwatchFormat setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];

    fullDateFormat = [[NSDateFormatter alloc]init];
    [fullDateFormat setDateFormat:@"y-mm-dd HH:mm:ss"];
    referenceDate = [stopwatchFormat dateFromString:@"00:00:00"];

    stopwatchIsRunningBool = [[self.boundObject valueForKey:@"stopwatchRunning"]boolValue];
//
}


- (void) loadBindingsIntoCustomControls
{
    addStopwatch = (NSDate *)[self.boundObject valueForKey:@"addStopwatch"];

    stopwatchTextField.text = [stopwatchFormat stringFromDate:addStopwatch];
}


- (void) customButtonTapped:(UIButton *)button forCell:(SCCustomCell *)cell
{
//
}


- (void) resetValuesToDefault
{
    [timer invalidate];
    stopwatchRestartAfterStop = NO;
    stopwatchIsRunningBool = NO;

    addStopwatch = referenceDate;
    stopwatchStartTime = [NSDate date];
    pauseInterval = 0;
    pauseTime = referenceDate;
    needsCommit = TRUE;
    [self commitChanges];
    stopwatchTextField.text = [stopwatchFormat stringFromDate:addStopwatch];
}


- (IBAction) stopButtonTapped:(id)sender
{
    [self toggleStartStopButtons];
    [self stopTheStopwatchTimer];

    @try
    {
        [[NSNotificationCenter defaultCenter]
         postNotificationName:@"stopwatchStopButtonTapped"
                       object:self];
    }
    @catch (NSException *exception)
    {
        //do nothing
    }
}


- (IBAction) resetButtonTapped:(id)sender
{
    startButton.highlighted = TRUE;
    startButton.hidden = FALSE;
    [self resetValuesToDefault];

    @try
    {
        [[NSNotificationCenter defaultCenter]
         postNotificationName:@"stopwatchResetButtonTapped"
                       object:self];
    }
    @catch (NSException *exception)
    {
        //do nothing
    }
}


- (void) toggleStartStopButtons
{
    startButton.highlighted = TRUE;
    stopButton.highlighted = TRUE;
    if (startButton.hidden)
    {
        startButton.hidden = FALSE;
        stopButton.hidden=YES;
    }
    else
    {
        startButton.hidden = TRUE;
        stopButton.hidden=NO;
    }
}


- (IBAction) startButtonTapped:(id)sender
{
    [self toggleStartStopButtons];
    [timer invalidate];

    stopwatchIsRunningBool = (BOOL)[[self.boundObject valueForKey:@"stopwatchRunning"] boolValue];

    stopwatchRestartAfterStop = (BOOL)[[self.boundObject valueForKey:@"stopwatchRestartAfterStop"] boolValue];

    pauseTime = (NSDate *)[self.boundObject valueForKey:@"pauseTime"];
    addStopwatch = (NSDate *)[self.boundObject valueForKey:@"addStopwatch"];

    pauseInterval = [[self.boundObject valueForKey:@"pauseInterval"] doubleValue];

    if (stopwatchIsRunningBool)
    {
        stopwatchStartTime = [self.boundObject valueForKey:@"stopwatchStartTime"];

        if (!stopwatchStartTime)
        {
            stopwatchStartTime = [NSDate date];
        }
    }
    else
    {
        stopwatchStartTime = [NSDate date];
    }

    now = [NSDate date];
    if (pauseTime)
    {
        //

        NSTimeInterval lastAddStopwatchDateTo1970 = [addStopwatch timeIntervalSinceDate:referenceDate];

        pauseInterval = lastAddStopwatchDateTo1970;

        if (stopwatchIsRunningBool)
        {
            NSTimeInterval pauseTimeToNow = [now timeIntervalSinceDate:pauseTime];

            pauseInterval = pauseInterval + pauseTimeToNow;

            stopwatchStartTime = [NSDate date];
            [self.boundObject setValue:stopwatchStartTime forKey:@"stopwatchStartTime"];
        }

        if (pauseInterval > 1)
        {
            //cut off miliseconds

            NSString *pauseIntervalString = [NSString stringWithFormat:@"%f",pauseInterval];

            NSRange range;
            range.length = 6;
            range.location = pauseIntervalString.length - 6;
            pauseIntervalString = [pauseIntervalString stringByReplacingCharactersInRange:range withString:@"000000"];

            pauseInterval = [pauseIntervalString doubleValue];
        }
        else
        {
            pauseInterval = 0;
        }
    }

    timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                             target:self
                                           selector:@selector(runStopwatch)
                                           userInfo:NULL
                                            repeats:YES];
}


- (void) stopTheStopwatchTimer
{
    [timer invalidate];
    stopwatchIsRunningBool = NO;
    stopwatchRestartAfterStop = YES;

    needsCommit = TRUE;
    [self commitChanges];
}


- (void) invalidateTheTimer
{
    [timer invalidate];
    if (stopwatchIsRunningBool)
    {
        [self runStopwatch];
    }
}


// overrides superclass
- (void) commitChanges
{
    if (!needsCommit)
    {
        return;
    }

    NSDictionary *stopwatchDictionary = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[NSNumber numberWithBool:stopwatchIsRunningBool], [NSNumber numberWithDouble:pauseInterval],pauseTime, stopwatchStartTime, [NSNumber numberWithBool:stopwatchRestartAfterStop], addStopwatch, nil] forKeys:[NSArray arrayWithObjects:@"stopwatchRunning", @"pauseInterval", @"pauseTime", @"stopwatchStartTime",   @"stopwatchRestartAfterStop",  @"addStopwatch",  nil]];

    [self.boundObject setValuesForKeysWithDictionary:stopwatchDictionary];

    [super commitChanges];
    needsCommit = FALSE;
}


- (void) runStopwatch
{
    now = [NSDate date];

//

    NSTimeInterval howLong = [now timeIntervalSinceDate:stopwatchStartTime];
    returnDate = [referenceDate dateByAddingTimeInterval:howLong];

    if (stopwatchIsRunningBool || stopwatchRestartAfterStop)
    {
        returnDate = [returnDate dateByAddingTimeInterval:pauseInterval];
    }

    addStopwatch = returnDate;

//
    stopwatchIsRunningBool = YES;

    pauseTime = [NSDate date];

    needsCommit = TRUE;

    stopwatchTextField.text = [stopwatchFormat stringFromDate:addStopwatch];

    @try
    {
        [[NSNotificationCenter defaultCenter]
         postNotificationName:@"addStopwatchChanged"
                       object:self];
    }
    @catch (NSException *exception)
    {
        //do nothing
    }
}


@end
