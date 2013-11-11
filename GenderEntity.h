//
//  GenderEntity.h
//  PsyTrack Clinician Tools
//  Version: 1.5.5
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class DemographicProfileEntity;

@interface GenderEntity : NSManagedObject

@property (nonatomic, retain) NSNumber *order;
@property (nonatomic, retain) NSString *notes;
@property (nonatomic, retain) NSString *genderName;
@property (nonatomic, retain) NSSet *existingGenders;
@property (nonatomic, retain) NSSet *demographics;

@property (nonatomic, weak) NSString *clientCountStr;

@end

@interface GenderEntity (CoreDataGeneratedAccessors)

- (void) addExistingGendersObject:(NSManagedObject *)value;
- (void) removeExistingGendersObject:(NSManagedObject *)value;
- (void) addExistingGenders:(NSSet *)values;
- (void) removeExistingGenders:(NSSet *)values;

- (void) addDemographicsObject:(DemographicProfileEntity *)value;
- (void) removeDemographicsObject:(DemographicProfileEntity *)value;
- (void) addDemographics:(NSSet *)values;
- (void) removeDemographics:(NSSet *)values;

-(BOOL)associatedWithTimeRecords;
@end
