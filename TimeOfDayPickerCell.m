/*
 *  TimeOfDayPickerCell.m
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
 *  Created by Daniel Boice on 11/8/11.
 *  Copyright (c) 2011 PsycheWeb LLC. All rights reserved.
 *
 *
 *	This notice may not be removed from this file.
 *
 */
#import "TimeOfDayPickerCell.h"
#import "CustomView.h"

@interface TimeOfDayPickerCell (PRIVATE)

- (NSString *) imagePathForRow:(NSInteger)row;
- (NSInteger) rowForImagePath:(NSString *)path;

@end

@implementation TimeOfDayPickerCell

// overrides superclass
- (void) performInitialization
{
    [super performInitialization];

    // place any initialization code here

    pickerDataSource = [[TimeOfDayPickerDataSource alloc] init];

    pickerView = [[UIPickerView alloc] init];
    pickerView.dataSource = pickerDataSource;
    pickerView.delegate = self;
    pickerView.showsSelectionIndicator = YES;

    pickerField = [[UITextField alloc] initWithFrame:CGRectZero];
    pickerField.delegate = self;
    pickerField.inputView = pickerView;
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

//    NSString *imagePath = [self.boundObject valueForKey:@"title"];
//    if(!imagePath)
//        imagePath = [self imagePathForRow:0];
//    [pickerView selectRow:[self rowForImagePath:imagePath] inComponent:0 animated:NO];
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
//    NSString *imagePath = [self imagePathForRow:[pickerView selectedRowInComponent:0]];
//    [self.boundObject setValue:imagePath forKey:@"title"];
//
    needsCommit = FALSE;
}


//override superclass
- (void) cellValueChanged
{
    NSInteger selectedRowIndex = [pickerView selectedRowInComponent:0];
    self.imageView.image = [UIImage imageNamed:[self imagePathForRow:selectedRowIndex]];
    self.label.text = ( (CustomView *)[pickerDataSource.customPickerArray objectAtIndex:selectedRowIndex] ).title;

    [super cellValueChanged];
}


//override superclass
- (void) willDisplay
{
    [super willDisplay];

    self.textLabel.text = @"Title";

    NSInteger selectedRowIndex = [pickerView selectedRowInComponent:0];
    self.imageView.image = [UIImage imageNamed:[self imagePathForRow:selectedRowIndex]];
    self.label.text = ( (CustomView *)[pickerDataSource.customPickerArray objectAtIndex:selectedRowIndex] ).title;
}


//override superclass
- (void) didSelectCell
{
    self.ownerTableViewModel.activeCell = self;

    [pickerField becomeFirstResponder];
}


- (NSString *) imagePathForRow:(NSInteger)row
{
    return ( (CustomView *)[pickerDataSource.customPickerArray objectAtIndex:row] ).imagePath;
}


- (NSInteger) rowForImagePath:(NSString *)path
{
    NSInteger row = 0;

    for (NSInteger i = 0; i < pickerDataSource.customPickerArray.count; i++)
    {
        if ([path isEqualToString:( (CustomView *)[pickerDataSource.customPickerArray objectAtIndex:i] ).imagePath])
        {
            row = i;
            break;
        }
    }

    return row;
}


#pragma mark -
#pragma mark UIPickerViewDelegate methods

// tell the picker which view to use for a given component and row, we have an array of views to show
- (UIView *) pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row
           forComponent:(NSInteger)component reusingView:(UIView *)view
{
    return [pickerDataSource.customPickerArray objectAtIndex:row];
}


- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    [self cellValueChanged];
}


@end
