//
//  ClientGroupEntity.h
//  PsyTrack Clinician Tools
//  Version: 1.5.4
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ClientEntity;

@interface ClientGroupEntity : NSManagedObject

@property (nonatomic, retain) NSString *groupName;
@property (nonatomic, retain) NSNumber *addNewClients;
@property (nonatomic, retain) NSSet *clients;
@end

@interface ClientGroupEntity (CoreDataGeneratedAccessors)

- (void) addClientsObject:(ClientEntity *)value;
- (void) removeClientsObject:(ClientEntity *)value;
- (void) addClients:(NSSet *)values;
- (void) removeClients:(NSSet *)values;

@end
