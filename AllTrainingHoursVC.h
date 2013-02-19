//
//  AllTrainingHoursVC.h
//  PsyTrack Clinician Tools
//  Version: 1.05
//
//  Created by Daniel Boice on 9/5/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import <SensibleTableView/SensibleTableView.h>
#import "ClinicianEntity.h"
#import "TrainingProgramEntity.h"

@interface AllTrainingHoursVC : SCViewController <SCTableViewControllerDelegate, SCTableViewModelDelegate>{
    
    
    SCArrayOfObjectsModel *objectsModel;
    
    
    BOOL doctorateLevel;
}

@property(nonatomic, weak) NSString *studentName;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil doctorateLevel:(BOOL)doctorateLevelSelected;
@end
