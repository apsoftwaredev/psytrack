/*
 *  TrackTypeWithTotalTimes.m
 *  psyTrack
 *  Version: 1.0
 *
 *
 *	THIS SOURCE CODE AND ANY ACCOMPANYING DOCUMENTATION ARE PROTECTED BY UNITED STATES 
 *	INTELLECTUAL PROPERTY LAW AND INTERNATIONAL TREATIES. UNAUTHORIZED REPRODUCTION OR 
 *	DISTRIBUTION IS SUBJECT TO CIVIL AND CRIMINAL PENALTIES. 
 *
 *  Created by Daniel Boice on 7/10/12.
 *  Copyright (c) 2011 PsycheWeb LLC. All rights reserved.
 *
 *
 *	This notice may not be removed from this file.
 *
 */


#import "TrackTypeWithTotalTimes.h"
#import "InterventionTypeEntity.h"
#import "InterventionTypeSubtypeEntity.h"
#import "AssessmentTypeEntity.h"
#import "SupportActivityTypeEntity.h"
#import "SupervisionTypeEntity.h"
#import "SupervisionTypeSubtypeEntity.h"
#import "PTTAppDelegate.h"
#import "ExistingHoursEntity.h"
#import "ExistingInterventionEntity.h"
#import "ExistingAssessmentEntity.h"
#import "ExistingSupportActivityEntity.h"
#import "ExistingSupervisionReceivedEntity.h"

@implementation TrackTypeWithTotalTimes

@synthesize trackTypeObject;
@synthesize trackType=trackType_;
@synthesize trackPathStartString=trackPathStartString_;

@synthesize typeLabelText;

@synthesize totalWeek1Str;
@synthesize totalWeek2Str;
@synthesize totalWeek3Str;
@synthesize totalWeek4Str;
@synthesize totalWeek5Str;

@synthesize totalWeek1TI;
@synthesize totalWeek2TI;
@synthesize totalWeek3TI;
@synthesize totalWeek4TI;
@synthesize totalWeek5TI;


@synthesize totalWeekUndefinedStr;
@synthesize totalWeekUndefinedTI;

@synthesize totalForMonthStr;
@synthesize totalForMonthTI;

@synthesize totalCummulativeStr;
@synthesize totalCummulativeTI;

@synthesize totalToDateStr;
@synthesize totalToDateTI;
@synthesize monthlyLogNotes=monthlyLogNotes_;



