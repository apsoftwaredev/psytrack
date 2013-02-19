/*
 *  ClientsSelectionCell.h
 *  psyTrack Clinician Tools
 *  Version: 1.05
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
#import "ClientEntity.h"
@interface ClientsSelectionCell : SCObjectSelectionCell {


     ClientEntity *clientObject;
    BOOL hasChangedClients;
    NSDate *testDate;
    BOOL addAgeCells_;
    
    BOOL multiSelect;
    NSMutableArray *clientsArray_;
}

@property (nonatomic,strong) NSMutableArray *clientsArray;
@property (nonatomic, strong)  NSMutableSet *alreadySelectedClients;
@property (nonatomic, readwrite)  BOOL hasChangedClients;
@property (nonatomic, strong) NSDate *testDate;

@property (nonatomic, assign) BOOL addAgeCells;
@property (nonatomic,strong)IBOutlet  ClientEntity *clientObject;

-(void)doneButtonTappedInDetailView:(NSObject *)selectedObject selectedClients:(NSArray *)selectedClients withValue:(BOOL)hasValue;

//-(NSString *)clientIDCodeString;
@end
