//
//  AllHoursReportBottomCell.h
//  PsyTrack Clinician Tools
//  Version: 1.05
//
//  Created by Daniel Boice on 9/5/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import "ClinicianEntity.h"
#import "TrackTypeWithTotalTimes.h"

@interface AllHoursReportBottomCell : SCCustomCell {
    __weak ClinicianEntity *clinician_;
    __weak TrackTypeWithTotalTimes *trackTypeWithTotalTimesObject_;
}

@property (nonatomic, weak)  TrackTypeWithTotalTimes *trackTypeWithTotalTimesObject;
@property (nonatomic, weak) IBOutlet UIView *cellsContainerView;
@property (nonatomic, weak) IBOutlet UILabel *cellSubTypeLabel;
@property (nonatomic, weak) IBOutlet UILabel *hoursTotalHoursLabel;

@end
