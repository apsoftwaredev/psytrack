//
//  RelationshipEntity.m
//  PsyTrack Clinician Tools
//  Version: 1.5.5
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import "RelationshipEntity.h"
#import "InterpersonalEntity.h"

@implementation RelationshipEntity

@dynamic order;
@dynamic relationship;
@dynamic clientRelationship;


-(BOOL)associatedWithTimeRecords{
    
    
    
    BOOL associatedRecords=NO;
    
    [self willAccessValueForKey:@"clientRelationship"];
    
    if (self.clientRelationship.count) {
        associatedRecords=YES;
    }
    [self didAccessValueForKey:@"clientRelationship"];
    
    
    
    
    return associatedRecords;
    
    
    
    
    
    
    
    
    
}

@end
