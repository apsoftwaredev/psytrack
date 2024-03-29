//
//  FeeTypeEntity.h
//  PsyTrack Clinician Tools
//  Version: 1.5.4
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class FeeEntity;

@interface FeeTypeEntity : NSManagedObject

@property (nonatomic, retain) NSString *feeType;
@property (nonatomic, retain) NSNumber *order;
@property (nonatomic, retain) NSSet *fees;
@end

@interface FeeTypeEntity (CoreDataGeneratedAccessors)

- (void) addFeesObject:(FeeEntity *)value;
- (void) removeFeesObject:(FeeEntity *)value;
- (void) addFees:(NSSet *)values;
- (void) removeFees:(NSSet *)values;

@end
