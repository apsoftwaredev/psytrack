//
//  ExistingHoursEntity.m
//  PsyTrack
//
//  Created by Daniel Boice on 7/22/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import "ExistingHoursEntity.h"
#import "ClinicianEntity.h"
#import "ExistingAssessmentEntity.h"
#import "ExistingInterventionEntity.h"
#import "ExistingSupervisionReceivedEntity.h"
#import "ExistingSupportActivityEntity.h"
#import "SiteEntity.h"
#import "TrainingProgramEntity.h"
#import "PTTAppDelegate.h"

@implementation ExistingHoursEntity

@dynamic endDate;
@dynamic startDate;
@dynamic notes;
@dynamic keyString;
@dynamic supportActivities;
@dynamic assessments;
@dynamic supervisor;
@dynamic directInterventions;
@dynamic supervisionReceived;
@dynamic supervisionGiven;
@dynamic programCourse;
@dynamic site;
@synthesize tempNotes;

- (void) awakeFromInsert 
{
    [super awakeFromInsert];
    
    //set the default date to the current date if it isn't already set to another date, assuming the client wasn't added on june 6, 2006 at 11:11:11 AM MST
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
    
    [dateFormatter setDateFormat:@"H:m:ss yyyy M d"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"MST"]];
    NSDate *referenceDate=[dateFormatter dateFromString:[NSString stringWithFormat:@"%i:%i:%i %i %i %i",11,11,11,2006,6,6]];
    //DLog(@"reference date %@",referenceDate);
    
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
    DLog(@"traingin program entity is %@",trainingProgramEntity);
    //    [trainingProgramFetchRequest setRelationshipKeyPathsForPrefetching:[NSArray arrayWithObject:@"selectedByDefault"]];
    //    
    //    NSPredicate *defaultTrainingPredicate = [NSPredicate predicateWithFormat:@"selectedByDefault == %@ ", [NSNumber numberWithBool:YES]];
    //    [trainingProgramFetchRequest setPredicate:defaultTrainingPredicate];
    
    NSError *trainingProgramError = nil;
    NSArray *trainingProgramFetchedObjects = [appDelegate.managedObjectContext executeFetchRequest:trainingProgramFetchRequest error:&trainingProgramError];
    
    DLog(@"trainging program fetched objects are %@",trainingProgramFetchedObjects);
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
    DLog(@"traingin program entity is %@",siteFetchRequest);
    //    [trainingProgramFetchRequest setRelationshipKeyPathsForPrefetching:[NSArray arrayWithObject:@"selectedByDefault"]];
    //    
    //    NSPredicate *defaultTrainingPredicate = [NSPredicate predicateWithFormat:@"selectedByDefault == %@ ", [NSNumber numberWithBool:YES]];
    //    [trainingProgramFetchRequest setPredicate:defaultTrainingPredicate];
    
    NSError *siteError = nil;
    NSArray *siteFetchedObjects = [appDelegate.managedObjectContext executeFetchRequest:siteFetchRequest error:&siteError];
    
    DLog(@"trainging program fetched objects are %@",siteFetchedObjects);
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




-(void)rekeyEncryptedAttributes{
    
    if (self.notes) {
        [self rekeyString:(NSString *)self.notes forKey:@"notes"];
    }
    
    
}
- (void)rekeyString:(NSString *)strValue forKey:(NSString *)key
{
    
    PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
    
    if (strValue&& strValue.length ) {
        
        
        
        
        
        NSDictionary *encryptedDataDictionary=[appDelegate encryptStringToEncryptedData:(NSString *)strValue withKeyString:nil];
        //DLog(@"encrypted dictionary right after set %@",encryptedDataDictionary);
        NSData *encryptedData;
        NSString *encryptedKeyString;
        if ([encryptedDataDictionary.allKeys containsObject:@"encryptedData"]) {
            encryptedData=[encryptedDataDictionary valueForKey:@"encryptedData"];
            
            
            if ([encryptedDataDictionary.allKeys containsObject:@"keyString"]) {
                //DLog(@"all keys are %@",[encryptedDataDictionary allKeys]);
                
                encryptedKeyString=[encryptedDataDictionary valueForKey:@"keyString"];
                //DLog(@"key date is client entity %@",encryptedkeyString);
            }
        }
        
        
        if (encryptedData.length) {
            [self willChangeValueForKey:key];
            [self setPrimitiveValue:encryptedData forKey:key];
            [self didChangeValueForKey:key];
        }
        
        
        [self willAccessValueForKey:@"keyString"];
        if (![encryptedKeyString isEqualToString:self.keyString]) {
            [self didAccessValueForKey:@"keyString"];
            [self willChangeValueForKey:@"keyString"];
            [self setPrimitiveValue:encryptedKeyString forKey:@"keyString"];
            [self didChangeValueForKey:@"keyString"];
            
        }
        
        
        
        
        
        
    }
}




