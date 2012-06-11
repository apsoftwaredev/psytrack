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
#import "InAppSettingsViewController.h"
#import "ClinicianViewController.h"
#import "CliniciansDetailViewController_iPad.h"
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

@synthesize messageView;
//@synthesize cliniciansViewController_Shared=cliniciansViewController_Shared_;
//@synthesize appSettingsViewController;
@synthesize myTableView;

#pragma mark -
#pragma mark View lifecycle


//- (void) didReceiveMemoryWarning 
//{
//    // Releases the view if it doesn't have a superview.
//    [super didReceiveMemoryWarning];
//    
//    // Release any cached data, images, etc. that aren't in use.
//    PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
//    
//    
//    [appDelegate displayMemoryWarning];
//
//    
//}


//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//   //   
////    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
////        
////        [self.tableView setBackgroundView:nil];
////        [self.tableView setBackgroundView:[[UIView alloc] init]];
////        [self.tableView setBackgroundColor:UIColor.clearColor]; // Make the table view transparent
////        
////        
////    }
//
//
// 
////    
////    
////    //Do some property definition customization for the Supervisor Class
////    //      managedObjectContext = [(PTTAppDelegate *)[UIApplication sharedApplication].delegate managedObjectContext];
////    //    
////    NSPredicate *myInfoPredicate=[NSPredicate predicateWithFormat:@"myInformation = %@", [NSNumber numberWithBool:YES]]; 
////    
////    
////    self.clinicianDef.titlePropertyName=@"firstName;lastName";
////    
//////    SCSelectionCell *myInfoCell=[SCSelectionCell cellWithText:@"My Background Information" withBoundKey:@"myClinicianData" withValue:nil];
//////    myInfoCell.delegate=self;
//////    myInfoCell.tag=1;
////    
////    //Do some property definition customization for the Supervisor Class
////    SCSelectionCell *testAdministrationCell=[SCSelectionCell cellWithText:@"Assessment" withBoundKey:@"testAdminstrationCell" withValue:nil];
////    testAdministrationCell.delegate=self;
////    testAdministrationCell.tag=2;
////    SCSelectionCell *interventionCell=[SCSelectionCell cellWithText:@"Psychotherapy" withBoundKey:@"psychotherapyCell" withValue:nil];
////    interventionCell.delegate=self;
////    interventionCell.tag=3;
////    
////    SCSelectionCell *indirectSupportCell=[SCSelectionCell cellWithText:@"Indirect Support" withBoundKey:@"indirectSupportCell" withValue:nil];
////    indirectSupportCell.delegate=self;
////    indirectSupportCell.tag=4;
////    
////    
////    
////    SCSelectionCell *supervisionReceivedCell=[SCSelectionCell cellWithText:@"Supervision Received" withBoundKey:@"supervisionReceivedCell" withValue:nil];
////    supervisionReceivedCell.delegate=self;
////    supervisionReceivedCell.tag=5;
////    SCSelectionCell *supervisionGivenCell=[SCSelectionCell cellWithText:@"Supervision Given" withBoundKey:@"supervisionGivenCell" withValue:nil];
////    supervisionGivenCell.delegate=self;
////    supervisionGivenCell.tag=6;
////    
////    SCSelectionCell *existingHoursCell=[SCSelectionCell cellWithText:@"Existing Hours" withBoundKey:@"existingHoursCell" withValue:nil];
////    existingHoursCell.delegate=self;
////    existingHoursCell.tag=7;
////    
////    SCSelectionCell *consultationsCell=[SCSelectionCell cellWithText:@"Consultations" withBoundKey:@"consultationCell" withValue:nil];
////    consultationsCell.delegate=self;
////    consultationsCell.tag=8;
////    
////    SCSelectionCell *continuingEducationCell=[SCSelectionCell cellWithText:@"Continuing Education Credits" withBoundKey:@"continuingEducationCell" withValue:nil];
////    continuingEducationCell.delegate=self;
////    continuingEducationCell.tag=9;
////    
////    SCSelectionCell *certificationsCell=[SCSelectionCell cellWithText:@"Certifications" withBoundKey:@"certificationsCell" withValue:nil];
////    certificationsCell.delegate=self;
////    certificationsCell.tag=10;
////    
////    SCSelectionCell *collegeCoursesCell=[SCSelectionCell cellWithText:@"College Courses" withBoundKey:@"collegeCoursesCell" withValue:nil];
////    collegeCoursesCell.delegate=self;
////    collegeCoursesCell.tag=11;
////    
////    SCSelectionCell *presentationsCell=[SCSelectionCell cellWithText:@"Presentations" withBoundKey:@"presentationsCell" withValue:nil];
////    presentationsCell.delegate=self;
////    presentationsCell.tag=12;
////    
////    SCSelectionCell *teachingExperienceCell=[SCSelectionCell cellWithText:@"Teaching Experience" withBoundKey:@"teachingExperiencesCell" withValue:nil];
////    teachingExperienceCell.delegate=self;
////    teachingExperienceCell.tag=13;
////    
////    SCSelectionCell *advisingExperienceCell=[SCSelectionCell cellWithText:@"Advisors & Advisees" withBoundKey:@"advisingExperienceCell" withValue:nil];
////    advisingExperienceCell.delegate=self;
////    advisingExperienceCell.tag=14;
////    
////    CustomSCSelectonCellWithLoading *drugDatabaseCell=[CustomSCSelectonCellWithLoading cellWithText:@"Drug Database" withBoundKey:@"drugDatabaseCell" withValue:nil];
////    drugDatabaseCell.delegate=self;
////    drugDatabaseCell.tag=15;
////    
////    SCSelectionCell *lockPasscodeCell=[SCSelectionCell cellWithText:@"Lock Screen Settings" withBoundKey:@"lockSettingsCell" withValue:nil];
////    lockPasscodeCell.delegate=self;
////    lockPasscodeCell.tag=16;
////    
////    SCSelectionCell *otherAppSettingsCell=[SCSelectionCell cellWithText:@"Calander & Contacts" withBoundKey:@"otherSettingsCell" withValue:nil];
////    otherAppSettingsCell.delegate=self;
////    otherAppSettingsCell.tag=17;
////    
////    SCSelectionCell *supportCell=[SCSelectionCell cellWithText:@"Support" withBoundKey:@"supportCell" withValue:nil];
////    supportCell.delegate=self;
////    supportCell.tag=18;
////    
////    SCSelectionCell *aboutCell=[SCSelectionCell cellWithText:@"About" withBoundKey:@"aboutCell" withValue:nil];
////    aboutCell.delegate=self;
////    aboutCell.tag=19;
////    
////    
////    
////    // Initialize tableModel_
////    self.tableModel = [[SCArrayOfObjectsModel alloc] initWithTableView:self.tableView withViewController:self];
////    
////    // Create an array of objects section
////    SCArrayOfObjectsSection *myInformationSection = [SCArrayOfObjectsSection sectionWithHeaderTitle:@"My Information Track" withEntityClassDefinition:self.clinicianDef usingPredicate:myInfoPredicate];
////    
////    
////   
////    
////    //    [myInformationSection addCell:myInfoCell];
////	
////	// Create an array of objects section
////    SCTableViewSection *directSection = [SCTableViewSection sectionWithHeaderTitle:@"Direct Client Contact Track" ];
////    [directSection addCell:testAdministrationCell];
////    [directSection addCell:interventionCell];
////    
////    
////	SCTableViewSection *indirectSection = [SCTableViewSection sectionWithHeaderTitle:@"Indirect Client Support Activities Track"];
////	[indirectSection addCell:indirectSupportCell];
////    
////    SCTableViewSection *supervisionSection = [SCTableViewSection sectionWithHeaderTitle:@"Direct Supervision Track"];
////    [supervisionSection addCell:supervisionReceivedCell];
////    [supervisionSection addCell:supervisionGivenCell];
////  	
////    SCTableViewSection *existingHoursSection = [SCTableViewSection sectionWithHeaderTitle:@"Existing Hours Track"];
////    [existingHoursSection addCell:existingHoursCell];
////    
////    SCTableViewSection *consultationSection = [SCTableViewSection sectionWithHeaderTitle:@"Consultation Track"];
////    [consultationSection addCell:consultationsCell];
////    
////	SCTableViewSection *formalEducationSection = [SCTableViewSection sectionWithHeaderTitle:@"Formal Education Track"];
////    [formalEducationSection addCell:collegeCoursesCell];
////    [formalEducationSection addCell:certificationsCell];
////	
////    
////    
////    SCTableViewSection *teachingAndAdvisingSection = [SCTableViewSection sectionWithHeaderTitle:@"Teaching and Advising Track"];
////    [teachingAndAdvisingSection addCell:teachingExperienceCell];
////    [teachingAndAdvisingSection addCell:advisingExperienceCell];
////    [teachingAndAdvisingSection addCell:presentationsCell];
////    
////    SCTableViewSection *drugsDatabaseSection = [SCTableViewSection sectionWithHeaderTitle:@"Drug Database"];
////    [drugsDatabaseSection addCell:drugDatabaseCell];
////    
////    SCTableViewSection *preferencesSection = [SCTableViewSection sectionWithHeaderTitle:@"Preferences Track"];
////    [preferencesSection addCell:lockPasscodeCell];
////    [preferencesSection addCell:otherAppSettingsCell];
////    
////    
////    SCTableViewSection *supportAndAboutSection = [SCTableViewSection sectionWithHeaderTitle:@"Support and About Track"];
////    [supportAndAboutSection addCell:supportCell];
////    [supportAndAboutSection addCell:aboutCell];
////    
//// 
////    
////    [tableModel_ addSection:myInformationSection];
////    [tableModel_ addSection:directSection];
////    [tableModel_ addSection:indirectSection];
////    [tableModel_ addSection:supervisionSection];
////    [tableModel_ addSection:existingHoursSection];
////    [tableModel_ addSection:consultationSection];
////    [tableModel_ addSection:formalEducationSection];
////    [tableModel_ addSection:teachingAndAdvisingSection];
////    [tableModel_ addSection:drugsDatabaseSection];
////    [tableModel_ addSection:preferencesSection];
////    [tableModel_ addSection:supportAndAboutSection];
////    
//}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    NSInteger result = 0;
    if ([tableView isEqual:self.myTableView]){
        result = 11;
    }
    return result;
    
}

