//
//  InstrumentTypeEntity.h
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

@class InstrumentEntity;

@interface InstrumentTypeEntity : PTManagedObject

@property (nonatomic, retain) NSString *instrumentType;
@property (nonatomic, retain) NSNumber *order;
@property (nonatomic, retain) NSString *notes;
@property (nonatomic, retain) NSSet *testNames;
@end

@interface InstrumentTypeEntity (CoreDataGeneratedAccessors)

- (void) addTestNamesObject:(InstrumentEntity *)value;
- (void) removeTestNamesObject:(InstrumentEntity *)value;
- (void) addTestNames:(NSSet *)values;
- (void) removeTestNames:(NSSet *)values;

@end
