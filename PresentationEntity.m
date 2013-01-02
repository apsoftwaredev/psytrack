//
//  PresentationEntity.m
//  PsyTrack
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import "PresentationEntity.h"
#import "ConferenceEntity.h"
#import "LogEntity.h"
#import "PresentationDeliveredEntity.h"
#import "PublicationEntity.h"


@implementation PresentationEntity

@dynamic length;
@dynamic title;
@dynamic notes;
@dynamic logs;
@dynamic topics;
@dynamic publications;
@dynamic conferences;
@dynamic deliveries;

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
