/*
 *  ReportsDetailViewController_iPad.h
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
#import <UIKit/UIKit.h>

@class  ReportsRootViewController_iPad;
@interface ReportsDetailViewController_iPad : UITableViewController
{


    __weak ReportsRootViewController_iPad *reportsRootViewController_iPad;

}

@property (nonatomic, weak) IBOutlet  ReportsRootViewController_iPad *reportsRootViewController_iPad;

@end
