//
//  SupervisionReceivedEntity.h
//  PsyTrack
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "SupervisionParentEntity.h"
#import "PTManagedObjectContext.h"

@class SupervisionTypeEntity, SupervisionTypeSubtypeEntity, TimeEntity;

@interface SupervisionReceivedEntity : SupervisionParentEntity

@property (nonatomic, retain) SupervisionTypeSubtypeEntity *subType;
@property (nonatomic, retain) TimeEntity *time;
@property (nonatomic, retain) SupervisionTypeEntity *supervisionType;

@end
