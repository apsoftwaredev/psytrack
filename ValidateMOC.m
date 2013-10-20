//
//  ValidateMOC.m
//  PsyTrack
//
//  Created by Daniel Boice on 10/19/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import "ValidateMOC.h"

#import "TimeTrackEntity.h"
#import "ServiceParentEntity.h"
#import "ExistingHoursEntity.h"
#import "AssessmentEntity.h"
#import "SupervisionGivenEntity.h"
#import "SupervisionReceivedEntity.h"
#import "InterventionDeliveredEntity.h"

#import "PTTAppDelegate.h"


@implementation ValidateMOC

-(BOOL)supervisorsAllPresent{

    BOOL supervisorsAllPresent=YES;
    
    NSManagedObjectContext * managedObjectContext = [(PTTAppDelegate *)[UIApplication sharedApplication].delegate managedObjectContext];
    
    NSFetchRequest *requestTime = [[NSFetchRequest alloc] init];
    
    NSPredicate *predicate =
    [NSPredicate predicateWithFormat:@"supervisor == nil"];
    
    [requestTime setPredicate:predicate];
    
 
NSEntityDescription *entityTime = [NSEntityDescription entityForName:@"TimeTrackEntity" inManagedObjectContext:managedObjectContext];
[requestTime setEntity:entityTime];



    NSError *error = nil;



    
    NSUInteger countTime = [managedObjectContext countForFetchRequest:requestTime error:&error];

    if (countTime> 0) {
        
        DLog(@"count %i",countTime);
        NSArray *fetchedObjects=(NSArray *)[managedObjectContext executeFetchRequest:requestTime error:&error];
        
        DLog(@"fetched objects %@",fetchedObjects);
        supervisorsAllPresent=NO;
    }
    
    if (supervisorsAllPresent) {
   
        NSFetchRequest *requestExisting = [[NSFetchRequest alloc] init];
        [requestExisting setPredicate:predicate];
        
        
        NSEntityDescription *entityExisting = [NSEntityDescription entityForName:@"ExistingHoursEntity" inManagedObjectContext:managedObjectContext];
        [requestExisting setEntity:entityExisting];
        
        NSUInteger countExisting = [managedObjectContext countForFetchRequest:requestExisting error:&error];
        
        if (countExisting> 0) {
            
            DLog(@"count %i",countExisting);
            supervisorsAllPresent=NO;
        }
    }
    
    

    return supervisorsAllPresent;
}

-(BOOL)siteAllPresent{
    
    BOOL siteAllPresent=YES;
    
    NSManagedObjectContext * managedObjectContext = [(PTTAppDelegate *)[UIApplication sharedApplication].delegate managedObjectContext];
    
    NSFetchRequest *requestTime = [[NSFetchRequest alloc] init];
    
    NSPredicate *predicate =
    [NSPredicate predicateWithFormat:@"site == nil"];
    
    [requestTime setPredicate:predicate];
    
    
    NSEntityDescription *entityTime = [NSEntityDescription entityForName:@"TimeTrackEntity" inManagedObjectContext:managedObjectContext];
    [requestTime setEntity:entityTime];
    
    
    
    NSError *error = nil;
    
    
    
    
    NSUInteger countTime = [managedObjectContext countForFetchRequest:requestTime error:&error];
    
    if (countTime> 0) {
        
        DLog(@"count %i",countTime);
        siteAllPresent=NO;
    }
    
    if (siteAllPresent) {
        
        NSFetchRequest *requestExisting = [[NSFetchRequest alloc] init];
        [requestExisting setPredicate:predicate];
        
        
        NSEntityDescription *entityExisting = [NSEntityDescription entityForName:@"ExistingHoursEntity" inManagedObjectContext:managedObjectContext];
        [requestExisting setEntity:entityExisting];
        
        NSUInteger countExisting = [managedObjectContext countForFetchRequest:requestExisting error:&error];
        
        if (countExisting> 0) {
            
            DLog(@"count %i",countExisting);
            siteAllPresent=NO;
        }
    }
    
    
    
    return siteAllPresent;
}

