//
//  SupervisionTypeEntity.m
//  PsyTrack Clinician Tools
//  Version: 1.5.3
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import "SupervisionTypeEntity.h"
#import "ExistingSupervisionEntity.h"
#import "SupervisionGivenEntity.h"
#import "SupervisionReceivedEntity.h"
#import "SupervisionTypeSubtypeEntity.h"

@implementation SupervisionTypeEntity

@dynamic order;
@dynamic notes;
@dynamic supervisionType;
@dynamic existingSupervision;
@dynamic supervisionRecieved;
@dynamic supervisionGiven;
@dynamic subTypes;



-(BOOL)associatedWithTimeRecords{
    
    
    
    BOOL associatedRecords=NO;
    
    [self willAccessValueForKey:@"existingSupervision"];
    
    if (self.existingSupervision.count) {
        associatedRecords=YES;
    }
    [self didAccessValueForKey:@"existingSupervision"];
    
    
    [self willAccessValueForKey:@"supervisionRecieved"];
    
    if (self.supervisionRecieved.count) {
        associatedRecords=YES;
    }
    [self didAccessValueForKey:@"supervisionRecieved"];
    
    [self willAccessValueForKey:@"supervisionGiven"];
    
    if (self.supervisionGiven.count) {
        associatedRecords=YES;
    }
    [self didAccessValueForKey:@"supervisionGiven"];

    return associatedRecords;
    
    
    
    
    
    
    
    
    
}

@end
