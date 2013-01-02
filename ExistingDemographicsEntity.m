//
//  ExistingDemographicsEntity.m
//  PsyTrack
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import "ExistingDemographicsEntity.h"
#import "ExistingAssessmentEntity.h"
#import "ExistingEthnicityEntity.h"
#import "ExistingInterventionEntity.h"


@implementation ExistingDemographicsEntity

@dynamic otherIntervention;
@dynamic individualsWithDisabilities;
@dynamic sexualOrientations;
@dynamic races;
@dynamic ageGroups;
@dynamic genders;
@dynamic existingAssessment;
@dynamic ethnicities;

-(BOOL)validateValue:(__autoreleasing id *)value forKey:(NSString *)key error:(NSError *__autoreleasing *)error
{
    if ( ![self.managedObjectContext isKindOfClass:[PTManagedObjectContext class]] ) {
        return YES;
    }
    else {
        return [super validateValue:value forKey:key error:error];
    }
}

+(BOOL)deletesInvalidObjectsAfterFailedSave
{
    return NO;
}

-(void)repairForError:(NSError *)error
{
    if ( [self.class deletesInvalidObjectsAfterFailedSave] ) {
        [self.managedObjectContext deleteObject:self];
    }
}


@end
