/*
 *  TrainTrackViewController.m
 *  psyTrack Clinician Tools
 *  Version: 1.0
 *
 *
 *	THIS SOURCE CODE AND ANY ACCOMPANYING DOCUMENTATION ARE PROTECTED BY UNITED STATES 
 *	INTELLECTUAL PROPERTY LAW AND INTERNATIONAL TREATIES. UNAUTHORIZED REPRODUCTION OR 
 *	DISTRIBUTION IS SUBJECT TO CIVIL AND CRIMINAL PENALTIES. 
 *
 *  Created by Daniel Boice on 9/28/11.
 *  Copyright (c) 2011 PsycheWeb LLC. All rights reserved.
 *
 *
 *	This notice may not be removed from this file.
 *
 */
#import "TrainTrackViewController.h"
#import "PTTAppDelegate.h"
#import "TimeTrackViewController.h"
#import "DrugViewController_iPhone.h"
#import "ClinicianEntity.h"
#import "CustomSCSelectonCellWithLoading.h"
//#import "CliniciansViewController_Shared.h"
#import "LCYLockSettingsViewController.h"
#import "ExistingHoursViewController.h"
#import "CliniciansRootViewController_iPad.h"
#import "DTAboutViewController.h"
#import "NSString+Helpers.h"
#import "ClinicianGroupsViewController.h"
#import "ClinicianViewController.h"
#import "CliniciansDetailViewController_iPad.h"
#import "ClientGroupsViewController.h"
#import "PresentationsViewController.h"
#import "ConsultationsViewController.h"
#import "CECreditsViewController.h"
//#import "UICasualAlert.h"
//#import <MessageUI/MessageUI.h>
//
//#import "IASKSpecifier.h"
//#import "IASKSettingsReader.h"
//
//#import "CustomViewCell.h"

//#import "InterventionViewController.h"
//#import "IndirectSupportViewController.h"
//#import "SupervisionReceivedViewController.h"
//#import "SupervisionGivenViewController.h"

@implementation TrainTrackViewController


//@synthesize cliniciansViewController_Shared=cliniciansViewController_Shared_;
//@synthesize appSettingsViewController;


#pragma mark -
#pragma mark View lifecycle




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    NSInteger result  = 12;
    
    return result;
    
}

