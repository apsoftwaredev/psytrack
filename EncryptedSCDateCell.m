//
//  EncryptedSCDateCell.m
//  PsyTrack Clinician Tools
//
//  Created by Daniel Boice on 3/12/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import "EncryptedSCDateCell.h"
#import "PTTAppDelegate.h"

@implementation EncryptedSCDateCell

- (void) performInitialization
{
    [super performInitialization];

    self.displayDatePickerInDetailView = NO;
    self.datePicker.tag = 1;

    self.autoValidateValue = NO;
    NSDateFormatter *dateFormatterShort = [[NSDateFormatter alloc] init];
    [dateFormatterShort setDateFormat:@"MMM dd, yyyy"];

    self.dateFormatter = dateFormatterShort;

    self.datePicker.datePickerMode = UIDatePickerModeDate;
    self.textLabel.textColor = [UIColor colorWithRed:0.851 green:0.004 blue:0.157 alpha:1.0];
}


- (void) loadBoundValueIntoControl
{
    [super loadBoundValueIntoControl];

//    PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;

//    NSData *encryptedData=[self.boundObject valueForKey:[self.objectBindings valueForKey:@"1"]];
//    NSDate *keyString=[self.boundObject valueForKey:[self.objectBindings valueForKey:@"32"]];
//
//
//    //
//    NSData *decryptedData=[appDelegate decryptDataToPlainDataUsingKeyEntityWithDate:keyString encryptedData:encryptedData];
//
//    if (decryptedData.length) {
    NSDate *restoredDate = [self.boundObject valueForKey:[self.objectBindings valueForKey:@"34"]];
    if (restoredDate)
    {
        self.datePicker.date = restoredDate;
        self.label.text = [dateFormatter stringFromDate:restoredDate];
    }

//    }
    NSString *textLabelStr = [NSString string];
    if ([self.objectBindings objectForKey:@"33"])
    {
        textLabelStr = [self.objectBindings valueForKey:@"33"];
    }

    self.textLabel.text = textLabelStr;

    //    self.boundObject=self.testString;
}


- (void) commitChanges
{
    if (!needsCommit)
    {
        return;
    }

    [self.boundObject setValue:self.datePicker.date forKey:[_objectBindings valueForKey:@"34"]];

    needsCommit = false;
}


@end
