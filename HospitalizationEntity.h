//
//  HospitalizationEntity.h
//  PsyTrack Clinician Tools
//  Version: 1.5.5
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ClientEntity;

@interface HospitalizationEntity : NSManagedObject

@property (nonatomic, retain) NSNumber *voluntary;
@property (nonatomic, retain) NSDate *dateDischarged;
@property (nonatomic, retain) NSString *notes;
@property (nonatomic, retain) NSDate *dateAdmitted;
@property (nonatomic, retain) ClientEntity *client;

@end
