/*
 *  TrackTypeWithTotalTimes.m
 *  psyTrack
 *  Version: 1.0
 *
 *
 The MIT License (MIT)
 Copyright © 2011- 2021 Daniel Boice
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
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

@synthesize order;
@synthesize trackTypeObject;
@synthesize trackType = trackType_;
@synthesize trackPathStartString = trackPathStartString_;

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
@synthesize monthlyLogNotes = monthlyLogNotes_;
@synthesize doctorateLevel;

- (id) initWithDoctorateLevel:(BOOL)doctoarateLevelSelected clinician:(ClinicianEntity *)supervisor trackTypeObject:(id)trackTypeObjectGiven
{
    //override superclass
    self = [super initWithDoctorateLevel:doctoarateLevelSelected clinician:supervisor trainingProgram:nil];

    if (self)
    {
        self.doctorateLevel = doctoarateLevelSelected;

        self.clinician = supervisor;
        self.trackType = [self trackTypeForObjectGiven:trackTypeObjectGiven];

        NSPredicate *predicateForTrackEntities = [NSPredicate predicateWithFormat:@"trainingProgram.doctorateLevel == %@",[NSNumber numberWithBool:doctoarateLevelSelected]];

        NSPredicate *predicateForExistingHoursEntities = [NSPredicate predicateWithFormat:@"existingHours.programCourse.doctorateLevel == %@",[NSNumber numberWithBool:doctoarateLevelSelected]];

        self.order = (NSUInteger)[self.trackTypeObject valueForKey : @"order"];

        self.trackTypeObject = trackTypeObjectGiven;

        switch (trackType_)
        {
            case kTrackTypeIntervention:
            {
                if ([trackTypeObjectGiven isKindOfClass:[InterventionTypeEntity class]])
                {
                    InterventionTypeEntity *interventionType = (InterventionTypeEntity *)trackTypeObjectGiven;

                    self.typeLabelText = interventionType.interventionType;
                    NSSet *allInterventionDeliveredForType = nil;
                    [interventionType willAccessValueForKey:@"supportActivitiesDelivered"];
                    if (interventionType.interventionsDelivered)
                    {
                        allInterventionDeliveredForType = [interventionType valueForKey:@"interventionsDelivered"];
                    }

                    if (allInterventionDeliveredForType && allInterventionDeliveredForType.count  )
                    {
                        if (predicateForTrackEntities)
                        {
                            self.interventionsDeliveredArray = [allInterventionDeliveredForType filteredSetUsingPredicate:predicateForTrackEntities];
                        }
                        else
                        {
                            self.interventionsDeliveredArray = allInterventionDeliveredForType;
                        }
                    }

                    NSSet *allExistingInterventionsSetForType = nil;

                    if (interventionType.existingInterventions)
                    {
                        [interventionType willAccessValueForKey:@"existingInterventions"];
                        allExistingInterventionsSetForType = [interventionType valueForKey:@"existingInterventions"];

                        if (predicateForExistingHoursEntities)
                        {
                            self.existingHInterventionrray = [allExistingInterventionsSetForType filteredSetUsingPredicate:predicateForExistingHoursEntities];
                        }
                    }
                }
            }
            break;
            case kTrackTypeInterventionSubType:
            {
                if ([trackTypeObjectGiven isKindOfClass:[InterventionTypeSubtypeEntity class]])
                {
                    InterventionTypeSubtypeEntity *interventionSubType = (InterventionTypeSubtypeEntity *)trackTypeObjectGiven;

                    self.typeLabelText = interventionSubType.interventionSubType;

                    NSSet *allInterventionDeliveredForType = nil;
                    [interventionSubType willAccessValueForKey:@"interventionsDelivered"];
                    if (interventionSubType.interventionsDelivered)
                    {
                        allInterventionDeliveredForType = [interventionSubType valueForKey:@"interventionsDelivered"];
                    }

                    if (allInterventionDeliveredForType && allInterventionDeliveredForType.count  )
                    {
                        if (predicateForTrackEntities)
                        {
                            self.interventionsDeliveredArray = [allInterventionDeliveredForType filteredSetUsingPredicate:predicateForTrackEntities];
                        }
                        else
                        {
                            self.interventionsDeliveredArray = allInterventionDeliveredForType;
                        }
                    }

                    NSSet *allExistingInterventionsSetForSubType = nil;

                    if (interventionSubType.existingInterventions)
                    {
                        [interventionSubType willAccessValueForKey:@"existingInterventions"];
                        allExistingInterventionsSetForSubType = [interventionSubType valueForKey:@"existingInterventions"];

                        if (predicateForExistingHoursEntities)
                        {
                            self.existingHInterventionrray = [allExistingInterventionsSetForSubType filteredSetUsingPredicate:predicateForExistingHoursEntities];
                        }
                    }
                }
            }
            break;
            case kTrackTypeAssessment:
            {
                if ([trackTypeObjectGiven isKindOfClass:[AssessmentTypeEntity class]])
                {
                    AssessmentTypeEntity *assessmentType = (AssessmentTypeEntity *)trackTypeObjectGiven;

                    self.typeLabelText = assessmentType.assessmentType;

                    NSSet *allAssessmentsDeliveredForType = nil;
                    [assessmentType willAccessValueForKey:@"supportActivitiesDelivered"];
                    if (assessmentType.assessments)
                    {
                        allAssessmentsDeliveredForType = [assessmentType valueForKey:@"assessments"];
                    }

                    if (allAssessmentsDeliveredForType && allAssessmentsDeliveredForType.count  )
                    {
                        if (predicateForTrackEntities)
                        {
                            self.assessmentsDeliveredArray = [allAssessmentsDeliveredForType filteredSetUsingPredicate:predicateForTrackEntities];
                        }
                        else
                        {
                            self.assessmentsDeliveredArray = allAssessmentsDeliveredForType;
                        }
                    }

                    NSSet *allExistingAssessmentsSetForSubType = nil;

                    if (assessmentType.existingAssessments)
                    {
                        [assessmentType willAccessValueForKey:@"existingAssessments"];
                        allExistingAssessmentsSetForSubType = [assessmentType valueForKey:@"existingAssessments"];

                        if (predicateForExistingHoursEntities)
                        {
                            self.existingAssessmentArray = [allExistingAssessmentsSetForSubType filteredSetUsingPredicate:predicateForExistingHoursEntities];
                        }
                    }
                }
            }
            break;
            case kTrackTypeSupport:
            {
                if ([trackTypeObjectGiven isKindOfClass:[SupportActivityTypeEntity class]])
                {
                    SupportActivityTypeEntity *supportActivityType = (SupportActivityTypeEntity *)trackTypeObjectGiven;

                    self.typeLabelText = supportActivityType.supportActivityType;

                    NSSet *allSuppoetActivityDeliveredForType = nil;
                    [supportActivityType willAccessValueForKey:@"supportActivitiesDelivered"];
                    if (supportActivityType.supportActivitiesDelivered)
                    {
                        allSuppoetActivityDeliveredForType = [supportActivityType valueForKey:@"supportActivitiesDelivered"];
                    }

                    if (allSuppoetActivityDeliveredForType && allSuppoetActivityDeliveredForType.count  )
                    {
                        if (predicateForTrackEntities)
                        {
                            self.supportActivityDeliveredArray = [allSuppoetActivityDeliveredForType filteredSetUsingPredicate:predicateForTrackEntities];
                        }
                        else
                        {
                            self.supportActivityDeliveredArray = allSuppoetActivityDeliveredForType;
                        }
                    }

                    NSSet *allExistingSupportActivityReceivedSetForType = nil;

                    if (supportActivityType.existingSupportActivities)
                    {
                        allExistingSupportActivityReceivedSetForType = [supportActivityType valueForKey:@"existingSupportActivities"];

                        if (predicateForExistingHoursEntities)
                        {
                            self.existingSupportArray = [allExistingSupportActivityReceivedSetForType filteredSetUsingPredicate:predicateForExistingHoursEntities];
                        }
                    }
                }
            }
            break;
            case kTrackTypeSupervision:
            {
                if ([trackTypeObjectGiven isKindOfClass:[SupervisionTypeEntity class]])
                {
                    SupervisionTypeEntity *supervisionType = (SupervisionTypeEntity *)trackTypeObjectGiven;

                    self.typeLabelText = supervisionType.supervisionType;

                    NSSet *allSupervisionReceivedForType = nil;
                    if (supervisionType.supervisionRecieved)
                    {
                        allSupervisionReceivedForType = [supervisionType valueForKey:@"supervisionRecieved"];
                    }

                    if (allSupervisionReceivedForType && allSupervisionReceivedForType.count  )
                    {
                        if (predicateForTrackEntities)
                        {
                            self.supervisionReceivedArray = [allSupervisionReceivedForType filteredSetUsingPredicate:predicateForTrackEntities];
                        }
                        else
                        {
                            self.supervisionReceivedArray = allSupervisionReceivedForType;
                        }
                    }

                    NSSet *allExistingSupervisionReceivedSetForType = nil;

                    if (supervisionType.existingSupervision)
                    {
                        [supervisionType willAccessValueForKey:@"existingSupervision"];
                        allExistingSupervisionReceivedSetForType = [supervisionType valueForKey:@"existingSupervision"];

                        if (predicateForExistingHoursEntities)
                        {
                            self.existingSupervisionArray = [allExistingSupervisionReceivedSetForType filteredSetUsingPredicate:predicateForExistingHoursEntities];
                        }
                    }
                }
            }
            break;
            case kTrackTypeSupervisionSubType:
            {
                if ([trackTypeObjectGiven isKindOfClass:[SupervisionTypeSubtypeEntity class]])
                {
                    SupervisionTypeSubtypeEntity *supervisionSubType = (SupervisionTypeSubtypeEntity *)trackTypeObjectGiven;

                    self.typeLabelText = supervisionSubType.subType;

                    NSSet *allSupervisionReceivedForSubType = nil;
                    [supervisionSubType willAccessValueForKey:@"supervisionReceived"];
                    if (supervisionSubType.supervisionReceived)
                    {
                        allSupervisionReceivedForSubType = [supervisionSubType valueForKey:@"supervisionReceived"];
                    }

                    if (allSupervisionReceivedForSubType && allSupervisionReceivedForSubType.count  )
                    {
                        if (predicateForTrackEntities)
                        {
                            self.supervisionReceivedArray = [allSupervisionReceivedForSubType filteredSetUsingPredicate:predicateForTrackEntities];
                        }
                        else
                        {
                            self.supervisionReceivedArray = allSupervisionReceivedForSubType;
                        }
                    }

                    NSSet *allExistingSupervisionReceivedSetForSubType = nil;

                    if (supervisionSubType.existingSupervision)
                    {
                        allExistingSupervisionReceivedSetForSubType = [supervisionSubType valueForKey:@"existingSupervision"];

                        if (predicateForExistingHoursEntities)
                        {
                            self.existingSupervisionArray = [allExistingSupervisionReceivedSetForSubType filteredSetUsingPredicate:predicateForExistingHoursEntities];
                        }
                    }
                }
            }
            break;
            case kTrackTypeUnknown:
            {
                PTTAppDelegate *appDelegate = (PTTAppDelegate *)[UIApplication sharedApplication].delegate;

                [appDelegate displayNotification:@"Track type object class was not identified"];
            }
            break;

            default:
                break;
        } /* switch */

        self.monthlyLogNotes = [self monthlyLogNotesForMonth];

        if (trackType_ == kTrackTypeIntervention || trackType_ == kTrackTypeSupervision || !self.monthToDisplay)
        {
            [ self totalOverallHoursTIForOveralCell:(PTSummaryCell)kSummaryTotalToDate clinician:(ClinicianEntity *)supervisor];
        }
        else if (trackType_ != kTrackTypeUnknown)
        {
            for (NSInteger i = 0; i < 9; i++)
            {
                [ self totalOverallHoursTIForOveralCell:(PTSummaryCell)i clinician:(ClinicianEntity *)supervisor];
            }
        }
    }

    return self;
}


