//
//  SupportActivityTypeEntity.m
//  PsyTrack Clinician Tools
//  Version: 1.5.3
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import "SupportActivityTypeEntity.h"
#import "ExistingSupportActivityEntity.h"
#import "SupportActivityDeliveredEntity.h"

@implementation SupportActivityTypeEntity

@dynamic order;
@dynamic notes;
@dynamic supportActivityType;
@dynamic supportActivitiesDelivered;
@dynamic existingSupportActivities;


-(BOOL)associatedWithTimeRecords{
    
    
    
    BOOL associatedRecords=NO;
    
    [self willAccessValueForKey:@"supportActivitiesDelivered"];
    
    if (self.supportActivitiesDelivered.count) {
        associatedRecords=YES;
    }
    [self didAccessValueForKey:@"supportActivitiesDelivered"];
    
    
    [self willAccessValueForKey:@"existingSupportActivities"];
    
    if (self.existingSupportActivities.count) {
        associatedRecords=YES;
    }
    [self didAccessValueForKey:@"existingSupportActivities"];
    
    
    return associatedRecords;
    
    
    
    
    
    
    
    
    
}


@end
