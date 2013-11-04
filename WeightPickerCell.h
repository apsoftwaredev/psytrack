/*
 *  WeightPickerCell.h
 *  psyTrack Clinician Tools
 *  Version: 1.5.4
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

#import "MyPickerView.h"

@interface WeightPickerCell : SCLabelCell <UIPickerViewDataSource, UIPickerViewDelegate>
{
    UITextField *pickerField;
    MyPickerView *picker;
    int maximumRowValue;
    BOOL useMetricUnits;
    BOOL loadingRows;
    BOOL firstComponentValueIsFour;
    UIView *view;
}

@property (nonatomic, strong) IBOutlet UIView *view;
@property (nonatomic, strong) IBOutlet UIPickerView *picker;

@end
