//
//  OrientationHistoryEntity.m
//  PsyTrack
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import "OrientationHistoryEntity.h"
#import "ClinicianEntity.h"


@implementation OrientationHistoryEntity

@dynamic order;
@dynamic endDate;
@dynamic dateAdopted;
@dynamic notes;
@dynamic clinician;
@dynamic orientation;


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
