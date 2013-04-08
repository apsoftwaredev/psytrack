//
//  SubjectEntity.h
//  PsyTrack Clinician Tools
//  Version: 1.5.1
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "PTManagedObjectContext.h"
#import "PTManagedObject.h"

@class PublicationEntity;

@interface SubjectEntity : PTManagedObject

@property (nonatomic, retain) NSString *subject;
@property (nonatomic, retain) NSNumber *order;
@property (nonatomic, retain) NSSet *publications;
@end

@interface SubjectEntity (CoreDataGeneratedAccessors)

- (void) addPublicationsObject:(PublicationEntity *)value;
- (void) removePublicationsObject:(PublicationEntity *)value;
- (void) addPublications:(NSSet *)values;
- (void) removePublications:(NSSet *)values;

@end
