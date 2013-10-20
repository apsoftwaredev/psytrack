//
//  AccomodationEntity.h
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

@class ClientEntity;

@interface AccomodationEntity : PTManagedObject

@property (nonatomic, retain) NSNumber *order;
@property (nonatomic, retain) NSString *notes;
@property (nonatomic, retain) NSString *accomodation;
@property (nonatomic, retain) NSSet *client;
@end

@interface AccomodationEntity (CoreDataGeneratedAccessors)

- (void) addClientObject:(ClientEntity *)value;
- (void) removeClientObject:(ClientEntity *)value;
- (void) addClient:(NSSet *)values;
- (void) removeClient:(NSSet *)values;

@end
