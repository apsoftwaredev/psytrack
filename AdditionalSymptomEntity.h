//
//  AdditionalSymptomEntity.h
//  PsyTrack Clinician Tools
//  Version: 1.05
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "PTManagedObjectContext.h"
#import "PTManagedObject.h"



@class FrequencyEntity, MedicationEntity;

@interface AdditionalSymptomEntity : PTManagedObject

@property (nonatomic, retain) NSDate * onset;
@property (nonatomic, retain) NSNumber * order;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSNumber * severity;
@property (nonatomic, retain) FrequencyEntity *frequency;
@property (nonatomic, retain) NSManagedObject *symptomName;
@property (nonatomic, retain) MedicationEntity *medicationReview;

@end