- (NSInteger)tableView:(UITableView *)tableView 
 numberOfRowsInSection:(NSInteger)section{
    
    NSInteger result = 0;
    if ([tableView isEqual:self.myTableView]){
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
                result = 2;
                break;
            }
            case 7:{
                result = 2;
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
                result = 2;
                break;
            }
           default:
                break;
                  
        }
    }
    return result;
    
}
-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{


    return 50;



}
- (UITableViewCell *)     tableView:(UITableView *)tableView 
              cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *result = nil;
    
    if ([tableView isEqual:self.myTableView]){
        
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
                    if (indexPath.row==0)result.textLabel.text=@"Support Activities";
                    
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

                    if (indexPath.row==1)result.textLabel.text=@"Certifications";

                    
                }
                    break;
                    
                case 7:
                {
                     if (indexPath.row==0)result.textLabel.text=@"Courses Taught";
                     if (indexPath.row==1)result.textLabel.text=@"Presentations";
                    
                }
                    break;
                case 8:
                {
                    result.textLabel.text=@"Drug Database";
                    
                }
                    break;
                    
                case 9:
                {
                    if (indexPath.row==0)result.textLabel.text=@"Lock Screen Settings";
                    if (indexPath.row==1)result.textLabel.text=@"Calander and Address Book";
                    

                  
                }
                    break;
                   
                case 10:
                {
                
                    if (indexPath.row==0)result.textLabel.text=@"Support";
                    if (indexPath.row==1)result.textLabel.text=@"About";
                
                }
                default:
                    break;
            }
        
        result.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

        
    }
    
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
//            if (indexPath.row==0);
            
            
        }
            break;
            
        case 6:
        {
            //@"Continuing Education Credits"
//            if (indexPath.row==0);
            
            //@"Certifications"
//            if (indexPath.row==1);
            
            
        }
            break;
            
        case 7:
        {
            //@"Courses Taught"
//            if (indexPath.row==0);
            
            //@"Presentations"
//            if (indexPath.row==1);
            
        }
            break;
        case 8:
        {
            //@"Drug Database"
            UITabBar *tabBar=(UITabBar *) [(PTTAppDelegate *)[UIApplication sharedApplication].delegate tabBar];
            tabBar.userInteractionEnabled=FALSE;            
            
            DrugViewController_iPhone *drugViewController_iPhone = [[DrugViewController_iPhone alloc] initWithNibName:@"DrugViewController_iPhone" bundle:nil];
//            PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
            
           NSLog(@"view controller is %@",self.tableViewModel);
//            UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:drugViewController_iPhone];	
            
//            PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
            

            [self.navigationController pushViewController:drugViewController_iPhone animated:YES];
            
            
            tabBar.userInteractionEnabled=TRUE;
           
            
        }
            break;
            
        case 9:
        {
            //@"Lock Screen Settings"
            if (indexPath.row==0){
            
                LCYLockSettingsViewController *lockSettingsVC = [[LCYLockSettingsViewController alloc] initWithNibName:@"LCYLockSettingsViewController" bundle:nil];
                [[self navigationController] pushViewController:lockSettingsVC animated:YES];            
                break;
            
            };
            //@"Calander and Address Book"
            if (indexPath.row==1){
            
            
                InAppSettingsViewController *inAppSettingsViewController = [[InAppSettingsViewController alloc] initWithNibName:@"InAppSettingsViewController" bundle:nil];
                
                [self.navigationController pushViewController:inAppSettingsViewController animated:YES];
                
                inAppSettingsViewController.rootNavController=self.navigationController;
            
            
            };
            
            
            
        }
            break;
            
        case 10:
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
    self.myTableView = 
    [[UITableView alloc] initWithFrame:self.view.bounds
                                 style:UITableViewStyleGrouped];
