//
//  HeightPickerCell.h
//  psyTrainTrack
//
//  Created by Daniel Boice on 11/9/11.
//  Copyright (c) 2011 PsycheWeb LLC. All rights reserved.
//

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