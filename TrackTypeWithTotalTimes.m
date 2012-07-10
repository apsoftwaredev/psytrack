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


@implementation TrackTypeWithTotalTimes

@synthesize trackTypeObject;
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





-(id)initWithMonth:(NSDate *)date clinician:(ClinicianEntity *)clinician trackTypeObject:(id)trackTypeObjectGiven{
    //override superclass
    self= [super initWithMonth:date clinician:clinician];
    
    if (self) {
        
        NSPredicate *predicateForTrackEntities=[self predicateForTrackEntitiesAllBeforeAndEqualToEndDateForMonth:(NSDate *)date];
        
        NSPredicate * predicateForExistingHoursEntities=[self predicateForExistingHoursAllBeforeAndEqualToEndDateForMonth:date];
        self.trackTypeObject=trackTypeObjectGiven;
        

                if ([trackTypeObjectGiven isKindOfClass:[InterventionTypeEntity class]]) {
                    InterventionTypeEntity *interventionType=(InterventionTypeEntity *)trackTypeObjectGiven;
                    
                    self.typeLabelText=interventionType.interventionType;
                    NSArray *allInterventionsDeliveredForType=interventionType.interventionDelivered.allObjects;
                    
                    if (allInterventionsDeliveredForType&&allInterventionsDeliveredForType.count) {
                          self.interventionsDeliveredArray=[allInterventionsDeliveredForType filteredArrayUsingPredicate:predicateForTrackEntities];
                    }
                  
                    NSLog(@"intervention Delivered Array is %@",self.interventionsDeliveredArray);
                    
                   
                    NSArray *allExistingInterventionsArrayForType=interventionType.existingInterventions.allObjects;
                    
                    if (allExistingInterventionsArrayForType&&allExistingInterventionsArrayForType.count) {
                        self.existingHoursHoursArray=[allExistingInterventionsArrayForType filteredArrayUsingPredicate:predicateForExistingHoursEntities];
                    }
                    
                    
                    
                    
                    trackType=kTrackTypeIntervention;
                    return self;
                    
                }

            
            
       
                if ([trackTypeObjectGiven isKindOfClass:[InterventionTypeSubtypeEntity class]]) {
                    
                    InterventionTypeSubtypeEntity *interventionSubType=(InterventionTypeSubtypeEntity *)trackTypeObjectGiven;
                    
                    self.typeLabelText=interventionSubType.interventionSubType;
                    
                    NSArray *allInterventionsDeliveredForSubType=interventionSubType.interventionDelivered.allObjects;
                    
                    if (allInterventionsDeliveredForSubType &&allInterventionsDeliveredForSubType.count) {
                        self.interventionsDeliveredArray=[allInterventionsDeliveredForSubType filteredArrayUsingPredicate:predicateForTrackEntities];
                        
                    }
                    NSLog(@"intervention Delivered Array is %@",self.interventionsDeliveredArray);
                    
                    
                    
                    NSArray *allExistingInterventionsArrayForSubType=interventionSubType.existingInterventions.allObjects;
                    
                    if (allExistingInterventionsArrayForSubType&&allExistingInterventionsArrayForSubType.count) {
                        self.existingHoursHoursArray=[allExistingInterventionsArrayForSubType filteredArrayUsingPredicate:predicateForExistingHoursEntities];
                        
                    }
                    
                    
                    
                    trackType=kTrackTypeInterventionSubType;
                    return self;
                    
                }

       
                if ([trackTypeObjectGiven isKindOfClass:[AssessmentTypeEntity class]]) {
                    AssessmentTypeEntity *assessmentType=(AssessmentTypeEntity *)trackTypeObjectGiven;
                    
                    self.typeLabelText=assessmentType.assessmentType;
                    
                    NSArray *allAssessemntsDeliveredForType=assessmentType.assessments.allObjects;
                    
                    if (allAssessemntsDeliveredForType&&allAssessemntsDeliveredForType.count) {
                        self.assessmentsDeliveredArray=[allAssessemntsDeliveredForType filteredArrayUsingPredicate:predicateForTrackEntities];
                        
                    }
                    NSLog(@"intervention Delivered Array is %@",self.assessmentsDeliveredArray);
                    
                    
                    NSArray *allExistingAssessmentsArrayForType=assessmentType.existingAssessments.allObjects;
                    
                    if (allExistingAssessmentsArrayForType&&allExistingAssessmentsArrayForType.count) {
                        self.existingHoursHoursArray=[allExistingAssessmentsArrayForType filteredArrayUsingPredicate:predicateForExistingHoursEntities];
                        
                    }
                    
                    
                    
                    
                    trackType=kTrackTypeAssessment;
                    return self;
                }
                
        
                
                if ([trackTypeObjectGiven isKindOfClass:[SupportActivityTypeEntity class]]) {
                    SupportActivityTypeEntity *supportActivityType=(SupportActivityTypeEntity *)trackTypeObjectGiven;
                    
                    self.typeLabelText=supportActivityType.supportActivityType;
                    
                    NSArray *allSupportActivitiesDeliveredForType=supportActivityType.supportActivitiesDelivered.allObjects;
                    
                    if (allSupportActivitiesDeliveredForType&&allSupportActivitiesDeliveredForType.count) {
                        self.supportActivityDeliveredArray=[allSupportActivitiesDeliveredForType filteredArrayUsingPredicate:predicateForTrackEntities];
                        
                    }
                    
                    NSLog(@"intervention Delivered Array is %@",self.supportActivityDeliveredArray);
                    
                    
                    NSArray *allExistingSupportActivitiesArrayForType=supportActivityType.existingSupportActivities.allObjects;
                    
                    if (allSupportActivitiesDeliveredForType && allSupportActivitiesDeliveredForType.count) {
                        self.existingHoursHoursArray=[allExistingSupportActivitiesArrayForType filteredArrayUsingPredicate:predicateForExistingHoursEntities];
                    }
                                       
                    
                    trackType=kTrackTypeSupport;
                    return self;
                }
         
                
                if ([trackTypeObjectGiven isKindOfClass:[SupervisionTypeEntity class]]) {
                    SupervisionTypeEntity *supervisionType=(SupervisionTypeEntity *)trackTypeObjectGiven;
                    
                    self.typeLabelText=supervisionType.supervisionType;
                    
                    
                    NSArray *allSupervisionReceivedForType=supervisionType.supervisionRecieved.allObjects;
                    
                    if (allSupervisionReceivedForType &&allSupervisionReceivedForType.count) {
                        self.supervisionReceivedArray=[allSupervisionReceivedForType filteredArrayUsingPredicate:predicateForTrackEntities];
                        
                    }
                    
                    
                    NSLog(@"intervention Delivered Array is %@",self.supportActivityDeliveredArray);
                    
                    NSArray *allExistingSupervisionReceivedArrayForType=supervisionType.existingSupervision.allObjects;
                    
                    if (allExistingSupervisionReceivedArrayForType&&allExistingSupervisionReceivedArrayForType.count) {
                        self.existingHoursHoursArray=[allExistingSupervisionReceivedArrayForType filteredArrayUsingPredicate:predicateForExistingHoursEntities];
                        
                    }
                    
                    
                    
                    trackType=kTrackTypeSupervision;
                    return self;
                }
        
                
                if ([trackTypeObjectGiven isKindOfClass:[SupervisionTypeSubtypeEntity class]]) {
                    SupervisionTypeSubtypeEntity *supervisionSubType=(SupervisionTypeSubtypeEntity *)trackTypeObjectGiven;
                    
                    self.typeLabelText=supervisionSubType.subType;
                    NSArray *allSupervisionReceivedForSubType=supervisionSubType.supervisionReceived.allObjects;
                    
                    if (allSupervisionReceivedForSubType &&allSupervisionReceivedForSubType.count) {
                        self.supervisionReceivedArray=[allSupervisionReceivedForSubType filteredArrayUsingPredicate:predicateForTrackEntities];
                        
                    }
                    
                    
                    NSLog(@"intervention Delivered Array is %@",self.supportActivityDeliveredArray);
                    
                    NSArray *allExistingSupervisionReceivedArrayForSubType=supervisionSubType.existingSupervision.allObjects;
                    
                    if (allExistingSupervisionReceivedArrayForSubType &&allExistingSupervisionReceivedArrayForSubType.count) {
                        self.existingHoursHoursArray=[allExistingSupervisionReceivedArrayForSubType filteredArrayUsingPredicate:predicateForExistingHoursEntities];
                        
                        
                    }
                    
                    
                    trackType=kTrackTypeSupervisionSubType;
                    
                }
   
        
    }
    
    return self;
    
    
}


