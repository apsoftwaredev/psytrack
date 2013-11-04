//
//  PresentationDeliveredEntity.h
//  PsyTrack Clinician Tools
//  Version: 1.5.4
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface PresentationDeliveredEntity : NSManagedObject

@property (nonatomic, retain) NSDate *date;
@property (nonatomic, retain) NSString *notes;
@property (nonatomic, retain) NSNumber *audienceSize;
@property (nonatomic, retain) NSString *audience;
@property (nonatomic, retain) NSManagedObject *presentation;

@end
