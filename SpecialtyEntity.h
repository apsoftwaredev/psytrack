//
//  SpecialtyEntity.h
//  PsyTrack Clinician Tools
//  Version: 1.5.3
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "PTManagedObjectContext.h"
#import "PTManagedObject.h"

@class ClinicianEntity;

@interface SpecialtyEntity : PTManagedObject

@property (nonatomic, retain) NSDate *updatedTimeStamp;
@property (nonatomic, retain) NSNumber *order;
@property (nonatomic, retain) NSString *notes;
@property (nonatomic, retain) NSDate *startDate;
@property (nonatomic, retain) NSManagedObject *specialty;
@property (nonatomic, retain) ClinicianEntity *clinicians;

@end
