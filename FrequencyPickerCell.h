//
//  FrequencyPicker.h
//  psyTrainTrack
//
//  Created by Daniel Boice on 12/2/11.
//  Copyright (c) 2011 PsycheWeb LLC. All rights reserved.
//

#import "SCTableViewModel.h"



@interface FrequencyPickerCell : SCLabelCell <UIPickerViewDataSource, UIPickerViewDelegate>
{
    __weak  UITextField *pickerField;
    __weak UIPickerView *picker;
   
    __weak UIView *view;
}

@property (nonatomic, weak) IBOutlet UITextField *pickerField;
@property (nonatomic, weak ) IBOutlet UIView *view;
@property (nonatomic, weak ) IBOutlet UIPickerView *picker;

@end