- (NSInteger)tableView:(UITableView *)tableView 
 numberOfRowsInSection:(NSInteger)section{
    
    NSInteger result = 0;
   
        switch (section){
            case 0:{
                result = 1;
                break;
            }
            case 1:{
                result = 2;
                break;
            }
            case 2:{
                result = 1;
                break;
            }
            case 3:{
                result = 2;
                break;
            }
            case 4:{
                result = 1;
                break;
            }
            case 5:{
                result = 1;
                break;
            }
            case 6:{
                result = 3;
                break;
            }
            case 7:{
                result = 3;
                break;
            }
           
            case 8:{
                result = 1;
                break;
            }
            case 9:{
                result = 2;
                break;
            }
            case 10:{
                result = 1;
                break;
            }
    
            case 11:{
                result = 2;
                break;
            }
           default:
                break;
                  
        }
    
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
                    if (indexPath.row==0)result.textLabel.text=@"My Information";
                
                }
                    break;
                
                case 1:
                {
                    if (indexPath.row==0)result.textLabel.text=@"Assessments";

                    if (indexPath.row==1)result.textLabel.text=@"Interventions";

                    
                }
                    break;
                case 2:
                {
                    if (indexPath.row==0)result.textLabel.text=@"Indirect Support Activities";
                    
                }
                    break;
                case 3:
                {
                    if (indexPath.row==0)result.textLabel.text=@"Supervision Received";
                    if (indexPath.row==1)result.textLabel.text=@"Supervision Given";
                    
                    
                }
                    break;
                case 4:
                {
                    if (indexPath.row==0)result.textLabel.text=@"Existing Hours";
                  
                    
                }
                    break;
                case 5:
                {
                    if (indexPath.row==0)result.textLabel.text=@"Consultations";
                   
                    
                    
                    
                }
                    break;
                    
                case 6:
                {
                    if (indexPath.row==0)result.textLabel.text=@"Continuing Education Credits";

                    if (indexPath.row==1)result.textLabel.text=@"Courses Taken";
                    if (indexPath.row==2)result.textLabel.text=@"Conferences Attended";
                  

                    
                }
                    break;
                    
                case 7:
                {
                     if (indexPath.row==0)result.textLabel.text=@"Courses Taught";
                     if (indexPath.row==1)result.textLabel.text=@"Presentations";
                   
                    if (indexPath.row==2)result.textLabel.text=@"Expert Testemony";
                    
                }
                    break;
               
                
               
                
                case 8:
                {
                    result.textLabel.text=@"Drug Database";
                    
                }
                    break;
                    
                case 9:
                {
                    
                    
                    if (indexPath.row==0)result.textLabel.text=@"Clinician Groups";
                    if (indexPath.row==1)result.textLabel.text=@"Client Groups";

                  
                }
                    break;
                case 10:
                {
                    if (indexPath.row==0)result.textLabel.text=@"Lock Screen and Encryption";
                    
                    
                } 
                    break;
                case 11:
                {
                
                    if (indexPath.row==0)result.textLabel.text=@"Support";
                    if (indexPath.row==1)result.textLabel.text=@"About";
                
                }
                default:
                    break;
            }
        
        result.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

        
    
    
    return result;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{


    if (indexPath.section==0 &&indexPath.row==0) 
        {
            //@"My Information"
           
                PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
                
            if (![SCUtilities is_iPad]) {
           
                UINavigationController *navController=nil;
                for (navController in appDelegate.tabBarController.viewControllers) {
                    if ([navController.title isEqualToString:@"Clinicians"]) {
                        
                        [appDelegate.clinicianViewController setSelectMyInformationOnLoad:YES];
                        [appDelegate.tabBarController setSelectedViewController:navController];
                        
                        break;
                    }
                }            
                
            }               
            else
            {
                UISplitViewController *splitView=nil;
                CliniciansDetailViewController_iPad *cliniciansDetailViewController_iPad=nil;
                CliniciansRootViewController_iPad *cliniciansRootViewController_iPad=nil;
                UIPopoverController *popoverController=nil;
                for (splitView in appDelegate.tabBarController.viewControllers) {
                    if ([splitView.title isEqualToString:@"Clinicians"]) {
                        
                        for (UINavigationController *navController in splitView.viewControllers) {
                            if ([navController.title isEqualToString:@"ClinicianRoot"]) {
                                cliniciansRootViewController_iPad=(CliniciansRootViewController_iPad *)[navController.viewControllers objectAtIndex:0];
                                
                                
                                [cliniciansRootViewController_iPad setSelectMyInformationOnLoad:YES];
                                
                            }
                            else if ([navController.title isEqualToString:@"ClinicianDetail"]) 
                            {
                                    
                                
                                cliniciansDetailViewController_iPad=(CliniciansDetailViewController_iPad *)[navController.viewControllers objectAtIndex:0];
                                
                                if (cliniciansDetailViewController_iPad.popoverController) {
                                    popoverController=cliniciansDetailViewController_iPad.popoverController;
                                }
                                
                            }
                            
                            
                            
                            
                        }
                        
                        
                        [appDelegate.clinicianViewController setSelectMyInformationOnLoad:YES];
                        [appDelegate.tabBarController setSelectedViewController:splitView];
                        
                        
//                        NSLog(@"barbutton item action is %@",barButtonItem.action);
                    
                      
                      
                        
                        
                        
                        break;
                    }
                }
                
            }  
    
    
        }
            
        

    





    switch (indexPath.section) {
      
            
        case 1:
        {
            //@"Assessments "
            if (indexPath.row==0){
                [self LoadTimeTrackViewControllerWithSetup:(PTrackControllerSetup)kTrackAssessmentSetup];
                break;
            };
            
            if (indexPath.row==1) {
                [self LoadTimeTrackViewControllerWithSetup:(PTrackControllerSetup)kTrackInterventionSetup];
                break;
            }            //interventions
//            if (indexPath.row==1){};
            
            
        }
            break;
        case 2:
        {
            //@"Support Activities"
            //            if (indexPath.row==0){
            [self LoadTimeTrackViewControllerWithSetup:(PTrackControllerSetup)kTrackSupportSetup];
            break;
        
            
        }
            break;
        case 3:
        {
            //@"Supervision Received"
            if (indexPath.row==0)
                [self LoadTimeTrackViewControllerWithSetup:(PTrackControllerSetup)kTrackSupervisionReceivedSetup];
            
            //@"Supervision Given
            if (indexPath.row==1)
                [self LoadTimeTrackViewControllerWithSetup:(PTrackControllerSetup)kTrackSupervisionGivenSetup];
            
        }
            break;
        case 4:
        {
            //@"Existing Hours"
            if (indexPath.row==0){
                NSString *existingHoursViewControllerNibName=nil;
                if ([SCUtilities is_iPad]) {
                    existingHoursViewControllerNibName=@"ExistingHoursViewController_iPad";
                }else {
                    existingHoursViewControllerNibName=@"ExistingHoursViewController";
                }
                ExistingHoursViewController *existingHoursViewController = [[ExistingHoursViewController alloc] initWithNibName:existingHoursViewControllerNibName bundle:[NSBundle mainBundle]];
                
                [self.navigationController pushViewController:existingHoursViewController animated:YES];
                break;
            }  
            
            
        }
            break;
        case 5:
        {
            //@"Consultations"
       
            if (indexPath.row==0){
                
                
                
                ConsultationsViewController *consultationsViewController = [[ConsultationsViewController alloc] initWithNibName:@"ConsultationsViewController" bundle:[NSBundle mainBundle]];
                
                [self.navigationController pushViewController:consultationsViewController animated:YES];
                break;
            }  
            
            
        }
            break;
            
        case 6:
        {
            //@"Continuing Education Credits"
            if (indexPath.row==0){
            
            
            
                CECreditsViewController *ceCreditsViewController = [[CECreditsViewController alloc] initWithNibName:@"CECreditsViewController" bundle:[NSBundle mainBundle]];
                
                [self.navigationController pushViewController:ceCreditsViewController animated:YES];
           
            }
            
            
            //@"Certifications"
//            if (indexPath.row==1);
            
            
        }
            break;
            
        case 7:
        {
            //@"Courses Taught"
//            if (indexPath.row==0);
            
            //@"Presentations"
            if (indexPath.row==1){
            
               
                   
                    PresentationsViewController *presentationsViewController = [[PresentationsViewController alloc] initWithNibName:@"PresentationsViewController" bundle:[NSBundle mainBundle]];
                    
                    [self.navigationController pushViewController:presentationsViewController animated:YES];
                    break;
            }  

            
            
            
            
            
            
            
        }
            break;
       
        
        case 8:
        {
            //@"Courses Taught"
            //            if (indexPath.row==0);
            
            //@"Presentations"
            //            if (indexPath.row==1);
            
        }
            break;
       
            
        case 9:
        {
            //@"Courses Taught"
            //            if (indexPath.row==0);
            
            //@"Presentations"
            //            if (indexPath.row==1);
            
        }
            break;
            
        case 10:
        {
            //@"Drug Database"
            UITabBar *tabBar=(UITabBar *) [(PTTAppDelegate *)[UIApplication sharedApplication].delegate tabBar];
            tabBar.userInteractionEnabled=FALSE;            
            
            [[NSNotificationCenter defaultCenter]
             addObserver:prog
             selector:@selector(stopAnimating)
             name:@"DrugViewControllerDidAppear"
             object:nil];

            
            
            
            [NSThread detachNewThreadSelector:@selector(startAnimatingProgressInBackground) toTarget:prog withObject:prog];
            
            DrugViewController_iPhone *drugViewController_iPhone = [[DrugViewController_iPhone alloc] initWithNibName:@"DrugViewController_iPhone" bundle:nil];
//           
            
//            PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
            
//           NSLog(@"view controller is %@",self.tableViewModel);
//            UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:drugViewController_iPhone];	
            
//            PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
            

            [self.navigationController pushViewController:drugViewController_iPhone animated:YES];
            
            
            tabBar.userInteractionEnabled=TRUE;
           
            
        }
            break;
            
        case 11:
        {
            //@"Clinician Groups"
            
            
            if (indexPath.row==0){
                
                
                ClinicianGroupsViewController *clinicianGroupsViewController = [[ClinicianGroupsViewController alloc] initWithNibName:@"ClinicianGroupsViewController" bundle:[NSBundle mainBundle] ];
                
                [self.navigationController pushViewController:clinicianGroupsViewController animated:YES];
                
                clinicianGroupsViewController.rootNavController=self.navigationController;
                
                
            };
            
            //@"Clinician Groups"
            
            if (indexPath.row==1){
                
                
                ClientGroupsViewController *clientGroupsViewController = [[ClientGroupsViewController alloc] initWithNibName:@"ClientGroupsViewController" bundle:[NSBundle mainBundle]];
                
                [self.navigationController pushViewController:clientGroupsViewController animated:YES];
                
                
            };
            

                        
            
        }
            break;
        case 12:
        {
            //@"Lock Screen Settings"
            if (indexPath.row==0){
                
                LCYLockSettingsViewController *lockSettingsVC = [[LCYLockSettingsViewController alloc] initWithNibName:@"LCYLockSettingsViewController" bundle:nil];
                [[self navigationController] pushViewController:lockSettingsVC animated:YES];            
                break;
                
            };
            
                 
        }
            break;
           
        case 13:
        {
            //@"Support"
            if (indexPath.row==0){
                DTLayoutDefinition *supportLayout = [DTLayoutDefinition layoutNamed:@"support"];
                DTAboutViewController *support =[[DTAboutViewController alloc] initWithLayout:supportLayout];
                support.title = @"Support";
                [self.navigationController pushViewController:support animated:YES];

            
            };
            
            //@"About"
            if (indexPath.row==1){
            
                DTAboutViewController *about = [[DTAboutViewController alloc] initWithLayout:nil]; // default is @"about"
                about.title	 = @"About";
                about.delegate = self;
                [self.navigationController pushViewController:about animated:YES];
            
            
            };
            
        }
        default:
            break;
    }
    












}

