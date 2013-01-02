//
//  OrganizationEntity.m
//  PsyTrack
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import "OrganizationEntity.h"
#import "ConferenceEntity.h"
#import "ConsultationEntity.h"
#import "ExpertTestemonyEntity.h"
#import "LeadershipRoleEntity.h"


@implementation OrganizationEntity

@dynamic notes;
@dynamic size;
@dynamic name;
@dynamic expertTestemony;
@dynamic conferences;
@dynamic leadershipRoles;
@dynamic consultations;

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
