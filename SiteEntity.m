//
//  SiteEntity.m
//  PsyTrack
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import "SiteEntity.h"
#import "ClinicianEntity.h"
#import "ExistingHoursEntity.h"
#import "TimeTrackEntity.h"


@implementation SiteEntity

@dynamic siteName;
@dynamic location;
@dynamic order;
@dynamic notes;
@dynamic started;
@dynamic ended;
@dynamic defaultSite;
@dynamic settingType;
@dynamic supervisor;
@dynamic timeTracks;
@dynamic existingHours;

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