- (void)setStringToPrimitiveData:(NSString *)strValue forKey:(NSString *)key 
{
    
    PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
    
    if ( strValue && strValue.length  ) {
        
        
        
        
        
        NSDictionary *encryptedDataDictionary=[appDelegate encryptStringToEncryptedData:(NSString *)strValue withKeyString:self.keyString];
        //DLog(@"encrypted dictionary right after set %@",encryptedDataDictionary);
        NSData *encryptedData;
        NSString *encryptedKeyString;
        if ([encryptedDataDictionary.allKeys containsObject:@"encryptedData"]) {
            encryptedData=[encryptedDataDictionary valueForKey:@"encryptedData"];
            
            
            if ([encryptedDataDictionary.allKeys containsObject:@"keyString"]) {
                //DLog(@"all keys are %@",[encryptedDataDictionary allKeys]);
                
                encryptedKeyString=[encryptedDataDictionary valueForKey:@"keyString"];
                //DLog(@"key date is client entity %@",encryptedkeyString);
            }
        }
        
        
        if (encryptedData.length) {
            [self willChangeValueForKey:key];
            [self setPrimitiveValue:encryptedData forKey:key];
            [self didChangeValueForKey:key];
        }
        
        
        [self willAccessValueForKey:@"keyString"];
        if (![encryptedKeyString isEqualToString:self.keyString]) {
            [self didAccessValueForKey:@"keyString"];
            [self willChangeValueForKey:@"keyString"];
            [self setPrimitiveValue:encryptedKeyString forKey:@"keyString"];
            [self didChangeValueForKey:@"keyString"];
            
        }
        
        
        
        
        
        
    }
}
-(NSString *)notes{
    
    NSString *tempStr;
    [self willAccessValueForKey:@"tempNotes"];
    
    
    if (!self.tempNotes ||!self.tempNotes.length) {
        
        [self didAccessValueForKey:@"tempNotes"];
        PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
        
        
        [self willAccessValueForKey:@"notes"];
        
        
        NSData *primitiveData=[self primitiveValueForKey:@"notes"];
        [self didAccessValueForKey:@"notes"];
        if (!primitiveData ||!primitiveData.length) {
            return nil;
        }
        [self willAccessValueForKey:@"keyString"];
        NSString *tmpKeyString=self.keyString;
        [self didAccessValueForKey:@"keyString"];
        
        NSData *strData=[appDelegate decryptDataToPlainDataUsingKeyEntityWithString:tmpKeyString encryptedData:primitiveData];
        
        tempStr=[appDelegate convertDataToString:strData];
        
        [self willChangeValueForKey:@"tempNotes"];
        
        self.tempNotes=tempStr;
        [self didChangeValueForKey:@"tempNotes"];
        
        
    }
    else 
    {
        tempStr=self.tempNotes;
        [self didAccessValueForKey:@"tempNotes"];
    }
    
    
    
    
    return tempStr;
    
    
    
    
    
    
}
-(void)setNotes:(NSString *)notes{
    
    [self setStringToPrimitiveData:(NSString *)notes forKey:@"notes"];
    
    self.tempNotes=notes;
}

@end