-(id)initWithMonth:(NSDate *)date clinician:(ClinicianEntity *)clinician trackTypeObject:(id)trackTypeObjectGiven trainingProgram:(TrainingProgramEntity *)trainingProgramGiven{
    //override superclass
    self= [super initWithMonth:date clinician:clinician trainingProgram:trainingProgramGiven];
    
    if (self) {
        
        
        DLog(@"date is %@",date);
        
        
        self.clinician=clinician;
       self.trackType=[self trackTypeForObjectGiven:trackTypeObjectGiven];
        
        NSPredicate *predicateForTrackEntities=[self predicateForTrackEntitiesAllBeforeAndEqualToEndDateForMonth];
        
        NSPredicate * predicateForExistingHoursEntities=[self predicateForExistingHoursAllBeforeAndEqualToEndDateForMonth];
        
        
               
        NSPredicate *predicateForTrackTrainingProgram=[self predicateForTrackTrainingProgram];
        NSPredicate *predicateForExistingHoursProgramCourse=[self predicateForExistingHoursProgramCourse];
        

        self.trackTypeObject=trackTypeObjectGiven;
         NSMutableArray *existingHoursMutableArray=[NSMutableArray array];
       
        switch (trackType_) {
            case kTrackTypeIntervention:
            {
                if ([trackTypeObjectGiven isKindOfClass:[InterventionTypeEntity class]]) {
                    InterventionTypeEntity *interventionType=(InterventionTypeEntity *)trackTypeObjectGiven;
                    
                    self.typeLabelText=interventionType.interventionType;
                    NSArray *allInterventionsDeliveredForType=nil;
                    if (interventionType.interventionsDelivered) {
                        
                        allInterventionsDeliveredForType=interventionType.interventionsDelivered.allObjects;
                    }
                    if (allInterventionsDeliveredForType&&allInterventionsDeliveredForType.count &&predicateForTrackEntities) {
                        
                        NSArray *tempInterventionsDeliveredArray=[allInterventionsDeliveredForType filteredArrayUsingPredicate:predicateForTrackEntities];

                        if (tempInterventionsDeliveredArray &&tempInterventionsDeliveredArray.count) {
                            self.interventionsDeliveredArray= [tempInterventionsDeliveredArray filteredArrayUsingPredicate:predicateForTrackTrainingProgram];
                        }
                                               
                        
                    }
                    
                   
                    NSArray *allExistingInterventionsArrayForType=nil;
                    if (interventionType.existingInterventions) {
                        allExistingInterventionsArrayForType=interventionType.existingInterventions.allObjects;
                    }
                    
                    
                   
                    
                    for (ExistingInterventionEntity *existingInterventionObject in allExistingInterventionsArrayForType) {
                        if (existingInterventionObject.existingHours &&[existingInterventionObject.existingHours isKindOfClass:[ExistingHoursEntity class]]) {
                            ExistingHoursEntity *existingHoursObject =( ExistingHoursEntity*)existingInterventionObject.existingHours;
                            
                            [existingHoursMutableArray addObject:existingHoursObject];
                        }
                    }
                    
                  
                    
                    
                    
                   
                    
                  
                    
                }
                

            
            
            }
                break;
            case kTrackTypeInterventionSubType:
            {
                if ([trackTypeObjectGiven isKindOfClass:[InterventionTypeSubtypeEntity class]]) {
                    
                    InterventionTypeSubtypeEntity *interventionSubType=(InterventionTypeSubtypeEntity *)trackTypeObjectGiven;
                    
                    self.typeLabelText=interventionSubType.interventionSubType;
                    
                    
                    NSArray *allInterventionsDeliveredForSubType=nil;
                    if (interventionSubType.interventionsDelivered) {
                        allInterventionsDeliveredForSubType= interventionSubType.interventionsDelivered.allObjects;
                    }
                    
                    
                    
                    if (allInterventionsDeliveredForSubType &&allInterventionsDeliveredForSubType.count &&predicateForTrackEntities) {
                        
                        
                        NSArray *tempInterventionsDeliveredArray=[allInterventionsDeliveredForSubType filteredArrayUsingPredicate:predicateForTrackEntities];
                        
                        if (tempInterventionsDeliveredArray &&tempInterventionsDeliveredArray.count) {
                            self.interventionsDeliveredArray= [tempInterventionsDeliveredArray filteredArrayUsingPredicate:predicateForTrackTrainingProgram];
                        }

                        
                        
                    }
                    
                    
                    NSArray *allExistingInterventionsArrayForSubType=nil;
                    if (interventionSubType.existingInterventions) {
                        allExistingInterventionsArrayForSubType=interventionSubType.existingInterventions.allObjects;
                    }
                    
                    
                   
                    
                    for (ExistingInterventionEntity *existingInterventionObject in allExistingInterventionsArrayForSubType) {
                        if (existingInterventionObject.existingHours &&[existingInterventionObject.existingHours isKindOfClass:[ExistingHoursEntity class]]) {
                            ExistingHoursEntity *existingHoursObject =( ExistingHoursEntity*)existingInterventionObject.existingHours;
                            
                            [existingHoursMutableArray addObject:existingHoursObject];
                        }
                    }
                    
                    
                    
                   
                                   }

                
                
            }
                break;
            case kTrackTypeAssessment:
            {
                if ([trackTypeObjectGiven isKindOfClass:[AssessmentTypeEntity class]]) {
                    AssessmentTypeEntity *assessmentType=(AssessmentTypeEntity *)trackTypeObjectGiven;
                    
                    self.typeLabelText=assessmentType.assessmentType;
                    
                    NSArray *allAssessemntsDeliveredForType=nil;
                    if (assessmentType.assessments) {
                        allAssessemntsDeliveredForType=assessmentType.assessments.allObjects;
                    }
                    
                    
                    
                    if (allAssessemntsDeliveredForType&&allAssessemntsDeliveredForType.count  &&predicateForTrackEntities) {
                        
                        
                        
                        NSArray *tempAssessmentsDeliveredArray=[allAssessemntsDeliveredForType filteredArrayUsingPredicate:predicateForTrackEntities];
                        
                        if (tempAssessmentsDeliveredArray &&tempAssessmentsDeliveredArray.count) {
                            self.assessmentsDeliveredArray= [tempAssessmentsDeliveredArray filteredArrayUsingPredicate:predicateForTrackTrainingProgram];
                        }

                        
                        
                    }
                                       
                    NSArray *allExistingAssessmentsArrayForType=nil;
                    
                    if (assessmentType.existingAssessments) {
                        allExistingAssessmentsArrayForType=assessmentType.existingAssessments.allObjects;
                    }
                    
                    
                    
                 
                    
                    for (ExistingAssessmentEntity *existingAssessmentObject in allExistingAssessmentsArrayForType) {
                        if (existingAssessmentObject.existingHours &&[existingAssessmentObject.existingHours isKindOfClass:[ExistingHoursEntity class]]) {
                            ExistingHoursEntity *existingHoursObject =( ExistingHoursEntity*)existingAssessmentObject.existingHours;
                           
                            [existingHoursMutableArray addObject:existingHoursObject];
                        }
                    }
                    
                   

                    
                   
                    
                }

                
                
            }
                break;
            case kTrackTypeSupport:
            {
                
                if ([trackTypeObjectGiven isKindOfClass:[SupportActivityTypeEntity class]]) {
                    SupportActivityTypeEntity *supportActivityType=(SupportActivityTypeEntity *)trackTypeObjectGiven;
                    
                    self.typeLabelText=supportActivityType.supportActivityType;
                    
                    NSArray *allSupportActivitiesDeliveredForType=nil;
                    if (supportActivityType.supportActivitiesDelivered) {
                        allSupportActivitiesDeliveredForType=supportActivityType.supportActivitiesDelivered.allObjects;
                    }
                    
                    
                    
                    
                    if (allSupportActivitiesDeliveredForType&&allSupportActivitiesDeliveredForType.count  &&predicateForTrackEntities) {
                        
                        
                        NSArray *tempSupportActivitiesDeliveredArray=[allSupportActivitiesDeliveredForType filteredArrayUsingPredicate:predicateForTrackEntities];
                        
                        if (tempSupportActivitiesDeliveredArray &&tempSupportActivitiesDeliveredArray.count) {
                            self.supportActivityDeliveredArray= [tempSupportActivitiesDeliveredArray filteredArrayUsingPredicate:predicateForTrackTrainingProgram];
                        }

                        
                    }
                    
                    
                    NSArray *allExistingSupportActivitiesArrayForType=nil;
                    
                    if (supportActivityType.existingSupportActivities) {
                        allExistingSupportActivitiesArrayForType=supportActivityType.existingSupportActivities.allObjects;
                        
                    }
                    
                    
                   
                    
                    for (ExistingAssessmentEntity *existingSupportActivityObject in allExistingSupportActivitiesArrayForType) {
                        if (existingSupportActivityObject.existingHours &&[existingSupportActivityObject.existingHours isKindOfClass:[ExistingHoursEntity class]]) {
                            ExistingHoursEntity *existingHoursObject =( ExistingHoursEntity*)existingSupportActivityObject.existingHours;
                            
                            [existingHoursMutableArray addObject:existingHoursObject];
                        }
                    }
                    
                   
                    
                   
                   
                }

                
                
            }
                break;
            case kTrackTypeSupervision:
            {
                if ([trackTypeObjectGiven isKindOfClass:[SupervisionTypeEntity class]]) {
                    SupervisionTypeEntity *supervisionType=(SupervisionTypeEntity *)trackTypeObjectGiven;
                    
                    self.typeLabelText=supervisionType.supervisionType;
                    
                    NSArray *allSupervisionReceivedForType=nil;
                    if (supervisionType.supervisionRecieved) {
                        allSupervisionReceivedForType=supervisionType.supervisionRecieved.allObjects;
                    }
                    
                    
                    
                    if (allSupervisionReceivedForType &&allSupervisionReceivedForType.count  &&predicateForTrackEntities) {
                   
                        NSArray *tempSupervisionDeliveredArray=[allSupervisionReceivedForType filteredArrayUsingPredicate:predicateForTrackEntities];
                        
                        if (tempSupervisionDeliveredArray &&tempSupervisionDeliveredArray.count) {
                            self.supervisionReceivedArray= [tempSupervisionDeliveredArray filteredArrayUsingPredicate:predicateForTrackTrainingProgram];
                        }
                        
                        
                    }
                    
                    
                    
                    
                    NSArray *allExistingSupervisionReceivedArrayForType=nil;
                    if (supervisionType.existingSupervision) {
                        allExistingSupervisionReceivedArrayForType=supervisionType.existingSupervision.allObjects;
                    }
                    
                   
                    
                    for (ExistingAssessmentEntity *existingSupervisionReceivedObject in allExistingSupervisionReceivedArrayForType) {
                        if (existingSupervisionReceivedObject.existingHours &&[existingSupervisionReceivedObject.existingHours isKindOfClass:[ExistingHoursEntity class]]) {
                            ExistingHoursEntity *existingHoursObject =( ExistingHoursEntity*)existingSupervisionReceivedObject.existingHours;
                            [existingHoursMutableArray addObject:existingHoursObject];
                        }
                    }
                    
                                       
                   
                    
                    
                }

                
                
            }
                break;
            case kTrackTypeSupervisionSubType:
            {
                
                
                if ([trackTypeObjectGiven isKindOfClass:[SupervisionTypeSubtypeEntity class]]) {
                    SupervisionTypeSubtypeEntity *supervisionSubType=(SupervisionTypeSubtypeEntity *)trackTypeObjectGiven;
                    
                    self.typeLabelText=supervisionSubType.subType;
                    
                    
                    NSArray *allSupervisionReceivedForSubType=nil;
                    if (supervisionSubType.supervisionReceived) {
                        allSupervisionReceivedForSubType =supervisionSubType.supervisionReceived.allObjects;
                    }
                    
                    
                    
                    
                    
                    if (allSupervisionReceivedForSubType &&allSupervisionReceivedForSubType.count  &&predicateForTrackEntities) {
                                                
                        NSArray *tempSupervisionDeliveredArray=[allSupervisionReceivedForSubType filteredArrayUsingPredicate:predicateForTrackEntities];
                        
                        if (tempSupervisionDeliveredArray &&tempSupervisionDeliveredArray.count) {
                            self.supervisionReceivedArray= [tempSupervisionDeliveredArray filteredArrayUsingPredicate:predicateForTrackTrainingProgram];
                        }

                        
                        
                    }
                    
                    
                    
                    NSArray *allExistingSupervisionReceivedArrayForSubType=nil;
                    
                    if (supervisionSubType.existingSupervision) {
                        allExistingSupervisionReceivedArrayForSubType=supervisionSubType.existingSupervision.allObjects;
                        
                    }
                    
                    
                   
                    
                    for (ExistingAssessmentEntity *existingSupervisionReceivedObject in allExistingSupervisionReceivedArrayForSubType) {
                        if (existingSupervisionReceivedObject.existingHours &&[existingSupervisionReceivedObject.existingHours isKindOfClass:[ExistingHoursEntity class]]) {
                            ExistingHoursEntity *existingHoursObject =( ExistingHoursEntity*)existingSupervisionReceivedObject.existingHours;
                           
                            [existingHoursMutableArray addObject:existingHoursObject];
                        }
                    }
                    
                   

                    
                    
                    
                }

                
            }
                break;
            case kTrackTypeUnknown:
            {
                PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
                

                [appDelegate displayNotification:@"Track type object class was not identified"];
                
            }
                break;
                
            default:
                break;
        }
        
                           
            
       
        if (existingHoursMutableArray&&existingHoursMutableArray.count  && predicateForExistingHoursEntities) {
            
            NSArray *tempExistingHoursArray=[existingHoursMutableArray filteredArrayUsingPredicate:predicateForExistingHoursEntities];
            
            if (tempExistingHoursArray &&tempExistingHoursArray.count && predicateForExistingHoursProgramCourse) {
                self.existingHoursHoursArray=[tempExistingHoursArray filteredArrayUsingPredicate:predicateForExistingHoursProgramCourse];
            }
            
        }
        
        self.monthlyLogNotes=[self monthlyLogNotesForMonth];
                             
        if (trackType_== kTrackTypeIntervention ||trackType_==kTrackTypeSupervision) {
             [ self  totalOverallHoursTIForOveralCell:(PTSummaryCell)kSummaryTotalToDate clinician:(ClinicianEntity *)clinician];
        }
        else if (trackType_!=kTrackTypeUnknown){
            for (NSInteger i=0; i<9; i++) {
                [ self  totalOverallHoursTIForOveralCell:(PTSummaryCell)i clinician:(ClinicianEntity *)clinician];
            }   
        }
        
                   
                
                        
                  
        
    }
    
   
    
    
    
    return self;
    
    
}
-(PTrackType)trackTypeForObjectGiven:(id)trackTypeObjectGiven{


    PTrackType trackTypeToReturn=kTrackTypeUnknown;
   

    if ([trackTypeObjectGiven isKindOfClass:[InterventionTypeEntity class]]) {

    
        return  kTrackTypeIntervention;
        
    }

    if ([trackTypeObjectGiven isKindOfClass:[InterventionTypeSubtypeEntity class]]) {

       
       return  kTrackTypeInterventionSubType;

    }


    if ([trackTypeObjectGiven isKindOfClass:[AssessmentTypeEntity class]]) {

        
        return  kTrackTypeAssessment;

    }

    if ([trackTypeObjectGiven isKindOfClass:[SupportActivityTypeEntity class]]) {

        return kTrackTypeSupport;

    }


    if ([trackTypeObjectGiven isKindOfClass:[SupervisionTypeEntity class]]) {

        
       return  kTrackTypeSupervision;

    }


    if ([trackTypeObjectGiven isKindOfClass:[SupervisionTypeSubtypeEntity class]]) {

       
       return   kTrackTypeSupervisionSubType;

    }
    
  
    return trackTypeToReturn;

}

