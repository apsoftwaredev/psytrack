//
//  ExistingHoursEntity.m
//  PsyTrack Clinician Tools
//  Version: 1.05
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import "ExistingHoursEntity.h"
#import "ClinicianEntity.h"
#import "ExistingAssessmentEntity.h"
#import "ExistingInterventionEntity.h"
#import "ExistingSupervisionGivenEntity.h"
#import "ExistingSupervisionReceivedEntity.h"
#import "ExistingSupportActivityEntity.h"
#import "SiteEntity.h"
#import "TrainingProgramEntity.h"

#import "PTTAppDelegate.h"

@implementation ExistingHoursEntity

@dynamic keyString;
@dynamic endDate;
@dynamic notes;
@dynamic startDate;
@dynamic supportActivities;
@dynamic directInterventions;
@dynamic supervisor;
@dynamic assessments;
@dynamic programCourse;
@dynamic site;
@dynamic supervisionReceived;
@dynamic supervisionGiven;



- (void) awakeFromInsert
{
    [super awakeFromInsert];
    
    //set the default date to the current date if it isn't already set to another date, assuming the client wasn't added on june 6, 2006 at 11:11:11 AM MST
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
    
    [dateFormatter setDateFormat:@"H:m:ss yyyy M d"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"MST"]];
    NSDate *referenceDate=[dateFormatter dateFromString:[NSString stringWithFormat:@"%i:%i:%i %i %i %i",11,11,11,2006,6,6]];
    
    
    //    NSTimeInterval thirtyDays=60*60*24*30;
    NSDate *currentDate=[NSDate date];
    
    
    [self willAccessValueForKey:@"startDate"];
    if ([(NSDate *)self.startDate isEqualToDate:referenceDate]) {
        [self didAccessValueForKey:@"startDate"];
        [self willChangeValueForKey:(NSString *)@"startDate"];
        NSTimeInterval minusOneDay=-1*60*60*24;
        self.startDate = [currentDate dateByAddingTimeInterval: minusOneDay];
        [self didChangeValueForKey:(NSString *)@"startDate"];
    }
    
    [self willAccessValueForKey:@"endDate"];
    if ([(NSDate *)self.endDate isEqualToDate:referenceDate]) {
        [self didAccessValueForKey:@"endDate"];
        [self willChangeValueForKey:(NSString *)@"endDate"];
        self.endDate = currentDate;
        [self didChangeValueForKey:(NSString *)@"endDate"];
    }
    
    
    
    PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
    
    
    
    
    NSFetchRequest *supervisorFetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *clinicianEntity = [NSEntityDescription entityForName:@"ClinicianEntity" inManagedObjectContext:appDelegate.managedObjectContext];
    [supervisorFetchRequest setEntity:clinicianEntity];
    
    NSPredicate *myCurrentSupervisorOrMyInformationPredicate = [NSPredicate predicateWithFormat:@"myCurrentSupervisor == %@ OR myInformation == %@", [NSNumber numberWithBool:YES],[NSNumber numberWithBool:YES]];
    [supervisorFetchRequest setPredicate:myCurrentSupervisorOrMyInformationPredicate];
    
    NSError *clinicianError = nil;
    NSArray *clinicianFetchedObjects = [appDelegate.managedObjectContext executeFetchRequest:supervisorFetchRequest error:&clinicianError];
    
    ClinicianEntity *mySupervisor=nil;
    if (clinicianFetchedObjects &&clinicianFetchedObjects.count) {
        
        int clinicianFetchedObjectsCount=clinicianFetchedObjects.count;
        
        if (clinicianFetchedObjectsCount>1) {
            
            NSPredicate *myCurrentSupervisorPredicate=[NSPredicate predicateWithFormat:@"myInformation == %@",[NSNumber numberWithBool:NO]];
            NSArray *myCurrentSupervisors=[clinicianFetchedObjects filteredArrayUsingPredicate:myCurrentSupervisorPredicate];
            
            if (myCurrentSupervisors&&myCurrentSupervisors.count) {
                
                mySupervisor=[myCurrentSupervisors objectAtIndex:0];
            }
            else {
                mySupervisor=[clinicianFetchedObjects objectAtIndex:0];
            }
            
        }
        else if (clinicianFetchedObjectsCount==1){
            mySupervisor=[clinicianFetchedObjects objectAtIndex:0];
        }
        
    }
    
    [self willChangeValueForKey:@"supervisor"];
    self.supervisor=mySupervisor;
    [self didChangeValueForKey:@"supervisor"];
    
    NSFetchRequest *trainingProgramFetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *trainingProgramEntity = [NSEntityDescription entityForName:@"TrainingProgramEntity" inManagedObjectContext:appDelegate.managedObjectContext];
    [trainingProgramFetchRequest setEntity:trainingProgramEntity];
    
    //    [trainingProgramFetchRequest setRelationshipKeyPathsForPrefetching:[NSArray arrayWithObject:@"selectedByDefault"]];
    //
    //    NSPredicate *defaultTrainingPredicate = [NSPredicate predicateWithFormat:@"selectedByDefault == %@ ", [NSNumber numberWithBool:YES]];
    //    [trainingProgramFetchRequest setPredicate:defaultTrainingPredicate];
    
    NSError *trainingProgramError = nil;
    NSArray *trainingProgramFetchedObjects = [appDelegate.managedObjectContext executeFetchRequest:trainingProgramFetchRequest error:&trainingProgramError];
    
    
    for (TrainingProgramEntity *trainingProgram in trainingProgramFetchedObjects) {
        [trainingProgram willAccessValueForKey:@"selectedByDefault"];
        if ([trainingProgram.selectedByDefault isEqualToNumber:[NSNumber numberWithBool:YES]]) {
            [self willChangeValueForKey:@"programCourse"];
            self.programCourse=trainingProgram;
            [self didChangeValueForKey:@"programCourse"];
            [trainingProgram didAccessValueForKey:@"selectedByDefault"];
            break;
        }
        
        
    }
    
    
    NSFetchRequest *siteFetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *siteEntity = [NSEntityDescription entityForName:@"SiteEntity" inManagedObjectContext:appDelegate.managedObjectContext];
    [siteFetchRequest setEntity:siteEntity];
    
    //    [trainingProgramFetchRequest setRelationshipKeyPathsForPrefetching:[NSArray arrayWithObject:@"selectedByDefault"]];
    //
    //    NSPredicate *defaultTrainingPredicate = [NSPredicate predicateWithFormat:@"selectedByDefault == %@ ", [NSNumber numberWithBool:YES]];
    //    [trainingProgramFetchRequest setPredicate:defaultTrainingPredicate];
    
    NSError *siteError = nil;
    NSArray *siteFetchedObjects = [appDelegate.managedObjectContext executeFetchRequest:siteFetchRequest error:&siteError];
    
    
    for (SiteEntity *site in siteFetchedObjects) {
        [site willAccessValueForKey:@"defaultSite"];
        if ([site.defaultSite isEqualToNumber:[NSNumber numberWithBool:YES]]) {
            
            [self willChangeValueForKey:@"site"];
            
            self.site=site;
            [self didChangeValueForKey:@"site"];
            
            [site didAccessValueForKey:@"defaultSite"];
            break;
        }
        [site didAccessValueForKey:@"defaultSite"];
        
    }
    dateFormatter=nil;
    supervisorFetchRequest=nil;
    trainingProgramFetchRequest=nil;
    siteFetchRequest=nil;
    
    
}

@end
