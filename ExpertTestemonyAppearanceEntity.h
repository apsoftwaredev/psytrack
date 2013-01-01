//
//  ExpertTestemonyAppearanceEntity.h
//  PsyTrack
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ExpertTestemonyEntity;

@interface ExpertTestemonyAppearanceEntity : NSManagedObject

@property (nonatomic, retain) NSDate * dateAppeared;
@property (nonatomic, retain) NSNumber * order;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSDate * hours;
@property (nonatomic, retain) ExpertTestemonyEntity *expertTestemony;

@end