//    self.myTableView.backgroundColor=[UIColor clearColor];
    self.myTableView.dataSource = self;
    self.myTableView.delegate=self;
    /* Make sure our table view resizes correctly */
    self.myTableView.autoresizingMask = 
    UIViewAutoresizingFlexibleWidth |
    UIViewAutoresizingFlexibleHeight;
    
    [self.view addSubview:self.myTableView];
    NSString *menuBarImageNameStr=nil;
    if ([SCUtilities is_iPad]) {
        
        [self.myTableView setBackgroundView:nil];
        [self.myTableView setBackgroundView:[[UIView alloc] init]];
        menuBarImageNameStr=@"ipad-menubar-full.png";
    }
    else {
        [self.myTableView setBackgroundColor:[UIColor clearColor]];
        menuBarImageNameStr=@"menubar.png"; 

    }
          UIImage *navBarBackgroundImage=[UIImage imageNamed:menuBarImageNameStr];
    

    UINavigationBar *navBar=(UINavigationBar *)self.navigationController.navigationBar;
    
    [navBar setBackgroundImage:navBarBackgroundImage forBarMetrics:UIBarMetricsDefault];
    
    
}

- (void)viewDidUnload{
    [super viewDidUnload];
    self.myTableView = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    
    return YES;
    
}

