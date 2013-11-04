//
//  MembershipOrganizationEntity.h
//  PsyTrack Clinician Tools
//  Version: 1.5.4
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class MembershipEntity;

@interface MembershipOrganizationEntity : NSManagedObject

@property (nonatomic, retain) NSString *organization;
@property (nonatomic, retain) NSNumber *order;
@property (nonatomic, retain) NSString *notes;
@property (nonatomic, retain) NSSet *memberships;
@end

@interface MembershipOrganizationEntity (CoreDataGeneratedAccessors)

- (void) addMembershipsObject:(MembershipEntity *)value;
- (void) removeMembershipsObject:(MembershipEntity *)value;
- (void) addMemberships:(NSSet *)values;
- (void) removeMemberships:(NSSet *)values;

@end
