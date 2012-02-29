//
//  TimePickerView.h
//  psyTrainTrack
//
//  Created by Daniel Boice on 10/23/11.
//  Copyright (c) 2011 PsycheWeb LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimePickerView : UIPickerView{
    
    __weak UIPickerView *picker;
     __weak UILabel *hourLabel;
    
    __weak UILabel *minLabel;
    __weak UIView *view;
}




@property (nonatomic,weak) IBOutlet UIPickerView *picker;
@property (weak, nonatomic)IBOutlet UILabel *hourLabel;
@property (weak, nonatomic) IBOutlet UIView *view;
@property (weak, nonatomic)IBOutlet UILabel *minLabel;






@end
