/*
 *  ReportsRootViewController_iPad.h
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
@class ReportsDetailViewController_iPad;
@interface ReportsRootViewController_iPad : UIViewController{



    __weak ReportsDetailViewController_iPad *reportsDetailViewController_iPad;



}


@property (nonatomic,weak) IBOutlet ReportsDetailViewController_iPad *reportsDetailViewController_iPad;

@end
