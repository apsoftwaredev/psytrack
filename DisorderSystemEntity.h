//
//  DisorderSystemEntity.h
//  PsyTrack
//
//  Created by Daniel Boice on 9/17/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class DisorderEntity;

@interface DisorderSystemEntity : NSManagedObject

@property (nonatomic, retain) NSString * abbreviatedName;
@property (nonatomic, retain) NSNumber * order;
@property (nonatomic, retain) NSString * classificationSystem;
@property (nonatomic, retain) NSString * desc;
@property (nonatomic, retain) NSSet *disorders;
@end

@interface DisorderSystemEntity (CoreDataGeneratedAccessors)

- (void)addDisordersObject:(DisorderEntity *)value;
- (void)removeDisordersObject:(DisorderEntity *)value;
- (void)addDisorders:(NSSet *)values;
- (void)removeDisorders:(NSSet *)values;

@end
