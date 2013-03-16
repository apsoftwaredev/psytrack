/*
 *  LongTimePickerCell.m
 *  psyTrack Clinician Tools
 *  Version: 1.05
 *
 *
 *	THIS SOURCE CODE AND ANY ACCOMPANYING DOCUMENTATION ARE PROTECTED BY UNITED STATES
 *	INTELLECTUAL PROPERTY LAW AND INTERNATIONAL TREATIES. UNAUTHORIZED REPRODUCTION OR
 *	DISTRIBUTION IS SUBJECT TO CIVIL AND CRIMINAL PENALTIES.
 *
 *  Created by Daniel Boice on 12/17/11.
 *  Copyright (c) 2011 PsycheWeb LLC. All rights reserved.
 *
 *
 *	This notice may not be removed from this file.
 *
 */
#import "LongTimePickerCell.h"
#import "TimePickerView.h"
#import "TabFile.h"
#import "PTTAppDelegate.h"
#import "DrugProductEntity.h"
@interface LongTimePickerCell (PRIVATE)

- (NSString *) titleForRow:(NSInteger)row;
- (NSInteger) rowForTitle:(NSString *)title;

@end

@implementation LongTimePickerCell

//@synthesize myPickerView;
@synthesize view;
@synthesize hourLabel, minLabel,dateLabel;
@synthesize picker;
@synthesize timeValue;
@synthesize pickerField;
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

    [hourFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
    [minuteFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
    [hourMinFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];

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
    [self.boundObject setValue:timeValue forKey:boundObjectName];

    needsCommit = FALSE;
}


//override superclass
- (void) cellValueChanged
{
    NSInteger firstComponent = [picker selectedRowInComponent:0];
    NSInteger secondComponent = [picker selectedRowInComponent:1];

//    NSInteger thirdComponent=[picker selectedRowInComponent:2];
    [minuteFormatter setDateFormat:@"mm"];

    timeValue = [hourMinFormatter dateFromString:[NSString stringWithFormat:@"%i:%@",firstComponent,[minuteFormatter stringFromDate:[minuteFormatter dateFromString:[NSString stringWithFormat:@"%i",secondComponent ]]]]];

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
    float returnFloat = 0;

    switch (component)
    {
        case 0:
            returnFloat = 40.0;
            break;
        case 1:
            returnFloat = 40.0;
            break;
        case 2:
            returnFloat = 110.0;
            break;

        default:
            break;
    }

    return returnFloat;
}


- (NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}


- (NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSInteger returnInteger = 0;

    switch (component)
    {
        case 0:
            returnInteger = 99;
            break;
        case 1:
            returnInteger = 99;
            break;

        case 2:
            returnInteger = 9;
            break;
        default:
            break;
    }

    return returnInteger;
}


#pragma mark -
#pragma mark UIPickerViewDelegate methods

- (NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *returnStr = @"";

    // note: custom picker doesn't care about titles, it uses custom views

    if (component == 2)
    {
        switch (row)
        {
            case 0:
                returnStr = @"seconds"; break;
            case 1:
                returnStr = @"minutes"; break;
            case 2:
                returnStr = @"hours"; break;
            case 3:
                returnStr = @"days"; break;
            case 4:
                returnStr = @"weeks"; break;
            case 5:
                returnStr = @"months"; break;
            case 6:
                returnStr = @"years"; break;
            case 7:
                returnStr = @"decades"; break;
            case 8:
                returnStr = @"century"; break;

            default:
                break;
        } /* switch */
    }
    else
    {
        if (component == 1 && row < 10)
        {
            returnStr = [NSString stringWithFormat:@"0%i", row];
        }
        else if (component == 0 && row < 10)
        {
            returnStr = [NSString stringWithFormat:@"  %i", row];
        }
        else
        {
            returnStr = [[NSNumber numberWithInt:row] stringValue];
        }
    }

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