-(void ) totalOverallHoursTIForOveralCell:(PTSummaryCell)summaryCell clinician:(ClinicianEntity *)clinician{
    
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
            existingHoursPredicate=[self predicateForExistingHoursAllBeforeEndDate:monthStartDate_];
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
    
    NSTimeInterval totalExistingInterventionsTI=0;
    NSTimeInterval totalExistingAssessmentsTI=0;
    NSTimeInterval totalExistingSupportTI=0;
    NSTimeInterval totalExistingSupervisionReceivedTI=0;
    
    NSArray *filteredExistingHoursArray=nil;
    
    if (existingHoursPredicate && existingHoursArray_ && existingHoursArray_.count) {
        filteredExistingHoursArray=[existingHoursArray_ filteredArrayUsingPredicate:existingHoursPredicate];
              
    }
    else {
        filteredExistingHoursArray=existingHoursArray_; //unfiltered
    }


   
        
        switch (trackType_) {
            case kTrackTypeIntervention:
                if (summaryCell!=kTrackWeekUndefined)  
                    trackTotalInterventionTimeInterval=[self totalTimeIntervalForTrackArray:self.interventionsDeliveredArray predicate:trackPredicate];
                
                totalExistingInterventionsTI=[self totalTimeIntervalForExistingHoursArray:filteredExistingHoursArray keyPath:kTrackKeyPathForExistingHoursInterventionHours];
                break;
           
            case kTrackTypeInterventionSubType:
                if (summaryCell!=kTrackWeekUndefined) 
                    trackTotalInterventionTimeInterval=[self totalTimeIntervalForTrackArray:self.interventionsDeliveredArray predicate:trackPredicate];
               
                totalExistingInterventionsTI=[self totalTimeIntervalForExistingHoursArray:filteredExistingHoursArray keyPath:kTrackKeyPathForExistingHoursInterventionHours];
                break;

            
            case kTrackTypeAssessment:
                
                if (summaryCell!=kTrackWeekUndefined) 
                    trackTotalAssessmentInterval=[self totalTimeIntervalForTrackArray:self.assessmentsDeliveredArray predicate:trackPredicate];
               
               
                totalExistingAssessmentsTI=[self totalTimeIntervalForExistingHoursArray:filteredExistingHoursArray keyPath:kTrackKeyPathForExistingHoursAssessmentHours];
                
                break;
            case kTrackTypeSupport:
                
                if (summaryCell!=kTrackWeekUndefined) 
                    trackTotalSupportTimeInterval=[self totalTimeIntervalForTrackArray:self.supportActivityDeliveredArray predicate:trackPredicate];
                
                totalExistingSupportTI=[self totalTimeIntervalForExistingHoursArray:filteredExistingHoursArray keyPath:kTrackKeyPathForExistingHoursSupportActivityHours];
                
                break;
                
            case kTrackTypeSupervision:
                
                if (summaryCell!=kTrackWeekUndefined) 
                    trackTotalSupervisionReceivedTimeInterval=[self totalTimeIntervalForTrackArray:self.supervisionReceivedArray predicate:trackPredicate];
                 
                totalExistingSupervisionReceivedTI=[self totalTimeIntervalForExistingHoursArray:filteredExistingHoursArray keyPath:kTrackKeyPathForExistingHoursSupervisionReceivedHours];
                break;
                

            case kTrackTypeSupervisionSubType:
                
                if (summaryCell!=kTrackWeekUndefined) 
                    trackTotalSupervisionReceivedTimeInterval=[self totalTimeIntervalForTrackArray:self.supervisionReceivedArray predicate:trackPredicate];
                
                totalExistingSupervisionReceivedTI=[self totalTimeIntervalForExistingHoursArray:filteredExistingHoursArray keyPath:kTrackKeyPathForExistingHoursSupervisionReceivedHours];
                break;


            default:
                break;
        }

   
        
 
    
       
     
    
//    NSTimeInterval overallTotalTI=0;
    
    switch (summaryCell) {
        case kSummaryWeekOne:
        {
            if (trackType_==kTrackTypeIntervention||trackType_==kTrackTypeInterventionSubType) {
                self.totalWeek1TI=trackTotalInterventionTimeInterval+totalExistingInterventionsTI;
                
            }
            if (trackType_==kTrackTypeAssessment) {
                self.totalWeek1TI=trackTotalAssessmentInterval+totalExistingAssessmentsTI;
            }
            if (trackType_==kTrackTypeSupport) {
                self.totalWeek1TI=trackTotalSupportTimeInterval+totalExistingSupportTI;
            }
            if (trackType_==kTrackTypeSupervision||trackType_==kTrackTypeSupervisionSubType) {
                self.totalWeek1TI=trackTotalSupervisionReceivedTimeInterval+totalExistingSupervisionReceivedTI;
            }
            
            
            self.totalWeek1Str=[self totalTimeStr:self.totalWeek1TI];
            
            
            
            
        }
            break;
        case kSummaryWeekTwo:
        {
            if (trackType_==kTrackTypeIntervention||trackType_==kTrackTypeInterventionSubType) {
                self.totalWeek2TI=trackTotalInterventionTimeInterval+totalExistingInterventionsTI;
            }
            if (trackType_==kTrackTypeAssessment) {
               
                self.totalWeek2TI=trackTotalAssessmentInterval+totalExistingAssessmentsTI;
            }
            if (trackType_==kTrackTypeSupport) {
                self.totalWeek2TI=trackTotalSupportTimeInterval+totalExistingSupportTI;
            }
            if (trackType_==kTrackTypeSupervision||trackType_==kTrackTypeSupervisionSubType) {
                self.totalWeek2TI=trackTotalSupervisionReceivedTimeInterval+totalExistingSupervisionReceivedTI;
            }
            
            
            self.totalWeek2Str=[self totalTimeStr:self.totalWeek2TI];
            
            
            
        }
            break;
        case kSummaryWeekThree:
        {
            if (trackType_==kTrackTypeIntervention||trackType_==kTrackTypeInterventionSubType) {
                self.totalWeek3TI=trackTotalInterventionTimeInterval+totalExistingInterventionsTI;
            }
            if (trackType_==kTrackTypeAssessment) {
                self.totalWeek3TI=trackTotalAssessmentInterval+totalExistingAssessmentsTI;
            }
            if (trackType_==kTrackTypeSupport) {
                self.totalWeek3TI=trackTotalSupportTimeInterval+totalExistingSupportTI;
            }
            if (trackType_==kTrackTypeSupervision||trackType_==kTrackTypeSupervisionSubType) {
                self.totalWeek3TI=trackTotalSupervisionReceivedTimeInterval+totalExistingSupervisionReceivedTI;
            }
            
            
            self.totalWeek3Str=[self totalTimeStr:self.totalWeek3TI];
            
            

            
            
        }
            break;
        case kSummaryWeekFour:
        {
            if (trackType_==kTrackTypeIntervention||trackType_==kTrackTypeInterventionSubType) {
                self.totalWeek4TI=trackTotalInterventionTimeInterval+totalExistingInterventionsTI;
            }
            if (trackType_==kTrackTypeAssessment) {
                self.totalWeek4TI=trackTotalAssessmentInterval+totalExistingAssessmentsTI;
            }
            if (trackType_==kTrackTypeSupport) {
                self.totalWeek4TI=trackTotalSupportTimeInterval+totalExistingSupportTI;
            }
            if (trackType_==kTrackTypeSupervision||trackType_==kTrackTypeSupervisionSubType) {
                self.totalWeek4TI=trackTotalSupervisionReceivedTimeInterval+totalExistingSupervisionReceivedTI;
            }
            
            
            self.totalWeek4Str=[self totalTimeStr:self.totalWeek4TI];
            
            

        }
            break;
        case kSummaryWeekFive:
        {
            if (trackType_==kTrackTypeIntervention||trackType_==kTrackTypeInterventionSubType) {
                self.totalWeek5TI=trackTotalInterventionTimeInterval+totalExistingInterventionsTI;
            }
            if (trackType_==kTrackTypeAssessment) {
                self.totalWeek5TI=trackTotalAssessmentInterval+totalExistingAssessmentsTI;
            }
            if (trackType_==kTrackTypeSupport) {
                self.totalWeek5TI=trackTotalSupportTimeInterval+totalExistingSupportTI;
            }
            if (trackType_==kTrackTypeSupervision||trackType_==kTrackTypeSupervisionSubType) {
                self.totalWeek5TI=trackTotalSupervisionReceivedTimeInterval+totalExistingSupervisionReceivedTI;
            }
            
            
            self.totalWeek5Str=[self totalTimeStr:self.totalWeek5TI];
            
            

            
        }
            break;
        case kSummaryWeekUndefined:
        {
            if (trackType_==kTrackTypeIntervention||trackType_==kTrackTypeInterventionSubType) {
                self.totalWeekUndefinedTI=trackTotalInterventionTimeInterval+totalExistingInterventionsTI;
            }
            if (trackType_==kTrackTypeAssessment) {
                self.totalWeekUndefinedTI=trackTotalAssessmentInterval+totalExistingAssessmentsTI;
            }
            if (trackType_==kTrackTypeSupport) {
                self.totalWeekUndefinedTI=trackTotalSupportTimeInterval+totalExistingSupportTI;
            }
            if (trackType_==kTrackTypeSupervision||trackType_==kTrackTypeSupervisionSubType) {
                self.totalWeekUndefinedTI=trackTotalSupervisionReceivedTimeInterval+totalExistingSupervisionReceivedTI;
            }
            
            
            self.totalWeekUndefinedStr=[self totalTimeStr:self.totalWeekUndefinedTI];
            
            

            
        }
            break;
        case kSummaryTotalForMonth:
        {
            if (trackType_==kTrackTypeIntervention||trackType_==kTrackTypeInterventionSubType) {
                self.totalForMonthTI=trackTotalInterventionTimeInterval+totalExistingInterventionsTI;
            }
            if (trackType_==kTrackTypeAssessment) {
                self.totalForMonthTI=trackTotalAssessmentInterval+totalExistingAssessmentsTI;
            }
            if (trackType_==kTrackTypeSupport) {
                self.totalForMonthTI=trackTotalSupportTimeInterval+totalExistingSupportTI;
            }
            if (trackType_==kTrackTypeSupervision||trackType_==kTrackTypeSupervisionSubType) {
                self.totalForMonthTI=trackTotalSupervisionReceivedTimeInterval+totalExistingSupervisionReceivedTI;
            }
            
            
            self.totalForMonthStr=[self totalTimeStr:self.totalForMonthTI];
            
            
        }
            break;
        case kSummaryCummulative:
        {
            if (trackType_==kTrackTypeIntervention||trackType_==kTrackTypeInterventionSubType) {
                self.totalCummulativeTI=trackTotalInterventionTimeInterval+totalExistingInterventionsTI;
            }
            if (trackType_==kTrackTypeAssessment) {
                self.totalCummulativeTI=trackTotalAssessmentInterval+totalExistingAssessmentsTI;
            }
            if (trackType_==kTrackTypeSupport) {
                self.totalCummulativeTI=trackTotalSupportTimeInterval+totalExistingSupportTI;
            }
            if (trackType_==kTrackTypeSupervision||trackType_==kTrackTypeSupervisionSubType) {
                self.totalCummulativeTI=trackTotalSupervisionReceivedTimeInterval+totalExistingSupervisionReceivedTI;
            }
            
            
            self.totalCummulativeStr=[self totalTimeStr:self.totalCummulativeTI];
            
            

            
            
        }
            break;
        case kSummaryTotalToDate:
        {
            if (trackType_==kTrackTypeIntervention||trackType_==kTrackTypeInterventionSubType) {
                self.totalToDateTI=trackTotalInterventionTimeInterval+totalExistingInterventionsTI;
            }
            if (trackType_==kTrackTypeAssessment) {
                self.totalToDateTI=trackTotalAssessmentInterval+totalExistingAssessmentsTI;
            }
            if (trackType_==kTrackTypeSupport) {
                self.totalToDateTI=trackTotalSupportTimeInterval+totalExistingSupportTI;
            }
            if (trackType_==kTrackTypeSupervision||trackType_==kTrackTypeSupervisionSubType) {
                self.totalToDateTI=trackTotalSupervisionReceivedTimeInterval+totalExistingSupervisionReceivedTI;
            }
            
            
            self.totalToDateStr=[self totalTimeStr:self.totalToDateTI];
            
            
            
            
        }
            
            
        default:
            break;
    }
    
    
    
    
    
}

