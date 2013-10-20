//
//  MilitaryServiceDatesEntity.h
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

@interface MilitaryServiceDatesEntity : PTManagedObject

@property (nonatomic, retain) NSNumber *officerOrEnlisted;
@property (nonatomic, retain) NSDate *dateDischarged;
@property (nonatomic, retain) NSString *branch;
@property (nonatomic, retain) NSNumber *order;
@property (nonatomic, retain) NSString *notes;
@property (nonatomic, retain) NSDate *dateJoined;
@property (nonatomic, retain) NSString *dischargeType;
@property (nonatomic, retain) NSManagedObject *militaryService;

@end
