//
//  JobTitleEntity.h
//  PsyTrack Clinician Tools
//  Version: 1.5.4
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ClinicianEntity;

@interface JobTitleEntity : NSManagedObject

@property (nonatomic, retain) NSString *jobTitle;
@property (nonatomic, retain) NSNumber *order;
@property (nonatomic, retain) NSSet *clinicians;
@end

@interface JobTitleEntity (CoreDataGeneratedAccessors)

- (void) addCliniciansObject:(ClinicianEntity *)value;
- (void) removeCliniciansObject:(ClinicianEntity *)value;
- (void) addClinicians:(NSSet *)values;
- (void) removeClinicians:(NSSet *)values;

@end
