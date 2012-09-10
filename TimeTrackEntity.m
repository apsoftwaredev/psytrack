//
//  TimeTrackEntity.m
//  PsyTrack
//
//  Created by Daniel Boice on 7/15/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import "TimeTrackEntity.h"
#import "ClinicianEntity.h"
#import "PTTAppDelegate.h"
#import "TrainingProgramEntity.h"
#import "SiteEntity.h"
@implementation TimeTrackEntity

@dynamic monthlyLogNotes;
@dynamic order;
@dynamic notes;
@dynamic dateOfService;
@dynamic eventIdentifier;
@dynamic site;
@dynamic supervisor;
@dynamic trainingProgram;


-(void)awakeFromInsert{
    
    
    
    [super awakeFromInsert];
    PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
    
    
    //set the default date to the current date if it isn't already set to another date, assuming the client wasn't added on june 6, 2006 at 11:11:11 AM MST
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
    
    [dateFormatter setDateFormat:@"H:m:ss yyyy M d"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"MST"]];
    NSDate *referenceDate=[dateFormatter dateFromString:[NSString stringWithFormat:@"%i:%i:%i %i %i %i",11,11,11,2006,6,6]];
    
    [self willAccessValueForKey:@"dateOfService"];
    if ([(NSDate *)self.dateOfService isEqualToDate:referenceDate]) {
        [self didAccessValueForKey:@"dateOfService"];
        
        [self willChangeValueForKey:@"dateOfService"];
        self.dateOfService = [NSDate date];
        [self didChangeValueForKey:@"dateOfService"];
        
    }
    
    
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
            [self willChangeValueForKey:@"trainingProgram"];
            self.trainingProgram=trainingProgram;
            [self didChangeValueForKey:@"trainingProgram"];
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

    
    
   }


@end
