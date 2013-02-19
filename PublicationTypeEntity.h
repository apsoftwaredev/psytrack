//
//  PublicationTypeEntity.h
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



@class PublicationEntity;

@interface PublicationTypeEntity : PTManagedObject

@property (nonatomic, retain) NSNumber * order;
@property (nonatomic, retain) NSString * publicationType;
@property (nonatomic, retain) NSSet *publication;
@end

@interface PublicationTypeEntity (CoreDataGeneratedAccessors)

- (void)addPublicationObject:(PublicationEntity *)value;
- (void)removePublicationObject:(PublicationEntity *)value;
- (void)addPublication:(NSSet *)values;
- (void)removePublication:(NSSet *)values;

@end
