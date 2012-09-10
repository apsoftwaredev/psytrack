//
//  SupervisorsForMonth.m
//  PsyTrack
//
//  Created by Daniel Boice on 7/7/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import "SupervisorsAndTotalTimesForMonth.h"
#import "PTTAppDelegate.h"
#import "ExistingAssessmentEntity.h"
#import "ExistingSupportActivityEntity.h"
#import "SiteEntity.h"
#import "TimeTrackEntity.h"
#import "SchoolEntity.h"

@implementation SupervisorsAndTotalTimesForMonth

@synthesize  clinicians;
@synthesize cliniciansStr,studentNameStr;
@synthesize practicumSiteNamesStr,numberOfSites;

@synthesize assessmentMonthlyNotes=assessmentMonthlyNotes_,supportMonthlyNotes=supportMonthlyNotes_;

@synthesize interventionTotalWeek1Str;
@synthesize interventionTotalWeek2Str;
@synthesize interventionTotalWeek3Str;
@synthesize interventionTotalWeek4Str;
@synthesize interventionTotalWeek5Str;

@synthesize interventionTotalWeek1TI;
@synthesize interventionTotalWeek2TI;
@synthesize interventionTotalWeek3TI;
@synthesize interventionTotalWeek4TI;
@synthesize interventionTotalWeek5TI;


@synthesize interventionTotalWeekUndefinedStr;
@synthesize interventionTotalWeekUndefinedTI;

@synthesize interventionTotalForMonthStr;
@synthesize interventionTotalForMonthTI;


@synthesize interventionTotalCummulativeStr;
@synthesize interventionTotalCummulativeTI;

@synthesize interventionTotalToDateStr;
@synthesize interventionTotalToDateTI;



@synthesize assessmentTotalWeek1Str;
@synthesize assessmentTotalWeek2Str;
@synthesize assessmentTotalWeek3Str;
@synthesize assessmentTotalWeek4Str;
@synthesize assessmentTotalWeek5Str;

@synthesize assessmentTotalWeek1TI;
@synthesize assessmentTotalWeek2TI;
@synthesize assessmentTotalWeek3TI;
@synthesize assessmentTotalWeek4TI;
@synthesize assessmentTotalWeek5TI;

@synthesize assessmentTotalWeekUndefinedStr;
@synthesize assessmentTotalWeekUndefinedTI;

@synthesize assessmentTotalForMonthStr;
@synthesize assessmentTotalForMonthTI;


@synthesize assessmentTotalCummulativeStr;
@synthesize assessmentTotalCummulativeTI;

@synthesize assessmentTotalToDateStr;
@synthesize assessmentTotalToDateTI;


@synthesize supportTotalWeek1Str;
@synthesize supportTotalWeek2Str;
@synthesize supportTotalWeek3Str;
@synthesize supportTotalWeek4Str;
@synthesize supportTotalWeek5Str;

@synthesize supportTotalWeek1TI;
@synthesize supportTotalWeek2TI;
@synthesize supportTotalWeek3TI;
@synthesize supportTotalWeek4TI;
@synthesize supportTotalWeek5TI;


@synthesize supportTotalWeekUndefinedStr;
@synthesize supportTotalWeekUndefinedTI;

@synthesize supportTotalForMonthStr;
@synthesize supportTotalForMonthTI;


@synthesize supportTotalCummulativeStr;
@synthesize supportTotalCummulativeTI;

@synthesize supportTotalToDateStr;
@synthesize supportTotalToDateTI;


@synthesize supervisionTotalWeek1Str;
@synthesize supervisionTotalWeek2Str;
@synthesize supervisionTotalWeek3Str;
@synthesize supervisionTotalWeek4Str;
@synthesize supervisionTotalWeek5Str;

@synthesize supervisionTotalWeek1TI;
@synthesize supervisionTotalWeek2TI;
@synthesize supervisionTotalWeek3TI;
@synthesize supervisionTotalWeek4TI;
@synthesize supervisionTotalWeek5TI;


@synthesize supervisionTotalWeekUndefinedStr;
@synthesize supervisionTotalWeekUndefinedTI;

@synthesize supervisionTotalForMonthStr;
@synthesize supervisionTotalForMonthTI;


@synthesize supervisionTotalCummulativeStr;
@synthesize supervisionTotalCummulativeTI;

@synthesize supervisionTotalToDateStr;
@synthesize supervisionTotalToDateTI;



@synthesize directTotalWeek1Str;
@synthesize directTotalWeek2Str;
@synthesize directTotalWeek3Str;
@synthesize directTotalWeek4Str;
@synthesize directTotalWeek5Str;

@synthesize directTotalWeek1TI;
@synthesize directTotalWeek2TI;
@synthesize directTotalWeek3TI;
@synthesize directTotalWeek4TI;
@synthesize directTotalWeek5TI;


@synthesize directTotalWeekUndefinedStr;
@synthesize directTotalWeekUndefinedTI;

@synthesize directTotalForMonthStr;
@synthesize directTotalForMonthTI;

@synthesize directTotalCummulativeStr;
@synthesize directTotalCummulativeTI;

@synthesize directTotalToDateStr;
@synthesize directTotalToDateTI;


@synthesize overallTotalWeek1Str;
@synthesize overallTotalWeek2Str;
@synthesize overallTotalWeek3Str;
@synthesize overallTotalWeek4Str;
@synthesize overallTotalWeek5Str;

@synthesize overallTotalWeek1TI;
@synthesize overallTotalWeek2TI;
@synthesize overallTotalWeek3TI;
@synthesize overallTotalWeek4TI;
@synthesize overallTotalWeek5TI;


@synthesize overallTotalWeekUndefinedStr;
@synthesize overallTotalWeekUndefinedTI;

@synthesize overallTotalCummulativeStr;
@synthesize overallTotalCummulativeTI;

@synthesize overallTotalToDateStr;
@synthesize overallTotalToDateTI;

@synthesize overallTotalForMonthStr;
@synthesize overallTotalForMonthTI;

@synthesize practicumSeminarInstructtor, schoolNameStr, monthAndYearsInParentheses;
@synthesize markAmended;
@synthesize trainingProgramsStr;

