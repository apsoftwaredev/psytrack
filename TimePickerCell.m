/*
 *  TimePickerCell.m
 *  psyTrack Clinician Tools
 *  Version: 1.5.1
 *
 *
 *	THIS SOURCE CODE AND ANY ACCOMPANYING DOCUMENTATION ARE PROTECTED BY UNITED STATES
 *	INTELLECTUAL PROPERTY LAW AND INTERNATIONAL TREATIES. UNAUTHORIZED REPRODUCTION OR
 *	DISTRIBUTION IS SUBJECT TO CIVIL AND CRIMINAL PENALTIES.
 *
 *  Created by Daniel Boice on 11/8/11.
 *  Copyright (c) 2011 PsycheWeb LLC. All rights reserved.
 *
 *
 *	This notice may not be removed from this file.
 *
 */

#import "TimePickerCell.h"
#import "TimePickerView.h"

@interface TimePickerCell (PRIVATE)

- (NSString *) titleForRow:(NSInteger)row;
- (NSInteger) rowForTitle:(NSString *)title;

@end

@implementation TimePickerCell

//@synthesize myPickerView;
@synthesize view;
@synthesize hourLabel, minLabel,dateLabel;
@synthesize picker,pickerField;
@synthesize timeValue;

@synthesize containerView;

