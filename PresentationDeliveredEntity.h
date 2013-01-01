//
//  PresentationDeliveredEntity.h
//  PsyTrack
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "PTManagedObjectContext.h"


@interface PresentationDeliveredEntity : NSManagedObject

@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSNumber * audienceSize;
@property (nonatomic, retain) NSString * audience;
@property (nonatomic, retain) NSManagedObject *presentation;

@end
