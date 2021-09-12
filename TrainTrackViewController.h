/*
 *  TrainTrackViewController.h
 *  psyTrack Clinician Tools
 *  Version: 1.5.4
 *
 *
 The MIT License (MIT)
 Copyright © 2011- 2021 Daniel Boice
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
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
#import "EBPWebsitesTableViewController.h"

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

    EBPWebsitesTableViewController *ebpWebsitesVC;
}

@end
