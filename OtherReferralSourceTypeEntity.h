//
//  OtherReferralSourceTypeEntity.h
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



@class OtherReferralSourceEntity;

@interface OtherReferralSourceTypeEntity : PTManagedObject

@property (nonatomic, retain) NSNumber * order;
@property (nonatomic, retain) NSString * referralType;
@property (nonatomic, retain) NSSet *otherReferralSources;
@end

@interface OtherReferralSourceTypeEntity (CoreDataGeneratedAccessors)

- (void)addOtherReferralSourcesObject:(OtherReferralSourceEntity *)value;
- (void)removeOtherReferralSourcesObject:(OtherReferralSourceEntity *)value;
- (void)addOtherReferralSources:(NSSet *)values;
- (void)removeOtherReferralSources:(NSSet *)values;

@end
