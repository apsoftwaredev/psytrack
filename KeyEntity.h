//
//  KeyEntity.h
//  PsyTrack Clinician Tools
//  Version: 1.5.5
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface KeyEntity : NSManagedObject

@property (nonatomic, retain) NSData *keyF;
@property (nonatomic, retain) NSDate *keyDate;
@property (nonatomic, retain) NSString *keyString;
@property (nonatomic, retain) NSData *dataF;

@end
