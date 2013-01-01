//
//  AdvisingEntity.m
//  PsyTrack
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import "AdvisingEntity.h"
#import "ClinicianEntity.h"
#import "LogEntity.h"


@implementation AdvisingEntity

@dynamic endDate;
@dynamic order;
@dynamic startDate;
@dynamic notes;
@dynamic current;
@dynamic logs;
@dynamic advisee;



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