- (CGFloat)     tableView:(UITableView *)tableView 
 heightForHeaderInSection:(NSInteger)section{
    
    CGFloat result = 0.0f;
    
    if ([tableView isEqual:self.myTableView]){
        result = 30.0f;
    }
    
    return result;
    
}

- (CGFloat)     tableView:(UITableView *)tableView 
 heightForFooterInSection:(NSInteger)section{
    
    CGFloat result = 0.0f;
    
    if ([tableView isEqual:self.myTableView] ){
        result = 30.0f;
    }
    
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
            headerTitle=@"Support Activities Track";
            break;
        case 3:
            headerTitle=@"Direct Supervision Track";
            break;
        case 4:
            headerTitle=@"Existing Hours Track";
            break;
        case 5:
            headerTitle=@"Consultations";
            break;
        case 6:
            headerTitle=@"Formal Education Track";
            break;
        case 7:
            headerTitle=@"Teaching and Advising Track";
            break;
        case 8:
            headerTitle=@"Drug Database";
            break;
        case 9:
            headerTitle=@"Preferences Track";
            break;
        case 10:
            headerTitle=@"Support and About Track";
            break;
  
        default:
            break;
    }
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.myTableView.bounds.size.width, 30)];
    if (section == 0)
        [headerView setBackgroundColor:[UIColor clearColor]];
    else 
        [headerView setBackgroundColor:[UIColor clearColor]];

    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 3, self.myTableView.bounds.size.width - 10, 18)];
    
    
    
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
//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
//{
//    // Return YES for supported orientations
//    
//    return YES;
//    
//}
//
//- (void)tableViewModel:(SCTableViewModel *) tableViewModel willConfigureCell:(SCTableViewCell *) cell forRowAtIndexPath:(NSIndexPath *) indexPath
//{
//    [super tableViewModel:tableViewModel willConfigureCell:cell forRowAtIndexPath:indexPath];
//    
////    cell.backgroundColor=[UIColor whiteColor];
////    cell.height= 45;
////    cell.textLabel.lineBreakMode=UILineBreakModeCharacterWrap;
////
//    
//}

