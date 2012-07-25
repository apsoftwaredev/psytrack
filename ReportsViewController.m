/*
 *  ReportsViewController_iPhone.m
 *  psyTrack Clinician Tools
 *  Version: 1.0
 *
 *
 *	THIS SOURCE CODE AND ANY ACCOMPANYING DOCUMENTATION ARE PROTECTED BY UNITED STATES 
 *	INTELLECTUAL PROPERTY LAW AND INTERNATIONAL TREATIES. UNAUTHORIZED REPRODUCTION OR 
 *	DISTRIBUTION IS SUBJECT TO CIVIL AND CRIMINAL PENALTIES. 
 *
 *  Created by Daniel Boice on 11/24/11.
 *  Copyright (c) 2011 PsycheWeb LLC. All rights reserved.
 *
 *
 *	This notice may not be removed from this file.
 *
 */
#import "ReportsViewController.h"
#import "PTTAppDelegate.h"
#import "MonthlyPracticumLogGenerateViewController.h"

@implementation ReportsViewController
@synthesize myTableView;
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    NSInteger result = 1;
    
    return result;
    
}

- (NSInteger)tableView:(UITableView *)tableView 
 numberOfRowsInSection:(NSInteger)section{
    
    NSInteger result = 1;
       
    return result;
    
}
-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 50;
    
    
    
}
- (UITableViewCell *)     tableView:(UITableView *)tableView 
              cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *result = nil;
    
  
        
        static NSString *TableViewCellIdentifier = @"MyCells";
        
        result = [tableView
                  dequeueReusableCellWithIdentifier:TableViewCellIdentifier];
        
        if (result == nil){
            result = [[UITableViewCell alloc] 
                      initWithStyle:UITableViewCellStyleDefault
                      reuseIdentifier:TableViewCellIdentifier];
        }
        
        
        
        switch (indexPath.section) {
            case 0:
            {
                if (indexPath.row==0)result.textLabel.text=@"Monthly Practicum Log";
                
            }
                break;
                
           
            default:
                break;
        }
        
        result.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        

    
    return result;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
   
    
    
    
    
    
    
    
    
    switch (indexPath.section) {
            
            
        
        case 0:
        {
            if (indexPath.row==0){
                NSString *monthlyPracticumLogNibName=nil;
                if ([SCUtilities is_iPad]) {
                    monthlyPracticumLogNibName=@"MonthlyPracticumLogGenerateVC_iPad";
                }else {
                    monthlyPracticumLogNibName=@"MonthlyPracticumLogGenerateVC_iPhone";
                }
                MonthlyPracticumLogGenerateViewController *monthlyPracticumLogGenerateViewController = [[MonthlyPracticumLogGenerateViewController alloc] initWithNibName:monthlyPracticumLogNibName bundle:[NSBundle mainBundle]];
                
                [self.navigationController pushViewController:monthlyPracticumLogGenerateViewController animated:YES];
                break;
            }  
            
            
        }
            break;
                default:
            break;
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor clearColor];
    
   
//    self.myTableView = 
//    [[UITableView alloc] initWithFrame:self.view.bounds
//                                 style:UITableViewStyleGrouped];
    //    self.myTableView.backgroundColor=[UIColor clearColor];
    self.tableView.delegate=self;
    self.tableView.dataSource = self;
    
    /* Make sure our table view resizes correctly */
    self.tableView.autoresizingMask = 
    UIViewAutoresizingFlexibleWidth |
    UIViewAutoresizingFlexibleHeight;
    
   
    //    NSString *menuBarImageNameStr=nil;
    if ([SCUtilities is_iPad]) {
        
        [self.tableView setBackgroundView:nil];
        [self.tableView setBackgroundView:[[UIView alloc] init]];
        
    }
    
    [self.tableView setBackgroundColor:[UIColor clearColor]];
    
    
    
    //          UIImage *navBarBackgroundImage=[UIImage imageNamed:menuBarImageNameStr];
    
    //
    //    UINavigationBar *navBar=(UINavigationBar *)self.navigationController.navigationBar;
    
    //    [navBar setBackgroundImage:navBarBackgroundImage forBarMetrics:UIBarMetricsDefault];
    
  
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    
    return YES;
    
}

- (CGFloat)     tableView:(UITableView *)tableView 
 heightForHeaderInSection:(NSInteger)section{
    
    CGFloat result = 30.0f;
   
    return result;
    
}

- (CGFloat)     tableView:(UITableView *)tableView 
 heightForFooterInSection:(NSInteger)section{
    
    CGFloat result = 30.0f;
    
    
    return result;
    
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    
    NSString *headerTitle=nil;
    switch (section) {
        case 0:
            headerTitle=@"Training Reports";
            break;
                    
        default:
            break;
    }
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.bounds.size.width, 30)];
    if (section == 0)
        [headerView setBackgroundColor:[UIColor clearColor]];
    else 
        [headerView setBackgroundColor:[UIColor clearColor]];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 3, self.tableView.bounds.size.width - 10, 18)];
    
    
    
    label.text = headerTitle;
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor clearColor];
    [headerView addSubview:label];
    return headerView;  
}






@end