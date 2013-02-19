//
//  TopicEntity.h
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



@class ContinuingEducationEntity, PresentationEntity;

@interface TopicEntity : PTManagedObject

@property (nonatomic, retain) NSString * order;
@property (nonatomic, retain) NSString * topic;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSSet *presentations;
@property (nonatomic, retain) NSSet *cECredits;
@property (nonatomic, retain) NSSet *teachingExperience;
@end

@interface TopicEntity (CoreDataGeneratedAccessors)

- (void)addPresentationsObject:(PresentationEntity *)value;
- (void)removePresentationsObject:(PresentationEntity *)value;
- (void)addPresentations:(NSSet *)values;
- (void)removePresentations:(NSSet *)values;

- (void)addCECreditsObject:(ContinuingEducationEntity *)value;
- (void)removeCECreditsObject:(ContinuingEducationEntity *)value;
- (void)addCECredits:(NSSet *)values;
- (void)removeCECredits:(NSSet *)values;

- (void)addTeachingExperienceObject:(NSManagedObject *)value;
- (void)removeTeachingExperienceObject:(NSManagedObject *)value;
- (void)addTeachingExperience:(NSSet *)values;
- (void)removeTeachingExperience:(NSSet *)values;

@end
