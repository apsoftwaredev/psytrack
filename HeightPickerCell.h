/*
 *  HeightPickerCell.h
 *  psyTrack Clinician Tools
 *  Version: 1.0
 *
 *
 *	THIS SOURCE CODE AND ANY ACCOMPANYING DOCUMENTATION ARE PROTECTED BY UNITED STATES 
 *	INTELLECTUAL PROPERTY LAW AND INTERNATIONAL TREATIES. UNAUTHORIZED REPRODUCTION OR 
 *	DISTRIBUTION IS SUBJECT TO CIVIL AND CRIMINAL PENALTIES. 
 *
 *  Created by Daniel Boice on 11/9/12.
 *  Copyright (c) 2011 PsycheWeb LLC. All rights reserved.
 *
 *
 *	This notice may not be removed from this file.
 *
 */
#import "SCTableViewModel.h"
#import "MyPickerView.h"


@interface HeightPickerCell : SCLabelCell <UIPickerViewDataSource, UIPickerViewDelegate>
{
    __weak UITextField *pickerField;
    __weak UIPickerView *picker;
    int componentChanged;
    BOOL loadUnitsFromBoundObject;
    __weak UIView *view;
}


@property (nonatomic, weak ) IBOutlet UIView *view;
@property (nonatomic, weak ) IBOutlet UIPickerView *picker;
@property (nonatomic, weak ) IBOutlet UITextField *pickerField;
-(NSInteger) convertToMetersComponentFromInches:(NSInteger )inchesInteger;
-(NSInteger )convertToCentemetersComponentFromInches:(NSInteger )inchesInteger;
@end