//
//  ClientEntity.h
//  psyTrainTrack
//
//  Created by Daniel Boice on 11/22/11.
//  Copyright (c) 2011 PsycheWeb LLC. All rights reserved.
//
//
#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface ClientEntity : NSManagedObject

@property (nonatomic, strong) NSNumber * order;
@property (nonatomic, strong) NSString * notes;
@property (nonatomic, strong) NSDate * dateOfBirth;
@property (nonatomic, strong) NSString * clientIDCode;
@property (nonatomic, strong) NSString * initials;
@property (nonatomic, strong) NSDate * dateAdded;
@property (nonatomic, strong) NSManagedObject *demographicInfo;
@property (nonatomic, strong) NSSet *referrals;
@property (nonatomic, strong) NSSet *supportActivitiesDelivered;
@property (nonatomic, strong) NSSet *interventionsDelivered;
@property (nonatomic, strong) NSManagedObject *clientAndMentalState;
@property (nonatomic, strong) NSSet *diagnosis;

@property (nonatomic, strong)  NSString *clientIDcodeDC;


@end

@interface ClientEntity (CoreDataGeneratedAccessors)

- (void)addReferralsObject:(NSManagedObject *)value;
- (void)removeReferralsObject:(NSManagedObject *)value;
- (void)addReferrals:(NSSet *)values;
- (void)removeReferrals:(NSSet *)values;

- (void)addSupportActivitiesDeliveredObject:(NSManagedObject *)value;
- (void)removeSupportActivitiesDeliveredObject:(NSManagedObject *)value;
- (void)addSupportActivitiesDelivered:(NSSet *)values;
- (void)removeSupportActivitiesDelivered:(NSSet *)values;

- (void)addInterventionsDeliveredObject:(NSManagedObject *)value;
- (void)removeInterventionsDeliveredObject:(NSManagedObject *)value;
- (void)addInterventionsDelivered:(NSSet *)values;
- (void)removeInterventionsDelivered:(NSSet *)values;

- (void)addDiagnosisObject:(NSManagedObject *)value;
- (void)removeDiagnosisObject:(NSManagedObject *)value;
- (void)addDiagnosis:(NSSet *)values;
- (void)removeDiagnosis:(NSSet *)values;

-(NSData *)convertStringToEncryptedData:(NSString *) str;
-(NSString *)clientIDCode;

@end
