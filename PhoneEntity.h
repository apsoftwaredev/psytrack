//
//  PhoneEntity.h
//  PsyTrack Clinician Tools
//  Version: 1.05
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "PTManagedObjectContext.h"
#import "PTManagedObject.h"



@class ClientEntity;

@interface PhoneEntity : PTManagedObject

@property (nonatomic, retain) NSString * phoneNumber;
@property (nonatomic, retain) NSString * phoneName;
@property (nonatomic, retain) NSString * keyString;
@property (nonatomic, retain) NSString * extension;
@property (nonatomic, retain) ClientEntity *client;

@end