@synthesize numberOfProgramCourses;
-(id)initWithDoctorateLevel:(BOOL)doctoarateLevelSelected clinician:(ClinicianEntity *)supervisor{
    //override superclass
   self= [super initWithMonth:nil clinician:supervisor trainingProgram:nil];
    
    if (self) {
        
        self.doctorateLevel=doctoarateLevelSelected;
        NSPredicate *predicateForTrackDoctorateLevel=[self predicateForTrackDoctorateLevel];
        
        NSPredicate *predicateForExistingHoursDoctorateLevel=[self predicateForExistingHoursDoctorateLevel];
        
        self.interventionsDeliveredArray=[self fetchObjectsFromEntity:kTrackInterventionEntityName filterPredicate:nil pathsForPrefetching:[NSArray arrayWithObject:@"trainingProgram"]];
        
       self.assessmentsDeliveredArray=[self fetchObjectsFromEntity:kTrackAssessmentEntityName filterPredicate:nil pathsForPrefetching:[NSArray arrayWithObject:@"trainingProgram"]];
        
       self.supportActivityDeliveredArray=[self fetchObjectsFromEntity:kTrackSupportEntityName filterPredicate:nil pathsForPrefetching:[NSArray arrayWithObject:@"trainingProgram"]];
        
        self.supervisionReceivedArray=[self fetchObjectsFromEntity:kTrackSupervisionReceivedEntityName filterPredicate:nil pathsForPrefetching:[NSArray arrayWithObject:@"trainingProgram"]];
        
        self.existingHoursHoursArray=[self fetchObjectsFromEntity:kTrackExistingHoursEntityName filterPredicate:nil pathsForPrefetching:[NSArray arrayWithObject:@"programCourse" ]];
                                              
        self.interventionsDeliveredArray=[self.interventionsDeliveredArray filteredArrayUsingPredicate:predicateForTrackDoctorateLevel];
        
        
         DLog(@"assessment delivered array %@ %i",[self.assessmentsDeliveredArray valueForKeyPath:@"trainingProgram.doctorateLevel"],doctorateLevel_);
        
        
        self.assessmentsDeliveredArray=[self.assessmentsDeliveredArray filteredArrayUsingPredicate:predicateForTrackDoctorateLevel];
        
        DLog(@"assessment delivered array %@",self.assessmentsDeliveredArray);
        
        self.supportActivityDeliveredArray=[self.supportActivityDeliveredArray filteredArrayUsingPredicate:predicateForTrackDoctorateLevel];
        
        self.supervisionReceivedArray=[self.supervisionReceivedArray filteredArrayUsingPredicate:predicateForTrackDoctorateLevel];
        
        self.existingHoursHoursArray=[self.existingHoursHoursArray filteredArrayUsingPredicate:predicateForExistingHoursDoctorateLevel];
        
        
        if(clinician_){
            
            
            NSPredicate *clinicianFilter=[self predicateForClincian];
            self.interventionsDeliveredArray=[self.interventionsDeliveredArray filteredArrayUsingPredicate:clinicianFilter];
            self.assessmentsDeliveredArray=[self.assessmentsDeliveredArray filteredArrayUsingPredicate:clinicianFilter];
            
            self.supportActivityDeliveredArray=[self.supportActivityDeliveredArray filteredArrayUsingPredicate:clinicianFilter];
            
            self.supervisionReceivedArray=[self.supervisionReceivedArray filteredArrayUsingPredicate:clinicianFilter];
            
            self.existingHoursHoursArray=[self.existingHoursHoursArray filteredArrayUsingPredicate:clinicianFilter];
            
            
            
        }
        
        self.overallTotalToDateTI=[self totalOverallHoursTIForOveralCell:kSummaryTotalToDate clinician:nil];
        
        
        self.assessmentMonthlyNotes=[self monthlyLogNotesForMonth:kTrackAssessment];
        self.supportMonthlyNotes=[self monthlyLogNotesForMonth:kTrackSupport];

        self.directTotalToDateTI=self.interventionTotalToDateTI+self.assessmentTotalToDateTI;
        
        
       
        self.directTotalToDateStr=[self timeStrFromTimeInterval: self.directTotalToDateTI];
        
        self.studentNameStr=[self getStudentName];
        self.clinicians=[self supervisorsArray];
        DLog(@"self.clinicians is  %@",self.clinicians);
        self.cliniciansStr=[self cliniciansStrFromCliniciansArray:self.clinicians];
        self.trainingProgramsStr=[self setTrainingProgramString];
}

    return self;

}

