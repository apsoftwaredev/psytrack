/*
 *  DrugActionDateViewController.h
 *  psyTrack Clinician Tools
 *  Version: 1.0.6
 *
 *
 *	THIS SOURCE CODE AND ANY ACCOMPANYING DOCUMENTATION ARE PROTECTED BY UNITED STATES
 *	INTELLECTUAL PROPERTY LAW AND INTERNATIONAL TREATIES. UNAUTHORIZED REPRODUCTION OR
 *	DISTRIBUTION IS SUBJECT TO CIVIL AND CRIMINAL PENALTIES.
 *
 *  Created by Daniel Boice on   1/5/12.
 *  Copyright (c) 2011 PsycheWeb LLC. All rights reserved.
 *
 *
 *	This notice may not be removed from this file.
 *
 */

#import <UIKit/UIKit.h>

@interface DrugActionDateViewController : SCTableViewController <SCTableViewModelDataSource, SCTableViewModelDelegate>{
    SCArrayOfItemsModel *objectsModel;
    NSArray *_docTypesArray;
    NSMutableSet *actionDateMutableSet;
}

@property (nonatomic,strong) IBOutlet NSString *applNoString;
@property (nonatomic,strong) IBOutlet NSArray *docTypesArray;

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withApplNo:(NSString *)applNo;
@end
