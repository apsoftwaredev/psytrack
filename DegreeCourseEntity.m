//
//  DegreeCourseEntity.m
//  PsyTrack
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import "DegreeCourseEntity.h"
#import "ClinicianEntity.h"
#import "DegreeEntity.h"
#import "LogEntity.h"
#import "SchoolEntity.h"


@implementation DegreeCourseEntity

@dynamic endDate;
@dynamic startDate;
@dynamic notes;
@dynamic grade;
@dynamic credits;
@dynamic courseName;
@dynamic school;
@dynamic degree;
@dynamic logs;
@dynamic instructors;


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
