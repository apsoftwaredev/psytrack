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

#import "TimePickerView.h"

@interface TimePickerCell : SCCustomCell <UIPickerViewDataSource, UIPickerViewDelegate>
{
     UITextField *pickerField;
//    TimePickerView *timePickerView;
    NSDateFormatter *minuteFormatter;
    NSDateFormatter *hourFormatter;
    NSDateFormatter *hourMinFormatter;
    
     UIView *view;
    NSDate *timeValue;

    
     UIPickerView *picker;
     UILabel *hourLabel;

     UILabel *minLabel;

    UILabel *dateLabel;
    NSString *boundObjectName;
    NSString *boundObjectTitle;
}


//@property (strong, nonatomic) IBOutlet TimePickerView *timePickerView;

@property (strong, nonatomic) IBOutlet UIView *view;


@property (nonatomic, strong) IBOutlet NSDate *timeValue;
@property (nonatomic,strong) IBOutlet UIPickerView *picker;
@property (strong, nonatomic)IBOutlet UILabel *hourLabel;

@property (strong, nonatomic)IBOutlet UILabel *minLabel;
@property (strong, nonatomic)IBOutlet UITextField *pickerField;
@property (strong, nonatomic)IBOutlet UILabel *dateLabel;
@property (strong, nonatomic)IBOutlet UIView *containerView;

- (NSString *)titleForRow:(NSInteger)row;
- (NSInteger)rowForTitle:(NSString *)title;
-(void)clearTime;

@end








