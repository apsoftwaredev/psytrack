//
//  RateChargeEntity.m
//  PsyTrack
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import "RateChargeEntity.h"
#import "ConsultationEntity.h"
#import "RateEntity.h"


@implementation RateChargeEntity

@dynamic order;
@dynamic notes;
@dynamic hours;
@dynamic paid;
@dynamic dateCharged;
@dynamic consultation;
@dynamic rate;


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
