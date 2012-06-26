//
//  SubTypeHoursCell.h
//  PsyTrack
//
//  Created by Daniel Boice on 6/26/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//



@interface SubTypeHoursCell : SCCustomCell


@property (nonatomic, weak)IBOutlet UILabel *subTypeTextLabel;

@property (nonatomic, weak)IBOutlet UILabel *weekOneLabel;
@property (nonatomic, weak)IBOutlet UILabel *weekTwoLabel;
@property (nonatomic, weak)IBOutlet UILabel *weekThreeLabel;
@property (nonatomic, weak)IBOutlet UILabel *weekFourLabel;
@property (nonatomic, weak)IBOutlet UILabel *weekFiveLabel;

@property (nonatomic, weak)IBOutlet UILabel *weekTotalLabel;
@property (nonatomic, weak)IBOutlet UILabel *cumulativeHoursLabel;
@property (nonatomic, weak)IBOutlet UILabel *totalHoursToDateLabel;




@end
