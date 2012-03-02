/*
 *  ClientPresentations_Shared.h
 *  psyTrack Clinician Tools
 *  Version: 1.0
 *
 *
 *	THIS SOURCE CODE AND ANY ACCOMPANYING DOCUMENTATION ARE PROTECTED BY UNITED STATES 
 *	INTELLECTUAL PROPERTY LAW AND INTERNATIONAL TREATIES. UNAUTHORIZED REPRODUCTION OR 
 *	DISTRIBUTION IS SUBJECT TO CIVIL AND CRIMINAL PENALTIES. 
 *
 *  Created by Daniel Boice on 10/22/11.
 *  Copyright (c) 2011 PsycheWeb LLC. All rights reserved.
 *
 *
 *	This notice may not be removed from this file.
 *
 */
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "SCTableViewModel.h"

@interface ClientPresentations_Shared : NSObject <SCTableViewModelDelegate,SCTableViewControllerDelegate>{


     SCArrayOfObjectsModel *tableModel;

     SCClassDefinition *clientPresentationDef;


}


@property (strong, nonatomic) IBOutlet SCClassDefinition *clientPresentationDef;
@property (strong, nonatomic) IBOutlet SCArrayOfObjectsModel *tableModel;

@property (strong, nonatomic)IBOutlet NSDate *serviceDatePickerDate;

-(id)setupUsingSTV ;
-(void)addWechlerAgeCellToSection:(SCTableViewSection *)section;

@end
