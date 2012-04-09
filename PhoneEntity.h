//
//  PhoneEntity.h
//  PsyTrack Clinician Tools
//
//  Created by Daniel Boice on 3/20/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ClientEntity;

@interface PhoneEntity : NSManagedObject

@property (nonatomic, retain) NSString * phoneName;
@property (nonatomic, retain) NSNumber * order;
@property (nonatomic, retain) NSString * extention;
@property (nonatomic, retain) NSString * phoneNumber;
@property (nonatomic, retain) NSString   * keyString;
@property (nonatomic, retain) ClientEntity *client;

@property (nonatomic, strong) NSString *tempPhoneNumber;

@end
