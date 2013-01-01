//
//  PublicationEntity.m
//  PsyTrack
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import "PublicationEntity.h"
#import "ClinicianEntity.h"
#import "ExpertTestemonyEntity.h"
#import "PresentationEntity.h"
#import "PublicationTypeEntity.h"


@implementation PublicationEntity

@dynamic shortT;
@dynamic isbnDOI;
@dynamic address;
@dynamic datePublished;
@dynamic citeKey;
@dynamic url;
@dynamic edition;
@dynamic chapter;
@dynamic type;
@dynamic series;
@dynamic volume;
@dynamic update;
@dynamic howPublished;
@dynamic lastChecked;
@dynamic organization;
@dynamic school;
@dynamic order;
@dynamic institution;
@dynamic pageNumbers;
@dynamic group;
@dynamic publisher;
@dynamic month;
@dynamic keywords;
@dynamic authors;
@dynamic urlDate;
@dynamic sortWord;
@dynamic bibtex;
@dynamic title;
@dynamic publicationTitle;
@dynamic notes;
@dynamic volumeTitle;
@dynamic subject;
@dynamic clinician;
@dynamic publicationType;
@dynamic expertTestemony;
@dynamic presentations;
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
