//
//  OrientationHistoryEntity.h
//  PsyTrack Clinician Tools
//  Version: 1.5.5
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ClinicianEntity;

@interface OrientationHistoryEntity : NSManagedObject

@property (nonatomic, retain) NSNumber *order;
@property (nonatomic, retain) NSDate *endDate;
@property (nonatomic, retain) NSDate *dateAdopted;
@property (nonatomic, retain) NSString *notes;
@property (nonatomic, retain) ClinicianEntity *clinician;
@property (nonatomic, retain) NSManagedObject *orientation;

@end
