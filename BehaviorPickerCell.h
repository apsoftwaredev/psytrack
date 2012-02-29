//
//  BehaviorPickerCell.h
//  psyTrainTrack
//
//  Created by Daniel Boice on 10/23/11.
//  Copyright (c) 2011 PsycheWeb LLC. All rights reserved.
//

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
