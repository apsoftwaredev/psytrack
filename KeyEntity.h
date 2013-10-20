//
//  KeyEntity.h
//  PsyTrack Clinician Tools
//  Version: 1.5.3
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "PTManagedObjectContext.h"
#import "PTManagedObject.h"

@interface KeyEntity : PTManagedObject

@property (nonatomic, retain) NSData *keyF;
@property (nonatomic, retain) NSDate *keyDate;
@property (nonatomic, retain) NSString *keyString;
@property (nonatomic, retain) NSData *dataF;

@end