-(id)initWithMonth:(NSDate *)date clinician:(ClinicianEntity *)clinician trainingProgram:(TrainingProgramEntity *)trainingProgramGiven markAmended:(BOOL)markAmendedGiven{
    //override superclass
    self= [super initWithMonth:date clinician:clinician trainingProgram:trainingProgramGiven];
    
    if (self) {
        
                
        
        self.clinician=clinician;
        self.markAmended=markAmendedGiven;
        NSPredicate *predicateForTrackEntities=[self predicateForTrackEntitiesAllBeforeAndEqualToEndDateForMonth];
        
        NSArray *tempInterventionsDeliveredArray=[self fetchObjectsFromEntity:kTrackInterventionEntityName filterPredicate:predicateForTrackEntities];
        
       NSArray * tempAssessmentsDeliveredArray=[self fetchObjectsFromEntity:kTrackAssessmentEntityName filterPredicate:predicateForTrackEntities];
        
        NSArray * tempSupportActivityDeliveredArray=[self fetchObjectsFromEntity:kTrackSupportEntityName filterPredicate:predicateForTrackEntities];
        
        NSArray *tempSupervisionReceivedArray=[self fetchObjectsFromEntity:kTrackSupervisionReceivedEntityName filterPredicate:predicateForTrackEntities];
        
       NSArray *tempExistingHoursHoursArray=[self fetchObjectsFromEntity:kTrackExistingHoursEntityName filterPredicate:[self predicateForExistingHoursAllBeforeAndEqualToEndDateForMonth]];
        
        
        NSPredicate *predicateForTrackTrainingProgram=[self predicateForTrackTrainingProgram];
        if (tempInterventionsDeliveredArray&& tempInterventionsDeliveredArray.count) {
        
            self.interventionsDeliveredArray=[tempInterventionsDeliveredArray filteredArrayUsingPredicate:predicateForTrackTrainingProgram];
        }
        if (tempAssessmentsDeliveredArray&& tempAssessmentsDeliveredArray.count) {
            self.assessmentsDeliveredArray=[tempAssessmentsDeliveredArray filteredArrayUsingPredicate:predicateForTrackTrainingProgram];
        }
        if (tempSupportActivityDeliveredArray&& tempSupportActivityDeliveredArray.count) {
            self.supportActivityDeliveredArray=[tempSupportActivityDeliveredArray filteredArrayUsingPredicate:predicateForTrackTrainingProgram];
        }
        if (tempSupervisionReceivedArray&& tempSupervisionReceivedArray.count) {
            self.supervisionReceivedArray=[tempSupervisionReceivedArray filteredArrayUsingPredicate:predicateForTrackTrainingProgram];
        }
        
        NSPredicate *predicateForExistingHoursProgramCourse=[self predicateForExistingHoursProgramCourse];
       
        if (tempExistingHoursHoursArray&& tempExistingHoursHoursArray.count) {
            self.existingHoursHoursArray=[tempExistingHoursHoursArray filteredArrayUsingPredicate:predicateForExistingHoursProgramCourse];
        }
            
           
        
        
        if(clinician_){
        
        
            NSPredicate *clinicianFilter=[self predicateForClincian];
            self.interventionsDeliveredArray=[self.interventionsDeliveredArray filteredArrayUsingPredicate:clinicianFilter];
            self.assessmentsDeliveredArray=[self.assessmentsDeliveredArray filteredArrayUsingPredicate:clinicianFilter];
            
            self.supportActivityDeliveredArray=[self.supportActivityDeliveredArray filteredArrayUsingPredicate:clinicianFilter];
            
            self.supervisionReceivedArray=[self.supervisionReceivedArray filteredArrayUsingPredicate:clinicianFilter];
            
            self.existingHoursHoursArray=[self.existingHoursHoursArray filteredArrayUsingPredicate:clinicianFilter];
            
        
        
        }
        
        DLog(@"self.existing hours array is %@",self.existingHoursHoursArray);
        
        self.overallTotalWeek1TI=[self totalOverallHoursTIForOveralCell:kSummaryWeekOne clinician:clinician];
        self.overallTotalWeek2TI=[self totalOverallHoursTIForOveralCell:kSummaryWeekTwo clinician:clinician];
        self.overallTotalWeek3TI=[self totalOverallHoursTIForOveralCell:kSummaryWeekThree clinician:clinician];
        self.overallTotalWeek4TI=[self totalOverallHoursTIForOveralCell:kSummaryWeekFour clinician:clinician];
        self.overallTotalWeek5TI=[self totalOverallHoursTIForOveralCell:kSummaryWeekFive clinician:clinician];
        self.overallTotalWeekUndefinedTI=[self totalOverallHoursTIForOveralCell:kSummaryWeekUndefined clinician:clinician];
        
        
        self.overallTotalForMonthTI=[self totalOverallHoursTIForOveralCell:kSummaryTotalForMonth clinician:clinician];
        self.overallTotalCummulativeTI =[self totalOverallHoursTIForOveralCell:kSummaryCummulative clinician:(ClinicianEntity *)clinician];
        self.overallTotalToDateTI=[self totalOverallHoursTIForOveralCell:kSummaryTotalToDate clinician:clinician];
        
        
        self.assessmentMonthlyNotes=[self monthlyLogNotesForMonth:kTrackAssessment];
        self.supportMonthlyNotes=[self monthlyLogNotesForMonth:kTrackSupport];
        [self calculateDirectlHours];
        
        
        self.clinicians=[self supervisorsArray];
    
        self.cliniciansStr=[self cliniciansStrFromCliniciansArray:self.clinicians];
        self.practicumSiteNamesStr=[self practicumSitesStr];
        self.studentNameStr=[self getStudentName];
        self.practicumSeminarInstructtor=self.trainingProgram.seminarInstructor.combinedName;
        self.schoolNameStr=self.trainingProgram.school.schoolName;
        [self setMonthandYearsInParentheses];
       
    }
    
    return self;
    
    
}
-(void)setMonthandYearsInParentheses{

    NSDateFormatter *monthDateFormatter=[[NSDateFormatter alloc]init];
    
    [monthDateFormatter setDateFormat:@"MMMM yyyy"];
    
    NSDateFormatter *yearDateFormatter=[[NSDateFormatter alloc]init];
    
    [yearDateFormatter setDateFormat:@"yyyy"];
    
    NSDate *trainingProgramStartDate=self.trainingProgram.startDate;
    NSDate *trainingProgramEndDate=self.trainingProgram.endDate;
    
    NSInteger startDateYear=[[yearDateFormatter stringFromDate:trainingProgramStartDate]integerValue];
    NSInteger endDateYear=[[yearDateFormatter stringFromDate:trainingProgramEndDate]integerValue];
    
    
    NSString *yearsInParentheses=nil;
    if ((trainingProgramEndDate &&!trainingProgramEndDate)||(startDateYear==endDateYear&&startDateYear>0)) {
         yearsInParentheses=[NSString stringWithFormat:@" (%i Year)",startDateYear];
    }
    else if(trainingProgramStartDate &&trainingProgramEndDate&&(endDateYear- startDateYear==1)) {
        yearsInParentheses=[NSString stringWithFormat:@" (%i-%i Year)",startDateYear,endDateYear];
    }
    else if (endDateYear-startDateYear>1){
        yearsInParentheses=[NSString stringWithFormat:@" (%i-%i Years)",startDateYear,endDateYear];
    }
   
    if (self.monthToDisplay) {
        self.monthAndYearsInParentheses=[NSString stringWithFormat:@"%@%@",[monthDateFormatter stringFromDate:self.monthToDisplay],yearsInParentheses?yearsInParentheses:@""];
    }
    
    
    
    
    
    

}

-(NSString *)setTrainingProgramString{
    
    NSSet *trainingProgramSet=[self.interventionsDeliveredArray valueForKey:@"trainingProgram"];
    NSSet *programCourseSet=[self.existingHoursHoursArray valueForKey:@"programCourse"];

    NSMutableSet *combinedSet=[NSMutableSet set];
    if (trainingProgramSet && programCourseSet &&programCourseSet.count&& trainingProgramSet.count) {
        [combinedSet addObjectsFromArray:programCourseSet.allObjects];
        [combinedSet addObjectsFromArray:trainingProgramSet.allObjects];
    }
    else if(programCourseSet&& (!trainingProgramSet||!trainingProgramSet.count)){
    
        [combinedSet addObjectsFromArray:programCourseSet.allObjects];
    
    
    }else if ((!programCourseSet ||!programCourseSet.count)&&trainingProgramSet&&trainingProgramSet.count){
    
        [combinedSet addObjectsFromArray:trainingProgramSet.allObjects];
    
    }
    
    self.numberOfProgramCourses=combinedSet.count;
    NSString *returnString=nil;
    for (TrainingProgramEntity *trainingProgram in combinedSet.allObjects) {
        
        if (!returnString||!returnString.length) {
            returnString=[NSString stringWithFormat:@"%@ - %@",trainingProgram.trainingProgram ,trainingProgram.course];
        }
        else {
            returnString=[returnString stringByAppendingFormat:@"; %@ - %@",trainingProgram.trainingProgram,trainingProgram.course];
        }
        
    }
    
    return  returnString;
    
    
}



