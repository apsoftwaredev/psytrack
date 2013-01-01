//
//  SchoolEntity.m
//  PsyTrack
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import "SchoolEntity.h"
#import "DegreeCourseEntity.h"
#import "DegreeEntity.h"
#import "TeachingExperienceEntity.h"
#import "TrainingProgramEntity.h"


@implementation SchoolEntity

@dynamic order;
@dynamic notes;
@dynamic schoolName;
@dynamic degrees;
@dynamic courses;
@dynamic trainingProgram;
@dynamic teachingExperience;


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