-(NSString *)monthlyLogNotesForMonth{
    
    
    NSArray *trackDeliveredFilteredForCurrentMonth=nil;
    NSPredicate *trackPredicateForCurrentMonth=[self predicateForTrackCurrentMonth];
    NSString *returnString=nil;
    switch (trackType_) {
        case kTrackTypeIntervention:
            trackDeliveredFilteredForCurrentMonth=[self.interventionsDeliveredArray filteredArrayUsingPredicate:trackPredicateForCurrentMonth];
            
            
            break;
            
        case kTrackTypeInterventionSubType:
            trackDeliveredFilteredForCurrentMonth=[self.interventionsDeliveredArray filteredArrayUsingPredicate:trackPredicateForCurrentMonth];
            
           
            break;
            
        case kTrackTypeAssessment:
            trackDeliveredFilteredForCurrentMonth=[self.assessmentsDeliveredArray filteredArrayUsingPredicate:trackPredicateForCurrentMonth];
            
            
            break;
            
            
        case kTrackTypeSupport:
            trackDeliveredFilteredForCurrentMonth=[self.supportActivityDeliveredArray filteredArrayUsingPredicate:trackPredicateForCurrentMonth];
            
            
            break;
            
            
        case kTrackTypeSupervision:
            trackDeliveredFilteredForCurrentMonth=[self.supervisionReceivedArray filteredArrayUsingPredicate:trackPredicateForCurrentMonth];
            
            
            break;
            
        case kTrackTypeSupervisionSubType:
            trackDeliveredFilteredForCurrentMonth=[self.supervisionReceivedArray filteredArrayUsingPredicate:trackPredicateForCurrentMonth];
            
            
            break;
            
        default:
            break;
    }
    
    
    if (trackDeliveredFilteredForCurrentMonth) {
        
        int trackDeliveredFilteredForCurrentMonthCount=trackDeliveredFilteredForCurrentMonth.count;
        if (trackDeliveredFilteredForCurrentMonthCount) {
            
            NSMutableArray *monthlyLogNotesArray=[trackDeliveredFilteredForCurrentMonth mutableArrayValueForKey:@"monthlyLogNotes"];
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
    
    
    NSArray *filteredExistingHoursArray=nil;
    if (self.existingHoursHoursArray &&self.existingHoursHoursArray.count) {
        filteredExistingHoursArray=[self.existingHoursHoursArray filteredArrayUsingPredicate:[self predicateForExistingHoursCurrentMonth]];
    }
    
    int filteredExistingHoursArrayCount=filteredExistingHoursArray.count;
    if (filteredExistingHoursArrayCount) {
        
        NSArray *existingTypeArray=nil;
        
        NSSet *existingTypeSet=nil;
        switch (trackType_) {
                
            case kTrackTypeAssessment:
                
            {
                
                if (filteredExistingHoursArray&&filteredExistingHoursArray.count) {
                    existingTypeSet=[filteredExistingHoursArray mutableSetValueForKeyPath:@"assessments.monthlyLogNotes"];
                }
                
                
            }
                break;
                
            case kTrackTypeSupport:
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
                        
                        if (!logNotesStr ||!logNotesStr.length) {
                            logNotesStr=logNoteInLogNotesArray;
                        }
                        else {
                            logNotesStr=[NSString stringWithFormat:@"%@; %@",logNotesStr,logNoteInLogNotesArray];
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
