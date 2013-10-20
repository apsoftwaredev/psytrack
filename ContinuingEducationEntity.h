//
//  ContinuingEducationEntity.h
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

@class ContinuingEducationProviderEntity, ContinuingEducationTypeEntity;

@interface ContinuingEducationEntity : PTManagedObject

@property (nonatomic, retain) NSNumber *cost;
@property (nonatomic, retain) NSString *notes;
@property (nonatomic, retain) NSDate *dateEarned;
@property (nonatomic, retain) NSString *cETitle;
@property (nonatomic, retain) NSNumber *credits;
@property (nonatomic, retain) NSManagedObject *forLicenseRenewal;
@property (nonatomic, retain) ContinuingEducationProviderEntity *provider;
@property (nonatomic, retain) NSSet *topics;
@property (nonatomic, retain) ContinuingEducationTypeEntity *type;
@end

@interface ContinuingEducationEntity (CoreDataGeneratedAccessors)

- (void) addTopicsObject:(NSManagedObject *)value;
- (void) removeTopicsObject:(NSManagedObject *)value;
- (void) addTopics:(NSSet *)values;
- (void) removeTopics:(NSSet *)values;

@end
