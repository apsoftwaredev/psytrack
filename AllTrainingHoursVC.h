//
//  AllTrainingHoursVC.h
//  PsyTrack
//
//  Created by Daniel Boice on 9/5/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import <SensibleTableView/SensibleTableView.h>
#import "ClinicianEntity.h"
#import "TrainingProgramEntity.h"

@interface AllTrainingHoursVC : SCViewController <SCTableViewControllerDelegate, SCTableViewModelDelegate>{
    
    
    SCArrayOfObjectsModel *objectsModel;
    
    ClinicianEntity *supervisorObject;
    
    TrainingProgramEntity *trainingProgram_;
    NSDate *monthToDisplay_;
    BOOL markAmended;
}

@property(nonatomic, weak) NSString *studentName;


@end
