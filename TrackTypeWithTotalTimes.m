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


@implementation TrackTypeWithTotalTimes

@synthesize trackTypeObject;
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





-(id)initWithMonth:(NSDate *)date clinician:(ClinicianEntity *)clinician trackTypeObject:(id)trackTypeObjectGiven{
    //override superclass
    self= [super initWithMonth:date clinician:clinician];
    
    if (self) {
        
        
        NSLog(@"date is %@",date);
        
        
             
         trackType=[self trackTypeForObjectGiven:trackTypeObjectGiven];
        
        NSPredicate *predicateForTrackEntities=[self predicateForTrackEntitiesAllBeforeAndEqualToEndDateForMonth];
        
        NSPredicate * predicateForExistingHoursEntities=[self predicateForExistingHoursAllBeforeAndEqualToEndDateForMonth];
        
        
        NSLog(@"predicate for existing hours entites is %@",predicateForExistingHoursEntities.predicateFormat);
        NSLog(@"predicate for track entities is %@",predicateForTrackEntities.predicateFormat);
        
        
        
        
        

        self.trackTypeObject=trackTypeObjectGiven;
        
       
        switch (trackType) {
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
                        self.interventionsDeliveredArray=[allInterventionsDeliveredForType filteredArrayUsingPredicate:predicateForTrackEntities];
                    }
                    
                    NSLog(@"intervention Delivered Array is %@",self.interventionsDeliveredArray);
                    
                    NSArray *allExistingInterventionsArrayForType=nil;
                    if (interventionType.existingInterventions) {
                        allExistingInterventionsArrayForType=interventionType.existingInterventions.allObjects;
                    }
                    
                    
                    if (allExistingInterventionsArrayForType&&allExistingInterventionsArrayForType.count&& predicateForExistingHoursEntities) {
                        
                    
                        self.existingHoursHoursArray=[allExistingInterventionsArrayForType filteredArrayUsingPredicate:predicateForExistingHoursEntities];
                    }
                    
                    
                    
                    
                   
                    
                    for (NSInteger i=0; i<9; i++) {
                        [ self  totalOverallHoursTIForOveralCell:(PTSummaryCell)i clinician:(ClinicianEntity *)clinician];
                    }
                    return self;
                    
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
                    
                    
                    
                    NSLog(@"all interventions deliverd before filter%@",allInterventionsDeliveredForSubType);
                    if (allInterventionsDeliveredForSubType &&allInterventionsDeliveredForSubType.count &&predicateForTrackEntities) {
                        self.interventionsDeliveredArray=[allInterventionsDeliveredForSubType filteredArrayUsingPredicate:predicateForTrackEntities];
                        
                    }
                    NSLog(@"intervention Delivered Array is %@",self.interventionsDeliveredArray);
                    
                    
                    NSArray *allExistingInterventionsArrayForSubType=nil;
                    if (interventionSubType.existingInterventions) {
                        allExistingInterventionsArrayForSubType=interventionSubType.existingInterventions.allObjects;
                    }
                    
                    
                    NSMutableArray *existingHoursMutableArray=[NSMutableArray array];
                    
                    for (ExistingInterventionEntity *existingInterventionObject in allExistingInterventionsArrayForSubType) {
                        if (existingInterventionObject.existingHours &&[existingInterventionObject.existingHours isKindOfClass:[ExistingHoursEntity class]]) {
                            ExistingHoursEntity *existingHoursObject =( ExistingHoursEntity*)existingInterventionObject.existingHours;
                            NSLog(@"existing hours obect is %@",existingHoursObject);
                            [existingHoursMutableArray addObject:existingHoursObject];
                        }
                    }
                    
                    NSLog(@"all existing interventions before filter %@",allExistingInterventionsArrayForSubType);
                    if (allExistingInterventionsArrayForSubType&&allExistingInterventionsArrayForSubType.count  && predicateForExistingHoursEntities) {
                        self.existingHoursHoursArray=[existingHoursMutableArray filteredArrayUsingPredicate:predicateForExistingHoursEntities];
                        
                    }NSLog(@"existing hours array is %@",self.existingHoursHoursArray);
                    
                    
                   
                    for (NSInteger i=0; i<9; i++) {
                        [ self  totalOverallHoursTIForOveralCell:(PTSummaryCell)i clinician:(ClinicianEntity *)clinician];
                    }
                    return self;
                    
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
                        self.assessmentsDeliveredArray=[allAssessemntsDeliveredForType filteredArrayUsingPredicate:predicateForTrackEntities];
                        
                    }
                    NSLog(@"intervention Delivered Array is %@",self.assessmentsDeliveredArray);
                    
                    NSArray *allExistingAssessmentsArrayForType=nil;
                    
                    if (assessmentType.existingAssessments) {
                        allExistingAssessmentsArrayForType=assessmentType.existingAssessments.allObjects;
                    }
                    
                    
                    
                    
                    if (allExistingAssessmentsArrayForType&&allExistingAssessmentsArrayForType.count && predicateForExistingHoursEntities) {
                        self.existingHoursHoursArray=[allExistingAssessmentsArrayForType filteredArrayUsingPredicate:predicateForExistingHoursEntities];
                        
                    }
                    
                    
                    
                   
                    for (NSInteger i=0; i<9; i++) {
                        [ self  totalOverallHoursTIForOveralCell:(PTSummaryCell)i clinician:(ClinicianEntity *)clinician];
                    }
                    return self;
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
                        self.supportActivityDeliveredArray=[allSupportActivitiesDeliveredForType filteredArrayUsingPredicate:predicateForTrackEntities];
                        
                    }
                    
                    NSLog(@"intervention Delivered Array is %@",self.supportActivityDeliveredArray);
                    
                    NSArray *allExistingSupportActivitiesArrayForType=nil;
                    
                    if (supportActivityType.existingSupportActivities) {
                        allExistingSupportActivitiesArrayForType=supportActivityType.existingSupportActivities.allObjects;
                        
                    }
                    
                    
                    if (allSupportActivitiesDeliveredForType && allSupportActivitiesDeliveredForType.count&& predicateForExistingHoursEntities) {
                        self.existingHoursHoursArray=[allExistingSupportActivitiesArrayForType filteredArrayUsingPredicate:predicateForExistingHoursEntities];
                    }
                    
                   
                    for (NSInteger i=0; i<9; i++) {
                        [ self  totalOverallHoursTIForOveralCell:(PTSummaryCell)i clinician:(ClinicianEntity *)clinician];
                    }
                    return self;
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
                        self.supervisionReceivedArray=[allSupervisionReceivedForType filteredArrayUsingPredicate:predicateForTrackEntities];
                        
                    }
                    
                    
                    NSLog(@"intervention Delivered Array is %@",self.supportActivityDeliveredArray);
                    
                    
                    
                    NSArray *allExistingSupervisionReceivedArrayForType=nil;
                    if (supervisionType.existingSupervision) {
                        allExistingSupervisionReceivedArrayForType=supervisionType.existingSupervision.allObjects;
                    }
                    
                    if (allExistingSupervisionReceivedArrayForType&&allExistingSupervisionReceivedArrayForType.count&& predicateForExistingHoursEntities) {
                        self.existingHoursHoursArray=[allExistingSupervisionReceivedArrayForType filteredArrayUsingPredicate:predicateForExistingHoursEntities];
                        
                    }
                    
                    
                   
                    
                    for (NSInteger i=0; i<9; i++) {
                        [ self  totalOverallHoursTIForOveralCell:(PTSummaryCell)i clinician:(ClinicianEntity *)clinician];
                    }
                    return self;
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
                        self.supervisionReceivedArray=[allSupervisionReceivedForSubType filteredArrayUsingPredicate:predicateForTrackEntities];
                        
                    }
                    
                    
                    NSLog(@"intervention Delivered Array is %@",self.supportActivityDeliveredArray);
                    NSArray *allExistingSupervisionReceivedArrayForSubType=nil;
                    
                    if (supervisionSubType.existingSupervision) {
                        allExistingSupervisionReceivedArrayForSubType=supervisionSubType.existingSupervision.allObjects;
                        
                    }
                    
                    
                    
                    if (allExistingSupervisionReceivedArrayForSubType &&allExistingSupervisionReceivedArrayForSubType.count&& predicateForExistingHoursEntities) {
                        self.existingHoursHoursArray=[allExistingSupervisionReceivedArrayForSubType filteredArrayUsingPredicate:predicateForExistingHoursEntities];
                        
                        
                    }
                    
                    
                    
                }

                
            }
                break;
            case kTrakTypeUnknown:
            {
                PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
                

                [appDelegate displayNotification:@"Track object type was not identified"];
                
            }
                break;
                
            default:
                break;
        }
        
                           
            
       
               
       
                             
        
                        
                
                        
                  
        
    }
    
    for (NSInteger i=0; i<9; i++) {
        [ self  totalOverallHoursTIForOveralCell:(PTSummaryCell)i clinician:(ClinicianEntity *)clinician];
    }
    
    
    
    return self;
    
    
}
-(PTrackType)trackTypeForObjectGiven:(id)trackTypeObjectGiven{


    PTrackType trackTypeToReturn=kTrakTypeUnknown;
    NSString * tempString=nil;

    if ([trackTypeObjectGiven isKindOfClass:[InterventionTypeEntity class]]) {

        tempString=@"interventionsDelivered";
        trackTypeToReturn= kTrackTypeIntervention;

    }

    if ([trackTypeObjectGiven isKindOfClass:[InterventionTypeSubtypeEntity class]]) {

        tempString=@"interventionsDelivered";
        trackTypeToReturn=  kTrackTypeInterventionSubType;

    }


    if ([trackTypeObjectGiven isKindOfClass:[AssessmentTypeEntity class]]) {

        tempString=@"assessmentsDelivered";
        trackTypeToReturn=  kTrackTypeAssessment;

    }

    if ([trackTypeObjectGiven isKindOfClass:[SupportActivityTypeEntity class]]) {

        tempString=@"supportActivitiesDelivered";
        trackTypeToReturn=  kTrackTypeSupport;

    }


    if ([trackTypeObjectGiven isKindOfClass:[SupervisionTypeEntity class]]) {

        tempString=@"supervisionReceived";
        trackTypeToReturn=  kTrackTypeSupervision;

    }


    if ([trackTypeObjectGiven isKindOfClass:[SupervisionTypeSubtypeEntity class]]) {

        tempString=@"supervisionReceived";
        trackTypeToReturn=  kTrackTypeSupervisionSubType;

    }
    
    self.trackPathStartString= [tempString stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    return trackTypeToReturn;

}

-(void ) totalOverallHoursTIForOveralCell:(PTSummaryCell)summaryCell clinician:(ClinicianEntity *)clinician{
    
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

   
        
 
    
       
     
    
//    NSTimeInterval overallTotalTI=0;
    
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
    
    
    
    
    
}


-(NSPredicate *)allHoursPredicateForClincian:(ClinicianEntity *)clinician{
    
    NSPredicate *priorMonthsServiceDatesPredicate=nil;
    
        
        
    if (clinician) {
    
        
        
        priorMonthsServiceDatesPredicate=[NSPredicate predicateWithFormat:@"%K. supervisor.objectID == %@ ",clinician.objectID];
        
    }
    
    return priorMonthsServiceDatesPredicate;
    
}


-(NSString *)relationshipPathStartToTrackEntity{


    NSString *relationshipPathStartPoint;
    
    
    return relationshipPathStartPoint;


}



-(NSPredicate *)priorMonthsHoursPredicateForClincian:(ClinicianEntity *)clinician{
    
    NSPredicate *priorMonthsServiceDatesPredicate=nil;
   
    
    
    if (clinician) {
        priorMonthsServiceDatesPredicate=[NSPredicate predicateWithFormat:@"(self.supervisor.objectID == %@) AND (dateOfService < %@ )",clinician.objectID,monthStartDate_];
        
    }else {
        priorMonthsServiceDatesPredicate=[NSPredicate predicateWithFormat:@"dateOfService < %@ ",monthStartDate_];
        
        
    }
    
    return priorMonthsServiceDatesPredicate;
    
}


-(NSPredicate *)predicateForTrackCurrentMonthsForClincian:(ClinicianEntity *)clinician{
    
    NSPredicate *currentMonthPredicate=nil;
    
    
    if (clinician) {
        currentMonthPredicate = [NSPredicate predicateWithFormat:@"((self.supervisor.objectID == %@ ) AND ((dateOfService >= %@) AND (dateOfService <= %@)) || (dateOfService = nil))", clinician.objectID, monthStartDate_, monthEndDate_];
    }
    else {
        currentMonthPredicate = [NSPredicate predicateWithFormat:@" (dateOfService >= %@) AND (dateOfService <= %@)  ", monthStartDate_,monthEndDate_];
    }
    
    return currentMonthPredicate;    
}


-(NSPredicate *)predicateForExistingHoursCurrentMonthsForClincian:(ClinicianEntity *)clinician{
    
    NSPredicate *currentMonthPredicate=nil;
    
    
    if (clinician) {
        currentMonthPredicate = [NSPredicate predicateWithFormat:@"(self.supervisor.objectID == %@ ) AND (existingHours.startDate >= %@) AND (existingHours.endDate <= %@)",clinician.objectID, monthStartDate_,monthEndDate_];
    }
    else {
        currentMonthPredicate = [NSPredicate predicateWithFormat:@" (startDate >= %@) AND (endDate <= %@)", monthStartDate_,monthEndDate_];
    }
    
    return currentMonthPredicate;    
}


-(NSPredicate *)predicateForTrackEntitiesAllBeforeAndEqualToEndDateForMonth{
    
    NSPredicate *returnPredicate=nil;
    
    
    if (monthEndDate_) {
        
        returnPredicate = [NSPredicate predicateWithFormat:  @" (dateOfService <= %@)",  monthEndDate_];
    }
    
    return returnPredicate;    
}                                          

-(NSPredicate *)predicateForExistingHoursAllBeforeAndEqualToEndDateForMonth{
    
    NSPredicate *returnPredicate=nil;
       
    
    if (monthEndDate_) {
        
        returnPredicate = [NSPredicate predicateWithFormat:@" (endDate <= %@)", monthEndDate_];
    }
    
    return returnPredicate;    
}     



-(NSPredicate *)predicateForExistingHoursAllBeforeEndDate:(NSDate *)date clinician:(ClinicianEntity *)clinician{
    
    NSPredicate *returnPredicate=nil;
   

    
    if (date &&[date isKindOfClass:[NSDate class]]) {
        if (clinician) {
            returnPredicate = [NSPredicate predicateWithFormat:@"((supervisor.objectID == %@ ) AND  (endDate < %@))",clinician.objectID, date];
        }
        else {
            returnPredicate = [NSPredicate predicateWithFormat:@" (endDate < %@)", date];
        }
    }
    
    return returnPredicate;    
}     


-(NSPredicate *)predicateForExistingHoursWeek:(PTrackWeek)week clincian:(ClinicianEntity *)clinician{
    
    NSPredicate *weekPredicate=nil;
    

    
    if (clinician) {
        weekPredicate = [NSPredicate predicateWithFormat:@"((self.supervisor.objectID == %@ ) AND (existingHours.startDate >= %@) AND (existingHours.endDate <= %@))",clinician.objectID, [self storedStartDateForWeek:week],[self storedEndDateForWeek:week]];
    }
    else {
        weekPredicate = [NSPredicate predicateWithFormat:@" ((startDate >= %@) AND (endDate <= %@))", [self storedStartDateForWeek:week],[self storedEndDateForWeek:week]];
    }
    
    return weekPredicate;
    
}


-(NSPredicate *)predicateForExistingHoursWeekUndefinedForClincian:(ClinicianEntity *)clinician{
    
    NSPredicate *undefinedWeekPredicate=nil;
   

    
    if (clinician) {
        undefinedWeekPredicate = [NSPredicate predicateWithFormat:@" ((self.supervisor.objectID == %@ )  AND ((startDate >= %@) AND (endDate <= %@)) AND (   ((startDate >= %@) AND (endDate > %@)) OR ((startDate >= %@) AND (endDate > %@)) OR ((startDate >= %@) AND (endDate > %@)) OR ((startDate >= %@) AND (endDate > %@)) ))",clinician.objectID, monthStartDate_,monthEndDate_,week1StartDate_,week1EndDate_,week2StartDate_,week2EndDate_,week3StartDate_,week3EndDate_,week4StartDate_,week4EndDate_];
        
        
    }
    else {
        undefinedWeekPredicate = [NSPredicate predicateWithFormat:@" (((startDate >= %@) AND (endDate <= %@)) AND (   ((startDate >= %@) AND (endDate > %@)) OR ((startDate >= %@) AND (endDate > %@)) OR ((startDate >= %@) AND (endDate > %@)) OR ((startDate >= %@) AND (endDate > %@)) ))", monthStartDate_,monthEndDate_,week1StartDate_,week1EndDate_,week2StartDate_,week2EndDate_,week3StartDate_,week3EndDate_,week4StartDate_,week4EndDate_];
    }
    
    return undefinedWeekPredicate;
    
}

-(NSPredicate *)predicateForTrackWeek:(PTrackWeek)week clincian:(ClinicianEntity *)clinician{
    
    NSPredicate *weekPredicate=nil;
    

    
    if (clinician) {
        weekPredicate = [NSPredicate predicateWithFormat:@"(supervisor.objectID == %@ ) AND ((dateOfService >= %@) AND (dateOfService <= %@))",clinician.objectID, [self storedStartDateForWeek:week],[self storedEndDateForWeek:week]];
    }
    else {
        weekPredicate = [NSPredicate predicateWithFormat:@" (dateOfService >= %@) AND (dateOfService <= %@)  ", [self storedStartDateForWeek:week],[self storedEndDateForWeek:week]];
    }
    
    return weekPredicate;
    
}




@end
