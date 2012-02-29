//
//  MyPickerView.h
//  psyTrainTrack
//
//  Created by Daniel Boice on 10/24/11.
//  Copyright (c) 2011 PsycheWeb LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyPickerView : UIPickerView

@property (nonatomic, weak) IBOutlet UIView *view;
@property (nonatomic, weak) IBOutlet UIPickerView *picker;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil;
@end


