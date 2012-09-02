//
//  CommunityServiceVC.h
//  PsyTrack
//
//  Created by Daniel Boice on 9/1/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import <SensibleTableView/SensibleTableView.h>

@interface CommunityServiceVC : SCTableViewController<SCTableViewModelDelegate> {
    
    SCArrayOfObjectsModel *objectsModel;
    
    NSDateFormatter *dateFormatter;
    
}


@end