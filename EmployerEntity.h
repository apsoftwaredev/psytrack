//
//  EmployerEntity.h
//  PsyTrack Clinician Tools
//  Version: 1.5.2
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "PTManagedObjectContext.h"
#import "PTManagedObject.h"

@class EmploymentEntity;

@interface EmployerEntity : PTManagedObject

@property (nonatomic, retain) NSString *employerName;
@property (nonatomic, retain) NSNumber *order;
@property (nonatomic, retain) NSString *notes;
@property (nonatomic, retain) NSNumber *addressBookRecordIdentifier;
@property (nonatomic, retain) NSSet *employements;
@end

@interface EmployerEntity (CoreDataGeneratedAccessors)

- (void) addEmployementsObject:(EmploymentEntity *)value;
- (void) removeEmployementsObject:(EmploymentEntity *)value;
- (void) addEmployements:(NSSet *)values;
- (void) removeEmployements:(NSSet *)values;

@end
