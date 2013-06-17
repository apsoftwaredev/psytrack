//
//  MigrationHistoryEntity.h
//  PsyTrack Clinician Tools
//  Version: 1.5.2
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "PTManagedObjectContext.h"
#import "PTManagedObject.h"

@class DemographicProfileEntity;

@interface MigrationHistoryEntity : PTManagedObject

@property (nonatomic, retain) NSDate *arrivedDate;
@property (nonatomic, retain) NSString *notes;
@property (nonatomic, retain) NSString *keyString;
@property (nonatomic, retain) NSString *migratedFrom;
@property (nonatomic, retain) NSString *migratedTo;
@property (nonatomic, retain) DemographicProfileEntity *demographicProfile;

@end
