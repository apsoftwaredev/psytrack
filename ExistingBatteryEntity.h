//
//  ExistingBatteryEntity.h
//  PsyTrack
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "PTManagedObjectContext.h"

@class BatteryEntity, ExistingAssessmentEntity;

@interface ExistingBatteryEntity : NSManagedObject

@property (nonatomic, retain) NSNumber * numberAdminstered;
@property (nonatomic, retain) NSNumber * numberOfReportsWritten;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSNumber * adminstrationAndReport;
@property (nonatomic, retain) ExistingAssessmentEntity *existingAssessment;
@property (nonatomic, retain) BatteryEntity *battery;

@end
