//
//  AdditionalSymptomNameEntity.m
//  PsyTrack
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import "AdditionalSymptomNameEntity.h"
#import "AdditionalSymptomEntity.h"
#import "DisorderEntity.h"


@implementation AdditionalSymptomNameEntity

@dynamic symptomDescription;
@dynamic order;
@dynamic symptomName;
@dynamic additionalSypmtoms;
@dynamic possibleDisorders;
@dynamic diagnosisLog;


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
