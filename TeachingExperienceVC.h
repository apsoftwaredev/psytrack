//
//  TeachingExperienceVC.h
//  PsyTrack Clinician Tools
//  Version: 1.5.2
//
//  Created by Daniel Boice on 8/12/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import <SensibleTableView/SensibleTableView.h>

@interface TeachingExperienceVC : SCTableViewController <SCTableViewModelDelegate> {
    SCArrayOfObjectsModel *objectsModel;

    NSDateFormatter *dateFormatter;
}

@end