- (void)viewDidLoad{
    [super viewDidLoad];
    

    self.view.backgroundColor = [UIColor clearColor];
    
    UIImage *lockImage=[UIImage imageNamed:@"lock.png"];
	UIBarButtonItem *stopButton = [[UIBarButtonItem alloc] initWithImage:lockImage style:UIBarButtonItemStyleDone target:self action:@selector(lockScreen:)];
    self.navigationItem.rightBarButtonItem = stopButton;
//    self.myTableView = 
//    [[UITableView alloc] initWithFrame:self.view.bounds
//                                 style:UITableViewStyleGrouped];
//    self.myTableView.backgroundColor=[UIColor clearColor];
    self.tableView.dataSource = self;
    self.tableView.delegate=self;
    /* Make sure our table view resizes correctly */
//    self.tableView.autoresizingMask = 
//    UIViewAutoresizingFlexibleWidth |
//    UIViewAutoresizingFlexibleHeight;
    
//    [self.view addSubview:self.myTableView];
//    NSString *menuBarImageNameStr=nil;
    if ([SCUtilities is_iPad]) {
        
        [self.tableView setBackgroundView:nil];
        [self.tableView setBackgroundView:[[UIView alloc] init]];
       
    }
    
        [self.tableView setBackgroundColor:[UIColor clearColor]];
       
prog = [[BigProgressViewWithBlockedView alloc] initWithFrame:CGRectMake(0, 64, 320, 367) blockedView:self.view];
    
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
    
    CGFloat result =  30.0f;
    
    
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
            headerTitle=@"My Information";
            break;
        case 1:
            headerTitle=@"Direct Intervention Track" ;
            break;
        case 2:
            headerTitle=@"Indirect Support Activities Track";
            break;
        case 3:
            headerTitle=@"Direct Supervision Track";
            break;
        case 4:
            headerTitle=@"Existing Hours Track";
            break;
        case 5:
            headerTitle=@"Consultations Track";
            break;
        case 6:
            headerTitle=@"Education Track";
            break;
        case 7:
            headerTitle=@"Teaching and Leadership Track";
            break;
       
        case 8:
            headerTitle=@"Drug Database Track";
            break;
        
        case 9:
            headerTitle=@"Groups Track";
            
            break;
        case 10:
            headerTitle=@"Security Track";
            break;
        case 11:
            headerTitle=@"Support and About Track";
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


-(void)LoadTimeTrackViewControllerWithSetup:(PTrackControllerSetup )timeTrackSetup{

    TimeTrackViewController *timeTrackViewController = [[TimeTrackViewController alloc] initWithNibName:@"TimeTrackViewController" bundle:nil trackSetup:timeTrackSetup];
    
    [self.navigationController pushViewController:timeTrackViewController animated:YES];



}


-(void)drugViewControllerDidFinishLoading{

    [prog stopAnimating];



}
- (IBAction) lockScreen: (id) sender;
{
	PTTAppDelegate *appDelegate =  (PTTAppDelegate *)	[[UIApplication sharedApplication] delegate];
    
	//NSLog(@"app passcode is: %@", [appDelegate appLockPasscode]);	
	
    [appDelegate lockApplication];

    
}


#pragma mark DTAboutViewController Delegate
- (void)aboutViewController:(DTAboutViewController *)aboutViewController performCustomAction:(NSString *)action withObject:(id)object
{
	// demonstrate responding to an action that the controller does not know how to perform
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.psyTrack.com/"]];
}

- (UIView *)aboutViewController:(DTAboutViewController *)aboutViewController customViewForDictionary:(NSDictionary *)dictionary {
	return nil;
}

- (void)aboutViewController:(DTAboutViewController *)aboutViewController didSetupLabel:(UILabel *)label forTextStyle:(NSUInteger)style
{
	// demonstrate different text color on labels
	label.textColor = [UIColor whiteColor];
}




@end
