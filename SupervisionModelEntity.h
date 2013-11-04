//
//  SupervisionModelEntity.h
//  PsyTrack Clinician Tools
//  Version: 1.5.4
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class SupervisionParentEntity;

@interface SupervisionModelEntity : NSManagedObject

@property (nonatomic, retain) NSString *modelName;
@property (nonatomic, retain) NSNumber *evidenceBased;
@property (nonatomic, retain) NSString *acronym;
@property (nonatomic, retain) NSString *notes;
@property (nonatomic, retain) NSSet *supervisionParents;
@end

@interface SupervisionModelEntity (CoreDataGeneratedAccessors)

- (void) addSupervisionParentsObject:(SupervisionParentEntity *)value;
- (void) removeSupervisionParentsObject:(SupervisionParentEntity *)value;
- (void) addSupervisionParents:(NSSet *)values;
- (void) removeSupervisionParents:(NSSet *)values;

@end
