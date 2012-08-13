//
//  ConferencesAttendedVC.h
//  PsyTrack
//
//  Created by Daniel Boice on 8/12/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import <SensibleTableView/SensibleTableView.h>

@interface ConferencesAttendedVC : SCTableViewController <SCTableViewModelDelegate> {
    
    SCArrayOfObjectsModel *objectsModel;
    
    NSDateFormatter *dateFormatter;
    
}


@end