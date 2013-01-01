//
//  TeachingExperienceEntity.m
//  PsyTrack
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import "TeachingExperienceEntity.h"
#import "ClinicianEntity.h"
#import "LogEntity.h"
#import "PublicationEntity.h"
#import "SchoolEntity.h"
#import "TopicEntity.h"


@implementation TeachingExperienceEntity

@dynamic subject;
@dynamic credits;
@dynamic classTitle;
@dynamic numberOfStudents;
@dynamic hours;
@dynamic endDate;
@dynamic notes;
@dynamic teachingRole;
@dynamic startDate;
@dynamic school;
@dynamic clinician;
@dynamic publications;
@dynamic logs;
@dynamic topics;

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
