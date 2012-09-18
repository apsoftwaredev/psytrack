//
//  AdditionalSymptomEntity.h
//  PsyTrack
//
//  Created by Daniel Boice on 9/17/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class MedicationEntity;

@interface AdditionalSymptomEntity : NSManagedObject

@property (nonatomic, retain) NSDate * onset;
@property (nonatomic, retain) NSNumber * order;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSNumber * severity;
@property (nonatomic, retain) NSManagedObject *frequency;
@property (nonatomic, retain) NSManagedObject *symptomName;
@property (nonatomic, retain) MedicationEntity *medicationReview;

@end
