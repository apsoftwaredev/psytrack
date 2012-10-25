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
                result = 6;
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
                     if (indexPath.row==0)result.textLabel.text=@"Teaching Experience";
                     if (indexPath.row==1)result.textLabel.text=@"Presentations";
                   
                    if (indexPath.row==2)result.textLabel.text=@"Expert Testemony";
                    if (indexPath.row==3)result.textLabel.text=@"Media Appearances";
                    if (indexPath.row==4)result.textLabel.text=@"Community Service";
                    if (indexPath.row==5)result.textLabel.text=@"Other Activities";
                    
                    
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
                        
                        
//                        
                    
                      
                      
                        
                        
                        
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
              
                if (!existingHoursViewController) {
                    NSString *existingHoursViewControllerNibName=nil;
                    if ([SCUtilities is_iPad]) {
                        existingHoursViewControllerNibName=@"ExistingHoursViewController_iPad";
                    }else {
                        existingHoursViewControllerNibName=@"ExistingHoursViewController";
                    }
                     existingHoursViewController = [[ExistingHoursViewController alloc] initWithNibName:existingHoursViewControllerNibName bundle:[NSBundle mainBundle]];
                }
               
                
                [self.navigationController pushViewController:existingHoursViewController animated:YES];
                break;
            }  
            
            
        }
            break;
        case 5:
        {
            //@"Consultations"
       
            if (indexPath.row==0){
                
                
                if (!consultationsViewController) {
                    consultationsViewController = [[ConsultationsViewController alloc] initWithNibName:@"ConsultationsViewController" bundle:[NSBundle mainBundle]];
                    
                }
                
                [self.navigationController pushViewController:consultationsViewController animated:YES];
                break;
            }  
            
            
        }
            break;
            
        case 6:
        {
            //@"Continuing Education Credits"
            if (indexPath.row==0){
            
            
                if (!ceCreditsViewController) {
                   ceCreditsViewController = [[CECreditsViewController alloc] initWithNibName:@"CECreditsViewController" bundle:[NSBundle mainBundle]];
                    
                }
               
                [self.navigationController pushViewController:ceCreditsViewController animated:YES];
           
            }
            if (indexPath.row==1){
                
                
                if (!coursesTakenViewController) {
                   coursesTakenViewController = [[CoursesTakenViewController alloc] initWithNibName:@"CoursesTakenViewController" bundle:[NSBundle mainBundle]];
                    
                }
               
                [self.navigationController pushViewController:coursesTakenViewController animated:YES];
                
            }
            if (indexPath.row==2){
                
                
                if (!conferencesAttendedViewController) {
                   conferencesAttendedViewController = [[ConferencesAttendedVC alloc] initWithNibName:@"ConferencesAttendedVC" bundle:[NSBundle mainBundle]];
                    

                }
                [self.navigationController pushViewController:conferencesAttendedViewController animated:YES];
                
            }
            
            
            
        }
            break;
            
        case 7:
        {
            if (indexPath.row==0){
                
                
                if (!teachingExperienceVC) {
                    teachingExperienceVC = [[TeachingExperienceVC alloc] initWithNibName:@"TeachingExperienceVC" bundle:[NSBundle mainBundle]];
                    
                }
                
                [self.navigationController pushViewController:teachingExperienceVC animated:YES];
                
            }
            if (indexPath.row==1){
            
               
                if (!presentationsViewController) {
                   presentationsViewController = [[PresentationsViewController alloc] initWithNibName:@"PresentationsViewController" bundle:[NSBundle mainBundle]];
                    
                }
                
                    [self.navigationController pushViewController:presentationsViewController animated:YES];
                    break;
            }  

            if (indexPath.row==2){
                
                
                if (!expertTestemonyVC) {
                    expertTestemonyVC = [[ExpertTestemonyVC alloc] initWithNibName:@"ExpertTestemonyVC" bundle:[NSBundle mainBundle]];
                }
               
                
                [self.navigationController pushViewController:expertTestemonyVC animated:YES];
                break;
            }

            if (indexPath.row==3){
                
                
                
            
                if (!mediaAppearanceVC) {
                    mediaAppearanceVC = [[MediaAppearanceVC alloc] initWithNibName:@"MediaAppearanceVC" bundle:[NSBundle mainBundle]];
                }
                
                [self.navigationController pushViewController:mediaAppearanceVC animated:YES];
                break;
            }
            
            if (indexPath.row==4){
                
                
                
                
                if (!communitySerivceVC) {
                    communitySerivceVC = [[CommunityServiceVC alloc] initWithNibName:@"CommunityServiceVC" bundle:[NSBundle mainBundle]];
                }
                
                [self.navigationController pushViewController:communitySerivceVC animated:YES];
                break;
            }
            
            
            if (indexPath.row==5){
                
                
                if (!otherActivityVC) {
                    otherActivityVC = [[OtherActivityVC alloc] initWithNibName:@"OtherActivityVC" bundle:[NSBundle mainBundle]];
                }
            
                
                [self.navigationController pushViewController:otherActivityVC animated:YES];
                break;
            }
            
        }
            break;
       
        
       
            
        case 8:
        {
            //@"Drug Database"
           
            
//           
            
//            PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
            
//           
//            UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:drugViewController_iPhone];	
            
//            PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
            
            if (!drugViewController_iPhone) {
                drugViewController_iPhone = [[DrugViewController_iPhone alloc] initWithNibName:@"DrugViewController_iPhone" bundle:nil];
            }
            [self.navigationController pushViewController:drugViewController_iPhone animated:YES];
            
            
         
           
            
        }
            break;
            
        case 9:
        {
            //@"Clinician Groups"
            
            
            if (indexPath.row==0){
                
                if (!clinicianGroupsViewController) {
                    clinicianGroupsViewController = [[ClinicianGroupsViewController alloc] initWithNibName:@"ClinicianGroupsViewController" bundle:[NSBundle mainBundle] ];
                }
              
                
                [self.navigationController pushViewController:clinicianGroupsViewController animated:YES];
                
                clinicianGroupsViewController.rootNavController=self.navigationController;
                
                
            };
            
            //@"Clinician Groups"
            
            if (indexPath.row==1){
                
                if (!clientGroupsViewController) {
                    clientGroupsViewController = [[ClientGroupsViewController alloc] initWithNibName:@"ClientGroupsViewController" bundle:[NSBundle mainBundle]];
                }
              
                
                [self.navigationController pushViewController:clientGroupsViewController animated:YES];
                
                
            };
            

                        
            
        }
            break;
        case 10:
        {
            //@"Lock Screen Settings"
            if (indexPath.row==0){
                
               
                
                if (!lockSettingsVC) {
                    lockSettingsVC = [[LCYLockSettingsViewController alloc] initWithNibName:@"LCYLockSettingsViewController" bundle:nil];
                }
                [[self navigationController] pushViewController:lockSettingsVC animated:YES];
                break;
                
            };
            
                 
        }
            break;
           
        case 11:
        {
            //@"Support"
            if (indexPath.row==0){
                DTLayoutDefinition *supportLayout = [DTLayoutDefinition layoutNamed:@"support"];
                if (!support) {
                    support =[[DTAboutViewController alloc] initWithLayout:supportLayout];
                }
               
                support.title = @"Support";
                [self.navigationController pushViewController:support animated:YES];

            
            };
            
            //@"About"
            if (indexPath.row==1){
                if (!about) {
                    about = [[DTAboutViewController alloc] initWithLayout:nil];
                }
               
                about.title	 = @"About";
                about.delegate = self;
                [self.navigationController pushViewController:about animated:YES];
            
            
            };
            
        }
        default:
            break;
    }
    


}


