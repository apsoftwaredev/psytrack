//
//  FeeTypeEntity.h
//  PsyTrack
//
//  Created by Daniel Boice on 11/22/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class FeeEntity;

@interface FeeTypeEntity : NSManagedObject

@property (nonatomic, retain) NSString * feeType;
@property (nonatomic, retain) NSNumber * order;
@property (nonatomic, retain) NSSet *fees;
@end

@interface FeeTypeEntity (CoreDataGeneratedAccessors)

- (void)addFeesObject:(FeeEntity *)value;
- (void)removeFeesObject:(FeeEntity *)value;
- (void)addFees:(NSSet *)values;
- (void)removeFees:(NSSet *)values;

@end
