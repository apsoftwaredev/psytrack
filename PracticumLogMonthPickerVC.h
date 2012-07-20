//
//  PracticumLogMonthPickerVC.h
//  PsyTrack
//
//  Created by Daniel Boice on 7/18/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PracticumLogMonthPickerVC : UIViewController <UIPickerViewDelegate,UIPickerViewDataSource>


@property (nonatomic, strong)IBOutlet UIPickerView *picker;

@end
