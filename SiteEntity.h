//
//  SiteEntity.h
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

@class ClinicianEntity, ExistingHoursEntity, TimeTrackEntity;

@interface SiteEntity : PTManagedObject

@property (nonatomic, retain) NSString *siteName;
@property (nonatomic, retain) NSString *location;
@property (nonatomic, retain) NSNumber *order;
@property (nonatomic, retain) NSString *notes;
@property (nonatomic, retain) NSDate *started;
@property (nonatomic, retain) NSDate *ended;
@property (nonatomic, retain) NSNumber *defaultSite;
@property (nonatomic, retain) NSManagedObject *settingType;
@property (nonatomic, retain) ClinicianEntity *supervisor;
@property (nonatomic, retain) NSSet *timeTracks;
@property (nonatomic, retain) NSSet *existingHours;
@end

@interface SiteEntity (CoreDataGeneratedAccessors)

- (void) addTimeTracksObject:(TimeTrackEntity *)value;
- (void) removeTimeTracksObject:(TimeTrackEntity *)value;
- (void) addTimeTracks:(NSSet *)values;
- (void) removeTimeTracks:(NSSet *)values;

- (void) addExistingHoursObject:(ExistingHoursEntity *)value;
- (void) removeExistingHoursObject:(ExistingHoursEntity *)value;
- (void) addExistingHours:(NSSet *)values;
- (void) removeExistingHours:(NSSet *)values;

@end
