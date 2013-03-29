//
//  ExistingHoursViewController.h
//  PsyTrack Clinician Tools
//  Version: 1.0.6
//
//  Created by Daniel Boice on 3/29/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import "InterventionTypeEntity.h"
#import "SupervisionTypeEntity.h"
@interface ExistingHoursViewController : SCTableViewController <SCTableViewModelDelegate,SCTableViewModelDataSource>{
    SCArrayOfObjectsModel *objectsModel;

    InterventionTypeEntity *selectedInterventionType;
    SupervisionTypeEntity *selectedSupervisionType;
}
//-(void)cancelButtonTapped;
@end
