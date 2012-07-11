//
//  ExistingSupportActivityEntity.h
//  PsyTrack
//
//  Created by Daniel Boice on 7/11/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ExistingHoursEntity, SupportActivityTypeEntity;

@interface ExistingSupportActivityEntity : NSManagedObject

@property (nonatomic, retain) NSDate * hours;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) SupportActivityTypeEntity *supportActivityType;
@property (nonatomic, retain) ExistingHoursEntity *existingHours;

@end
