//
//  SupervisionTypeSubtypeEntity.m
//  PsyTrack Clinician Tools
//  Version: 1.5.4
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import "SupervisionTypeSubtypeEntity.h"
#import "ExistingSupervisionEntity.h"
#import "SupervisionGivenEntity.h"
#import "SupervisionReceivedEntity.h"
#import "SupervisionTypeEntity.h"

@implementation SupervisionTypeSubtypeEntity

@dynamic subType;
@dynamic order;
@dynamic notes;
@dynamic existingSupervision;
@dynamic supervisionType;
@dynamic supervisionReceived;
@dynamic supervisionGiven;


-(BOOL)associatedWithTimeRecords{
    
    
    
    BOOL associatedRecords=NO;
    
    [self willAccessValueForKey:@"existingSupervision"];
    
    if (self.existingSupervision.count) {
        associatedRecords=YES;
    }
    [self didAccessValueForKey:@"existingSupervision"];
    
    
    [self willAccessValueForKey:@"supervisionReceived"];
    
    if (self.supervisionReceived.count) {
        associatedRecords=YES;
    }
    [self didAccessValueForKey:@"supervisionReceived"];
    
    [self willAccessValueForKey:@"supervisionGiven"];
    
    if (self.supervisionGiven.count) {
        associatedRecords=YES;
    }
    [self didAccessValueForKey:@"supervisionGiven"];
    
    return associatedRecords;
    
    
    
    
    
    
    
    
    
}


@end
