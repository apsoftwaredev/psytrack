//
//  SupervisionTypeSubtypeEntity.m
//  PsyTrack
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import "SupervisionTypeSubtypeEntity.h"
#import "ExistingSupervisionEntity.h"
#import "SupervisionGivenEntity.h"
#import "SupervisionReceivedEntity.h"
#import "SupervisionTypeEntity.h"


@implementation SupervisionTypeSubtypeEntity

@dynamic subType;
@dynamic order;
@dynamic notes;
@dynamic existingSupervision;
@dynamic supervisionType;
@dynamic supervisionReceived;
@dynamic supervisionGiven;

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
