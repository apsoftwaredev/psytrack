//
//  ContinuingEducationEntity.h
//  PsyTrack
//
//  Created by Daniel Boice on 9/17/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface ContinuingEducationEntity : NSManagedObject

@property (nonatomic, retain) NSNumber * cost;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSDate * dateEarned;
@property (nonatomic, retain) NSString * cETitle;
@property (nonatomic, retain) NSNumber * credits;
@property (nonatomic, retain) NSManagedObject *forLicenseRenewal;
@property (nonatomic, retain) NSManagedObject *provider;
@property (nonatomic, retain) NSManagedObject *type;

@end
