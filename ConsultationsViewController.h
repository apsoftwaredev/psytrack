//
//  ConsultationsViewController.h
//  PsyTrack
//
//  Created by Daniel Boice on 7/27/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//



@interface ConsultationsViewController : SCTableViewController <SCTableViewModelDelegate,SCTableViewModelDataSource>{

     SCArrayOfObjectsModel *objectsModel;
    NSDateFormatter *dateFormatter;
}

@end
