//
//  InterpersonalEntity.m
//  PsyTrack
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import "InterpersonalEntity.h"
#import "DemographicProfileEntity.h"
#import "RelationshipEntity.h"


@implementation InterpersonalEntity

@dynamic contactFrequencyUnitLength;
@dynamic notes;
@dynamic duration;
@dynamic contactFrequencyUnit;
@dynamic contactFrequencyNumber;
@dynamic keyString;
@dynamic demographicProfile;
@dynamic relationship;


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
