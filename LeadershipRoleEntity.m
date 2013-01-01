//
//  LeadershipRoleEntity.m
//  PsyTrack
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import "LeadershipRoleEntity.h"


@implementation LeadershipRoleEntity

@dynamic impact;
@dynamic theoreticalApproach;
@dynamic innovations;
@dynamic dateStarted;
@dynamic changesImplemented;
@dynamic dateEnded;
@dynamic role;
@dynamic challengesFaced;
@dynamic populationSize;
@dynamic organization;

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
