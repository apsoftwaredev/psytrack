//
//  ShortFieldCell.m
//  PsyTrack Clinician Tools
//  Version: 1.0.6
//
//  Created by Daniel Boice on 4/7/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import "ShortFieldCell.h"

@interface ShortFieldCell (PRIVATE)

- (NSString *) titleForRow:(NSInteger)row;
- (NSInteger) rowForTitle:(NSString *)title;

@end

@implementation ShortFieldCell
@synthesize textField = textField_,label = label_,prefixPickerView = prefixPickerView_,view = view_;
// overrides superclass
- (void) performInitialization
{
    [super performInitialization];

    // place any initialization code here
}


// overrides superclass
- (void) loadBindingsIntoCustomControls
{
    [super loadBindingsIntoCustomControls];
    if ([self.objectBindings objectForKey:@"70"])
    {
        useTitlePicker = [[self.objectBindings valueForKey:@"70"]boolValue];
    }

    if (useTitlePicker)
    {
        [self createPicker];
        NSString *title = [self.boundObject valueForKey:@"prefix"];

        [prefixPickerView_ selectRow:[self rowForTitle:title] inComponent:0 animated:NO];
        self.textField.text = title;
        self.textField.clearButtonMode = UITextFieldViewModeNever;
//        self.textField.userInteractionEnabled=NO;
    }
}


- (void) createPicker
{
    // Center the picker in the detailViewController
    CGRect pickerFrame = self.prefixPickerView.frame;
    pickerFrame.origin.x = (self.view.frame.size.width - pickerFrame.size.width) / 2;

    self.prefixPickerView.frame = pickerFrame;

    if ([SCUtilities is_iPad])
    {
        self.view.backgroundColor = [UIColor colorWithRed:32.0f / 255 green:35.0f / 255 blue:42.0f / 255 alpha:1];
    }
    else
    {
        self.view.backgroundColor = [UIColor colorWithRed:41.0f / 255 green:42.0f / 255 blue:57.0f / 255 alpha:1];
    }

    [prefixPickerView_ setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin];
    [prefixPickerView_ setAutoresizesSubviews:YES];
    prefixPickerView_.dataSource = self;
    prefixPickerView_.delegate = self;
    prefixPickerView_.showsSelectionIndicator = YES;

    self.textField.delegate = self;
    self.textField.inputView = prefixPickerView_;
}


// overrides superclass
- (void) commitChanges
{
    if (!needsCommit)
    {
        return;
    }

    [super commitChanges];
    if (useTitlePicker)
    {
        NSString *pickerPrefix = [self titleForRow:[prefixPickerView_ selectedRowInComponent:0]];
        NSString *textFieldStr = self.textField.text;

        NSString *prefix = nil;

        if ([pickerPrefix isEqualToString:textFieldStr])
        {
            prefix = pickerPrefix;
        }
        else
        {
            prefix = textFieldStr;
        }

        [self.boundObject setValue:prefix forKey:@"prefix"];
    }

    needsCommit = FALSE;
}


//override superclass

//override superclass
- (void) willDisplay
{
    [super willDisplay];
    if (useTitlePicker)
    {
        self.label.text = @"Prefix";
    }
}


//override superclass
- (void) didSelectCell
{
    if (useTitlePicker)
    {
        self.ownerTableViewModel.activeCell = self;

        [self.textField becomeFirstResponder];
    }
}


- (NSString *) titleForRow:(NSInteger)row
{
    NSString *title = nil;
    switch (row)
    {
        case 0:
            title = @"";        break;
        case 1:
            title = @"Dr.";     break;
        case 2:
            title = @"Mr.";     break;
        case 3:
            title = @"Ms.";     break;
        case 4:
            title = @"Mrs.";    break;
        case 5:
            title = @"Master";        break;
        case 6:
            title = @"Rev.";     break;
        case 7:
            title = @"Fr.";     break;
        case 8:
            title = @"Atty.";     break;
        case 9:
            title = @"Prof.";    break;
        case 10:
            title = @"Hon.";   break;
        case 11:
            title = @"Pres.";        break;
        case 12:
            title = @"Gov.";     break;
        case 13:
            title = @"Coach";     break;
        case 14:
            title = @"Ofc.";     break;
        case 15:
            title = @"Msgr.";     break;
        case 16:
            title = @"Sr.";     break;
        case 17:
            title = @"Br.";    break;
        case 18:
            title = @"Supt.";   break;
        case 19:
            title = @"Rep.";        break;
        case 20:
            title = @"Sen.";     break;
        case 21:
            title = @"Amb.";     break;
        case 22:
            title = @"Treas.";     break;

        case 23:
            title = @"Sec.";     break;
        case 24:
            title = @"Pvt.";     break;
        case 25:
            title = @"Spc.";    break;
        case 26:
            title = @"Sgt";   break;
        case 27:
            title = @"Adm";        break;
        case 28:
            title = @"Maj.";     break;
        case 29:
            title = @"Capt.";     break;
        case 30:
            title = @"Cmdr.";     break;

        case 31:
            title = @"Lt.";     break;
        case 32:
            title = @"Lt Col.";     break;
        case 33:
            title = @"Col.";    break;
        case 34:
            title = @"Gen.";   break;
        case 35:
            title = @"Adm.";        break;

        default:
            title = @"";        break;
    } /* switch */

    return title;
}


- (NSInteger) rowForTitle:(NSString *)title
{
    NSInteger row = 0;

    for (NSInteger i = 0; i < 36; i++)
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
    return 1;
}


- (NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return 36;
}


#pragma mark -
#pragma mark UIPickerViewDelegate methods

- (NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self titleForRow:row];
}


- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (useTitlePicker)
    {
        NSString *textStr = [self titleForRow:[pickerView selectedRowInComponent:0]];

        self.textField.text = textStr;
        needsCommit = YES;
    }
}


- (UIView *) pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 37)];
    label.text = [self titleForRow:row];

    label.font = [UIFont boldSystemFontOfSize:(CGFloat)20];
    label.textAlignment = UITextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];

    return label;
}


@end
