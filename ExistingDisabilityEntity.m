//
//  ExistingDisabilityEntity.m
//  PsyTrack
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import "ExistingDisabilityEntity.h"
#import "DisabilityEntity.h"
#import "ExistingDemographicsEntity.h"


@implementation ExistingDisabilityEntity

@dynamic numberOfIndividuals;
@dynamic existingDemographics;
@dynamic disability;


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