- (id) initWithMonth:(NSDate *)date clinician:(ClinicianEntity *)clinician trackTypeObject:(id)trackTypeObjectGiven trainingProgram:(TrainingProgramEntity *)trainingProgramGiven
{
    //override superclass
    self = [super initWithMonth:date clinician:clinician trainingProgram:trainingProgramGiven];

    if (self)
    {
        self.clinician = clinician;
        self.trackType = [self trackTypeForObjectGiven:trackTypeObjectGiven];

        NSPredicate *predicateForTrackEntities = nil;

        NSPredicate *predicateForExistingHoursEntities = nil;

        if (date)
        {
            predicateForTrackEntities = [self predicateForTrackEntitiesAllBeforeAndEqualToEndDateForMonth];

            predicateForExistingHoursEntities = [NSPredicate predicateWithFormat:@" (existingHours.endDate <= %@)", monthEndDate_];
        }

        NSPredicate *predicateForTrackTrainingProgram = nil;
        NSPredicate *predicateForExistingHoursProgramCourse = nil;
        if (trainingProgramGiven)
        {
            predicateForTrackTrainingProgram = [self predicateForTrackTrainingProgram];
            predicateForExistingHoursProgramCourse = [self predicateForExistingHoursProgramCourse];
        }

        self.trackTypeObject = trackTypeObjectGiven;

        switch (trackType_)
        {
            case kTrackTypeIntervention:
            {
                if ([trackTypeObjectGiven isKindOfClass:[InterventionTypeEntity class]])
                {
                    InterventionTypeEntity *interventionType = (InterventionTypeEntity *)trackTypeObjectGiven;

                    self.typeLabelText = interventionType.interventionType;
                    NSSet *allInterventionDeliveredForType = nil;
                    [interventionType willAccessValueForKey:@"supportActivitiesDelivered"];
                    if (interventionType.interventionsDelivered)
                    {
                        allInterventionDeliveredForType = [interventionType valueForKey:@"interventionsDelivered"];
                    }

                    if (allInterventionDeliveredForType && allInterventionDeliveredForType.count  )
                    {
                        NSSet *tempInterventionDeliveredArray = nil;
                        if (predicateForTrackEntities)
                        {
                            tempInterventionDeliveredArray = [allInterventionDeliveredForType filteredSetUsingPredicate:predicateForTrackEntities];
                        }
                        else
                        {
                            tempInterventionDeliveredArray = allInterventionDeliveredForType;
                        }

                        if (tempInterventionDeliveredArray && tempInterventionDeliveredArray.count && predicateForTrackTrainingProgram)
                        {
                            self.interventionsDeliveredArray = [tempInterventionDeliveredArray filteredSetUsingPredicate:predicateForTrackTrainingProgram];
                        }
                        else
                        {
                            self.interventionsDeliveredArray = allInterventionDeliveredForType;
                        }
                    }

                    NSSet *allExistingInterventionsSetForType = nil;

                    if (interventionType.existingInterventions)
                    {
                        [interventionType willAccessValueForKey:@"existingInterventions"];
                        allExistingInterventionsSetForType = [interventionType valueForKey:@"existingInterventions"];

                        if (predicateForExistingHoursEntities)
                        {
                            allExistingInterventionsSetForType = [allExistingInterventionsSetForType filteredSetUsingPredicate:predicateForExistingHoursEntities];
                        }
                    }

                    if (allExistingInterventionsSetForType && allExistingInterventionsSetForType.count && predicateForExistingHoursProgramCourse)
                    {
                        self.existingHInterventionrray = [allExistingInterventionsSetForType filteredSetUsingPredicate:[NSPredicate predicateWithFormat:@"existingHours.programCourse.objectID == %@", trainingProgram_.objectID]];
                    }
                }
            }
            break;
            case kTrackTypeInterventionSubType:
            {
                if ([trackTypeObjectGiven isKindOfClass:[InterventionTypeSubtypeEntity class]])
                {
                    InterventionTypeSubtypeEntity *interventionSubType = (InterventionTypeSubtypeEntity *)trackTypeObjectGiven;

                    self.typeLabelText = interventionSubType.interventionSubType;

                    NSSet *allInterventionDeliveredForType = nil;
                    [interventionSubType willAccessValueForKey:@"interventionsDelivered"];
                    if (interventionSubType.interventionsDelivered)
                    {
                        allInterventionDeliveredForType = [interventionSubType valueForKey:@"interventionsDelivered"];
                    }

                    if (allInterventionDeliveredForType && allInterventionDeliveredForType.count  )
                    {
                        NSSet *tempInterventionDeliveredArray = nil;
                        if (predicateForTrackEntities)
                        {
                            tempInterventionDeliveredArray = [allInterventionDeliveredForType filteredSetUsingPredicate:predicateForTrackEntities];
                        }
                        else
                        {
                            tempInterventionDeliveredArray = allInterventionDeliveredForType;
                        }

                        if (tempInterventionDeliveredArray && tempInterventionDeliveredArray.count && predicateForTrackTrainingProgram)
                        {
                            self.interventionsDeliveredArray = [tempInterventionDeliveredArray filteredSetUsingPredicate:predicateForTrackTrainingProgram];
                        }
                        else
                        {
                            self.interventionsDeliveredArray = allInterventionDeliveredForType;
                        }
                    }

                    NSSet *allExistingInterventionsSetForSubType = nil;

                    if (interventionSubType.existingInterventions)
                    {
                        [interventionSubType willAccessValueForKey:@"existingInterventions"];
                        allExistingInterventionsSetForSubType = [interventionSubType valueForKey:@"existingInterventions"];

                        if (predicateForExistingHoursEntities)
                        {
                            allExistingInterventionsSetForSubType = [allExistingInterventionsSetForSubType filteredSetUsingPredicate:predicateForExistingHoursEntities];
                        }
                    }

                    if (allExistingInterventionsSetForSubType && allExistingInterventionsSetForSubType.count && predicateForExistingHoursProgramCourse)
                    {
                        self.existingHInterventionrray = [allExistingInterventionsSetForSubType filteredSetUsingPredicate:[NSPredicate predicateWithFormat:@"existingHours.programCourse.objectID == %@", trainingProgram_.objectID]];
                    }
                }
            }
            break;
            case kTrackTypeAssessment:
            {
                if ([trackTypeObjectGiven isKindOfClass:[AssessmentTypeEntity class]])
                {
                    AssessmentTypeEntity *assessmentType = (AssessmentTypeEntity *)trackTypeObjectGiven;

                    self.typeLabelText = assessmentType.assessmentType;

                    NSSet *allAssessmentsDeliveredForType = nil;
                    [assessmentType willAccessValueForKey:@"supportActivitiesDelivered"];
                    if (assessmentType.assessments)
                    {
                        allAssessmentsDeliveredForType = [assessmentType valueForKey:@"assessments"];
                    }

                    if (allAssessmentsDeliveredForType && allAssessmentsDeliveredForType.count  )
                    {
                        NSSet *tempAssessmentsDeliveredArray = nil;
                        if (predicateForTrackEntities)
                        {
                            tempAssessmentsDeliveredArray = [allAssessmentsDeliveredForType filteredSetUsingPredicate:predicateForTrackEntities];
                        }
                        else
                        {
                            tempAssessmentsDeliveredArray = allAssessmentsDeliveredForType;
                        }

                        if (tempAssessmentsDeliveredArray && tempAssessmentsDeliveredArray.count && predicateForTrackTrainingProgram)
                        {
                            self.assessmentsDeliveredArray = [tempAssessmentsDeliveredArray filteredSetUsingPredicate:predicateForTrackTrainingProgram];
                        }
                        else
                        {
                            self.assessmentsDeliveredArray = allAssessmentsDeliveredForType;
                        }
                    }

                    NSSet *allExistingAssessmentsSetForSubType = nil;

                    if (assessmentType.existingAssessments)
                    {
                        [assessmentType willAccessValueForKey:@"existingAssessments"];
                        allExistingAssessmentsSetForSubType = [assessmentType valueForKey:@"existingAssessments"];

                        if (predicateForExistingHoursEntities)
                        {
                            allExistingAssessmentsSetForSubType = [allExistingAssessmentsSetForSubType filteredSetUsingPredicate:predicateForExistingHoursEntities];
                        }
                    }

                    if (allExistingAssessmentsSetForSubType && allExistingAssessmentsSetForSubType.count && predicateForExistingHoursProgramCourse)
                    {
                        self.existingAssessmentArray = [allExistingAssessmentsSetForSubType filteredSetUsingPredicate:[NSPredicate predicateWithFormat:@"existingHours.programCourse.objectID == %@", trainingProgram_.objectID]];
                    }
                }
            }
            break;
            case kTrackTypeSupport:
            {
                if ([trackTypeObjectGiven isKindOfClass:[SupportActivityTypeEntity class]])
                {
                    SupportActivityTypeEntity *supportActivityType = (SupportActivityTypeEntity *)trackTypeObjectGiven;

                    self.typeLabelText = supportActivityType.supportActivityType;

                    NSSet *allSuppoetActivityDeliveredForType = nil;
                    [supportActivityType willAccessValueForKey:@"supportActivitiesDelivered"];
                    if (supportActivityType.supportActivitiesDelivered)
                    {
                        allSuppoetActivityDeliveredForType = [supportActivityType valueForKey:@"supportActivitiesDelivered"];
                    }

                    if (allSuppoetActivityDeliveredForType && allSuppoetActivityDeliveredForType.count  )
                    {
                        NSSet *tempSupportAcitivtyDeliveredArray = nil;
                        if (predicateForTrackEntities)
                        {
                            tempSupportAcitivtyDeliveredArray = [allSuppoetActivityDeliveredForType filteredSetUsingPredicate:predicateForTrackEntities];
                        }
                        else
                        {
                            tempSupportAcitivtyDeliveredArray = allSuppoetActivityDeliveredForType;
                        }

                        if (tempSupportAcitivtyDeliveredArray && tempSupportAcitivtyDeliveredArray.count && predicateForTrackTrainingProgram)
                        {
                            self.supportActivityDeliveredArray = [tempSupportAcitivtyDeliveredArray filteredSetUsingPredicate:predicateForTrackTrainingProgram];
                        }
                        else
                        {
                            self.supportActivityDeliveredArray = allSuppoetActivityDeliveredForType;
                        }
                    }

                    NSSet *allExistingSupportActivityReceivedSetForSubType = nil;

                    if (supportActivityType.existingSupportActivities)
                    {
                        allExistingSupportActivityReceivedSetForSubType = [supportActivityType valueForKey:@"existingSupportActivities"];

                        if (predicateForExistingHoursEntities)
                        {
                            allExistingSupportActivityReceivedSetForSubType = [allExistingSupportActivityReceivedSetForSubType filteredSetUsingPredicate:predicateForExistingHoursEntities];
                        }
                    }

                    if (allExistingSupportActivityReceivedSetForSubType && allExistingSupportActivityReceivedSetForSubType.count && predicateForExistingHoursProgramCourse)
                    {
                        self.existingSupportArray = [allExistingSupportActivityReceivedSetForSubType filteredSetUsingPredicate:[NSPredicate predicateWithFormat:@"existingHours.programCourse.objectID == %@", trainingProgram_.objectID]];
                    }
                }
            }
            break;
            case kTrackTypeSupervision:
            {
                if ([trackTypeObjectGiven isKindOfClass:[SupervisionTypeEntity class]])
                {
                    SupervisionTypeEntity *supervisionType = (SupervisionTypeEntity *)trackTypeObjectGiven;

                    self.typeLabelText = supervisionType.supervisionType;

                    NSSet *allSupervisionReceivedForType = nil;
                    if (supervisionType.supervisionRecieved)
                    {
                        allSupervisionReceivedForType = [supervisionType valueForKey:@"supervisionRecieved"];
                    }

                    if (allSupervisionReceivedForType && allSupervisionReceivedForType.count  )
                    {
                        NSSet *tempSupervisionDeliveredArray = nil;
                        if (predicateForTrackEntities)
                        {
                            tempSupervisionDeliveredArray = [allSupervisionReceivedForType filteredSetUsingPredicate:predicateForTrackEntities];
                        }
                        else
                        {
                            tempSupervisionDeliveredArray = allSupervisionReceivedForType;
                        }

                        if (tempSupervisionDeliveredArray && tempSupervisionDeliveredArray.count && predicateForTrackTrainingProgram)
                        {
                            self.supervisionReceivedArray = [tempSupervisionDeliveredArray filteredSetUsingPredicate:predicateForTrackTrainingProgram];
                        }
                        else
                        {
                            self.supervisionReceivedArray = allSupervisionReceivedForType;
                        }
                    }

                    NSSet *allExistingSupervisionReceivedSetForType = nil;

                    if (supervisionType.existingSupervision)
                    {
                        allExistingSupervisionReceivedSetForType = [supervisionType valueForKey:@"existingSupervision"];
                        if (predicateForExistingHoursEntities)
                        {
                            allExistingSupervisionReceivedSetForType = [allExistingSupervisionReceivedSetForType filteredSetUsingPredicate:predicateForExistingHoursEntities];
                        }
                    }

                    if (allExistingSupervisionReceivedSetForType && allExistingSupervisionReceivedSetForType.count && predicateForExistingHoursProgramCourse)
                    {
                        self.existingSupervisionArray = [allExistingSupervisionReceivedSetForType filteredSetUsingPredicate:[NSPredicate predicateWithFormat:@"existingHours.programCourse.objectID == %@", trainingProgram_.objectID]];
                    }
                }
            }
            break;
            case kTrackTypeSupervisionSubType:
            {
                if ([trackTypeObjectGiven isKindOfClass:[SupervisionTypeSubtypeEntity class]])
                {
                    SupervisionTypeSubtypeEntity *supervisionSubType = (SupervisionTypeSubtypeEntity *)trackTypeObjectGiven;

                    self.typeLabelText = supervisionSubType.subType;

                    NSSet *allSupervisionReceivedForSubType = nil;
                    [supervisionSubType willAccessValueForKey:@"supervisionReceived"];
                    if (supervisionSubType.supervisionReceived)
                    {
                        allSupervisionReceivedForSubType = [supervisionSubType valueForKey:@"supervisionReceived"];
                    }

                    if (allSupervisionReceivedForSubType && allSupervisionReceivedForSubType.count  )
                    {
                        NSSet *tempSupervisionDeliveredArray = nil;
                        if (predicateForTrackEntities)
                        {
                            tempSupervisionDeliveredArray = [allSupervisionReceivedForSubType filteredSetUsingPredicate:predicateForTrackEntities];
                        }
                        else
                        {
                            tempSupervisionDeliveredArray = allSupervisionReceivedForSubType;
                        }

                        if (tempSupervisionDeliveredArray && tempSupervisionDeliveredArray.count && predicateForTrackTrainingProgram)
                        {
                            self.supervisionReceivedArray = [tempSupervisionDeliveredArray filteredSetUsingPredicate:predicateForTrackTrainingProgram];
                        }
                        else
                        {
                            self.supervisionReceivedArray = allSupervisionReceivedForSubType;
                        }
                    }

                    NSSet *allExistingSupervisionReceivedSetForSubType = nil;

                    if (supervisionSubType.existingSupervision)
                    {
                        allExistingSupervisionReceivedSetForSubType = [supervisionSubType valueForKey:@"existingSupervision"];

                        if (predicateForExistingHoursEntities)
                        {
                            allExistingSupervisionReceivedSetForSubType = [allExistingSupervisionReceivedSetForSubType filteredSetUsingPredicate:predicateForExistingHoursEntities];
                        }
                    }

                    if (allExistingSupervisionReceivedSetForSubType && allExistingSupervisionReceivedSetForSubType.count && predicateForExistingHoursProgramCourse)
                    {
                        self.existingSupervisionArray = [allExistingSupervisionReceivedSetForSubType filteredSetUsingPredicate:[NSPredicate predicateWithFormat:@"existingHours.programCourse.objectID == %@", trainingProgram_.objectID]];
                    }
                }
            }
            break;
            case kTrackTypeUnknown:
            {
                PTTAppDelegate *appDelegate = (PTTAppDelegate *)[UIApplication sharedApplication].delegate;

                [appDelegate displayNotification:@"Track type object class was not identified"];
            }
            break;

            default:
                break;
        } /* switch */

        self.monthlyLogNotes = [self monthlyLogNotesForMonth];

        if (trackType_ == kTrackTypeIntervention || trackType_ == kTrackTypeSupervision || !self.monthToDisplay)
        {
            [ self totalOverallHoursTIForOveralCell:(PTSummaryCell)kSummaryTotalToDate clinician:(ClinicianEntity *)clinician];
        }
        else if (trackType_ != kTrackTypeUnknown)
        {
            for (NSInteger i = 0; i < 9; i++)
            {
                [ self totalOverallHoursTIForOveralCell:(PTSummaryCell)i clinician:(ClinicianEntity *)clinician];
            }
        }
    }

    return self;
}