//-(void)tableViewModel:(SCTableViewModel *)tableViewModel willDisplayCell:(SCTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
//
//    [super tableViewModel:tableViewModel willDisplayCell:cell forRowAtIndexPath:indexPath];
//    if (tableViewModel.tag==0) {
//        switch (indexPath.section) {
//            case 0:
//            {
//                        NSManagedObject *cellManagedObject=(NSManagedObject *)cell.boundObject;
//                        
//                        ClinicianEntity *clinicianObject=(ClinicianEntity *)cellManagedObject;
//                        
//                        cell.textLabel.text=clinicianObject.combinedName;
//                        
//                        
//                        
//                        
//                        //NSLog(@"cellManagedObject%@",clinicianObject.combinedName);
//                    
//                        
//            }
//                break;
//                
//            default:
//                break;
//        }
//    }
//
//
//
//
//
//
//}





-(void)tableViewModel:(SCTableViewModel *)tableViewModel detailViewWillPresentForRowAtIndexPath:(NSIndexPath *)indexPath withDetailTableViewModel:(SCTableViewModel *)detailTableViewModel{
   
//    [super tableViewModel:tableViewModel detailViewWillPresentForRowAtIndexPath:indexPath withDetailTableViewModel:detailTableViewModel];
//    
    if (tableViewModel.tag==0) {
        if (detailTableViewModel.sectionCount>6) {
    
    if (indexPath.section==0) {
        SCTableViewCell *cell=(SCTableViewCell *)[tableViewModel cellAtIndexPath:indexPath];
        
      
        NSManagedObject *cellManagedObject=(NSManagedObject *)cell.boundObject; 
        if (cellManagedObject && [cellManagedObject.entity.name isEqualToString:@"ClinicianEntity"]) {
            [detailTableViewModel removeSectionAtIndex:1];
            [detailTableViewModel removeSectionAtIndex:4];
        }

    }
            
        }
    }
}

//-(void)tableViewModel:(SCTableViewModel *)tableViewModel detailModelCreatedForRowAtIndexPath:(NSIndexPath *)indexPath detailTableViewModel:(SCTableViewModel *)detailTableViewModel{
//    
//    
//   
//
//    if (tableViewModel.tag==0) {
////        SCTableViewSection *section=(SCTableViewSection *)[tableViewModel sectionAtIndex:indexPath.section];
//        
//        if (indexPath.section==0) {
//            
//        
//            
//            detailTableViewModel.tag = tableViewModel.tag+1;           
//            
//            if([SCUtilities is_iPad]){
//                [detailTableViewModel.modeledTableView setBackgroundView:nil];
//                [detailTableViewModel.modeledTableView setBackgroundView:[[UIView alloc] init]];
//                [detailTableViewModel.modeledTableView setBackgroundColor:UIColor.clearColor]; // Make the table view transparent
//            }
// 
//            detailTableViewModel.delegate=self.cliniciansViewController_Shared;
//            cliniciansViewController_Shared_.currentDetailTableViewModel=detailTableViewModel;
//            cliniciansViewController_Shared_.rootViewController=tableViewModel.viewController;
//        }
//        
//        
//        
//    }
//
//
//
//
//
//}

