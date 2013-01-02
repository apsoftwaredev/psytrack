//
//  OrientationHistoryEntity.h
//  PsyTrack
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "PTManagedObjectContext.h"
#import "PTManagedObject.h"



@class ClinicianEntity;

@interface OrientationHistoryEntity : PTManagedObject

@property (nonatomic, retain) NSNumber * order;
@property (nonatomic, retain) NSDate * endDate;
@property (nonatomic, retain) NSDate * dateAdopted;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) ClinicianEntity *clinician;
@property (nonatomic, retain) NSManagedObject *orientation;

@end
