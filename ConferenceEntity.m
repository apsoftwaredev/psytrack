//
//  ConferenceEntity.m
//  PsyTrack
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import "ConferenceEntity.h"
#import "LogEntity.h"
#import "OrganizationEntity.h"
#import "PresentationEntity.h"


@implementation ConferenceEntity

@dynamic attendenceSize;
@dynamic hours;
@dynamic notableTopics;
@dynamic notableSpeakers;
@dynamic endDate;
@dynamic title;
@dynamic notes;
@dynamic order;
@dynamic startDate;
@dynamic myPresentations;
@dynamic logs;
@dynamic hostingOrganizations;


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
