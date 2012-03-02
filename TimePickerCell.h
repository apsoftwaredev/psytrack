/*
 *  TimePickerCell.h
 *  psyTrack Clinician Tools
 *  Version: 1.0
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
#import "SCTableViewModel.h"
#import "TimePickerView.h"

@interface TimePickerCell : SCControlCell <UIPickerViewDataSource, UIPickerViewDelegate, SCTableViewCellDelegate>
{
    __weak UITextField *pickerField;
//    TimePickerView *timePickerView;
    NSDateFormatter *minuteFormatter;
    NSDateFormatter *hourFormatter;
    NSDateFormatter *hourMinFormatter;
    
    __weak UIView *view;
    NSDate *timeValue;

    
    __weak UIPickerView *picker;
    __weak UILabel *hourLabel;

    __weak UILabel *minLabel;

    __weak UILabel *dateLabel;
    NSString *boundObjectName;
    NSString *boundObjectTitle;
}


//@property (strong, nonatomic) IBOutlet TimePickerView *timePickerView;

@property (weak, nonatomic) IBOutlet UIView *view;


@property (nonatomic, strong) IBOutlet NSDate *timeValue;
@property (nonatomic,weak) IBOutlet UIPickerView *picker;
@property (weak, nonatomic)IBOutlet UILabel *hourLabel;

@property (weak, nonatomic)IBOutlet UILabel *minLabel;
@property (weak, nonatomic)IBOutlet UITextField *pickerField;
@property (weak, nonatomic)IBOutlet UILabel *dateLabel;
@property (weak, nonatomic)IBOutlet UIView *containerView;

- (NSString *)titleForRow:(NSInteger)row;
- (NSInteger)rowForTitle:(NSString *)title;


@end