-(BOOL)dateOfServiceAllPresent{
    
    BOOL dosAllPresent=YES;
    
    NSManagedObjectContext * managedObjectContext = [(PTTAppDelegate *)[UIApplication sharedApplication].delegate managedObjectContext];
    
    NSFetchRequest *requestTime = [[NSFetchRequest alloc] init];
    
    NSPredicate *predicate =
    [NSPredicate predicateWithFormat:@"dateOfService == nil"];
    
    [requestTime setPredicate:predicate];
    
    
    NSEntityDescription *entityTime = [NSEntityDescription entityForName:@"TimeTrackEntity" inManagedObjectContext:managedObjectContext];
    [requestTime setEntity:entityTime];
    
    
    
    NSError *error = nil;
    
    
    
    
    NSUInteger countTime = [managedObjectContext countForFetchRequest:requestTime error:&error];
    
    if (countTime> 0) {
        
        DLog(@"count %i",countTime);
        dosAllPresent=NO;
    }
    
    if (dosAllPresent) {
        
        NSFetchRequest *requestExisting = [[NSFetchRequest alloc] init];
        
        NSPredicate *predicateExisting =
        [NSPredicate predicateWithFormat:@"startDate == nil OR endDate==nil"];
        
        [requestExisting setPredicate:predicateExisting];
        
        
        NSEntityDescription *entityExisting = [NSEntityDescription entityForName:@"ExistingHoursEntity" inManagedObjectContext:managedObjectContext];
        [requestExisting setEntity:entityExisting];
        
        NSUInteger countExisting = [managedObjectContext countForFetchRequest:requestExisting error:&error];
        
        if (countExisting> 0) {
            
            DLog(@"count %i",countExisting);
            dosAllPresent=NO;
        }
    }
    
    
    
    return dosAllPresent;
}
-(BOOL)trainingProgramAllPresent{
    
    BOOL dosAllPresent=YES;
    
    NSManagedObjectContext * managedObjectContext = [(PTTAppDelegate *)[UIApplication sharedApplication].delegate managedObjectContext];
    
    NSFetchRequest *requestTime = [[NSFetchRequest alloc] init];
    
    NSPredicate *predicate =
    [NSPredicate predicateWithFormat:@"trainingProgram == nil"];
    
    [requestTime setPredicate:predicate];
    
    
    NSEntityDescription *entityTime = [NSEntityDescription entityForName:@"TimeTrackEntity" inManagedObjectContext:managedObjectContext];
    [requestTime setEntity:entityTime];
    
    
    
    NSError *error = nil;
    
    
    
    
    NSUInteger countTime = [managedObjectContext countForFetchRequest:requestTime error:&error];
    
    if (countTime> 0) {
        
        DLog(@"count %i",countTime);
        dosAllPresent=NO;
    }
    
    if (dosAllPresent) {
        
        NSFetchRequest *requestExisting = [[NSFetchRequest alloc] init];
        
        NSPredicate *predicateExisting =
        [NSPredicate predicateWithFormat:@"programCourse==nil"];
        
        [requestExisting setPredicate:predicateExisting];
        
        
        NSEntityDescription *entityExisting = [NSEntityDescription entityForName:@"ExistingHoursEntity" inManagedObjectContext:managedObjectContext];
        [requestExisting setEntity:entityExisting];
        
        NSUInteger countExisting = [managedObjectContext countForFetchRequest:requestExisting error:&error];
        
        if (countExisting> 0) {
            
            DLog(@"count %i",countExisting);
            dosAllPresent=NO;
        }
    }
    
    
    
    return dosAllPresent;
}

-(BOOL)interventionTypeAllPresent{
    
    BOOL allPresent=YES;
    
    NSManagedObjectContext * managedObjectContext = [(PTTAppDelegate *)[UIApplication sharedApplication].delegate managedObjectContext];
    
    NSFetchRequest *requestTime = [[NSFetchRequest alloc] init];
    
    NSPredicate *predicate =
    [NSPredicate predicateWithFormat:@"interventionType == nil or subtype==nil"];
    
    [requestTime setPredicate:predicate];
    
    
    NSEntityDescription *entityTime = [NSEntityDescription entityForName:@"InterventionDeliveredEntity" inManagedObjectContext:managedObjectContext];
    [requestTime setEntity:entityTime];
    
    
    
    NSError *error = nil;
    
    
    
    
    NSUInteger countTime = [managedObjectContext countForFetchRequest:requestTime error:&error];
    
    if (countTime> 0) {
        
        DLog(@"count %i",countTime);
        allPresent=NO;
    }
    
    if (allPresent) {
        
        NSFetchRequest *requestExisting = [[NSFetchRequest alloc] init];
        
        NSPredicate *predicateExisting =
        [NSPredicate predicateWithFormat:@"interventionType==nil OR interventionSubType==nil"];
        
        [requestExisting setPredicate:predicateExisting];
        
        
        NSEntityDescription *entityExisting = [NSEntityDescription entityForName:@"ExistingInterventionEntity" inManagedObjectContext:managedObjectContext];
        [requestExisting setEntity:entityExisting];
        
        NSUInteger countExisting = [managedObjectContext countForFetchRequest:requestExisting error:&error];
        
        if (countExisting> 0) {
            
            DLog(@"count %i",countExisting);
            allPresent=NO;
        }
    }
    
    
    
    return allPresent;
}

