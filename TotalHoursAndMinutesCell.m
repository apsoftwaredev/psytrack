//
//  TotalHoursAndMinutesCell.m
//  PsyTrack Clinician Tools
//  Version: 1.5.1
//
//  Created by Daniel Boice on 7/7/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import "TotalHoursAndMinutesCell.h"
#import "PresentationsViewController.h"
@implementation TotalHoursAndMinutesCell
@synthesize hours,minutes,totalTime = totalTime_;
@synthesize hoursTF,minutesTF,TotalHoursLabel;

- (id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // Initialization code
    }

    return self;
}


- (void) performInitialization
{
    [super performInitialization];

    self.autoValidateValue = NO;
}


- (void) loadBindingsIntoCustomControls
{
    [super loadBindingsIntoCustomControls];

    if (!self.needsCommit)
    {
        if ([self.ownerTableViewModel.masterModel.viewController isKindOfClass:[PresentationsViewController class]])
        {
            keyString = @"length";
            self.TotalHoursLabel.text = nil;
        }
        else
        {
            keyString = @"hours";
        }

        self.totalTime = (NSDate *)[self.boundObject valueForKey:keyString];

        NSCalendar *calendar = [NSCalendar currentCalendar];
        [calendar setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];

        NSTimeInterval totalTimeTI = 0;
        if (totalTime_ && [totalTime_ isKindOfClass:[NSDate class]])
        {
            totalTimeTI = [totalTime_ timeIntervalSince1970];
        }

        if (totalTimeTI > 0)
        {
            hoursTF.text = [NSString stringWithFormat:@"%i",[self totalHours:totalTimeTI]];

            minutesTF.text = [NSString stringWithFormat:@"%i",[self totalMinutes:totalTimeTI]];
        }
        else
        {
            hoursTF.text = @"0";

            minutesTF.text = @"0";
        }

        hoursTF.delegate = self;
        minutesTF.delegate = self;
    }
}


- (int) totalHours:(NSTimeInterval)totalTime
{
    return totalTime / 3600;
}


- (int) totalMinutes:(NSTimeInterval)totalTime
{
    return round( ( (totalTime / 3600) - [self totalHours:totalTime] ) * 60 );
}


- (void) commitChanges
{
    BOOL valuesAreValid = [self.ownerTableViewModel valuesAreValid];
    if (!self.needsCommit || !valuesAreValid)
    {
        return;
    }

    NSDate *totalTimeFromTF = [self totalTimeFromTextFields];

    [self.boundObject setValue:totalTimeFromTF forKey:keyString];

    [super commitChanges];
    self.needsCommit = NO;
}


- (NSDate *) totalTimeFromTextFields
{
    NSTimeInterval totalTimeInterval = 0;
    if ([self valueIsValid])
    {
        NSTimeInterval hoursTI = [hoursTF.text intValue] * 60 * 60;

        NSTimeInterval minutesTI = [minutesTF.text intValue] * 60;

        totalTimeInterval = hoursTI + minutesTI;
    }

    return [NSDate dateWithTimeIntervalSince1970:totalTimeInterval];
}


- (void) textFieldEditingChanged:(id)sender
{
    BOOL valuesAreValid = [self.ownerTableViewModel valuesAreValid];
    UIBarButtonItem *doneButton = (UIBarButtonItem *)self.ownerTableViewModel.commitButton;

    [doneButton setEnabled:valuesAreValid];

    self.needsCommit = YES;
}


- (BOOL) valueIsValid
{
    BOOL valid = NO;

    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    NSString *hoursNumberStr = [hoursTF.text stringByReplacingOccurrencesOfString:@"," withString:@""];
    NSNumber *number = [numberFormatter numberFromString:hoursNumberStr];

    if (hoursNumberStr.length && [hoursNumberStr floatValue] < 1000000 && [hoursNumberStr floatValue] >= 0 && number)
    {
        NSScanner *scan = [NSScanner scannerWithString:hoursNumberStr];
        int val;

        valid = [scan scanInt:&val] && [scan isAtEnd];
    }

    if (valid)
    {
        NSString *minutesNumberStr = [minutesTF.text stringByReplacingOccurrencesOfString:@"," withString:@""];
        number = [numberFormatter numberFromString:minutesNumberStr];

        if (minutesNumberStr.length && [minutesNumberStr floatValue] < 60 && [minutesNumberStr floatValue] >= 0 && number)
        {
            NSScanner *scan = [NSScanner scannerWithString:minutesNumberStr];
            int val;

            valid = [scan scanInt:&val] && [scan isAtEnd];
        }
        else
        {
            valid = NO;
        }
    }

    return valid;
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
