//
//  AssessmentTypeEntity.m
//  PsyTrack Clinician Tools
//  Version: 1.5.4
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import "AssessmentTypeEntity.h"
#import "AssessmentEntity.h"
#import "ExistingAssessmentEntity.h"

@implementation AssessmentTypeEntity

@dynamic order;
@dynamic notes;
@dynamic assessmentType;
@dynamic existingAssessments;
@dynamic assessments;

-(BOOL)associatedWithTimeRecords{
    
    
    
    BOOL associatedRecords=NO;
    
    [self willAccessValueForKey:@"existingAssessments"];
    
    if (self.existingAssessments.count) {
        associatedRecords=YES;
    }
    [self didAccessValueForKey:@"existingAssessments"];
    
    
    [self willAccessValueForKey:@"assessments"];
    
    if (self.assessments.count) {
        associatedRecords=YES;
    }
    [self didAccessValueForKey:@"assessments"];
    
    
    return associatedRecords;
    
    
    
    
    
    
    
    
    
}
@end
