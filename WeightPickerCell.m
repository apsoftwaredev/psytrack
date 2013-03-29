/*
 *  WeightPickerCell.m
 *  psyTrack Clinician Tools
 *  Version: 1.0.6
 *
 *
 *	THIS SOURCE CODE AND ANY ACCOMPANYING DOCUMENTATION ARE PROTECTED BY UNITED STATES
 *	INTELLECTUAL PROPERTY LAW AND INTERNATIONAL TREATIES. UNAUTHORIZED REPRODUCTION OR
 *	DISTRIBUTION IS SUBJECT TO CIVIL AND CRIMINAL PENALTIES.
 *
 *  Created by Daniel Boice on 10/23/11.
 *  Copyright (c) 2011 PsycheWeb LLC. All rights reserved.
 *
 *
 *	This notice may not be removed from this file.
 *
 */
#import "WeightPickerCell.h"

@interface WeightPickerCell (PRIVATE)

- (NSString *) titleForRow:(NSInteger)row;
- (NSInteger) rowForTitle:(NSString *)title;

@end

@implementation WeightPickerCell
@synthesize picker;
@synthesize view;

// overrides superclass
- (void) performInitialization
{
    [super performInitialization];

    // place any initialization code here

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

    picker.dataSource = self;
    picker.delegate = self;
    picker.showsSelectionIndicator = YES;

    pickerField = [[UITextField alloc] init];
    pickerField.delegate = self;
    pickerField.inputView = self.view;
    [self.contentView addSubview:pickerField];

    //
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
- (void) loadBoundValueIntoControl
{
    [super loadBoundValueIntoControl];

    NSInteger weight = [(NSNumber *)[self.boundObject valueForKey:@"weight"] integerValue];
    NSString *unit = (NSString *)[self.boundObject valueForKey:@"weightUnit"];

    NSInteger firstComponent = weight / 100;
    NSInteger secondComponent = weight / 10 - ( (weight / 100) * 10 );
    NSInteger thirdComponent = weight - firstComponent * 100 - secondComponent * 10;
    if ([unit isEqualToString:@"lb"])
    {
        useMetricUnits = FALSE;
    }
    else if ([unit isEqualToString:@"kg"])
    {
        loadingRows = TRUE;
        if (firstComponent == 4)
        {
            firstComponentValueIsFour = TRUE;
        }
        else
        {
            firstComponentValueIsFour = FALSE;
        }

        useMetricUnits = TRUE;
    }

//    NSString *title = @"";
    [picker selectRow:firstComponent inComponent:0 animated:YES];
    [picker selectRow:secondComponent inComponent:1 animated:YES];
    [picker selectRow:thirdComponent inComponent:2 animated:YES];
    [picker selectRow:[self rowForTitle:unit] inComponent:3 animated:NO];

//    [myPickerView.picker reloadComponent:1];
//    [myPickerView.picker reloadComponent:2];
    self.label.text = [NSString stringWithFormat:@"%i %@",weight,unit];
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

    NSInteger firstComponent = [picker selectedRowInComponent:0];
    NSInteger secondComponent = [picker selectedRowInComponent:1];
    NSInteger thirdComponent = [picker selectedRowInComponent:2];
    NSString *unit = [self titleForRow:[picker selectedRowInComponent:3]];
    NSInteger weight = (firstComponent * 100) + (secondComponent * 10) + thirdComponent;

    [self.boundObject setValue:[NSNumber numberWithInteger:weight] forKey:@"weight"];
    [self.boundObject setValue:unit forKey:@"weightUnit"];

    needsCommit = FALSE;
}


//override superclass
- (void) cellValueChanged
{
    NSInteger firstComponent = [picker selectedRowInComponent:0];
    NSInteger secondComponent = [picker selectedRowInComponent:1];
    NSInteger thirdComponent = [picker selectedRowInComponent:2];
    NSString *unit = [self titleForRow:[picker selectedRowInComponent:3]];
    NSInteger weight = (firstComponent * 100) + (secondComponent * 10) + thirdComponent;

    self.label.text = [NSString stringWithFormat:@"%i %@",weight,unit];

    [super cellValueChanged];
}


//override superclass
- (void) willDisplay
{
    [super willDisplay];

    self.textLabel.text = @"Weight";
}


//override superclass
- (void) didSelectCell
{
    self.ownerTableViewModel.activeCell = self;

    [pickerField becomeFirstResponder];
}


- (NSString *) titleForRow:(NSInteger)row
{
    NSString *title = nil;
    switch (row)
    {
        case 0:
            title = @"lb";     break;
        case 1:
            title = @"kg";    break;
    }

    return title;
}


- (NSInteger) rowForTitle:(NSString *)title
{
    NSInteger row = 0;

    for (NSInteger i = 0; i < 3; i++)
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

- (NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 4;
}


- (NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSInteger returnInteger = 0;

    if (useMetricUnits)
    {
        int firstComponentValue = (int)[picker selectedRowInComponent:0];
        if (component == 0)
        {
            returnInteger = 5;
        }

        if (component == 1)
        {
            if ( (firstComponentValue < 4 && !loadingRows) || (loadingRows && !firstComponentValueIsFour) )
            {
                returnInteger = 10;
            }
            else
            {
                returnInteger = 6;
            }
        }

        if (component == 2)
        {
            if ( (firstComponentValue < 4 && !loadingRows) || (loadingRows && !firstComponentValueIsFour) )
            {
                returnInteger = 10;
            }
            else
            {
                returnInteger = 4;
            }
        }
    }
    else if (component < 3)
    {
        returnInteger = 10;
    }

    if (component == 3)
    {
        returnInteger = 2;
    }

    return returnInteger;
}


- (CGFloat) pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    if ([SCUtilities is_iPad])
    {
        return 95.0;
    }
    else
    {
        return 50.0;
    }
}


#pragma mark -
#pragma mark UIPickerViewDelegate methods

- (NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *returnStr = @"";

    // note: custom picker doesn't care about titles, it uses custom views

    if (component <= 2)
    {
        returnStr = [[NSNumber numberWithInt:row] stringValue];
    }

    if (component == 3)
    {
        returnStr = [self titleForRow:row];
    }

    return returnStr;
}


- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    loadingRows = FALSE;
    if (component == 0)
    {
        NSString *unit = [self titleForRow:[picker selectedRowInComponent:3]];

        if ([unit isEqualToString:@"kg"])
        {
            useMetricUnits = TRUE;
        }

        [picker reloadComponent:0];

        [picker reloadComponent:1];

        [picker reloadComponent:2];
    }

    if (component == 3)
    {
        NSString *unit = [self titleForRow:[picker selectedRowInComponent:3]];
        NSInteger firstComponent = [picker selectedRowInComponent:0];
        NSInteger secondComponent = [picker selectedRowInComponent:1];
        NSInteger thirdComponent = [picker selectedRowInComponent:2];
        float weight = (firstComponent * 100) + (secondComponent * 10) + thirdComponent;

        if ([unit isEqualToString:@"kg"] )
        {
            weight = weight * 0.45359237;
            useMetricUnits = TRUE;
            if (weight < 400.0)
            {
                loadingRows = TRUE;
                firstComponentValueIsFour = FALSE;
            }

            [picker reloadComponent:0];

            [picker reloadComponent:1];

            [picker reloadComponent:2];
            if (weight >= 454)
            {
                weight = 453.0;
            }
        }
        else if ([unit isEqualToString:@"lb"])
        {
            weight = weight * 2.20462262;
            useMetricUnits = FALSE;
            [picker reloadComponent:0];

            [picker reloadComponent:1];

            [picker reloadComponent:2];
        }

//        NSInteger weightInteger;
        float firstComponentFloat,secondComponentFloat,thirdComponentFloat;
        NSInteger firstComponentInteger,secondComponentInteger, thirdComponentInteger;
        firstComponentFloat = weight / 100.0;

        firstComponentInteger = [[NSNumber numberWithFloat:firstComponentFloat]integerValue];

        secondComponentFloat = ( ( (firstComponentFloat * 100) - (firstComponentInteger * 100) ) / 10 );
        secondComponentInteger = secondComponentFloat;
        thirdComponentFloat = weight - (firstComponentInteger * 100) - (secondComponentInteger * 10);
        thirdComponentFloat = roundf(thirdComponentFloat);
        thirdComponentInteger = [[NSNumber numberWithFloat:thirdComponentFloat]integerValue];

        if (thirdComponentInteger > 9)
        {
            thirdComponentInteger = 0;
            secondComponentInteger++;
        }

        if (secondComponentInteger > 9)
        {
            firstComponentInteger++;
            secondComponentInteger = 0;
        }

        if (firstComponentInteger > 9)
        {
            firstComponentInteger = 9;
            secondComponentInteger = 9;
            thirdComponentInteger = 9;
        }

        [picker selectRow:firstComponentInteger inComponent:0 animated:YES];
        [picker selectRow:secondComponentInteger inComponent:1 animated:YES];
        [picker selectRow:thirdComponentInteger inComponent:2 animated:YES];

        [self cellValueChanged];
    }
    else
    {
        [self cellValueChanged];
    }
}


@end
