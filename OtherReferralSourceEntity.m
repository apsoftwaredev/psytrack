//
//  OtherReferralSourceEntity.m
//  PsyTrack
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import "OtherReferralSourceEntity.h"
#import "ClientEntity.h"
#import "OtherReferralSourceTypeEntity.h"
#import "ReferralEntity.h"


@implementation OtherReferralSourceEntity

@dynamic order;
@dynamic notes;
@dynamic sourceName;
@dynamic abIdentifier;
@dynamic referrals;
@dynamic grants;
@dynamic clients;
@dynamic referralType;

-(BOOL)validateValue:(__autoreleasing id *)value forKey:(NSString *)key error:(NSError *__autoreleasing *)error
{
    if ( ![self.managedObjectContext isKindOfClass:[PTManagedObjectContext class]] ) {
        return YES;
    }
    else {
        return [super validateValue:value forKey:key error:error];
    }
}

+(BOOL)deletesInvalidObjectsAfterFailedSave
{
    return NO;
}

-(void)repairForError:(NSError *)error
{
    if ( [self.class deletesInvalidObjectsAfterFailedSave] ) {
        [self.managedObjectContext deleteObject:self];
    }
}


@end
