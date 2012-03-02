/*
 *  ClientsViewController_shared.h
 *  psyTrack Clinician Tools
 *  Version: 1.0
 *
 *
 *	THIS SOURCE CODE AND ANY ACCOMPANYING DOCUMENTATION ARE PROTECTED BY UNITED STATES 
 *	INTELLECTUAL PROPERTY LAW AND INTERNATIONAL TREATIES. UNAUTHORIZED REPRODUCTION OR 
 *	DISTRIBUTION IS SUBJECT TO CIVIL AND CRIMINAL PENALTIES. 
 *
 *  Created by Daniel Boice on 9/26/11.
 *  Copyright (c) 2011 PsycheWeb LLC. All rights reserved.
 *
 *
 *	This notice may not be removed from this file.
 *
 */
#import "SCTableViewModel.h"


@interface ClientsViewController_Shared : NSObject /*<SCTableViewModelDelegate>*/{

NSManagedObjectContext *managedObjectContext;
    SCClassDefinition *clientDef;

}

@property (strong,nonatomic) SCClassDefinition *clientDef;


-(id)setupTheClientsViewModelUsingSTV;

-(NSString *)calculateWechslerAgeWithBirthdate:(NSDate *)birthdate;
-(NSString *)calculateActualAgeWithBirthdate:(NSDate *)birthdate;
-(NSString *)calculateWechslerAgeWithBirthdate:(NSDate *)birthdate toDate:(NSDate *)toDate;
-(NSString *)calculateActualAgeWithBirthdate:(NSDate *)birthdate toDate:(NSDate *)toDate;


@end
