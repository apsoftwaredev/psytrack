/*
 *  ClientsSelectionCell.h
 *  psyTrack Clinician Tools
 *  Version: 1.0
 *
 *
 *	THIS SOURCE CODE AND ANY ACCOMPANYING DOCUMENTATION ARE PROTECTED BY UNITED STATES 
 *	INTELLECTUAL PROPERTY LAW AND INTERNATIONAL TREATIES. UNAUTHORIZED REPRODUCTION OR 
 *	DISTRIBUTION IS SUBJECT TO CIVIL AND CRIMINAL PENALTIES. 
 *
 *  Created by Daniel Boice on 11/18/11.
 *  Copyright (c) 2011 PsycheWeb LLC. All rights reserved.
 *
 *
 *	This notice may not be removed from this file.
 *
 */
#import <UIKit/UIKit.h>

@interface ClientsSelectionCell : SCObjectSelectionCell {


     NSManagedObject *clientObject;
    BOOL hasChangedClients;
    NSDate *testDate;
    BOOL addAgeCells_;
}


@property (nonatomic, strong) IBOutlet NSMutableSet *alreadySelectedClients;
@property (nonatomic, readwrite)  BOOL hasChangedClients;
@property (nonatomic, strong) NSDate *testDate;

@property (nonatomic, assign) BOOL addAgeCells;
@property (nonatomic,strong)IBOutlet  NSManagedObject *clientObject;

-(void)doneButtonTappedInDetailView:(NSObject *)selectedObject  withValue:(BOOL)hasValue;

//-(NSString *)clientIDCodeString;
@end
