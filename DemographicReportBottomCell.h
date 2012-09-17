//
//  DemographicReportBottomCell.h
//  PsyTrack
//
//  Created by Daniel Boice on 9/16/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//


#import "DemographicVariableAndCount.h"
@interface DemographicReportBottomCell : SCCustomCell {

  __weak  DemographicVariableAndCount *demVariableAndCount_;


}

@property (nonatomic, weak)IBOutlet UILabel *variableLabel;
@property (nonatomic, weak)IBOutlet UILabel *variableCountLabel;
@property (nonatomic, weak)IBOutlet UIView *containerView;
@property (nonatomic, weak) DemographicVariableAndCount *demVariableAndCount;

@end