- (PTrackType) trackTypeForObjectGiven:(id)trackTypeObjectGiven
{
    PTrackType trackTypeToReturn = kTrackTypeUnknown;

    if ([trackTypeObjectGiven isKindOfClass:[InterventionTypeEntity class]])
    {
        return kTrackTypeIntervention;
    }
    else if ([trackTypeObjectGiven isKindOfClass:[InterventionTypeSubtypeEntity class]])
    {
        return kTrackTypeInterventionSubType;
    }
    else if ([trackTypeObjectGiven isKindOfClass:[AssessmentTypeEntity class]])
    {
        return kTrackTypeAssessment;
    }
    else if ([trackTypeObjectGiven isKindOfClass:[SupportActivityTypeEntity class]])
    {
        return kTrackTypeSupport;
    }
    else if ([trackTypeObjectGiven isKindOfClass:[SupervisionTypeEntity class]])
    {
        return kTrackTypeSupervision;
    }
    else if ([trackTypeObjectGiven isKindOfClass:[SupervisionTypeSubtypeEntity class]])
    {
        return kTrackTypeSupervisionSubType;
    }

    return trackTypeToReturn;
}


- (void) totalOverallHoursTIForOveralCell:(PTSummaryCell)summaryCell clinician:(ClinicianEntity *)clinician
{
    NSPredicate *trackPredicate = nil;
    NSPredicate *existingHoursPredicate = nil;

    switch (summaryCell)
    {
        case kSummaryWeekOne:
        {
            trackPredicate = [self predicateForTrackWeek:kTrackWeekOne];
            existingHoursPredicate = [self predicateForExistingHoursWeek:kTrackWeekOne];
        }
        break;
        case kSummaryWeekTwo:
        {
            trackPredicate = [self predicateForTrackWeek:kTrackWeekTwo];
            existingHoursPredicate = [self predicateForExistingHoursWeek:kTrackWeekTwo];
        }
        break;
        case kSummaryWeekThree:
        {
            trackPredicate = [self predicateForTrackWeek:kTrackWeekThree];
            existingHoursPredicate = [self predicateForExistingHoursWeek:kTrackWeekThree];
        }
        break;
        case kSummaryWeekFour:
        {
            trackPredicate = [self predicateForTrackWeek:kTrackWeekFour];
            existingHoursPredicate = [self predicateForExistingHoursWeek:kTrackWeekFour];
        }
        break;
        case kSummaryWeekFive:
        {
            trackPredicate = [self predicateForTrackWeek:kTrackWeekFive];
            existingHoursPredicate = [self predicateForExistingHoursWeek:kTrackWeekFive];
        }
        break;
        case kSummaryWeekUndefined:
        {
            existingHoursPredicate = [self predicateForExistingHoursWeekUndefined];
        }
        break;
        case kSummaryTotalForMonth:
        {
            trackPredicate = [self predicateForTrackCurrentMonth];
            existingHoursPredicate = [self predicateForExistingHoursCurrentMonth];
        }
        break;
        case kSummaryCummulative:
        {
            trackPredicate = [self priorMonthsHoursPredicate];
            existingHoursPredicate = [self predicateForExistingHoursAllBeforeEndDate:monthStartDate_];
        }
        break;
        case kSummaryTotalToDate:
        {
            trackPredicate = nil;
            existingHoursPredicate = nil;
        }
        break;

        default:
            break;
    } /* switch */

    NSTimeInterval trackTotalInterventionTimeInterval = 0;
    NSTimeInterval trackTotalAssessmentInterval = 0;
    NSTimeInterval trackTotalSupportTimeInterval = 0;
    NSTimeInterval trackTotalSupervisionReceivedTimeInterval = 0;

    NSTimeInterval totalExistingInterventionsTI = 0;
    NSTimeInterval totalExistingAssessmentsTI = 0;
    NSTimeInterval totalExistingSupportTI = 0;
    NSTimeInterval totalExistingSupervisionReceivedTI = 0;

    switch (trackType_)
    {
        case kTrackTypeIntervention:
        {
            if (summaryCell != kTrackWeekUndefined)
            {
                trackTotalInterventionTimeInterval = [self totalTimeIntervalForTrackArray:self.interventionsDeliveredArray predicate:trackPredicate];
            }

            NSSet *filteredExistingInterventionTypeSet = nil;

            if (existingHoursPredicate)
            {
                filteredExistingInterventionTypeSet = [self.existingHInterventionrray filteredSetUsingPredicate:existingHoursPredicate];
            }
            else
            {
                filteredExistingInterventionTypeSet = self.existingHInterventionrray;
            }

            totalExistingInterventionsTI = [self totalTimeIntervalForExistingHoursArray:filteredExistingInterventionTypeSet.allObjects];

            break;
        }
        case kTrackTypeInterventionSubType:
        {
            if (summaryCell != kTrackWeekUndefined)
            {
                trackTotalInterventionTimeInterval = [self totalTimeIntervalForTrackArray:self.interventionsDeliveredArray predicate:trackPredicate];
            }

            NSSet *filteredExistingInterventionSubtypeSet = nil;

            if (existingHoursPredicate)
            {
                filteredExistingInterventionSubtypeSet = [self.existingHInterventionrray filteredSetUsingPredicate:existingHoursPredicate];
            }
            else
            {
                filteredExistingInterventionSubtypeSet = self.existingHInterventionrray;
            }

            totalExistingInterventionsTI = [self totalTimeIntervalForExistingHoursArray:filteredExistingInterventionSubtypeSet.allObjects];

            break;
        }
        case kTrackTypeAssessment:
        {
            if (summaryCell != kTrackWeekUndefined)
            {
                trackTotalAssessmentInterval = [self totalTimeIntervalForTrackArray:self.assessmentsDeliveredArray predicate:trackPredicate];
            }

            NSSet *filteredExistingAssessmentSet = nil;

            if (existingHoursPredicate)
            {
                filteredExistingAssessmentSet = [self.existingAssessmentArray filteredSetUsingPredicate:existingHoursPredicate];
            }
            else
            {
                filteredExistingAssessmentSet = self.existingAssessmentArray;
            }

            totalExistingAssessmentsTI = [self totalTimeIntervalForExistingHoursArray:filteredExistingAssessmentSet.allObjects];
        }

        break;
        case kTrackTypeSupport:
        {
            if (summaryCell != kTrackWeekUndefined)
            {
                trackTotalSupportTimeInterval = [self totalTimeIntervalForTrackArray:self.supportActivityDeliveredArray predicate:trackPredicate];
            }

            NSSet *filteredExistingSupportSet = nil;

            if (existingHoursPredicate)
            {
                filteredExistingSupportSet = [self.existingSupportArray filteredSetUsingPredicate:existingHoursPredicate];
            }
            else
            {
                filteredExistingSupportSet = self.existingSupportArray;
            }

            totalExistingSupportTI = [self totalTimeIntervalForExistingHoursArray:filteredExistingSupportSet.allObjects];
        }

        break;

        case kTrackTypeSupervision:
        {
            if (summaryCell != kTrackWeekUndefined)
            {
                trackTotalSupervisionReceivedTimeInterval = [self totalTimeIntervalForTrackArray:self.supervisionReceivedArray predicate:trackPredicate];
            }

            NSSet *filteredExistingSupervisionReceivedSet = nil;

            if (self.existingSupervisionArray && existingHoursPredicate)
            {
                filteredExistingSupervisionReceivedSet = [self.existingSupervisionArray filteredSetUsingPredicate:existingHoursPredicate];
            }
            else
            {
                filteredExistingSupervisionReceivedSet = self.existingSupervisionArray;
            }

            totalExistingSupervisionReceivedTI = [self totalTimeIntervalForExistingHoursArray:filteredExistingSupervisionReceivedSet.allObjects];

            break;
        }

        case kTrackTypeSupervisionSubType:
        {
            if (summaryCell != kTrackWeekUndefined)
            {
                trackTotalSupervisionReceivedTimeInterval = [self totalTimeIntervalForTrackArray:self.supervisionReceivedArray predicate:trackPredicate];
            }

            NSSet *filteredExistingSupervisionReceivedSet = nil;

            if (existingHoursPredicate)
            {
                filteredExistingSupervisionReceivedSet = [self.existingSupervisionArray filteredSetUsingPredicate:existingHoursPredicate];
            }
            else
            {
                filteredExistingSupervisionReceivedSet = self.existingSupervisionArray;
            }

            totalExistingSupervisionReceivedTI = [self totalTimeIntervalForExistingHoursArray:filteredExistingSupervisionReceivedSet.allObjects];

            break;
        }

        default:
            break;
    } /* switch */

//    NSTimeInterval overallTotalTI=0;

    switch (summaryCell)
    {
        case kSummaryWeekOne:
        {
            if (trackType_ == kTrackTypeIntervention || trackType_ == kTrackTypeInterventionSubType)
            {
                self.totalWeek1TI = trackTotalInterventionTimeInterval + totalExistingInterventionsTI;
            }

            if (trackType_ == kTrackTypeAssessment)
            {
                self.totalWeek1TI = trackTotalAssessmentInterval + totalExistingAssessmentsTI;
            }

            if (trackType_ == kTrackTypeSupport)
            {
                self.totalWeek1TI = trackTotalSupportTimeInterval + totalExistingSupportTI;
            }

            if (trackType_ == kTrackTypeSupervision || trackType_ == kTrackTypeSupervisionSubType)
            {
                self.totalWeek1TI = trackTotalSupervisionReceivedTimeInterval + totalExistingSupervisionReceivedTI;
            }

            self.totalWeek1Str = [self totalTimeStr:self.totalWeek1TI];
        }
        break;
        case kSummaryWeekTwo:
        {
            if (trackType_ == kTrackTypeIntervention || trackType_ == kTrackTypeInterventionSubType)
            {
                self.totalWeek2TI = trackTotalInterventionTimeInterval + totalExistingInterventionsTI;
            }

            if (trackType_ == kTrackTypeAssessment)
            {
                self.totalWeek2TI = trackTotalAssessmentInterval + totalExistingAssessmentsTI;
            }

            if (trackType_ == kTrackTypeSupport)
            {
                self.totalWeek2TI = trackTotalSupportTimeInterval + totalExistingSupportTI;
            }

            if (trackType_ == kTrackTypeSupervision || trackType_ == kTrackTypeSupervisionSubType)
            {
                self.totalWeek2TI = trackTotalSupervisionReceivedTimeInterval + totalExistingSupervisionReceivedTI;
            }

            self.totalWeek2Str = [self totalTimeStr:self.totalWeek2TI];
        }
        break;
        case kSummaryWeekThree:
        {
            if (trackType_ == kTrackTypeIntervention || trackType_ == kTrackTypeInterventionSubType)
            {
                self.totalWeek3TI = trackTotalInterventionTimeInterval + totalExistingInterventionsTI;
            }

            if (trackType_ == kTrackTypeAssessment)
            {
                self.totalWeek3TI = trackTotalAssessmentInterval + totalExistingAssessmentsTI;
            }

            if (trackType_ == kTrackTypeSupport)
            {
                self.totalWeek3TI = trackTotalSupportTimeInterval + totalExistingSupportTI;
            }

            if (trackType_ == kTrackTypeSupervision || trackType_ == kTrackTypeSupervisionSubType)
            {
                self.totalWeek3TI = trackTotalSupervisionReceivedTimeInterval + totalExistingSupervisionReceivedTI;
            }

            self.totalWeek3Str = [self totalTimeStr:self.totalWeek3TI];
        }
        break;
        case kSummaryWeekFour:
        {
            if (trackType_ == kTrackTypeIntervention || trackType_ == kTrackTypeInterventionSubType)
            {
                self.totalWeek4TI = trackTotalInterventionTimeInterval + totalExistingInterventionsTI;
            }

            if (trackType_ == kTrackTypeAssessment)
            {
                self.totalWeek4TI = trackTotalAssessmentInterval + totalExistingAssessmentsTI;
            }

            if (trackType_ == kTrackTypeSupport)
            {
                self.totalWeek4TI = trackTotalSupportTimeInterval + totalExistingSupportTI;
            }

            if (trackType_ == kTrackTypeSupervision || trackType_ == kTrackTypeSupervisionSubType)
            {
                self.totalWeek4TI = trackTotalSupervisionReceivedTimeInterval + totalExistingSupervisionReceivedTI;
            }

            self.totalWeek4Str = [self totalTimeStr:self.totalWeek4TI];
        }
        break;
        case kSummaryWeekFive:
        {
            if (trackType_ == kTrackTypeIntervention || trackType_ == kTrackTypeInterventionSubType)
            {
                self.totalWeek5TI = trackTotalInterventionTimeInterval + totalExistingInterventionsTI;
            }

            if (trackType_ == kTrackTypeAssessment)
            {
                self.totalWeek5TI = trackTotalAssessmentInterval + totalExistingAssessmentsTI;
            }

            if (trackType_ == kTrackTypeSupport)
            {
                self.totalWeek5TI = trackTotalSupportTimeInterval + totalExistingSupportTI;
            }

            if (trackType_ == kTrackTypeSupervision || trackType_ == kTrackTypeSupervisionSubType)
            {
                self.totalWeek5TI = trackTotalSupervisionReceivedTimeInterval + totalExistingSupervisionReceivedTI;
            }

            self.totalWeek5Str = [self totalTimeStr:self.totalWeek5TI];
        }
        break;
        case kSummaryWeekUndefined:
        {
            if (trackType_ == kTrackTypeIntervention || trackType_ == kTrackTypeInterventionSubType)
            {
                self.totalWeekUndefinedTI = trackTotalInterventionTimeInterval + totalExistingInterventionsTI;
            }

            if (trackType_ == kTrackTypeAssessment)
            {
                self.totalWeekUndefinedTI = trackTotalAssessmentInterval + totalExistingAssessmentsTI;
            }

            if (trackType_ == kTrackTypeSupport)
            {
                self.totalWeekUndefinedTI = trackTotalSupportTimeInterval + totalExistingSupportTI;
            }

            if (trackType_ == kTrackTypeSupervision || trackType_ == kTrackTypeSupervisionSubType)
            {
                self.totalWeekUndefinedTI = trackTotalSupervisionReceivedTimeInterval + totalExistingSupervisionReceivedTI;
            }

            self.totalWeekUndefinedStr = [self totalTimeStr:self.totalWeekUndefinedTI];
        }
        break;
        case kSummaryTotalForMonth:
        {
            if (trackType_ == kTrackTypeIntervention || trackType_ == kTrackTypeInterventionSubType)
            {
                self.totalForMonthTI = trackTotalInterventionTimeInterval + totalExistingInterventionsTI;
            }

            if (trackType_ == kTrackTypeAssessment)
            {
                self.totalForMonthTI = trackTotalAssessmentInterval + totalExistingAssessmentsTI;
            }

            if (trackType_ == kTrackTypeSupport)
            {
                self.totalForMonthTI = trackTotalSupportTimeInterval + totalExistingSupportTI;
            }

            if (trackType_ == kTrackTypeSupervision || trackType_ == kTrackTypeSupervisionSubType)
            {
                self.totalForMonthTI = trackTotalSupervisionReceivedTimeInterval + totalExistingSupervisionReceivedTI;
            }

            self.totalForMonthStr = [self totalTimeStr:self.totalForMonthTI];
        }
        break;
        case kSummaryCummulative:
        {
            if (trackType_ == kTrackTypeIntervention || trackType_ == kTrackTypeInterventionSubType)
            {
                self.totalCummulativeTI = trackTotalInterventionTimeInterval + totalExistingInterventionsTI;
            }

            if (trackType_ == kTrackTypeAssessment)
            {
                self.totalCummulativeTI = trackTotalAssessmentInterval + totalExistingAssessmentsTI;
            }

            if (trackType_ == kTrackTypeSupport)
            {
                self.totalCummulativeTI = trackTotalSupportTimeInterval + totalExistingSupportTI;
            }

            if (trackType_ == kTrackTypeSupervision || trackType_ == kTrackTypeSupervisionSubType)
            {
                self.totalCummulativeTI = trackTotalSupervisionReceivedTimeInterval + totalExistingSupervisionReceivedTI;
            }

            self.totalCummulativeStr = [self totalTimeStr:self.totalCummulativeTI];
        }
        break;
        case kSummaryTotalToDate:
        {
            if (trackType_ == kTrackTypeIntervention || trackType_ == kTrackTypeInterventionSubType)
            {
                self.totalToDateTI = trackTotalInterventionTimeInterval + totalExistingInterventionsTI;
            }

            if (trackType_ == kTrackTypeAssessment)
            {
                self.totalToDateTI = trackTotalAssessmentInterval + totalExistingAssessmentsTI;
            }

            if (trackType_ == kTrackTypeSupport)
            {
                self.totalToDateTI = trackTotalSupportTimeInterval + totalExistingSupportTI;
            }

            if (trackType_ == kTrackTypeSupervision || trackType_ == kTrackTypeSupervisionSubType)
            {
                self.totalToDateTI = trackTotalSupervisionReceivedTimeInterval + totalExistingSupervisionReceivedTI;
            }

            self.totalToDateStr = [self totalTimeStr:self.totalToDateTI];
        }

        default:
            break;
    } /* switch */
}


