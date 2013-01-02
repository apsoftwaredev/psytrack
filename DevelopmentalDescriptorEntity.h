//
//  DevelopmentalDescriptorEntity.h
//  PsyTrack
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "PTManagedObjectContext.h"
#import "PTManagedObject.h"



@class DemographicProfileEntity;

@interface DevelopmentalDescriptorEntity : PTManagedObject

@property (nonatomic, retain) NSNumber * order;
@property (nonatomic, retain) NSString * descriptor;
@property (nonatomic, retain) NSString * desc;
@property (nonatomic, retain) DemographicProfileEntity *demographics;

@end
