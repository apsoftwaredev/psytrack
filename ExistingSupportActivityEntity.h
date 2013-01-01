//
//  ExistingSupportActivityEntity.h
//  PsyTrack
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ExistingHoursEntity, SupportActivityTypeEntity;

@interface ExistingSupportActivityEntity : NSManagedObject

@property (nonatomic, retain) NSDate * hours;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSString * monthlyLogNotes;
@property (nonatomic, retain) SupportActivityTypeEntity *supportActivityType;
@property (nonatomic, retain) ExistingHoursEntity *existingHours;

@end
