//
//  MonthlyPracticumLogBottonCell.h
//  PsyTrack
//
//  Created by Daniel Boice on 6/26/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import "ClinicianEntity.h"

@interface MonthlyPracticumLogBottonCell : SCCustomCell {

    ClinicianEntity *clinician_;
    NSDate *monthToDisplay_;
}




@property (nonatomic, strong)IBOutlet UIView *cellsContainerView;
@property (nonatomic, strong)IBOutlet UILabel *cellSubTypeLabel;
@property (nonatomic, strong)IBOutlet UILabel *hoursWeek1Label;
@property (nonatomic, strong)IBOutlet UILabel *hoursWeek2Label;
@property (nonatomic, strong)IBOutlet UILabel *hoursWeek3Label;
@property (nonatomic, strong)IBOutlet UILabel *hoursWeek4Label;
@property (nonatomic, strong)IBOutlet UILabel *hoursWeek5Label;
@property (nonatomic, strong)IBOutlet UILabel *hoursMonthTotalLabel;
@property (nonatomic, strong)IBOutlet UILabel *hoursCumulativeLabel;
@property (nonatomic, strong)IBOutlet UILabel *hoursTotalHoursLabel;




@end
