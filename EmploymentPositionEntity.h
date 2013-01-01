//
//  EmploymentPositionEntity.h
//  PsyTrack
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class EmploymentEntity;

@interface EmploymentPositionEntity : NSManagedObject

@property (nonatomic, retain) NSDate * startedDate;
@property (nonatomic, retain) NSNumber * order;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSDate * endedDate;
@property (nonatomic, retain) NSString * department;
@property (nonatomic, retain) NSManagedObject *jobTitle;
@property (nonatomic, retain) EmploymentEntity *employment;

@end
