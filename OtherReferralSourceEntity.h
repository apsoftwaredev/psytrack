//
//  OtherReferralSourceEntity.h
//  PsyTrack
//
//  Created by Daniel Boice on 7/27/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ClientEntity, ReferralEntity;

@interface OtherReferralSourceEntity : NSManagedObject

@property (nonatomic, retain) NSNumber * order;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSString * sourceName;
@property (nonatomic, retain) NSNumber * abIdentifier;
@property (nonatomic, retain) NSSet *grants;
@property (nonatomic, retain) NSSet *clients;
@property (nonatomic, retain) NSManagedObject *referralType;
@property (nonatomic, retain) NSSet *referrals;
@end

@interface OtherReferralSourceEntity (CoreDataGeneratedAccessors)

- (void)addGrantsObject:(NSManagedObject *)value;
- (void)removeGrantsObject:(NSManagedObject *)value;
- (void)addGrants:(NSSet *)values;
- (void)removeGrants:(NSSet *)values;

- (void)addClientsObject:(ClientEntity *)value;
- (void)removeClientsObject:(ClientEntity *)value;
- (void)addClients:(NSSet *)values;
- (void)removeClients:(NSSet *)values;

- (void)addReferralsObject:(ReferralEntity *)value;
- (void)removeReferralsObject:(ReferralEntity *)value;
- (void)addReferrals:(NSSet *)values;
- (void)removeReferrals:(NSSet *)values;

@end
