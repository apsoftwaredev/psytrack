//
//  InterventionTypeSubtypeEntity.h
//  PsyTrack
//
//  Created by Daniel Boice on 6/21/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "ClinicianEntity.h"
@class InterventionDeliveredEntity;

@interface InterventionTypeSubtypeEntity : NSManagedObject

@property (nonatomic, retain) NSString * interventionSubType;
@property (nonatomic, retain) NSNumber * order;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSManagedObject *interventionType;
@property (nonatomic, retain) NSSet *interventionDelivered;
@end

@interface InterventionTypeSubtypeEntity (CoreDataGeneratedAccessors)

- (void)addInterventionDeliveredObject:(InterventionDeliveredEntity *)value;
- (void)removeInterventionDeliveredObject:(InterventionDeliveredEntity *)value;
- (void)addInterventionDelivered:(NSSet *)values;
- (void)removeInterventionDelivered:(NSSet *)values;


-(NSString *)week1TotalHoursForMonthStr:(NSDate *)dateInMonth clinician:(ClinicianEntity*)clinician;
-(NSString *)week2TotalHoursForMonthStr:(NSDate *)dateInMonth clinician:(ClinicianEntity*)clinician;
-(NSString *)week3TotalHoursForMonthStr:(NSDate *)dateInMonth clinician:(ClinicianEntity*)clinician;
-(NSString *)week4TotalHoursForMonthStr:(NSDate *)dateInMonth clinician:(ClinicianEntity*)clinician;
-(NSString *)week5TotalHoursForMonthStr:(NSDate *)dateInMonth clinician:(ClinicianEntity*)clinician;
-(NSString *)unknownWeekTotalHoursForMonthStr:(NSDate *)dateInMonth clinician:(ClinicianEntity*)clinician;
-(NSString *)monthTotalHoursForMonthStr:(NSDate *)dateInMonth clinician:(ClinicianEntity*)clinician;
-(NSString *)previousMonthCumulativeForMonthStr:(NSDate *)dateInMonth clinician:(ClinicianEntity*)clinician;
-(NSString *)totalHoursToDateForMonthStr:(NSDate *)dateInMonth clinician:(ClinicianEntity*)clinician;

-(NSTimeInterval )week1TotalHoursForMonthTI:(NSDate *)dateInMonth clinician:(ClinicianEntity*)clinician;
-(NSTimeInterval )week2TotalHoursForMonthTI:(NSDate *)dateInMonth clinician:(ClinicianEntity*)clinician;
-(NSTimeInterval )week3TotalHoursForMonthTI:(NSDate *)dateInMonth clinician:(ClinicianEntity*)clinician;
-(NSTimeInterval )week4TotalHoursForMonthTI:(NSDate *)dateInMonth clinician:(ClinicianEntity*)clinician;
-(NSTimeInterval )week5TotalHoursForMonthTI:(NSDate *)dateInMonth clinician:(ClinicianEntity*)clinician;
-(NSTimeInterval )unknownWeekTotalHoursForMonthTI:(NSDate *)dateInMonth  clinician:(ClinicianEntity*)clinician;
-(NSTimeInterval )monthTotalHoursForMonthTI:(NSDate *)dateInMonth  clinician:(ClinicianEntity*)clinician;
-(NSTimeInterval )previousMonthCumulativeForMonthTI:(NSDate *)dateInMonth  clinician:(ClinicianEntity*)clinician;
-(NSTimeInterval )totalHoursToDateForMonthTI:(NSDate *)dateInMonth  clinician:(ClinicianEntity*)clinician;




@end
