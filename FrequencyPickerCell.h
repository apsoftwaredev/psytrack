/*
 *  FrequencyPicker.h
 *  psyTrack Clinician Tools
 *  Version: 1.0
 *
 *
 *	THIS SOURCE CODE AND ANY ACCOMPANYING DOCUMENTATION ARE PROTECTED BY UNITED STATES
 *	INTELLECTUAL PROPERTY LAW AND INTERNATIONAL TREATIES. UNAUTHORIZED REPRODUCTION OR
 *	DISTRIBUTION IS SUBJECT TO CIVIL AND CRIMINAL PENALTIES.
 *
 *  Created by Daniel Boice on 12/2/12.
 *  Copyright (c) 2011 PsycheWeb LLC. All rights reserved.
 *
 *
 *	This notice may not be removed from this file.
 *
 */

#import <UIKit/UIKit.h>

@interface FrequencyPickerCell : SCLabelCell <UIPickerViewDataSource, UIPickerViewDelegate>
{
    __weak UITextField *pickerField;
    __weak UIPickerView *picker;

    __weak UIView *view;
}

@property (nonatomic, weak) IBOutlet UITextField *pickerField;
@property (nonatomic, weak) IBOutlet UIView *view;
@property (nonatomic, weak) IBOutlet UIPickerView *picker;

@end
