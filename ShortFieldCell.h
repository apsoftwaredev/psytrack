//
//  ShortFieldCell.h
//  PsyTrack Clinician Tools
//  Version: 1.05
//
//  Created by Daniel Boice on 4/7/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShortFieldCell : SCCustomCell<UIPickerViewDataSource, UIPickerViewDelegate>
{
    BOOL useTitlePicker;

    __weak UIPickerView *prefixPickerView_;
    __weak UITextField *textField_;
    __weak UILabel *label_;
    __weak UIView *view_;
}
@property (nonatomic, weak) IBOutlet UIView *view;
@property (nonatomic, weak) IBOutlet UITextField *textField;
@property (nonatomic, weak) IBOutlet UILabel *label;
@property (nonatomic, weak) IBOutlet UIPickerView *prefixPickerView;
@end
