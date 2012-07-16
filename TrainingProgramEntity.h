//
//  TrainingProgramEntity.h
//  PsyTrack
//
//  Created by Daniel Boice on 7/15/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class TimeTrackEntity;

@interface TrainingProgramEntity : NSManagedObject

@property (nonatomic, retain) NSNumber * order;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSString * trainingProgram;
@property (nonatomic, retain) NSNumber * selectedByDefault;
@property (nonatomic, retain) NSSet *timeTracks;
@end

@interface TrainingProgramEntity (CoreDataGeneratedAccessors)

- (void)addTimeTracksObject:(TimeTrackEntity *)value;
- (void)removeTimeTracksObject:(TimeTrackEntity *)value;
- (void)addTimeTracks:(NSSet *)values;
- (void)removeTimeTracks:(NSSet *)values;

@end
