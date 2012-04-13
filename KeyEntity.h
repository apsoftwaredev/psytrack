//
//  KeyEntity.h
//  PsyTrack Clinician Tools
//
//  Created by Daniel Boice on 3/12/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface KeyEntity : NSManagedObject

@property (nonatomic, retain) NSData * keyF;
@property (nonatomic, retain) NSData * dataF;
@property (nonatomic, retain) NSString * keyString;
@property (nonatomic, retain) NSDate *keyDate;
@end
