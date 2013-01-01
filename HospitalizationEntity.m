//
//  HospitalizationEntity.m
//  PsyTrack
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import "HospitalizationEntity.h"
#import "ClientEntity.h"


@implementation HospitalizationEntity

@dynamic voluntary;
@dynamic dateDischarged;
@dynamic notes;
@dynamic dateAdmitted;
@dynamic client;


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
