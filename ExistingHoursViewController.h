//
//  ExistingHoursViewController.h
//  PsyTrack
//
//  Created by Daniel Boice on 3/29/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//



@interface ExistingHoursViewController : UITableViewController <SCTableViewModelDelegate,SCTableViewModelDataSource>{


    SCArrayOfObjectsModel *tableModel_;

}
-(void)cancelButtonTapped;
@end