- (void)tableViewModel:(SCTableViewModel *)tableViewModel didAddSectionAtIndex:(NSInteger)index
{
//    [super tableViewModel:tableViewModel didAddSectionAtIndex:index];
    SCTableViewSection *section = [tableViewModel sectionAtIndex:index];
    if (tableViewModel.tag==0) {
      
    if (index==0) {
        
        if ([section isKindOfClass:[SCArrayOfObjectsSection class]]) {
            SCArrayOfObjectsSection *arrayOfObjectsSection=(SCArrayOfObjectsSection *)section;
            
            
            //NSLog(@"items count is %i",[arrayOfObjectsSection.itemsSet count]);
            if ([arrayOfObjectsSection.items count]>1) {
               
              
                for (int i=0; i<[arrayOfObjectsSection.items count]; i++) {
                    ClinicianEntity *clinicianObject=(ClinicianEntity *)[arrayOfObjectsSection.items objectAtIndex:i];
                    if (i>0) {
                        clinicianObject.myInformation=FALSE;
                    }
                    
                }
                
               
                if (arrayOfObjectsSection.cellCount>1) {
                    PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
                    
                    [appDelegate saveContext];
//                    [tableModel_ reloadBoundValues];
//                    [tableModel_.modeledTableView reloadData];
                }
            } 
          
                
//               //                
//                SCSelectionCell *selectionCell=[[SCSelectionCell alloc]initWithText:@"My Information" withBoundKey:@"myClinicianDataCell" withLabelTextValue:nil];
//                
//                selectionCell.boundObject=myInfoObject;
//                
//                [arrayOfObjectsSection addCell:selectionCell];
                
                
                
        }
            
            
        
    }
        
    }
//    if(section.headerTitle !=nil)
//    {
//        
//        UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 60)];
//        UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, 300, 40)];
//        
//        
//        
//        
//        headerLabel.text = section.headerTitle;
//        
//        
//        headerLabel.backgroundColor = [UIColor clearColor];
//        headerLabel.textColor = [UIColor whiteColor];
//        
//        [containerView addSubview:headerLabel];
//        
//        section.headerView = containerView;
//        [self.tableView reloadData];
//        
//          }
}
-(void)tableViewModel:(SCTableViewModel *)tableViewModel detailModelCreatedForSectionAtIndex:(NSUInteger)index detailTableViewModel:(SCTableViewModel *)detailTableViewModel{
    
    
    
    
        detailTableViewModel.delegate = self;
        detailTableViewModel.tag = tableViewModel.tag+1;
     
    if([SCUtilities is_iPad]&&detailTableViewModel.modeledTableView.backgroundView.backgroundColor!=[UIColor clearColor]){
        
   
        [detailTableViewModel.modeledTableView setBackgroundView:nil];
        [detailTableViewModel.modeledTableView setBackgroundView:[[UIView alloc] init]];
        [detailTableViewModel.modeledTableView setBackgroundColor:UIColor.clearColor]; // Make the table view transparent
    }
    
    
    
}

