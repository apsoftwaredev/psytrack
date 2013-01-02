//
//  ContinuingEducationProviderEntity.h
//  PsyTrack
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "PTManagedObjectContext.h"
#import "PTManagedObject.h"



@class ContinuingEducationEntity;

@interface ContinuingEducationProviderEntity : PTManagedObject

@property (nonatomic, retain) NSNumber * order;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSString * providerName;
@property (nonatomic, retain) NSSet *continuingEducation;
@end

@interface ContinuingEducationProviderEntity (CoreDataGeneratedAccessors)

- (void)addContinuingEducationObject:(ContinuingEducationEntity *)value;
- (void)removeContinuingEducationObject:(ContinuingEducationEntity *)value;
- (void)addContinuingEducation:(NSSet *)values;
- (void)removeContinuingEducation:(NSSet *)values;

@end
