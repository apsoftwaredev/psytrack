//
//  MigrationHistoryEntity.h
//  PsyTrack Clinician Tools
//
//  Created by Daniel Boice on 3/23/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class DemographicProfileEntity;

@interface MigrationHistoryEntity : NSManagedObject

@property (nonatomic, retain) NSDate * arrivedDate;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSDate * keyDate;
@property (nonatomic, retain) NSString * migratedFrom;
@property (nonatomic, retain) NSString  * migratedTo;
@property (nonatomic, retain) DemographicProfileEntity *demographicProfile;

@property (nonatomic, retain) NSString  * tempNotes;
@property (nonatomic, retain) NSString  * tempMigratedFrom;
@property (nonatomic, retain) NSString  * tempMigratedTo;
@end
