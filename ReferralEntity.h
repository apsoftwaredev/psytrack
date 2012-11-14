//
//  ReferralEntity.h
//  PsyTrack
//
//  Created by Daniel Boice on 3/25/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ClientEntity, ClinicianEntity,OtherReferralSourceEntity;

@interface ReferralEntity : NSManagedObject

@property (nonatomic, retain) NSDate * dateReferred;
@property (nonatomic, retain) NSNumber * order;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSNumber * referralInOrOut;
@property (nonatomic, retain) NSString * keyString;
@property (nonatomic, retain) ClinicianEntity *clinician;
@property (nonatomic, retain) ClientEntity *client;
@property (nonatomic, retain) OtherReferralSourceEntity *otherSource;

@property (nonatomic, weak) NSString *tempNotes;
//-(void)rekeyEncryptedAttributes;
@end
