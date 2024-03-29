//
//  SupervisionGivenEntity.h
//  PsyTrack Clinician Tools
//  Version: 1.5.4
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
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
