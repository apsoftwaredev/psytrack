//
//  LicenseRenewalEntity.h
//  PsyTrack
//
//  Created by Daniel Boice on 7/28/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class LicenseEntity;


@interface LicenseRenewalEntity : NSManagedObject

@property (nonatomic, retain) NSDate * renewalDate;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSNumber * order;
@property (nonatomic, retain) NSSet *ceCredits;
@property (nonatomic, retain) LicenseEntity *license;
@end

@interface LicenseRenewalEntity (CoreDataGeneratedAccessors)

- (void)addCeCreditsObject:(NSManagedObject *)value;
- (void)removeCeCreditsObject:(NSManagedObject *)value;
- (void)addCeCredits:(NSSet *)values;
- (void)removeCeCredits:(NSSet *)values;

@end
