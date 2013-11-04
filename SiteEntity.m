//
//  SiteEntity.m
//  PsyTrack Clinician Tools
//  Version: 1.5.4
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


-(BOOL)associatedWithTimeRecords{
    
    
    
    BOOL associatedRecords=NO;
    
    [self willAccessValueForKey:@"timeTracks"];
    
    if (self.timeTracks.count) {
        associatedRecords=YES;
    }
    [self didAccessValueForKey:@"timeTracks"];
    
    
    [self willAccessValueForKey:@"existingHours"];
    
    if (self.existingHours.count) {
        associatedRecords=YES;
    }
    [self didAccessValueForKey:@"existingHours"];
    
    
    return associatedRecords;
    
  
    
}
@end
