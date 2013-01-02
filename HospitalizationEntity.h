//
//  HospitalizationEntity.h
//  PsyTrack
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "PTManagedObjectContext.h"
#import "PTManagedObject.h"



@class ClientEntity;

@interface HospitalizationEntity : PTManagedObject

@property (nonatomic, retain) NSNumber * voluntary;
@property (nonatomic, retain) NSDate * dateDischarged;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSDate * dateAdmitted;
@property (nonatomic, retain) ClientEntity *client;

@end
