//
//  GrantEntity.m
//  PsyTrack
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import "GrantEntity.h"
#import "ClinicianEntity.h"
#import "LogEntity.h"
#import "OtherReferralSourceEntity.h"


@implementation GrantEntity

@dynamic submissionDeadline;
@dynamic amount;
@dynamic notes;
@dynamic grantTitle;
@dynamic impact;
@dynamic dateAwarded;
@dynamic dateSubmitted;
@dynamic awarded;
@dynamic otherSources;
@dynamic setting;
@dynamic logs;
@dynamic otherClinicians;

-(BOOL)validateValue:(__autoreleasing id *)value forKey:(NSString *)key error:(NSError *__autoreleasing *)error
{
    if ( ![self.managedObjectContext isKindOfClass:[PTManagedObjectContext class]] ) {
        return YES;
    }
    else {
        return [super validateValue:value forKey:key error:error];
    }
}

@end
