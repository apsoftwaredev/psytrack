//
//  SupportActivityClientEntity.m
//  PsyTrack
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import "SupportActivityClientEntity.h"
#import "ClientEntity.h"
#import "SupportActivityDeliveredEntity.h"


@implementation SupportActivityClientEntity

@dynamic proBono;
@dynamic notes;
@dynamic paid;
@dynamic hourlyRate;
@dynamic client;
@dynamic supportActivityDelivered;

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