//-(void)tableViewModel:(SCTableViewModel *)tableViewModel didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//
//    
//    
//    
//    SCTableViewCell *cell =(SCTableViewCell *) [tableViewModel cellAtIndexPath:indexPath];
//    SCTableViewSection *section=(SCTableViewSection *)[tableViewModel sectionAtIndex:indexPath.section];
//    
//    //NSLog(@"index path section %i",indexPath.section);
//    if (tableViewModel.tag==0) {
//    
//    switch (cell.tag) {
//        
//        case 0:
//        {
//            if (indexPath.section==0) {
//                 //NSLog(@"selected zero");
//                if ([section isKindOfClass:[SCArrayOfObjectsSection class]]) {
//                    SCArrayOfObjectsSection *arrayOfObjectsSection=(SCArrayOfObjectsSection *)section;
//                    
//                    
//                    [arrayOfObjectsSection dispatchEventSelectRowAtIndexPath:indexPath];
//                }
//            
//            
//            }
//          
//        }  
//         break;
//        
//        
//        case 2:
//        {
//            TestAdministrationsViewController_iPad *testAdministrationsViewController_iPad = [[TestAdministrationsViewController_iPad alloc] initWithNibName:@"TestAdministrationsViewController_iPad" bundle:nil];
//            
//            [self.navigationController pushViewController:testAdministrationsViewController_iPad animated:YES];
//            break;
//        }    
//            
//        case 7:
//        {
//            NSString *existingHoursViewControllerNibName=nil;
//            if ([SCUtilities is_iPad]) {
//                existingHoursViewControllerNibName=@"ExistingHoursViewController_iPad";
//            }else {
//                existingHoursViewControllerNibName=@"ExistingHoursViewController";
//            }
//            ExistingHoursViewController *existingHoursViewController = [[ExistingHoursViewController alloc] initWithNibName:existingHoursViewControllerNibName bundle:[NSBundle mainBundle]];
//            
//            [self.navigationController pushViewController:existingHoursViewController animated:YES];
//            break;
//        }    
//        case 15:
//        {
//            
//            
//                        
////                if ([cell isKindOfClass:[CustomSCSelectonCellWithLoading class]]) {
////                    CustomSCSelectonCellWithLoading * loadingCell=(CustomSCSelectonCellWithLoading *)cell;
////                    loadingCell.imageView.hidden=FALSE;
////                }
//            
//            
//            
//            
//           
//               
////           dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//                
////                self.tableView.userInteractionEnabled=FALSE;
//                UITabBar *tabBar=(UITabBar *) [(PTTAppDelegate *)[UIApplication sharedApplication].delegate tabBar];
//                tabBar.userInteractionEnabled=FALSE;            
//            
//            DrugViewController_iPhone *drugViewController_iPhone = [[DrugViewController_iPhone alloc] initWithNibName:@"DrugViewController_iPhone" bundle:nil];
//            
//            [self.navigationController pushViewController:drugViewController_iPhone animated:YES];
//           
//                if ([cell isKindOfClass:[CustomSCSelectonCellWithLoading class]]) {
//                    CustomSCSelectonCellWithLoading * loadingCell=(CustomSCSelectonCellWithLoading *)cell;
//                    loadingCell.imageView.hidden=TRUE;
//                    [loadingCell setSelected:FALSE];
//                    [loadingCell setHighlighted:FALSE animated:YES];
//                    
//                }
//                tabBar.userInteractionEnabled=TRUE;
////                self.tableView.userInteractionEnabled=TRUE;
//                
//               
////           });
//
////            dispatch_release(firstSerialQueue);
//            
//            
//            break;
//        }    
//        case 16:
//        {
//                       
//            LCYLockSettingsViewController *lockSettingsVC = [[LCYLockSettingsViewController alloc] initWithNibName:@"LCYLockSettingsViewController" bundle:nil];
//            [[self navigationController] pushViewController:lockSettingsVC animated:YES];            
//            break;
//        }    
//        case 17:
//        {
//            InAppSettingsViewController *inAppSettingsViewController = [[InAppSettingsViewController alloc] initWithNibName:@"InAppSettingsViewController" bundle:nil];
//            
//            [self.navigationController pushViewController:inAppSettingsViewController animated:YES];
//            
//            inAppSettingsViewController.rootNavController=self.navigationController;
//            break;
//        }    
//        case 18:
//        {
//            DTLayoutDefinition *supportLayout = [DTLayoutDefinition layoutNamed:@"support"];
//			DTAboutViewController *support =[[DTAboutViewController alloc] initWithLayout:supportLayout];
//			support.title = @"Support";
//			[self.navigationController pushViewController:support animated:YES];
//            break;
//        }   
//        case 19:
//        {
//            DTAboutViewController *about = [[DTAboutViewController alloc] initWithLayout:nil]; // default is @"about"
//			about.title	 = @"About";
//			about.delegate = self;
//			[self.navigationController pushViewController:about animated:YES];
//        }   
//        default:
//            break;
//    }
//
//        
//    }     
//else {
//    if([section isKindOfClass:[SCArrayOfObjectsSection class]]){
//        
//        SCArrayOfObjectsSection *arrayOfObjectsSection=(SCArrayOfObjectsSection *)section;
//        [arrayOfObjectsSection dispatchEventSelectRowAtIndexPath:indexPath];
//        
//        
//    }
//}  
    