-(NSString *)cliniciansStrFromCliniciansArray:(NSArray*)cliniciansArray{

    NSString *returnString=nil;
    DLog(@"clinicians Array is %@",cliniciansArray);
    for (ClinicianEntity *clinicianInArray in cliniciansArray) {
        
        if (!returnString||!returnString.length) {
            returnString=clinicianInArray.combinedName;
        }
        else {
            returnString=[returnString stringByAppendingFormat:@"; %@",clinicianInArray.combinedName];
        }
        
    }

    return  returnString;


}
-(NSString *)getStudentName{

    NSString *studentName=nil;
    
    NSArray *cliniciansArrayWithMyInfo=[self fetchObjectsFromEntity:@"ClinicianEntity" filterPredicate:[NSPredicate predicateWithFormat:@"myInformation== %@",[NSNumber numberWithBool:YES]]];

    
    if (cliniciansArrayWithMyInfo&&cliniciansArrayWithMyInfo.count) {
       
        int clinicianCount=cliniciansArrayWithMyInfo.count;
        
        if (clinicianCount>1) {
            //there should only be one
           
            
            for (ClinicianEntity *clinicianInArray in cliniciansArrayWithMyInfo) {
               
                //try to find the right one
                if ([clinicianInArray.firstName isEqualToString:@"Enter Your"]) {
                    studentName=clinicianInArray.combinedName;
                    break;
                }
                
                
                
            }

            if ((!studentName ||!studentName.length )&&cliniciansArrayWithMyInfo && cliniciansArrayWithMyInfo.count) {
                ClinicianEntity *clinicianInArray=[cliniciansArrayWithMyInfo objectAtIndex:0];
                studentName=clinicianInArray.combinedName;
                
                
            }
            
            
            
        }
        else if (cliniciansArrayWithMyInfo&& cliniciansArrayWithMyInfo.count) {
           
            ClinicianEntity *clinicianInArray=[cliniciansArrayWithMyInfo objectAtIndex:0];
            studentName=clinicianInArray.combinedName;
        }
        
    }

    return studentName;

}
-(NSSet *)cliniciansFromTrackArray:(NSArray *)trackArray{
    NSPredicate *predicateForTrackEntitiesForMonth=nil;
    
    if (monthToDisplay_) {
         predicateForTrackEntitiesForMonth=[self predicateForTrackCurrentMonth];
    }
      
    
    NSArray *trackArrayForCurrentMonth=nil;
    if (trackArray&& [trackArray isKindOfClass:[NSArray class]] &&  trackArray.count &&predicateForTrackEntitiesForMonth) {
        trackArrayForCurrentMonth=[trackArray filteredArrayUsingPredicate:predicateForTrackEntitiesForMonth];
        
    }
    else{
    
        trackArrayForCurrentMonth=trackArray;
    }
    
    NSMutableSet *supervisorsSet=nil;
    if (trackArrayForCurrentMonth &&trackArrayForCurrentMonth.count) {
        
        supervisorsSet=[trackArrayForCurrentMonth mutableSetValueForKey:@"supervisor"];
                
    }

    
    
    return supervisorsSet;

}

-(NSSet *)cliniciansFromExistingHoursArray:(NSArray *)existingHoursArrayGiven{
    
    NSPredicate *predicateForExistingEntitiesForMonth=nil;
    if (monthToDisplay_) {
        predicateForExistingEntitiesForMonth=[self predicateForExistingHoursCurrentMonth];
    }
 
    
    NSArray *existingArrayForCurrentMonth=nil;
    if (existingHoursArrayGiven&& [existingHoursArrayGiven isKindOfClass:[NSArray class]] &&  existingHoursArrayGiven.count &&predicateForExistingEntitiesForMonth) {
        existingArrayForCurrentMonth=[existingHoursArrayGiven filteredArrayUsingPredicate:predicateForExistingEntitiesForMonth];
        
    }
    else{
    
        existingArrayForCurrentMonth=existingHoursArrayGiven;
    }
    
    
    
    NSMutableSet *supervisorsSet=nil;
    if (existingArrayForCurrentMonth &&existingArrayForCurrentMonth.count) {
        
        supervisorsSet=[existingArrayForCurrentMonth mutableSetValueForKey:@"supervisor"];
        
    }
    
    
    return supervisorsSet;
    
}

-(NSString *)practicumSitesStr{

    NSString *returnString=nil;
    NSPredicate *predicateForCurrentMonth=nil;
    if (monthToDisplay_) {
       predicateForCurrentMonth=[self predicateForTrackCurrentMonth];
    }
    
    
    NSArray *trackArray=[self fetchObjectsFromEntity:@"TimeTrackEntity" filterPredicate:predicateForCurrentMonth pathsForPrefetching:[NSArray arrayWithObject:@"site"]];

   
    
       NSMutableArray *siteObjectArray=[NSMutableArray array];
    
    for (TimeTrackEntity *trackInArray in trackArray) {
        SiteEntity *site=trackInArray.site;
        
        if (site &&  ![siteObjectArray containsObject:site]) {
            [siteObjectArray addObject:site];
        }
        
        
    }
    
    
    
    
 NSMutableArray *siteNamesArray=nil;
    if (siteObjectArray && siteObjectArray.count) {
        self.numberOfSites=siteObjectArray.count;
        siteNamesArray=[siteObjectArray mutableArrayValueForKeyPath:@"siteName"];
    }

    
    if (siteNamesArray&&siteNamesArray.count) {
        
               
        
        
        for (NSString *siteName in siteNamesArray) {
            
            if (!returnString||!returnString.length) {
            
                
                returnString=siteName;
            }
            else {
                returnString=[returnString stringByAppendingFormat:@"; %@",siteName];
            }
            
        }
    }
    
    
    return returnString;

}
-(NSArray *)fetchObjectsFromEntity:(NSString *)entityStr filterPredicate:(NSPredicate *)filterPredicate pathsForPrefetching:(NSArray *)pathsForPrefetching {
    PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
    
    
    
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityStr inManagedObjectContext:appDelegate.managedObjectContext];
    
    [fetchRequest setEntity:entity];
    [fetchRequest setRelationshipKeyPathsForPrefetching:
     pathsForPrefetching];
    
    
    if (filterPredicate) {
        [fetchRequest setPredicate:filterPredicate];
    }
   
  
    if (![entityStr isEqualToString:@"ExistingHoursEntity"]) {
       NSSortDescriptor *sortDescriptor = sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"order"
                                                                       ascending:YES];
        
        NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
        [fetchRequest setSortDescriptors:sortDescriptors];
        
    }
   
   
    
    NSError *error = nil;
    NSArray *fetchedObjects = [appDelegate.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    return fetchedObjects;
    
}


-(NSArray *)supervisorsArray{

    
  
    
    NSMutableSet *combinedCliniciansMutableSet=[NSMutableSet set];
    
    NSSet *cliniciansSetFromInterventions=[self cliniciansFromTrackArray:self.interventionsDeliveredArray];    
    
    NSSet *clinicianSetFromAssessments=[self cliniciansFromTrackArray:self.assessmentsDeliveredArray ];
    
    NSSet *clinicianSetFromSupport=[self cliniciansFromTrackArray:self.supportActivityDeliveredArray];
    
    NSSet *clinicianSetFromSupervision=[self cliniciansFromTrackArray:self.supervisionReceivedArray ];
    
    NSSet * clinicianSetFromExistingHours=[self cliniciansFromExistingHoursArray:self.existingHoursHoursArray];
    
      
    //to avoid duplicates
    
    if (cliniciansSetFromInterventions) {
        [combinedCliniciansMutableSet addObjectsFromArray:cliniciansSetFromInterventions.allObjects];
    }
   
    if (clinicianSetFromAssessments) {
        [combinedCliniciansMutableSet addObjectsFromArray:clinicianSetFromAssessments.allObjects];
    }
    
    if (clinicianSetFromSupport) {


        [combinedCliniciansMutableSet addObjectsFromArray:clinicianSetFromSupport.allObjects];
    }
    
    if (clinicianSetFromSupervision) {
        [combinedCliniciansMutableSet addObjectsFromArray:clinicianSetFromSupervision.allObjects];   
    }
    if (clinicianSetFromExistingHours) {
       
        [combinedCliniciansMutableSet addObjectsFromArray:clinicianSetFromExistingHours.allObjects];
    
    } 
       return combinedCliniciansMutableSet.allObjects;

}

