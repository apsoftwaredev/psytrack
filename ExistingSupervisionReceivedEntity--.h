//
//  ExistingSupervisionReceivedEntity.h
//  PsyTrack
//
//  Created by Daniel Boice on 7/11/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ExistingHoursEntity;

@interface ExistingSupervisionReceivedEntity : NSManagedObject

@property (nonatomic, retain) ExistingHoursEntity *existingHours;

@end
