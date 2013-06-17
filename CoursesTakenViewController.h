//
//  CoursesTakenViewController.h
//  PsyTrack Clinician Tools
//  Version: 1.5.2
//
//  Created by Daniel Boice on 8/10/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

@interface CoursesTakenViewController : SCTableViewController <SCTableViewModelDelegate> {
    SCArrayOfObjectsModel *objectsModel;

    NSDateFormatter *dateFormatter;
}

@end