//-(NSString *) totalCummulativeHoursForPTrackEntity:(PTrackEntity )pTrackEntity StrForClinician:(ClinicianEntity *)clinician{
//    
//    
//    NSArray *entityArray=nil;
//    
//    switch (pTrackEntity) {
//        case kTrackIntervention:
//            entityArray=interventionsDeliveredArray_;
//            
//            break;
//        case kTrackAssessment:
//            entityArray=assessmentsDeliveredArray_;
//            
//            break; 
//        case kTrackSupport:
//            entityArray=supportActivityDeliveredArray_;
//            
//            break;
//        case kTrackSupervisionReceived:
//            entityArray=supervisionReceivedArray_;
//            
//            break;
//        default:
//            break;
//    }
//    
//    
//    
//
//    NSPredicate *trackPredicate=[self priorMonthsHoursPredicateForClincian:clinician];
//   
//    
//    NSArray *filteredTrackObjects=[entityArray filteredArrayUsingPredicate:(NSPredicate *)trackPredicate];
//    
//    NSArray *trackTotalTimeArray=[filteredTrackObjects valueForKeyPath:@"time.totalTime"];
//
//    
//    NSTimeInterval trackTotalTimeInterval=[self totalTimeIntervalForTotalTimeArray:trackTotalTimeArray];
//    
//    
//    
//    NSPredicate *existingHoursPredicate=[self predicateForExistingHoursAllBeforeEndDate:monthStartDate_];
//    
//    
//    NSArray *filteredExistingHoursArray=[existingHoursArray_ filteredArrayUsingPredicate:existingHoursPredicate];
//    
//       NSTimeInterval totalTimeInterval=0;
//    
//    switch (pTrackEntity) {
//        case kTrackIntervention:
//        { NSArray *existingInterventionHoursArray=[filteredExistingHoursArray valueForKeyPath:kTrackKeyPathForExistingHoursInterventionHours];
//            
//            totalTimeInterval=[self totalTimeIntervalForTotalTimeArray:existingInterventionHoursArray];
//            
//            
//            break;
//        }
//        case kTrackAssessment:
//        {
//            NSArray *existingAssessmentHoursArray=[filteredExistingHoursArray valueForKeyPath:kTrackKeyPathForExistingHoursAssessmentHours];
//            
//            totalTimeInterval=[self totalTimeIntervalForTotalTimeArray:existingAssessmentHoursArray];
//        }
//        case kTrackSupport:
//        {
//            NSArray *existingSupportActivityHoursArray=[filteredExistingHoursArray valueForKeyPath:kTrackKeyPathForExistingHoursSupportActivityHours];
//            
//            totalTimeInterval=[self totalTimeIntervalForTotalTimeArray:existingSupportActivityHoursArray];
//            
//
//        }
//        case kTrackSupervisionReceived:
//        {
//            
//            NSArray *existingSupervisionReceivedHoursArray=[filteredExistingHoursArray valueForKeyPath:kTrackKeyPathForExistingHoursSupervisionReceivedHours];
//            
//           totalTimeInterval=[self totalTimeIntervalForTotalTimeArray:existingSupervisionReceivedHoursArray];
//        }
//        default:
//            break;
//    }
//    
//    
//    totalTimeInterval=totalTimeInterval+trackTotalTimeInterval;
//   
//    
//    
//   
//   
//    
// 
//    
//    return [self totalTimeStr:totalTimeInterval];
//    
//    
//    
//    
//    
//    
//    
//    
//    return [NSString stringWithFormat:@"%@",[self totalTimeStr:totalTimeInterval]];
//    
//   
//}


-(void ) calculateDirectlHours{


    self.directTotalWeek1TI=self.interventionTotalWeek1TI+self.assessmentTotalWeek1TI;
    self.directTotalWeek2TI=self.interventionTotalWeek2TI+self.assessmentTotalWeek2TI;
    self.directTotalWeek3TI=self.interventionTotalWeek3TI+self.assessmentTotalWeek3TI;
    self.directTotalWeek4TI=self.interventionTotalWeek4TI+self.assessmentTotalWeek4TI;
    self.directTotalWeek5TI=self.interventionTotalWeek5TI+self.assessmentTotalWeek5TI;
    self.directTotalWeekUndefinedTI=self.interventionTotalWeekUndefinedTI+self.assessmentTotalWeekUndefinedTI;
    self.directTotalForMonthTI=self.interventionTotalForMonthTI+self.assessmentTotalForMonthTI;
    self.directTotalCummulativeTI=self.interventionTotalCummulativeTI+self.assessmentTotalCummulativeTI;
    self.directTotalToDateTI=self.interventionTotalToDateTI+self.assessmentTotalToDateTI;
    

    self.directTotalWeek1Str=[self timeStrFromTimeInterval: self.directTotalWeek1TI]; 
    self.directTotalWeek2Str=[self timeStrFromTimeInterval: self.directTotalWeek2TI]; 
    self.directTotalWeek3Str=[self timeStrFromTimeInterval: self.directTotalWeek3TI]; 
    self.directTotalWeek4Str=[self timeStrFromTimeInterval: self.directTotalWeek4TI]; 
    self.directTotalWeek5Str=[self timeStrFromTimeInterval: self.directTotalWeek5TI]; 
    self.directTotalWeekUndefinedStr=[self timeStrFromTimeInterval: self.directTotalWeekUndefinedTI]; 
    self.directTotalForMonthStr =[self timeStrFromTimeInterval: self.directTotalForMonthTI]; 
    self.directTotalCummulativeStr=[self timeStrFromTimeInterval: self.directTotalCummulativeTI]; 
    self.directTotalToDateStr=[self timeStrFromTimeInterval: self.directTotalToDateTI]; 



}