// overrides superclass
- (void) performInitialization
{
    [super performInitialization];

    // place any initialization code here

    hourFormatter = [[NSDateFormatter alloc]init];
    minuteFormatter = [[NSDateFormatter alloc]init];
    hourMinFormatter = [[NSDateFormatter alloc]init];

    [hourMinFormatter setDateFormat:@"H:mm"];
    [minuteFormatter setDateFormat:@"m"];
    [hourFormatter setDateFormat:@"H"];

    [hourFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    [minuteFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    [hourMinFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];

    // Center the picker in the detailViewController
    CGRect pickerFrame = self.picker.frame;
    pickerFrame.origin.x = (self.view.frame.size.width - pickerFrame.size.width) / 2;

    self.picker.frame = pickerFrame;

    if ([SCUtilities is_iPad])
    {
        self.view.backgroundColor = [UIColor colorWithRed:32.0f / 255 green:35.0f / 255 blue:42.0f / 255 alpha:1];
    }
    else
    {
        self.view.backgroundColor = [UIColor colorWithRed:41.0f / 255 green:42.0f / 255 blue:57.0f / 255 alpha:1];
    }

    UIColor *blueTextColor = [UIColor colorWithRed:50.0f / 255 green:79.0f / 255 blue:133.0f / 255 alpha:1];
    hourLabel.textColor = blueTextColor;
    minLabel.textColor = blueTextColor;
    dateLabel.textColor = blueTextColor;

    self.selectionStyle = UITableViewCellSelectionStyleNone;

    self.picker.dataSource = self;
    self.picker.delegate = self;
    self.picker.showsSelectionIndicator = YES;

    self.pickerField = [[UITextField alloc] init];
    pickerField.delegate = self;
    pickerField.inputView = self.view;
    [self.contentView addSubview:pickerField];
}


//overrides superclass
- (BOOL) becomeFirstResponder
{
    return [pickerField becomeFirstResponder];
}


//overrides superclass
- (BOOL) resignFirstResponder
{
    return [pickerField resignFirstResponder];
}


// overrides superclass
- (void) loadBindingsIntoCustomControls
{
    [super loadBindingsIntoCustomControls];

    boundObjectName = (NSString *)[self.objectBindings valueForKey:@"41"];
    timeValue = (NSDate *)[self.boundObject valueForKey:boundObjectName];

    boundObjectTitle = (NSString *)[self.objectBindings valueForKey:@"42"];

    NSInteger hoursComponent = [[hourFormatter stringFromDate:timeValue]integerValue];

    NSInteger minutesComponent = [[minuteFormatter stringFromDate:timeValue]integerValue];

    if (hoursComponent == 1)
    {
        hourLabel.text = @"Hour";
    }
    else
    {
        hourLabel.text = @"Hours";
    }

    if (minutesComponent == 1)
    {
        minLabel.text = @"Minute";
    }
    else
    {
        minLabel.text = @"Minutes";
    }

    [hourMinFormatter setDateFormat:@"H:mm"];
    dateLabel.text = self.dateLabel.text = [NSString stringWithFormat:@"%@",[hourMinFormatter stringFromDate:timeValue]];

    [picker selectRow:hoursComponent inComponent:0 animated:YES];
    [picker selectRow:minutesComponent inComponent:1 animated:YES];

    self.textLabel.text = boundObjectTitle;
}


// overrides superclass
- (void) commitChanges
{
    if (!needsCommit)
    {
        return;
    }

    [super commitChanges];
//
    NSInteger hourComponent = [picker selectedRowInComponent:0];
    NSInteger minuteComponent = [picker selectedRowInComponent:1];

    [hourFormatter setDateFormat:@"H:m"];

    timeValue = [hourMinFormatter dateFromString:[NSString stringWithFormat:@"%i:%i",hourComponent,minuteComponent]];

    NSDateComponents *dateComponents = [[NSDateComponents alloc]init];
    dateComponents.year = 1970;
    dateComponents.month = 1;
    dateComponents.day = 1;
    dateComponents.hour = hourComponent;
    dateComponents.minute = minuteComponent;

    NSCalendar *calander = [NSCalendar currentCalendar];
    [calander setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    timeValue = [calander dateFromComponents:dateComponents];

    [self.boundObject setValue:timeValue forKey:boundObjectName];

    needsCommit = FALSE;
}


//override superclass
- (void) cellValueChanged
{
    NSInteger firstComponent = [picker selectedRowInComponent:0];
    NSInteger secondComponent = [picker selectedRowInComponent:1];
    [minuteFormatter setDateFormat:@"mm"];

    timeValue = [hourMinFormatter dateFromString:[NSString stringWithFormat:@"%i:%@",firstComponent,[minuteFormatter stringFromDate:[minuteFormatter dateFromString:[NSString stringWithFormat:@"%i",secondComponent ]]]]];

    if (firstComponent == 1)
    {
        hourLabel.text = @"Hour";
    }
    else
    {
        hourLabel.text = @"Hours";
    }

    if (secondComponent == 1)
    {
        minLabel.text = @"Minute";
    }
    else
    {
        minLabel.text = @"Minutes";
    }

    self.dateLabel.text = [hourMinFormatter stringFromDate:timeValue];

    [super cellValueChanged];
}


//override superclass
- (void) willDisplay
{
    [super willDisplay];

    self.textLabel.text = boundObjectTitle;
}


//override superclass
- (void) didSelectCell
{
    self.ownerTableViewModel.activeCell = self;

    [pickerField becomeFirstResponder];
}


- (NSString *) titleForRow:(NSInteger)row
{
    NSString *title = [NSString stringWithFormat:@"%i",row];

    return title;
}


- (void) clearTime
{
    self.timeValue = nil;
    [self.picker selectRow:0 inComponent:0 animated:YES];

    [self.picker selectRow:0 inComponent:1 animated:YES];
    self.dateLabel.text = @"0:00";
}


- (NSInteger) rowForTitle:(NSString *)title
{
    NSInteger row = 0;

    for (NSInteger i = 0; i < 5; i++)
    {
        if ([title isEqualToString:[self titleForRow:i]])
        {
            row = i;
            break;
        }
    }

    return row;
}


#pragma mark -
#pragma mark UIPickerViewDataSource methods

- (CGFloat) pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    if (component == 0)
    {
        return 95.0;
    }
    else
    {
        return 103.0;
    }
}


- (NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}


- (NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSInteger returnInteger = 0;
    if (component == 0)
    {
        returnInteger = 24;
    }

    if (component == 1)
    {
        returnInteger = 60;
    }

    return returnInteger;
}


#pragma mark -
#pragma mark UIPickerViewDelegate methods

- (NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *returnStr = @"";

    // note: custom picker doesn't care about titles, it uses custom views

    returnStr = [[NSNumber numberWithInt:row] stringValue];

    return returnStr;
}


- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    [self cellValueChanged];
}


- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}


@end
