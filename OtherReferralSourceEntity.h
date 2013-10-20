//
//  OtherReferralSourceEntity.h
//  PsyTrack Clinician Tools
//  Version: 1.5.3
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "PTManagedObjectContext.h"
#import "PTManagedObject.h"

@class ClientEntity, OtherReferralSourceTypeEntity, ReferralEntity;

@interface OtherReferralSourceEntity : PTManagedObject

@property (nonatomic, retain) NSNumber *order;
@property (nonatomic, retain) NSString *notes;
@property (nonatomic, retain) NSString *sourceName;
@property (nonatomic, retain) NSNumber *abIdentifier;
@property (nonatomic, retain) NSSet *referrals;
@property (nonatomic, retain) NSSet *grants;
@property (nonatomic, retain) NSSet *clients;
@property (nonatomic, retain) OtherReferralSourceTypeEntity *referralType;
@end

@interface OtherReferralSourceEntity (CoreDataGeneratedAccessors)

- (void) addReferralsObject:(ReferralEntity *)value;
- (void) removeReferralsObject:(ReferralEntity *)value;
- (void) addReferrals:(NSSet *)values;
- (void) removeReferrals:(NSSet *)values;

- (void) addGrantsObject:(NSManagedObject *)value;
- (void) removeGrantsObject:(NSManagedObject *)value;
- (void) addGrants:(NSSet *)values;
- (void) removeGrants:(NSSet *)values;

- (void) addClientsObject:(ClientEntity *)value;
- (void) removeClientsObject:(ClientEntity *)value;
- (void) addClients:(NSSet *)values;
- (void) removeClients:(NSSet *)values;

@end