- (NSString *) monthlyLogNotesForMonth
{
    NSSet *trackDeliveredFilteredForCurrentMonth = nil;
    NSPredicate *trackPredicateForCurrentMonth = [self predicateForTrackCurrentMonth];
    NSString *returnString = nil;
    switch (trackType_)
    {
        case kTrackTypeIntervention:
            trackDeliveredFilteredForCurrentMonth = [self.interventionsDeliveredArray filteredSetUsingPredicate:trackPredicateForCurrentMonth];

            break;

        case kTrackTypeInterventionSubType:
            trackDeliveredFilteredForCurrentMonth = [self.interventionsDeliveredArray filteredSetUsingPredicate:trackPredicateForCurrentMonth];

            break;

        case kTrackTypeAssessment:
            trackDeliveredFilteredForCurrentMonth = [self.assessmentsDeliveredArray filteredSetUsingPredicate:trackPredicateForCurrentMonth];

            break;

        case kTrackTypeSupport:
            trackDeliveredFilteredForCurrentMonth = [self.supportActivityDeliveredArray filteredSetUsingPredicate:trackPredicateForCurrentMonth];

            break;

        case kTrackTypeSupervision:
            trackDeliveredFilteredForCurrentMonth = [self.supervisionReceivedArray filteredSetUsingPredicate:trackPredicateForCurrentMonth];

            break;

        case kTrackTypeSupervisionSubType:
            trackDeliveredFilteredForCurrentMonth = [self.supervisionReceivedArray filteredSetUsingPredicate:trackPredicateForCurrentMonth];

            break;

        default:
            break;
    } /* switch */

    if (trackDeliveredFilteredForCurrentMonth)
    {
        int trackDeliveredFilteredForCurrentMonthCount = trackDeliveredFilteredForCurrentMonth.count;
        if (trackDeliveredFilteredForCurrentMonthCount)
        {
            NSMutableSet *monthlyLogNotesArray = [trackDeliveredFilteredForCurrentMonth mutableSetValueForKey:@"monthlyLogNotes"];
            int monthlyLogNotesArrayCount = monthlyLogNotesArray.count;
            for ( int i = 0; i < monthlyLogNotesArrayCount; i++)
            {
                id logNotesID = [monthlyLogNotesArray.allObjects objectAtIndex:i];

                if ([logNotesID isKindOfClass:[NSString class]])
                {
                    NSString *logNotesStr = (NSString *)logNotesID;
                    if (logNotesStr && logNotesStr.length)
                    {
                        if (i == 0)
                        {
                            returnString = logNotesStr;
                        }
                        else
                        {
                            returnString = [returnString stringByAppendingFormat:@"; %@",logNotesStr];
                        }
                    }
                }
            }
        }
    }

    if (returnString && ![returnString isKindOfClass:[NSString class]])
    {
        returnString = [NSString string];
    }

    return returnString;
}


@end
