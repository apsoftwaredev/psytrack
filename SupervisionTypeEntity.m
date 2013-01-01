//
//  SupervisionTypeEntity.m
//  PsyTrack
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import "SupervisionTypeEntity.h"
#import "ExistingSupervisionEntity.h"
#import "SupervisionGivenEntity.h"
#import "SupervisionReceivedEntity.h"
#import "SupervisionTypeSubtypeEntity.h"


@implementation SupervisionTypeEntity

@dynamic order;
@dynamic notes;
@dynamic supervisionType;
@dynamic existingSupervision;
@dynamic supervisionRecieved;
@dynamic supervisionGiven;
@dynamic subTypes;

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
