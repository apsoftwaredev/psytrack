//
//  CECreditsViewController.h
//  PsyTrack
//
//  Created by Daniel Boice on 7/28/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//



@interface CECreditsViewController : SCTableViewController <SCTableViewModelDelegate>{

    SCArrayOfObjectsModel *objectsModel;

    NSDateFormatter *dateFormatter;
}

@end