//
//  WeightPickerCell.h
//  psyTrainTrack
//
//  Created by Daniel Boice on 10/23/11.
//  Copyright (c) 2011 PsycheWeb LLC. All rights reserved.
//

#import "SCTableViewModel.h"
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


@property (nonatomic, strong ) IBOutlet UIView *view;
@property (nonatomic, strong ) IBOutlet UIPickerView *picker;



@end
