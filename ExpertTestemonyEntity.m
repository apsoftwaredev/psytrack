//
//  ExpertTestemonyEntity.m
//  PsyTrack
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import "ExpertTestemonyEntity.h"
#import "ClientEntity.h"
#import "LogEntity.h"
#import "PublicationEntity.h"


@implementation ExpertTestemonyEntity

@dynamic plantifDefendant;
@dynamic caseName;
@dynamic hours;
@dynamic attorneys;
@dynamic judge;
@dynamic notes;
@dynamic order;
@dynamic logs;
@dynamic courtAppearances;
@dynamic publications;
@dynamic client;
@dynamic organization;

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
