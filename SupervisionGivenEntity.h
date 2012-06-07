//
//  SupervisionGivenEntity.h
//  PsyTrack
//
//  Created by Daniel Boice on 6/6/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "SupervisionParentEntity.h"

@class TimeEntity;

@interface SupervisionGivenEntity : SupervisionParentEntity

@property (nonatomic, retain) TimeEntity *time;

@end
