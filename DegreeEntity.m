//
//  DegreeEntity.m
//  PsyTrack
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import "DegreeEntity.h"
#import "ClinicianEntity.h"
#import "DegreeNameEntity.h"
#import "SchoolEntity.h"


@implementation DegreeEntity

@dynamic dateAwarded;
@dynamic order;
@dynamic notes;
@dynamic updatedTimeStamp;
@dynamic school;
@dynamic degree;
@dynamic majors;
@dynamic minors;
@dynamic courses;
@dynamic clinician;

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