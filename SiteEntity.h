//
//  SiteEntity.h
//  PsyTrack
//
//  Created by Daniel Boice on 7/15/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ClinicianEntity, TimeTrackEntity;

@interface SiteEntity : NSManagedObject

@property (nonatomic, retain) NSString * siteName;
@property (nonatomic, retain) NSString * location;
@property (nonatomic, retain) NSDate * started;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSDate * ended;
@property (nonatomic, retain) NSNumber * defaultSite;
@property (nonatomic, retain) ClinicianEntity *supervisor;
@property (nonatomic, retain) NSSet *timeTracks;
@property (nonatomic, retain) NSManagedObject *settingType;
@end

@interface SiteEntity (CoreDataGeneratedAccessors)

- (void)addTimeTracksObject:(TimeTrackEntity *)value;
- (void)removeTimeTracksObject:(TimeTrackEntity *)value;
- (void)addTimeTracks:(NSSet *)values;
- (void)removeTimeTracks:(NSSet *)values;

@end
