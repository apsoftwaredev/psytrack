//
//  ExistingSupervisionGivenEntity.h
//  PsyTrack Clinician Tools
//  Version: 1.05
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "PTManagedObjectContext.h"
#import "PTManagedObject.h"

@class ExistingHoursEntity;

@interface ExistingSupervisionGivenEntity : PTManagedObject

@property (nonatomic, retain) ExistingHoursEntity *existingHours;

@end
