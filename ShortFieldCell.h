//
//  ShortFieldCell.h
//  PsyTrack
//
//  Created by Daniel Boice on 4/7/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import "SCTableViewModel.h"

@interface ShortFieldCell : SCControlCell<UIPickerViewDataSource, UIPickerViewDelegate>
{
    BOOL useTitlePicker;
  
    UIPickerView *prefixPickerView_;
    UITextField *textField_;
    UILabel *label_;
     UIView *view_;
}
@property (nonatomic, strong ) IBOutlet UIView *view;
@property (nonatomic, strong)IBOutlet UITextField *textField;
@property (nonatomic, strong)IBOutlet UILabel *label;
@property (nonatomic, strong)IBOutlet UIPickerView *prefixPickerView;
@end
