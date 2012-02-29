//
//  DrugsTableViewController.h
//  psyTrainTrack
//
//  Created by Daniel Boice on 1/15/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrugsTableViewController : UITableViewController<NSFetchedResultsControllerDelegate>{

NSFetchedResultsController *fetchedResultsController;
    NSManagedObjectContext *drugsManagedObjectContext;
}


@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, strong) NSManagedObjectContext *drugsManagedObjectContext;



@end
