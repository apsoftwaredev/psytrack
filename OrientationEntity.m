//
//  OrientationEntity.m
//  PsyTrack
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import "OrientationEntity.h"
#import "CommunityServiceEntity.h"
#import "OrientationHistoryEntity.h"


@implementation OrientationEntity

@dynamic orientation;
@dynamic order;
@dynamic desc;
@dynamic communityService;
@dynamic orientationHistories;


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
