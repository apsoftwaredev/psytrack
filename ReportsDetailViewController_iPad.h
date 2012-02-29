//
//  ReportsDetailViewController_iPad.h
//  psyTrainTrack
//
//  Created by Daniel Boice on 11/24/11.
//  Copyright (c) 2011 PsycheWeb LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class  ReportsRootViewController_iPad;
@interface ReportsDetailViewController_iPad : UITableViewController
{


    __weak ReportsRootViewController_iPad *reportsRootViewController_iPad;

}

@property (nonatomic, weak) IBOutlet  ReportsRootViewController_iPad *reportsRootViewController_iPad;

@end
