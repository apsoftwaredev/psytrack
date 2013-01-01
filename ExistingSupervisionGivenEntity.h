//
//  ExistingSupervisionGivenEntity.h
//  PsyTrack
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ExistingHoursEntity;

@interface ExistingSupervisionGivenEntity : NSManagedObject

@property (nonatomic, retain) ExistingHoursEntity *existingHours;

@end
