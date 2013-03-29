//
//  TotalHoursAndMinutesCell.h
//  PsyTrack Clinician Tools
//  Version: 1.0.6
//
//  Created by Daniel Boice on 7/7/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

@interface TotalHoursAndMinutesCell : SCCustomCell <UITextFieldDelegate>{
    NSDate *totalTime_;
    NSString *keyString;
}

@property (nonatomic, assign) int hours;
@property (nonatomic, assign) int minutes;
@property (nonatomic, strong) NSDate *totalTime;
@property (nonatomic, strong) IBOutlet UITextField *hoursTF;
@property (nonatomic, strong) IBOutlet UITextField *minutesTF;
@property (nonatomic, strong) IBOutlet UILabel *TotalHoursLabel;
@end
