//
//  InterventionTypeSubtypeEntity.m
//  PsyTrack Clinician Tools
//  Version: 1.5.3
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import "InterventionTypeSubtypeEntity.h"
#import "ExistingInterventionEntity.h"
#import "InterventionDeliveredEntity.h"
#import "InterventionTypeEntity.h"

@implementation InterventionTypeSubtypeEntity

@dynamic order;
@dynamic notes;
@dynamic interventionSubType;
@dynamic interventionType;
@dynamic interventionsDelivered;
@dynamic existingInterventions;

-(BOOL)associatedWithTimeRecords{
    
    
    
    BOOL associatedRecords=NO;
    
    [self willAccessValueForKey:@"interventionsDelivered"];
    
    if (self.interventionsDelivered.count) {
        associatedRecords=YES;
    }
    [self didAccessValueForKey:@"interventionsDelivered"];
    
    
    [self willAccessValueForKey:@"existingInterventions"];
    
    if (self.existingInterventions.count) {
        associatedRecords=YES;
    }
    [self didAccessValueForKey:@"existingInterventions"];
    
    
    return associatedRecords;
    
    
    
    
    
    
    
    
    
}

@end
