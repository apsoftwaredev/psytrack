/*
 *  DrugAppDocCell.m
 *  psyTrack Clinician Tools
 *  Version: 1.5.3
 *
 *
 *	THIS SOURCE CODE AND ANY ACCOMPANYING DOCUMENTATION ARE PROTECTED BY UNITED STATES
 *	INTELLECTUAL PROPERTY LAW AND INTERNATIONAL TREATIES. UNAUTHORIZED REPRODUCTION OR
 *	DISTRIBUTION IS SUBJECT TO CIVIL AND CRIMINAL PENALTIES.
 *
 *  Created by Daniel Boice on 1/3/12.
 *  Copyright (c) 2011 PsycheWeb LLC. All rights reserved.
 *
 *
 *	This notice may not be removed from this file.
 *
 */
#import "DrugAppDocCell.h"

@implementation DrugAppDocCell

- (void) performInitialization
{
    [super performInitialization];

    // place any initialization code here
}


- (void) willDisplay
{
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}


- (void) loadBindingsIntoCustomControls
{
    [super loadBindingsIntoCustomControls];

    NSString *docType = [self.boundObject valueForKey:@"docType"];
    NSDate *docDate = [self.boundObject valueForKey:@"docDate"];

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"m/d/yyyy"];
    self.textLabel.text = docType;
    self.label.text = [dateFormatter stringFromDate:docDate];

    dateFormatter = nil;
}


- (void) didSelectCell
{
    NSString *docURL = [self.boundObject valueForKey:@"docURL"];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:docURL]];
}


@end