-(NSTimeInterval ) totalOverallHoursTIForOveralCell:(PTSummaryCell)summaryCell clinician:(ClinicianEntity *)clinician{
    
    NSPredicate *trackPredicate=nil;
    NSPredicate *existingHoursPredicate=nil;
    
    switch (summaryCell) {
        case kSummaryWeekOne:
        {
            trackPredicate=[self predicateForTrackWeek:kTrackWeekOne clincian:clinician];
            existingHoursPredicate=[self predicateForExistingHoursWeek:kTrackWeekOne clincian:clinician];
        }
            break;
        case kSummaryWeekTwo:
        {
            trackPredicate=[self predicateForTrackWeek:kTrackWeekTwo clincian:clinician];
            existingHoursPredicate=[self predicateForExistingHoursWeek:kTrackWeekOne clincian:clinician];
        }
            break;
        case kSummaryWeekThree:
        {
            trackPredicate=[self predicateForTrackWeek:kTrackWeekThree clincian:clinician];
            existingHoursPredicate=[self predicateForExistingHoursWeek:kTrackWeekOne clincian:clinician];
        }
            break;
        case kSummaryWeekFour:
        {
            trackPredicate=[self predicateForTrackWeek:kTrackWeekFour clincian:clinician];
            existingHoursPredicate=[self predicateForExistingHoursWeek:kTrackWeekOne clincian:clinician];
        }
            break;
        case kSummaryWeekFive:
        {
            trackPredicate=[self predicateForTrackWeek:kTrackWeekFive clincian:clinician];
            existingHoursPredicate=[self predicateForExistingHoursWeek:kTrackWeekOne clincian:clinician];
        }
            break;
        case kSummaryWeekUndefined:
        {
            
            existingHoursPredicate=[self predicateForExistingHoursWeekUndefinedForClincian:clinician];
        }
            break;
        case kSummaryTotalForMonth:
        {
            trackPredicate=[self predicateForTrackCurrentMonthsForClincian:clinician];
            existingHoursPredicate=[self predicateForExistingHoursCurrentMonthsForClincian:clinician];
        }
            break;
        case kSummaryCummulative:
        {
            trackPredicate=[self priorMonthsHoursPredicateForClincian:clinician];
            existingHoursPredicate=[self predicateForExistingHoursAllBeforeEndDate:monthStartDate_ clinician:clinician];
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


   
        
        switch (trackType) {
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

   
        
 
    
       
     
    
    NSTimeInterval overallTotalTI=0;
    
    switch (summaryCell) {
        case kSummaryWeekOne:
        {
            if (trackType==kTrackIntervention||trackType==kTrackTypeInterventionSubType) {
                self.totalWeek1TI=trackTotalInterventionTimeInterval+totalExistingInterventionsTI;
            }
            if (trackType==kTrackAssessment) {
                self.totalWeek1TI=trackTotalAssessmentInterval+totalExistingAssessmentsTI;
            }
            if (trackType==kTrackTypeSupport) {
                self.totalWeek1TI=trackTotalSupportTimeInterval+totalExistingSupportTI;
            }
            if (trackType==kTrackTypeSupervision||trackType==kTrackTypeSupervisionSubType) {
                self.totalWeek1TI=trackTotalSupervisionReceivedTimeInterval+totalExistingSupervisionReceivedTI;
            }
            
            
            self.totalWeek1Str=[self totalTimeStr:self.totalWeek1TI];
            
            
            
            
        }
            break;
        case kSummaryWeekTwo:
        {
            if (trackType==kTrackIntervention||trackType==kTrackTypeInterventionSubType) {
                self.totalWeek2TI=trackTotalInterventionTimeInterval+totalExistingInterventionsTI;
            }
            if (trackType==kTrackAssessment) {
                self.totalWeek2TI=trackTotalAssessmentInterval+totalExistingAssessmentsTI;
            }
            if (trackType==kTrackTypeSupport) {
                self.totalWeek2TI=trackTotalSupportTimeInterval+totalExistingSupportTI;
            }
            if (trackType==kTrackTypeSupervision||trackType==kTrackTypeSupervisionSubType) {
                self.totalWeek2TI=trackTotalSupervisionReceivedTimeInterval+totalExistingSupervisionReceivedTI;
            }
            
            
            self.totalWeek2Str=[self totalTimeStr:self.totalWeek2TI];
            
            
            
        }
            break;
        case kSummaryWeekThree:
        {
            if (trackType==kTrackIntervention||trackType==kTrackTypeInterventionSubType) {
                self.totalWeek3TI=trackTotalInterventionTimeInterval+totalExistingInterventionsTI;
            }
            if (trackType==kTrackAssessment) {
                self.totalWeek3TI=trackTotalAssessmentInterval+totalExistingAssessmentsTI;
            }
            if (trackType==kTrackTypeSupport) {
                self.totalWeek3TI=trackTotalSupportTimeInterval+totalExistingSupportTI;
            }
            if (trackType==kTrackTypeSupervision||trackType==kTrackTypeSupervisionSubType) {
                self.totalWeek3TI=trackTotalSupervisionReceivedTimeInterval+totalExistingSupervisionReceivedTI;
            }
            
            
            self.totalWeek3Str=[self totalTimeStr:self.totalWeek3TI];
            
            

            
            
        }
            break;
        case kSummaryWeekFour:
        {
            if (trackType==kTrackIntervention||trackType==kTrackTypeInterventionSubType) {
                self.totalWeek4TI=trackTotalInterventionTimeInterval+totalExistingInterventionsTI;
            }
            if (trackType==kTrackAssessment) {
                self.totalWeek4TI=trackTotalAssessmentInterval+totalExistingAssessmentsTI;
            }
            if (trackType==kTrackTypeSupport) {
                self.totalWeek4TI=trackTotalSupportTimeInterval+totalExistingSupportTI;
            }
            if (trackType==kTrackTypeSupervision||trackType==kTrackTypeSupervisionSubType) {
                self.totalWeek4TI=trackTotalSupervisionReceivedTimeInterval+totalExistingSupervisionReceivedTI;
            }
            
            
            self.totalWeek4Str=[self totalTimeStr:self.totalWeek4TI];
            
            

        }
            break;
        case kSummaryWeekFive:
        {
            if (trackType==kTrackIntervention||trackType==kTrackTypeInterventionSubType) {
                self.totalWeek5TI=trackTotalInterventionTimeInterval+totalExistingInterventionsTI;
            }
            if (trackType==kTrackAssessment) {
                self.totalWeek5TI=trackTotalAssessmentInterval+totalExistingAssessmentsTI;
            }
            if (trackType==kTrackTypeSupport) {
                self.totalWeek5TI=trackTotalSupportTimeInterval+totalExistingSupportTI;
            }
            if (trackType==kTrackTypeSupervision||trackType==kTrackTypeSupervisionSubType) {
                self.totalWeek5TI=trackTotalSupervisionReceivedTimeInterval+totalExistingSupervisionReceivedTI;
            }
            
            
            self.totalWeek5Str=[self totalTimeStr:self.totalWeek5TI];
            
            

            
        }
            break;
        case kSummaryWeekUndefined:
        {
            if (trackType==kTrackIntervention||trackType==kTrackTypeInterventionSubType) {
                self.totalWeekUndefinedTI=trackTotalInterventionTimeInterval+totalExistingInterventionsTI;
            }
            if (trackType==kTrackAssessment) {
                self.totalWeekUndefinedTI=trackTotalAssessmentInterval+totalExistingAssessmentsTI;
            }
            if (trackType==kTrackTypeSupport) {
                self.totalWeekUndefinedTI=trackTotalSupportTimeInterval+totalExistingSupportTI;
            }
            if (trackType==kTrackTypeSupervision||trackType==kTrackTypeSupervisionSubType) {
                self.totalWeekUndefinedTI=trackTotalSupervisionReceivedTimeInterval+totalExistingSupervisionReceivedTI;
            }
            
            
            self.totalWeekUndefinedStr=[self totalTimeStr:self.totalWeekUndefinedTI];
            
            

            
        }
            break;
        case kSummaryTotalForMonth:
        {
            if (trackType==kTrackIntervention||trackType==kTrackTypeInterventionSubType) {
                self.totalForMonthTI=trackTotalInterventionTimeInterval+totalExistingInterventionsTI;
            }
            if (trackType==kTrackAssessment) {
                self.totalForMonthTI=trackTotalAssessmentInterval+totalExistingAssessmentsTI;
            }
            if (trackType==kTrackTypeSupport) {
                self.totalForMonthTI=trackTotalSupportTimeInterval+totalExistingSupportTI;
            }
            if (trackType==kTrackTypeSupervision||trackType==kTrackTypeSupervisionSubType) {
                self.totalForMonthTI=trackTotalSupervisionReceivedTimeInterval+totalExistingSupervisionReceivedTI;
            }
            
            
            self.totalForMonthStr=[self totalTimeStr:self.totalForMonthTI];
            
            
        }
            break;
        case kSummaryCummulative:
        {
            if (trackType==kTrackIntervention||trackType==kTrackTypeInterventionSubType) {
                self.totalCummulativeTI=trackTotalInterventionTimeInterval+totalExistingInterventionsTI;
            }
            if (trackType==kTrackAssessment) {
                self.totalCummulativeTI=trackTotalAssessmentInterval+totalExistingAssessmentsTI;
            }
            if (trackType==kTrackTypeSupport) {
                self.totalCummulativeTI=trackTotalSupportTimeInterval+totalExistingSupportTI;
            }
            if (trackType==kTrackTypeSupervision||trackType==kTrackTypeSupervisionSubType) {
                self.totalCummulativeTI=trackTotalSupervisionReceivedTimeInterval+totalExistingSupervisionReceivedTI;
            }
            
            
            self.totalCummulativeStr=[self totalTimeStr:self.totalCummulativeTI];
            
            

            
            
        }
            break;
        case kSummaryTotalToDate:
        {
            if (trackType==kTrackIntervention||trackType==kTrackTypeInterventionSubType) {
                self.totalToDateTI=trackTotalInterventionTimeInterval+totalExistingInterventionsTI;
            }
            if (trackType==kTrackAssessment) {
                self.totalToDateTI=trackTotalAssessmentInterval+totalExistingAssessmentsTI;
            }
            if (trackType==kTrackTypeSupport) {
                self.totalToDateTI=trackTotalSupportTimeInterval+totalExistingSupportTI;
            }
            if (trackType==kTrackTypeSupervision||trackType==kTrackTypeSupervisionSubType) {
                self.totalToDateTI=trackTotalSupervisionReceivedTimeInterval+totalExistingSupervisionReceivedTI;
            }
            
            
            self.totalToDateStr=[self totalTimeStr:self.totalToDateTI];
            
            
            
            
        }
            
            
        default:
            break;
    }
    
    
    
    return overallTotalTI;
    
}





@end