//    
//    if (cell.tag==2){
//        InterventionViewController *interventionViewController = [[InterventionViewController alloc] initWithNibName:@"InterventionViewController" bundle:nil];
//        
//        [self.navigationController pushViewController:interventionViewController animated:YES];
//        [interventionViewController release];
//        
//    }
//    if (cell.tag==3){
//        IndirectSupportViewController *indirectSupportViewController = [[IndirectSupportViewController alloc] initWithNibName:@"IndirectSupportViewController" bundle:nil];
//        
//        [self.navigationController pushViewController:indirectSupportViewController animated:YES];
//        [indirectSupportViewController release];
//        
//    }
//    if (cell.tag==4){
//        SupervisionReceivedViewController *supervisionReceivedViewController = [[SupervisionReceivedViewController alloc] initWithNibName:@"SupervisionReceivedViewController" bundle:nil];
//        
//        [self.navigationController pushViewController:supervisionReceivedViewController animated:YES];
//        [supervisionReceivedViewController release];
//        
//    }
//    if (cell.tag==5){
//        SupervisionGivenViewController *supervisionGivenViewController = [[SupervisionGivenViewController alloc] initWithNibName:@"SupervisionGivenViewController" bundle:nil];
//        
//        [self.navigationController pushViewController:supervisionGivenViewController animated:YES];
//        [supervisionGivenViewController release];
//        
 
//   }
//
//- (IASKAppSettingsViewController*)appSettingsViewController {
//	if (!appSettingsViewController) {
//		appSettingsViewController = [[IASKAppSettingsViewController alloc] initWithNibName:@"IASKAppSettingsView" bundle:nil];
//		appSettingsViewController.delegate = self;
//	}
//	return appSettingsViewController;
//}
//#pragma mark -
//#pragma mark IASKAppSettingsViewControllerDelegate protocol
//- (void)settingsViewControllerDidEnd:(IASKAppSettingsViewController*)sender {
//    [self dismissModalViewControllerAnimated:YES];
//	
//	// your code here to reconfigure the app for changed settings
//}
//
//// optional delegate method for handling mail sending result
//- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
//    
//    if ( error != nil ) {
//        // handle error here
//    }
//    
//    if ( result == MFMailComposeResultSent ) {
//        // your code here to handle this result
//    }
//    else if ( result == MFMailComposeResultCancelled ) {
//        // ...
//    }
//    else if ( result == MFMailComposeResultSaved ) {
//        // ...
//    }
//    else if ( result == MFMailComposeResultFailed ) {
//        // ...
//    }
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderForKey:(NSString*)key {
//	if ([key isEqualToString:@"IASKLogo"]) {
//		return [UIImage imageNamed:@"Icon.png"].size.height + 25;
//	}
//	return 0;
//}
//
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderForKey:(NSString*)key {
//	if ([key isEqualToString:@"IASKLogo"]) {
//		UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Icon.png"]];
//		imageView.contentMode = UIViewContentModeCenter;
//		return imageView ;
//	}
//	return nil;
//}
//
//
//
//#pragma mark UITextViewDelegate (for CustomViewCell)
//- (void)textViewDidChange:(UITextView *)textView {
//    [[NSUserDefaults standardUserDefaults] setObject:textView.text forKey:@"customCell"];
//    [[NSNotificationCenter defaultCenter] postNotificationName:kIASKAppSettingChanged object:@"customCell"];
//}
//
//#pragma mark -
//- (void)settingsViewController:(IASKAppSettingsViewController*)sender buttonTappedForKey:(NSString*)key {
//	if ([key isEqualToString:@"ButtonDemoAction1"]) {
//		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Demo Action 1 called" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//		[alert show];
//	} else {
//		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Demo Action 2 called" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//		[alert show];
//	}
//}

- (IBAction) lockScreen: (id) sender;
{
	PTTAppDelegate *appDelegate =  (PTTAppDelegate *)	[[UIApplication sharedApplication] delegate];
    
	//NSLog(@"app passcode is: %@", [appDelegate appLockPasscode]);	
	
    [appDelegate lockApplication];
//	if ([appDelegate isPasscodeOn])
//	{		
//		[appDelegate lockApplication];
//	}
//	else 
//	{
////		PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
//        
////        [[appDelegate window] addSubview:self.messageView];
//        
//       
//
//        
//        
//        UICasualAlert *casualAlert=[[UICasualAlert alloc]init];
////        [casualAlert displayRedAlert];
//         [casualAlert displayRegularAlert:@"Need To Set Passcode in Lock Screen Settings" forDuration:2.0 inView:nil];
////        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Need to set Passcode" message:nil delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
////		[av show];
//		
//	}
    
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
