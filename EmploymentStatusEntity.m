//
//  EmploymentStatusEntity.m
//  PsyTrack Clinician Tools
//  Version: 1.5.5
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import "EmploymentStatusEntity.h"
#import "DemographicProfileEntity.h"

@implementation EmploymentStatusEntity

@dynamic order;
@dynamic notes;
@dynamic employmentStatus;
@dynamic demographics;


-(BOOL)associatedWithTimeRecords{
    
    
    
    BOOL associatedRecords=NO;
    
    [self willAccessValueForKey:@"demographics"];
    
    if (self.demographics.count) {
        associatedRecords=YES;
    }
    [self didAccessValueForKey:@"demographics"];
    
    
    
    
    return associatedRecords;
    
    
    
    
    
    
    
    
    
}

@end