-(NSTimeInterval ) totalOverallHoursTIForOveralCell:(PTSummaryCell)summaryCell clinician:(ClinicianEntity *)clinician{
    
    NSPredicate *trackPredicate=nil;
    NSPredicate *existingHoursPredicate=nil;
    
    switch (summaryCell) {
        case kSummaryWeekOne:
        {
            trackPredicate=[self predicateForTrackWeek:kTrackWeekOne];
            existingHoursPredicate=[self predicateForExistingHoursWeek:kTrackWeekOne];
        }
            break;
        case kSummaryWeekTwo:
        {
            trackPredicate=[self predicateForTrackWeek:kTrackWeekTwo];
            existingHoursPredicate=[self predicateForExistingHoursWeek:kTrackWeekTwo];
        }
            break;
        case kSummaryWeekThree:
        {
            trackPredicate=[self predicateForTrackWeek:kTrackWeekThree];
            existingHoursPredicate=[self predicateForExistingHoursWeek:kTrackWeekThree];
        }
            break;
        case kSummaryWeekFour:
        {
            trackPredicate=[self predicateForTrackWeek:kTrackWeekFour];
            existingHoursPredicate=[self predicateForExistingHoursWeek:kTrackWeekFour];
        }
            break;
        case kSummaryWeekFive:
        {
            trackPredicate=[self predicateForTrackWeek:kTrackWeekFive];
            existingHoursPredicate=[self predicateForExistingHoursWeek:kTrackWeekFive];
        }
            break;
        case kSummaryWeekUndefined:
        {
            
            existingHoursPredicate=[self predicateForExistingHoursWeekUndefined];
            DLog(@"ksummaryweekundefined ");
        }
            break;
        case kSummaryTotalForMonth:
        {
            trackPredicate=[self predicateForTrackCurrentMonth];
            existingHoursPredicate=[self predicateForExistingHoursCurrentMonth];
        }
            break;
        case kSummaryCummulative:
        {
             trackPredicate=[self priorMonthsHoursPredicate];
             existingHoursPredicate=[self predicateForExistingHoursAllBeforeEndDate:monthStartDate_ ];
        }
            break;
        case kSummaryTotalToDate:
        {
            trackPredicate=nil;
            existingHoursPredicate=nil;
        }
            break;
            
        default:
            break;
    }
    
    
    NSTimeInterval trackTotalInterventionTimeInterval=0;
    NSTimeInterval trackTotalAssessmentInterval=0;
    NSTimeInterval trackTotalSupportTimeInterval=0;
    NSTimeInterval trackTotalSupervisionReceivedTimeInterval=0;
    
     
  
    if (summaryCell!= kSummaryWeekUndefined) {
    
            trackTotalInterventionTimeInterval=[self totalTimeIntervalForTrackArray:self.interventionsDeliveredArray predicate:trackPredicate];
            
                
            
            trackTotalAssessmentInterval=[self totalTimeIntervalForTrackArray:self.assessmentsDeliveredArray predicate:trackPredicate];;
            
               
            trackTotalSupportTimeInterval=[self totalTimeIntervalForTrackArray:self.supportActivityDeliveredArray predicate:trackPredicate];
            
           
            
            trackTotalSupervisionReceivedTimeInterval=[self totalTimeIntervalForTrackArray:self.supervisionReceivedArray predicate:trackPredicate];
    
    }
    
    
    NSArray *filteredExistingHoursArray=nil;
   
       if (existingHoursPredicate &&existingHoursArray_ &&existingHoursArray_.count) {
        
           DLog(@"exsiting hours before filter %@",existingHoursArray_);
           filteredExistingHoursArray=[existingHoursArray_ filteredArrayUsingPredicate:existingHoursPredicate];
        DLog(@"filtered existing hours array  %@",filteredExistingHoursArray);

    }
    else {
        filteredExistingHoursArray=existingHoursArray_; //unfiltered
    }
     
   


    NSTimeInterval totalExistingInterventionsTI=[self totalTimeIntervalForExistingHoursArray:filteredExistingHoursArray keyPath:kTrackKeyPathForExistingHoursInterventionHours];
            
    NSTimeInterval totalExistingAssessmentsTI=[self totalTimeIntervalForExistingHoursArray:filteredExistingHoursArray keyPath:kTrackKeyPathForExistingHoursAssessmentHours];
    
    
    DLog(@"total for existing assessments array  %f",totalExistingAssessmentsTI);
    NSTimeInterval totalExistingSupportTI=[self totalTimeIntervalForExistingHoursArray:filteredExistingHoursArray keyPath:kTrackKeyPathForExistingHoursSupportActivityHours];
    
    
    NSTimeInterval totalExistingSupervisionReceivedTI=[self totalTimeIntervalForExistingHoursArray:filteredExistingHoursArray keyPath:kTrackKeyPathForExistingHoursSupervisionReceivedHours];
    
    NSTimeInterval overallTotalTI=0;
    
    switch (summaryCell) {
        case kSummaryWeekOne:
        {
            self.interventionTotalWeek1TI=trackTotalInterventionTimeInterval+totalExistingInterventionsTI;
            self.assessmentTotalWeek1TI=trackTotalAssessmentInterval+totalExistingAssessmentsTI;
            self.supportTotalWeek1TI=trackTotalSupportTimeInterval+totalExistingSupportTI;
            self.supervisionTotalWeek1TI=trackTotalSupervisionReceivedTimeInterval+totalExistingSupervisionReceivedTI;
            
            
            overallTotalTI =self.interventionTotalWeek1TI+self.assessmentTotalWeek1TI+self.supportTotalWeek1TI+self.supervisionTotalWeek1TI;
            
            self.interventionTotalWeek1Str=[self totalTimeStr:self.interventionTotalWeek1TI];
            self.assessmentTotalWeek1Str=[self totalTimeStr:self.assessmentTotalWeek1TI];
            self.supportTotalWeek1Str=[self totalTimeStr:self.supportTotalWeek1TI];
            self.supervisionTotalWeek1Str=[self totalTimeStr:self.supervisionTotalWeek1TI];
            self.overallTotalWeek1Str=[self totalTimeStr:overallTotalTI];
            

        }
            break;
        case kSummaryWeekTwo:
        {
            self.interventionTotalWeek2TI=trackTotalInterventionTimeInterval+totalExistingInterventionsTI;
            self.assessmentTotalWeek2TI=trackTotalAssessmentInterval+totalExistingAssessmentsTI;
            self.supportTotalWeek2TI=trackTotalSupportTimeInterval+totalExistingSupportTI;
            self.supervisionTotalWeek2TI=trackTotalSupervisionReceivedTimeInterval+totalExistingSupervisionReceivedTI;
            
            
            overallTotalTI =self.interventionTotalWeek2TI+self.assessmentTotalWeek2TI+self.supportTotalWeek2TI+self.supervisionTotalWeek2TI;
            
            self.interventionTotalWeek2Str=[self totalTimeStr:self.interventionTotalWeek2TI];
            self.assessmentTotalWeek2Str=[self totalTimeStr:self.assessmentTotalWeek2TI];
            self.supportTotalWeek2Str=[self totalTimeStr:self.supportTotalWeek2TI];
            self.supervisionTotalWeek2Str=[self totalTimeStr:self.supervisionTotalWeek2TI];
            self.overallTotalWeek2Str=[self totalTimeStr:overallTotalTI];
            
            
        }
            break;
        case kSummaryWeekThree:
        {
            self.interventionTotalWeek3TI=trackTotalInterventionTimeInterval+totalExistingInterventionsTI;
            self.assessmentTotalWeek3TI=trackTotalAssessmentInterval+totalExistingAssessmentsTI;
            self.supportTotalWeek3TI=trackTotalSupportTimeInterval+totalExistingSupportTI;
            self.supervisionTotalWeek3TI=trackTotalSupervisionReceivedTimeInterval+totalExistingSupervisionReceivedTI;
            
            
            overallTotalTI =self.interventionTotalWeek3TI+self.assessmentTotalWeek3TI+self.supportTotalWeek3TI+self.supervisionTotalWeek3TI;
            
            self.interventionTotalWeek3Str=[self totalTimeStr:self.interventionTotalWeek3TI];
            self.assessmentTotalWeek3Str=[self totalTimeStr:self.assessmentTotalWeek3TI];
            self.supportTotalWeek3Str=[self totalTimeStr:self.supportTotalWeek3TI];
            self.supervisionTotalWeek3Str=[self totalTimeStr:self.supervisionTotalWeek3TI];
            self.overallTotalWeek3Str=[self totalTimeStr:overallTotalTI];
        }
            break;
        case kSummaryWeekFour:
        {
            self.interventionTotalWeek4TI=trackTotalInterventionTimeInterval+totalExistingInterventionsTI;
            self.assessmentTotalWeek4TI=trackTotalAssessmentInterval+totalExistingAssessmentsTI;
            self.supportTotalWeek4TI=trackTotalSupportTimeInterval+totalExistingSupportTI;
            self.supervisionTotalWeek4TI=trackTotalSupervisionReceivedTimeInterval+totalExistingSupervisionReceivedTI;
            
            
            overallTotalTI =self.interventionTotalWeek4TI+self.assessmentTotalWeek4TI+self.supportTotalWeek4TI+self.supervisionTotalWeek4TI;

            self.interventionTotalWeek4Str=[self totalTimeStr:self.interventionTotalWeek4TI];
            self.assessmentTotalWeek4Str=[self totalTimeStr:self.assessmentTotalWeek4TI];
            self.supportTotalWeek4Str=[self totalTimeStr:self.supportTotalWeek4TI];
            self.supervisionTotalWeek4Str=[self totalTimeStr:self.supervisionTotalWeek4TI];
            self.overallTotalWeek4Str=[self totalTimeStr:overallTotalTI];
        }
            break;
        case kSummaryWeekFive:
        {
            self.interventionTotalWeek5TI=trackTotalInterventionTimeInterval+totalExistingInterventionsTI;
            self.assessmentTotalWeek5TI=trackTotalAssessmentInterval+totalExistingAssessmentsTI;
            self.supportTotalWeek5TI=trackTotalSupportTimeInterval+totalExistingSupportTI;
            self.supervisionTotalWeek5TI=trackTotalSupervisionReceivedTimeInterval+totalExistingSupervisionReceivedTI;
            
            
            overallTotalTI =self.interventionTotalWeek5TI+self.assessmentTotalWeek5TI+self.supportTotalWeek5TI+self.supervisionTotalWeek5TI;
            
            self.interventionTotalWeek5Str=[self totalTimeStr:self.interventionTotalWeek5TI];
            self.assessmentTotalWeek5Str=[self totalTimeStr:self.assessmentTotalWeek5TI];
            self.supportTotalWeek5Str=[self totalTimeStr:self.supportTotalWeek5TI];
            self.supervisionTotalWeek5Str=[self totalTimeStr:self.supervisionTotalWeek5TI];
            self.overallTotalWeek5Str=[self totalTimeStr:overallTotalTI];
            
        }
            break;
        case kSummaryWeekUndefined:
        {
            self.interventionTotalWeekUndefinedTI=totalExistingInterventionsTI;
            self.assessmentTotalWeekUndefinedTI=totalExistingAssessmentsTI;
            DLog(@"assessments time interval %f",self.assessmentTotalWeekUndefinedTI);
            
            self.supportTotalWeekUndefinedTI=totalExistingSupportTI;
            self.supervisionTotalWeekUndefinedTI=totalExistingSupervisionReceivedTI;
            
            
            overallTotalTI =self.interventionTotalWeekUndefinedTI+self.assessmentTotalWeekUndefinedTI+self.supportTotalWeekUndefinedTI+self.supervisionTotalWeekUndefinedTI;
            
            self.interventionTotalWeekUndefinedStr=[self totalTimeStr:self.interventionTotalWeekUndefinedTI];
            self.assessmentTotalWeekUndefinedStr=[self totalTimeStr:self.assessmentTotalWeekUndefinedTI];
            self.supportTotalWeekUndefinedStr=[self totalTimeStr:self.supportTotalWeekUndefinedTI];
            self.supervisionTotalWeekUndefinedStr=[self totalTimeStr:self.supervisionTotalWeekUndefinedTI];
            self.overallTotalWeekUndefinedStr=[self totalTimeStr:overallTotalTI];
            
        }
            break;
        case kSummaryTotalForMonth:
        {
            self.interventionTotalForMonthTI=trackTotalInterventionTimeInterval+totalExistingInterventionsTI;
            self.assessmentTotalForMonthTI=trackTotalAssessmentInterval+totalExistingAssessmentsTI;
            self.supportTotalForMonthTI=trackTotalSupportTimeInterval+totalExistingSupportTI;
            self.supervisionTotalForMonthTI=trackTotalSupervisionReceivedTimeInterval+totalExistingSupervisionReceivedTI;
            
            
            overallTotalTI =self.interventionTotalForMonthTI+self.assessmentTotalForMonthTI+self.supportTotalForMonthTI+self.supervisionTotalForMonthTI;
            
            self.interventionTotalForMonthStr=[self totalTimeStr:self.interventionTotalForMonthTI];
            self.assessmentTotalForMonthStr=[self totalTimeStr:self.assessmentTotalForMonthTI];
            self.supportTotalForMonthStr=[self totalTimeStr:self.supportTotalForMonthTI];
            self.supervisionTotalForMonthStr=[self totalTimeStr:self.supervisionTotalForMonthTI];
            self.overallTotalForMonthStr=[self totalTimeStr:overallTotalTI];
        }
            break;
        case kSummaryCummulative:
        {
            self.interventionTotalCummulativeTI=trackTotalInterventionTimeInterval+totalExistingInterventionsTI;
            self.assessmentTotalCummulativeTI=trackTotalAssessmentInterval+totalExistingAssessmentsTI;
            self.supportTotalCummulativeTI=trackTotalSupportTimeInterval+totalExistingSupportTI;
            self.supervisionTotalCummulativeTI=trackTotalSupervisionReceivedTimeInterval+totalExistingSupervisionReceivedTI;
            
            
           overallTotalTI =self.interventionTotalCummulativeTI+self.assessmentTotalCummulativeTI+self.supportTotalCummulativeTI+self.supervisionTotalCummulativeTI;
            
            self.interventionTotalCummulativeStr=[self totalTimeStr:self.interventionTotalCummulativeTI];
            self.assessmentTotalCummulativeStr=[self totalTimeStr:self.assessmentTotalCummulativeTI];
            self.supportTotalCummulativeStr=[self totalTimeStr:self.supportTotalCummulativeTI];
            self.supervisionTotalCummulativeStr=[self totalTimeStr:self.supervisionTotalCummulativeTI];
            self.overallTotalCummulativeStr=[self totalTimeStr:overallTotalTI];
            

        }
            break;
        case kSummaryTotalToDate:
        {
            self.interventionTotalToDateTI=trackTotalInterventionTimeInterval+totalExistingInterventionsTI;
            self.assessmentTotalToDateTI=trackTotalAssessmentInterval+totalExistingAssessmentsTI;
            self.supportTotalToDateTI=trackTotalSupportTimeInterval+totalExistingSupportTI;
            self.supervisionTotalToDateTI=trackTotalSupervisionReceivedTimeInterval+totalExistingSupervisionReceivedTI;
            
            
            overallTotalTI =self.interventionTotalToDateTI+self.assessmentTotalToDateTI+self.supportTotalToDateTI+self.supervisionTotalToDateTI;
            
            self.interventionTotalToDateStr=[self totalTimeStr:self.interventionTotalToDateTI];
            self.assessmentTotalToDateStr=[self totalTimeStr:self.assessmentTotalToDateTI];
            self.supportTotalToDateStr=[self totalTimeStr:self.supportTotalToDateTI];
            self.supervisionTotalToDateStr=[self totalTimeStr:self.supervisionTotalToDateTI];
            self.overallTotalToDateStr=[self totalTimeStr:overallTotalTI];
            


        }

            
        default:
            break;
    }
    
    
   
    return overallTotalTI;

}



