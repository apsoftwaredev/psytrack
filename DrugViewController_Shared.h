
/*
 *  DrugViewController_Shared.h
 *  psyTrack Clinician Tools
 *  Version: 1.5.4
 *
 *
 *	THIS SOURCE CODE AND ANY ACCOMPANYING DOCUMENTATION ARE PROTECTED BY UNITED STATES
 *	INTELLECTUAL PROPERTY LAW AND INTERNATIONAL TREATIES. UNAUTHORIZED REPRODUCTION OR
 *	DISTRIBUTION IS SUBJECT TO CIVIL AND CRIMINAL PENALTIES.
 *
 *  Created by Daniel Boice on 12/19/11.
 *  Copyright (c) 2011 PsycheWeb LLC. All rights reserved.
 *
 *
 *	This notice may not be removed from this file.
 *
 */

#import <UIKit/UIKit.h>

@interface DrugViewController_Shared : NSObject <SCTableViewModelDelegate>{
    NSManagedObjectContext *drugsManagedObjectContext;
}

@property (strong,nonatomic) IBOutlet SCEntityDefinition *drugDef;
@property (strong, nonatomic) IBOutlet NSArray *drugsArray;

- (id) setupTheDrugsViewModelUsingSTV;

@end
