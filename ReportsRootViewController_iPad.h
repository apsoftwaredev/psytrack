//
//  ReportsRootViewController_iPad.h
//  psyTrainTrack
//
//  Created by Daniel Boice on 11/24/11.
//  Copyright (c) 2011 PsycheWeb LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ReportsDetailViewController_iPad;
@interface ReportsRootViewController_iPad : UIViewController{



    __weak ReportsDetailViewController_iPad *reportsDetailViewController_iPad;



}


@property (nonatomic,weak) IBOutlet ReportsDetailViewController_iPad *reportsDetailViewController_iPad;

@end
