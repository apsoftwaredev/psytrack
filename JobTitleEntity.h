//
//  JobTitleEntity.h
//  PsyTrack
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "PTManagedObjectContext.h"

@class ClinicianEntity;

@interface JobTitleEntity : NSManagedObject

@property (nonatomic, retain) NSString * jobTitle;
@property (nonatomic, retain) NSNumber * order;
@property (nonatomic, retain) NSSet *clinicians;
@end

@interface JobTitleEntity (CoreDataGeneratedAccessors)

- (void)addCliniciansObject:(ClinicianEntity *)value;
- (void)removeCliniciansObject:(ClinicianEntity *)value;
- (void)addClinicians:(NSSet *)values;
- (void)removeClinicians:(NSSet *)values;

@end
