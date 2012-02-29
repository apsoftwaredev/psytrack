//
//  PTTMasterViewController.h
//  psyTrainTrack
//
//  Created by Daniel Boice on 9/22/11.
//  Copyright (c) 2011 PsycheWeb LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PTTDetailViewController_iPhone;

#import <CoreData/CoreData.h>

@interface PTTMasterViewController_iPhone : UIViewController 
@property (strong,nonatomic) IBOutlet UITabBarController *tabBarController;

@property (strong, nonatomic) IBOutlet UINavigationBar *navigationBar;
@end
