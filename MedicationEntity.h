//
//  MedicationEntity.h
//  PsyTrack
//
//  Created by Daniel Boice on 3/27/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ClientEntity;

@interface MedicationEntity : NSManagedObject

@property (nonatomic, retain) NSString * applNo;
@property (nonatomic, retain) NSNumber * order;
@property (nonatomic, retain) NSDate * dateStarted;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSDate * discontinued;
@property (nonatomic, retain) NSString * drugName;
@property (nonatomic, retain) NSString * productNo;
@property (nonatomic, retain) NSString * keyString;
@property (nonatomic, retain) ClientEntity *client;
@property (nonatomic, retain) NSSet *medLogs;
@property (nonatomic, retain) NSSet *symptomsTargeted;

@property (nonatomic, weak) NSString *tempNotes;
-(void)rekeyEncryptedAttributes;

@end

@interface MedicationEntity (CoreDataGeneratedAccessors)

- (void)addMedLogsObject:(NSManagedObject *)value;
- (void)removeMedLogsObject:(NSManagedObject *)value;
- (void)addMedLogs:(NSSet *)values;
- (void)removeMedLogs:(NSSet *)values;

- (void)addSymptomsTargetedObject:(NSManagedObject *)value;
- (void)removeSymptomsTargetedObject:(NSManagedObject *)value;
- (void)addSymptomsTargeted:(NSSet *)values;
- (void)removeSymptomsTargeted:(NSSet *)values;

@end
