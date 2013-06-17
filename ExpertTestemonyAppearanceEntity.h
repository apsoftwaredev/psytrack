//
//  ExpertTestemonyAppearanceEntity.h
//  PsyTrack Clinician Tools
//  Version: 1.5.2
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "PTManagedObjectContext.h"
#import "PTManagedObject.h"

@class ExpertTestemonyEntity;

@interface ExpertTestemonyAppearanceEntity : PTManagedObject

@property (nonatomic, retain) NSDate *dateAppeared;
@property (nonatomic, retain) NSNumber *order;
@property (nonatomic, retain) NSString *notes;
@property (nonatomic, retain) NSDate *hours;
@property (nonatomic, retain) ExpertTestemonyEntity *expertTestemony;

@end
