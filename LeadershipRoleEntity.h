//
//  LeadershipRoleEntity.h
//  PsyTrack Clinician Tools
//  Version: 1.5.5
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface LeadershipRoleEntity : NSManagedObject

@property (nonatomic, retain) NSString *impact;
@property (nonatomic, retain) NSString *theoreticalApproach;
@property (nonatomic, retain) NSString *innovations;
@property (nonatomic, retain) NSDate *dateStarted;
@property (nonatomic, retain) NSString *changesImplemented;
@property (nonatomic, retain) NSDate *dateEnded;
@property (nonatomic, retain) NSString *role;
@property (nonatomic, retain) NSString *challengesFaced;
@property (nonatomic, retain) NSNumber *populationSize;
@property (nonatomic, retain) NSManagedObject *organization;

@end
