//
//  CommunityServiceEntity.m
//  PsyTrack
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import "CommunityServiceEntity.h"
#import "LogEntity.h"


@implementation CommunityServiceEntity

@dynamic order;
@dynamic dateStarted;
@dynamic dateEnded;
@dynamic hours;
@dynamic notes;
@dynamic projectName;
@dynamic logs;
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
