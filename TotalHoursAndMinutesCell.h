//
//  TotalHoursAndMinutesCell.h
//  PsyTrack
//
//  Created by Daniel Boice on 7/7/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//



@interface TotalHoursAndMinutesCell : SCCustomCell {

    NSDate *totalTime_;


}


@property (nonatomic, strong)NSNumber *hours;
@property (nonatomic, strong)NSNumber *minutes;
@property (nonatomic, strong)NSDate *totalTime;
@property (nonatomic, strong)IBOutlet UITextField *hoursTF;
@property (nonatomic, strong)IBOutlet UITextField *minutesTF;

@end
