//
//  PublicationTypeEntity.h
//  PsyTrack
//
//  Created by Daniel Boice on 9/17/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class PublicationEntity;

@interface PublicationTypeEntity : NSManagedObject

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