-(void)viewDidAppear:(BOOL)animated{


    [self setviewControllersToNil];

}



-(void)setviewControllersToNil{
  
    if (timeTrackViewController) {
        [timeTrackViewController viewDidUnload];
        timeTrackViewController.view=nil;
        timeTrackViewController=nil;
    }
    
    if (existingHoursViewController) {
        [existingHoursViewController viewDidUnload];
        existingHoursViewController.view=nil;
        existingHoursViewController=nil;

    }
    
    if (consultationsViewController) {
        [consultationsViewController viewDidUnload];
        consultationsViewController.view=nil;
        consultationsViewController =nil;
        
    }
    
    if (ceCreditsViewController) {
        [ceCreditsViewController viewDidUnload];
        ceCreditsViewController.view=nil;
        ceCreditsViewController =nil;
        
    }
    
    if (coursesTakenViewController) {
        [coursesTakenViewController viewDidUnload];
        coursesTakenViewController.view=nil;
        coursesTakenViewController =nil;
        
    }
   
    if (conferencesAttendedViewController) {
        [conferencesAttendedViewController viewDidUnload];
        conferencesAttendedViewController.view=nil;
        conferencesAttendedViewController =nil;
        
        
    }
    
    if (teachingExperienceVC) {
        [teachingExperienceVC viewDidUnload];
        teachingExperienceVC.view=nil;
        teachingExperienceVC =nil;
        
    }
   
    if (presentationsViewController) {
        [presentationsViewController viewDidUnload];
        presentationsViewController.view=nil;
        presentationsViewController =nil;
        
        
    }
    if (expertTestemonyVC) {
        [expertTestemonyVC viewDidUnload];
        expertTestemonyVC.view=nil;
        expertTestemonyVC =nil;
        
    }
    if (mediaAppearanceVC) {
        [mediaAppearanceVC viewDidUnload];
        mediaAppearanceVC.view=nil;
        mediaAppearanceVC =nil;
        
    }
    if (communitySerivceVC) {
        [communitySerivceVC viewDidUnload];
        communitySerivceVC.view=nil;
        communitySerivceVC=nil ;
        
    }
   
    if (otherActivityVC) {
        [otherActivityVC viewDidUnload];
        otherActivityVC.view=nil;
        otherActivityVC =nil;
        
    }
    if (drugViewController_iPhone) {
        [drugViewController_iPhone viewDidUnload];
        drugViewController_iPhone.view=nil;
        
        drugViewController_iPhone=nil;
        
    }
    if (clinicianGroupsViewController) {
        [clinicianGroupsViewController viewDidUnload];
        clinicianGroupsViewController.view=nil;
        clinicianGroupsViewController =nil;
        
    }
    
    if (clinicianGroupsViewController) {
        [clientGroupsViewController viewDidUnload];
        clientGroupsViewController.view=nil;
        clientGroupsViewController =nil;
        
    }
   
    if (lockSettingsVC) {
        [lockSettingsVC viewDidUnload];
        lockSettingsVC.view=nil;
        lockSettingsVC =nil;
        
    }
    
    if (support) {
        [support viewDidUnload];
        support.view=nil;
        support =nil;
    }
   
    if (about) {
        [about viewDidUnload];
        about.view=nil;
        
        about =nil;
    }
     // default is @"about"
    












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
    if ([SCUtilities is_iPad]||[SCUtilities systemVersion]>=6) {
        
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
            headerTitle=@"Teaching and Involvement Track";
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

    timeTrackViewController = [[TimeTrackViewController alloc] initWithNibName:@"TimeTrackViewController" bundle:nil trackSetup:timeTrackSetup];
    
    [self.navigationController pushViewController:timeTrackViewController animated:YES];



}


- (IBAction) lockScreen: (id) sender;
{
	PTTAppDelegate *appDelegate =  (PTTAppDelegate *)	[[UIApplication sharedApplication] delegate];
    
		
	
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