-(NSString *)monthlyLogNotesForMonth:(PTrackEntity )ptrackEntityType{
    
    
    NSArray *trackDeliveredFilteredForCurrentMonth=nil;
    NSPredicate *trackPredicateForCurrentMonth=[self predicateForTrackCurrentMonth];
    NSString *returnString=nil;
   
    switch (ptrackEntityType) {
                    
            case kTrackAssessment:
            trackDeliveredFilteredForCurrentMonth=[self.assessmentsDeliveredArray filteredArrayUsingPredicate:trackPredicateForCurrentMonth];
            
            
            break;
            
            
        case kTrackSupport:
        
            trackDeliveredFilteredForCurrentMonth=[self.supportActivityDeliveredArray filteredArrayUsingPredicate:trackPredicateForCurrentMonth];
            
            
                     
            break;
            

            
        default:
            break;
    }
    
 NSArray *filteredExistingHoursArray=nil;
    if (self.existingHoursHoursArray &&self.existingHoursHoursArray.count) {
        filteredExistingHoursArray=[self.existingHoursHoursArray filteredArrayUsingPredicate:[self predicateForExistingHoursCurrentMonth]];
    }
    
    
    
    if (trackDeliveredFilteredForCurrentMonth) {
        
        int trackDeliveredFilteredForCurrentMonthCount=trackDeliveredFilteredForCurrentMonth.count;
        if (trackDeliveredFilteredForCurrentMonthCount) {
            
            NSArray *monthlyLogNotesArray=[trackDeliveredFilteredForCurrentMonth mutableArrayValueForKey:@"monthlyLogNotes"];
            
            int monthlyLogNotesArrayCount=monthlyLogNotesArray.count;
            for ( int i=0;i< monthlyLogNotesArrayCount; i++){
                
                
                id logNotesID=[monthlyLogNotesArray objectAtIndex:i];
                
                
                if ([logNotesID isKindOfClass:[NSString class]]) {
                    NSString *logNotesStr=(NSString *)logNotesID;
                    if (i==0) {
                        returnString=logNotesStr;
                    }
                    else {
                        returnString=[returnString stringByAppendingFormat:@"; %@",logNotesStr];
                    }
                }
            }
            
        }
    }
    
        
        int filteredExistingHoursArrayCount=filteredExistingHoursArray.count;
        if (filteredExistingHoursArrayCount) {
           
            NSArray *existingTypeArray=nil;
            
            NSSet *existingTypeSet=nil;
            switch (ptrackEntityType) {
               
                case kTrackAssessment:
                    
                {
                   
                    if (filteredExistingHoursArray&&filteredExistingHoursArray.count) {
                        existingTypeSet=[filteredExistingHoursArray mutableSetValueForKeyPath:@"assessments.monthlyLogNotes"];
                    }
                    
                    
                }
                    break;
                    
                case kTrackSupport:
                {
                    if (filteredExistingHoursArray &&filteredExistingHoursArray.count) {
                        existingTypeSet=[filteredExistingHoursArray mutableSetValueForKeyPath:@"supportActivities.monthlyLogNotes"];
                        
                    }
                   
                }
                    break;
                
                
                
                    
                default:
                    break;
            }
           
            
            existingTypeArray=existingTypeSet.allObjects;
        
            NSString *logNotesStr=nil;
            for ( id logNotesID in existingTypeArray){
                
                
               
                NSMutableArray  *filteredLogNotesMutableArray=nil;
                
                if ([logNotesID isKindOfClass:[NSString class]]) {
                    logNotesStr=(NSString *) logNotesID;
                }
                else if ([logNotesID isKindOfClass:[NSSet class]] )
                {
                    NSSet *logNotesSet=(NSSet *)logNotesID;
                                       NSArray *logNotesArray=logNotesSet.allObjects;
                    
                    for (int i=0;i<logNotesArray.count ; i++) {
                        NSString *logNoteInLogNotesArray=[logNotesArray objectAtIndex:i];
                       
                        if (logNoteInLogNotesArray &&[logNoteInLogNotesArray isKindOfClass:[NSString class]] &&logNoteInLogNotesArray.length) {
                            
//                            BOOL shouldAddToArray=NO;
                            
                            if (![filteredLogNotesMutableArray containsObject:logNoteInLogNotesArray]) {
                                [filteredLogNotesMutableArray addObject:logNoteInLogNotesArray];
                           
                            
                            
                                if (!logNotesStr ||!logNotesStr.length) {
                                    logNotesStr=logNoteInLogNotesArray;
                                }
                                else {
                                    logNotesStr=[NSString stringWithFormat:@"%@; %@",logNotesStr,logNoteInLogNotesArray];
                                }
                             }
                        }
                        
                    }
                }

                if (!returnString ||!returnString.length) {
                    returnString=logNotesStr;
                    
                }
                else {
                
                    if ([logNotesStr isKindOfClass:[NSString class]]) {
                        returnString=[returnString stringByAppendingFormat:@"; %@",logNotesStr];
                    }
                    
                }
                
               
                
                
            }
            
        }
    

    if (returnString && ![returnString isKindOfClass:[NSString class]]) {
        
        returnString=[NSString string];
        
    }
    
    return returnString;
    
    
}



@end
