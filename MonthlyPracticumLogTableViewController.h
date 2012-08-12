//
//  MonthlyPracticumLogTableViewControllerViewController.h
//  PsyTrack
//
//  Created by Daniel Boice on 6/26/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import "MonthlyPracticumLogTopCell.h"
#import "ClinicianEntity.h"
#import "TrainingProgramEntity.h"
@interface MonthlyPracticumLogTableViewController : SCViewController <SCTableViewControllerDelegate, SCTableViewModelDelegate>{


    SCArrayOfObjectsModel *objectsModel;
   
    ClinicianEntity *supervisorObject;

    TrainingProgramEntity *trainingProgram_;
    NSDate *monthToDisplay_;
    BOOL markAmended;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil monthToDisplay:(NSDate *)monthGiven trainingProgram:(TrainingProgramEntity *)trainingProgramGiven markAmended:(BOOL)markAmendedGiven;


@property(nonatomic, weak) NSString *studentName;
@end
