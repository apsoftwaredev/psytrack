//
//  AwardEntity.h
//  PsyTrack Clinician Tools
//  Version: 1.5.5
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ClinicianEntity;

@interface AwardEntity : NSManagedObject

@property (nonatomic, retain) NSString *awardedBy;
@property (nonatomic, retain) NSDate *dateAwarded;
@property (nonatomic, retain) NSNumber *order;
@property (nonatomic, retain) NSString *awardName;
@property (nonatomic, retain) NSString *desc;
@property (nonatomic, retain) ClinicianEntity *clinician;

@end
