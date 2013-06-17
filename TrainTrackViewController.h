/*
 *  TrainTrackViewController.h
 *  psyTrack Clinician Tools
 *  Version: 1.5.2
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
#import <UIKit/UIKit.h>

#import "CliniciansViewController_Shared.h"

#import "DTAboutViewController.h"
#import "BigProgressViewWithBlockedView.h"

#import "TimeTrackViewController.h"
#import "DrugViewController_iPhone.h"
#import "ClinicianEntity.h"

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
#import "CoursesTakenViewController.h"
#import "ConferencesAttendedVC.h"
#import "TeachingExperienceVC.h"
#import "ExpertTestemonyVC.h"
#import "MediaAppearanceVC.h"
#import "CommunityServiceVC.h"
#import "OtherActivityVC.h"

@interface TrainTrackViewController : UITableViewController < UITableViewDataSource, UITableViewDelegate, DTAboutViewControllerDelegate>{
    BigProgressViewWithBlockedView *prog;

    TimeTrackViewController *timeTrackViewController;
    ExistingHoursViewController *existingHoursViewController;

    ConsultationsViewController *consultationsViewController;

    CECreditsViewController *ceCreditsViewController;

    CoursesTakenViewController *coursesTakenViewController;

    ConferencesAttendedVC *conferencesAttendedViewController;

    TeachingExperienceVC *teachingExperienceVC;

    PresentationsViewController *presentationsViewController;

    ExpertTestemonyVC *expertTestemonyVC;

    MediaAppearanceVC *mediaAppearanceVC;

    CommunityServiceVC *communitySerivceVC;

    OtherActivityVC *otherActivityVC;
    DrugViewController_iPhone *drugViewController_iPhone;

    ClinicianGroupsViewController *clinicianGroupsViewController;

    ClientGroupsViewController *clientGroupsViewController;

    LCYLockSettingsViewController *lockSettingsVC;

    DTAboutViewController *support;

    DTAboutViewController *about;
}

@end
