//
//  DemographicReportViewController.h
//  PsyTrack Clinician Tools
//  Version: 1.5.3
//
//  Created by Daniel Boice on 9/16/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import <SensibleTableView/SensibleTableView.h>

@interface DemographicReportViewController : SCViewController <SCTableViewControllerDelegate, SCTableViewModelDelegate>{
    NSString *clinicianName_;
}

@property (nonatomic, strong) NSString *clinicianName;

@end
