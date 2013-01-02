//
//  MembershipOrganizationEntity.h
//  PsyTrack
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "PTManagedObjectContext.h"
#import "PTManagedObject.h"



@class MembershipEntity;

@interface MembershipOrganizationEntity : PTManagedObject

@property (nonatomic, retain) NSString * organization;
@property (nonatomic, retain) NSNumber * order;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSSet *memberships;
@end

@interface MembershipOrganizationEntity (CoreDataGeneratedAccessors)

- (void)addMembershipsObject:(MembershipEntity *)value;
- (void)removeMembershipsObject:(MembershipEntity *)value;
- (void)addMemberships:(NSSet *)values;
- (void)removeMemberships:(NSSet *)values;

@end
