//
//  PickerCell.h
//  Custom Cells App
//
//  Copyright 2011 Sensible Cocoa. All rights reserved.
//

#import "SCTableViewModel.h"
#import "TimeOfDayPickerDataSource.h"

@interface TimeOfDayPickerCell : SCLabelCell <UIPickerViewDelegate>
{
    TimeOfDayPickerDataSource *pickerDataSource;
    UITextField *pickerField;
    UIPickerView *pickerView;
}

@end
