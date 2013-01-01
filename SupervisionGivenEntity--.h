//
//  SupervisionGivenEntity.h
//  PsyTrack
//
//  Created by Daniel Boice on 7/15/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "SupervisionParentEntity.h"

@class SupervisionTypeEntity, SupervisionTypeSubtypeEntity, TimeEntity;

@interface SupervisionGivenEntity : SupervisionParentEntity

@property (nonatomic, retain) SupervisionTypeSubtypeEntity *subType;
@property (nonatomic, retain) TimeEntity *time;
@property (nonatomic, retain) SupervisionTypeEntity *supervisionType;

@end
