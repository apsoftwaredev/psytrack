//
//  ClinicianTypeEntity.m
//  PsyTrack Clinician Tools
//  Version: 1.5.5
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import "ClinicianTypeEntity.h"
#import "ClinicianEntity.h"

@implementation ClinicianTypeEntity

@dynamic order;
@dynamic clinicianType;
@dynamic clinician;

-(BOOL)associatedWithTimeRecords{
    
    
    
    BOOL associatedRecords=NO;
    
    [self willAccessValueForKey:@"clinician"];
    
    if (self.clinician.count) {
        associatedRecords=YES;
    }
    [self didAccessValueForKey:@"clinician"];
    
    
    
    
    return associatedRecords;
    
    
    
    
    
    
    
    
    
}
@end
