//
//  DemographicReportViewController.h
//  PsyTrack
//
//  Created by Daniel Boice on 9/16/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import <SensibleTableView/SensibleTableView.h>

@interface DemographicReportViewController : SCViewController <SCTableViewControllerDelegate, SCTableViewModelDelegate>{
    
    
    SCArrayOfObjectsModel *objectsModel;
    
    __weak NSString *clinicianName_;
    
}

@property (nonatomic, weak) NSString *clinicianName;

@end
