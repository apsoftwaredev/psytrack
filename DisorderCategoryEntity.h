//
//  DisorderCategoryEntity.h
//  PsyTrack
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class DisorderEntity;

@interface DisorderCategoryEntity : NSManagedObject

@property (nonatomic, retain) NSNumber * order;
@property (nonatomic, retain) NSString * desc;
@property (nonatomic, retain) NSString * categoryName;
@property (nonatomic, retain) NSSet *disorders;
@end

@interface DisorderCategoryEntity (CoreDataGeneratedAccessors)

- (void)addDisordersObject:(DisorderEntity *)value;
- (void)removeDisordersObject:(DisorderEntity *)value;
- (void)addDisorders:(NSSet *)values;
- (void)removeDisorders:(NSSet *)values;

@end