-(BOOL)assessmentTypeAllPresent{
    
    BOOL allPresent=YES;
    
    NSManagedObjectContext * managedObjectContext = [(PTTAppDelegate *)[UIApplication sharedApplication].delegate managedObjectContext];
    
    NSFetchRequest *requestTime = [[NSFetchRequest alloc] init];
    
    NSPredicate *predicate =
    [NSPredicate predicateWithFormat:@"assessmentType==nil"];
    
    [requestTime setPredicate:predicate];
    
    
    NSEntityDescription *entityTime = [NSEntityDescription entityForName:@"AssessmentEntity" inManagedObjectContext:managedObjectContext];
    [requestTime setEntity:entityTime];
    
    
    
    NSError *error = nil;
    
    
    
    
    NSUInteger countTime = [managedObjectContext countForFetchRequest:requestTime error:&error];
    
    if (countTime> 0) {
        
        DLog(@"count %i",countTime);
        allPresent=NO;
    }
    
    if (allPresent) {
        
        NSFetchRequest *requestExisting = [[NSFetchRequest alloc] init];
        
        NSPredicate *predicateExisting =
        [NSPredicate predicateWithFormat:@"assessmentType==nil"];
        
        [requestExisting setPredicate:predicateExisting];
        
        
        NSEntityDescription *entityExisting = [NSEntityDescription entityForName:@"ExistingAssessmentEntity" inManagedObjectContext:managedObjectContext];
        [requestExisting setEntity:entityExisting];
        
        NSUInteger countExisting = [managedObjectContext countForFetchRequest:requestExisting error:&error];
        
        if (countExisting> 0) {
            
            DLog(@"count %i",countExisting);
            allPresent=NO;
        }
    }
    
    
    
    return allPresent;
}

-(BOOL)supervisionTypeAllPresent{
    
    BOOL allPresent=YES;
    
    NSManagedObjectContext * managedObjectContext = [(PTTAppDelegate *)[UIApplication sharedApplication].delegate managedObjectContext];
    
    NSFetchRequest *requestTime = [[NSFetchRequest alloc] init];
    
    NSPredicate *predicate =
    [NSPredicate predicateWithFormat:@"subType==nil OR supervisionType==nil"];
    
    [requestTime setPredicate:predicate];
    
    
    NSEntityDescription *entityTime = [NSEntityDescription entityForName:@"SupervisionReceivedEntity" inManagedObjectContext:managedObjectContext];
    [requestTime setEntity:entityTime];
    
    
    
    NSError *error = nil;
    
    
    
    
    NSUInteger countTime = [managedObjectContext countForFetchRequest:requestTime error:&error];
    
    if (countTime> 0) {
        
        DLog(@"count %i",countTime);
        allPresent=NO;
    }
    
    if (allPresent) {
        
        NSFetchRequest *requestExisting = [[NSFetchRequest alloc] init];
        
        NSPredicate *predicateExisting =
        [NSPredicate predicateWithFormat:@"subType==nil OR supervisionType==nil"];
        
        [requestExisting setPredicate:predicateExisting];
        
        
        NSEntityDescription *entityExisting = [NSEntityDescription entityForName:@"ExistingSupervisionEntity" inManagedObjectContext:managedObjectContext];
        [requestExisting setEntity:entityExisting];
        
        NSUInteger countExisting = [managedObjectContext countForFetchRequest:requestExisting error:&error];
        
        if (countExisting> 0) {
            
            DLog(@"count %i",countExisting);
            allPresent=NO;
        }
    }
    
    
    
    return allPresent;
}


@end
