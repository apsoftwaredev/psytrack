//
//  TeachingExperienceVC.m
//  PsyTrack
//
//  Created by Daniel Boice on 8/12/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import "TeachingExperienceVC.h"
#import "PTTAppDelegate.h"

@interface TeachingExperienceVC ()

@end

@implementation TeachingExperienceVC


- (void)viewDidLoad
{
    [super viewDidLoad];
   
    dateFormatter = [[NSDateFormatter alloc] init];
    
    //set the date format
    [dateFormatter setDateFormat:@"M/d/yyyy"];
    [dateFormatter setTimeZone:[NSTimeZone defaultTimeZone]];
    

    
    
    NSManagedObjectContext * managedObjectContext = [(PTTAppDelegate *)[UIApplication sharedApplication].delegate managedObjectContext];
    
    
    
    SCEntityDefinition *degreeCourseDef=[SCEntityDefinition definitionWithEntityName:@"DegreeCourseEntity" managedObjectContext:managedObjectContext propertyNamesString:@"courseName;credits;startDate;endDate;grade;degree;logs;notes"];
    
    
    
    if([SCUtilities is_iPad]){
        
        self.tableView.backgroundView=nil;
        UIView *newView=[[UIView alloc]init];
        [self.tableView setBackgroundView:newView];
        
        
    }
    self.tableView.backgroundColor=[UIColor clearColor];
    
    
    [self setNavigationBarType: SCNavigationBarTypeAddEditRight];
    
    objectsModel=[[SCArrayOfObjectsModel alloc]initWithTableView:self.tableView entityDefinition:degreeCourseDef];
    
    objectsModel.editButtonItem = self.editButton;;
    
    objectsModel.addButtonItem = self.addButton;
    
    UIViewController *navtitle=self.navigationController.topViewController;
    
    navtitle.title=@"Courses Taken";
    
    
    
    self.view.backgroundColor=[UIColor clearColor];
    
    
    
	objectsModel.searchPropertyName = @"dateOfService";
    
    objectsModel.allowMovingItems=TRUE;
    
    objectsModel.autoAssignDelegateForDetailModels=TRUE;
    objectsModel.autoAssignDataSourceForDetailModels=TRUE;
    
    
    objectsModel.enablePullToRefresh = TRUE;
    objectsModel.pullToRefreshView.arrowImageView.image = [UIImage imageNamed:@"blueArrow.png"];
    
    self.tableViewModel=objectsModel;
    
    
    
    

}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

@end

