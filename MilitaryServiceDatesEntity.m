//
//  MilitaryServiceDatesEntity.m
//  PsyTrack
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import "MilitaryServiceDatesEntity.h"


@implementation MilitaryServiceDatesEntity

@dynamic officerOrEnlisted;
@dynamic dateDischarged;
@dynamic branch;
@dynamic order;
@dynamic notes;
@dynamic dateJoined;
@dynamic dischargeType;
@dynamic militaryService;

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
