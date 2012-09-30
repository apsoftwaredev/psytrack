//
//  ContinuingEducationTypeEntity.h
//  PsyTrack
//
//  Created by Daniel Boice on 9/17/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ContinuingEducationEntity;

@interface ContinuingEducationTypeEntity : NSManagedObject

@property (nonatomic, retain) NSNumber * order;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSString * cEType;
@property (nonatomic, retain) NSSet *continuingEducation;
@end

@interface ContinuingEducationTypeEntity (CoreDataGeneratedAccessors)

- (void)addContinuingEducationObject:(ContinuingEducationEntity *)value;
- (void)removeContinuingEducationObject:(ContinuingEducationEntity *)value;
- (void)addContinuingEducation:(NSSet *)values;
- (void)removeContinuingEducation:(NSSet *)values;

@end