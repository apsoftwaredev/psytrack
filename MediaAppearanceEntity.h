//
//  MediaAppearanceEntity.h
//  PsyTrack Clinician Tools
//  Version: 1.5.3
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "PTManagedObjectContext.h"
#import "PTManagedObject.h"

@interface MediaAppearanceEntity : PTManagedObject

@property (nonatomic, retain) NSString *topics;
@property (nonatomic, retain) NSString *audience;
@property (nonatomic, retain) NSString *showName;
@property (nonatomic, retain) NSString *notes;
@property (nonatomic, retain) NSNumber *order;
@property (nonatomic, retain) NSDate *hours;
@property (nonatomic, retain) NSString *host;
@property (nonatomic, retain) NSString *showtimes;
@property (nonatomic, retain) NSString *network;
@property (nonatomic, retain) NSDate *dateInterviewed;

@end
