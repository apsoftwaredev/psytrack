//
//  ExistingBatteryEntity.m
//  PsyTrack
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import "ExistingBatteryEntity.h"
#import "BatteryEntity.h"
#import "ExistingAssessmentEntity.h"


@implementation ExistingBatteryEntity

@dynamic numberAdminstered;
@dynamic numberOfReportsWritten;
@dynamic notes;
@dynamic adminstrationAndReport;
@dynamic existingAssessment;
@dynamic battery;

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
