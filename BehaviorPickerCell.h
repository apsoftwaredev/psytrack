/*
 *  BehaviorPickerCell.h
 *  psyTrack Clinician Tools
 *  Version: 1.0
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
#import "SCTableViewModel.h"
#import "MyPickerView.h"
#import "BOPickersDataSource.h"


@interface BehaviorPickerCell : SCLabelCell < UIPickerViewDelegate>
{
    BOPickersDataSource *pickerDataSource;
    UITextField *pickerField;
    MyPickerView *myPickerView;
    NSString *bOPropertyName;
}

-(void)setupPickerAndDatasource;
@property (nonatomic, strong)IBOutlet NSString *titleString;

@property (nonatomic,strong)IBOutlet MyPickerView *myPickerView;

@end
