//
//  MonthlyPracticumLogTableViewControllerViewController.h
//  PsyTrack
//
//  Created by Daniel Boice on 6/26/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import "MonthlyPracticumLogTopCell.h"
#import "ClinicianEntity.h"
@interface MonthlyPracticumLogTableViewController : SCTableViewController <SCTableViewControllerDelegate, SCTableViewModelDelegate>{


    SCArrayOfObjectsModel *objectsModel;
    NSInteger year;
    NSInteger month;
    ClinicianEntity *supervisorObject;


}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil month:(NSInteger)monthInteger year:(NSInteger )yearInteger supervisor:(ClinicianEntity *)supervisor;

@end
