//
//  AssessmentEntity.h
//  PsyTrack
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "ServiceParentEntity.h"
#import "PTManagedObjectContext.h"
#import "PTManagedObject.h"



@class AssessmentTypeEntity, ClientPresentationEntity, TimeEntity;

@interface AssessmentEntity : ServiceParentEntity

@property (nonatomic, retain) NSSet *clientPresentations;
@property (nonatomic, retain) AssessmentTypeEntity *assessmentType;
@property (nonatomic, retain) TimeEntity *time;
@end

@interface AssessmentEntity (CoreDataGeneratedAccessors)

- (void)addClientPresentationsObject:(ClientPresentationEntity *)value;
- (void)removeClientPresentationsObject:(ClientPresentationEntity *)value;
- (void)addClientPresentations:(NSSet *)values;
- (void)removeClientPresentations:(NSSet *)values;

@end
