//
//  ServiceParentEntity.h
//  PsyTrack
//
//  Created by Daniel Boice on 6/6/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "TimeTrackEntity.h"


@interface ServiceParentEntity : TimeTrackEntity

@property (nonatomic, retain) NSNumber * paperwork;
@property (nonatomic, retain) NSManagedObject *serviceCode;

@end
