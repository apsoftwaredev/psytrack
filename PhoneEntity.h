//
//  PhoneEntity.h
//  PsyTrack
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ClientEntity;

@interface PhoneEntity : NSManagedObject

@property (nonatomic, retain) NSString * phoneNumber;
@property (nonatomic, retain) NSString * phoneName;
@property (nonatomic, retain) NSString * keyString;
@property (nonatomic, retain) NSString * extension;
@property (nonatomic, retain) ClientEntity *client;

@end
