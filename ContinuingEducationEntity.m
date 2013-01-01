//
//  ContinuingEducationEntity.m
//  PsyTrack
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import "ContinuingEducationEntity.h"
#import "ContinuingEducationProviderEntity.h"
#import "ContinuingEducationTypeEntity.h"


@implementation ContinuingEducationEntity

@dynamic cost;
@dynamic notes;
@dynamic dateEarned;
@dynamic cETitle;
@dynamic credits;
@dynamic forLicenseRenewal;
@dynamic provider;
@dynamic topics;
@dynamic type;

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
