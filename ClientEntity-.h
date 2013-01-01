//
//  ClientEntity.h
//  PsyTrack
//
//  Created by Daniel Boice on 6/7/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class DemographicProfileEntity, LogEntity, MedicationEntity, PhoneEntity, ReferralEntity, VitalsEntity;

@interface ClientEntity : NSManagedObject

@property (nonatomic, retain) NSString * clientIDCode;
@property (nonatomic, retain) NSString * initials;
@property (nonatomic, retain) id dateOfBirth;
@property (nonatomic, retain) NSString * keyString;
@property (nonatomic, retain) NSData * fData;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSNumber * order;
@property (nonatomic, retain) NSDate * dateAdded;
@property (nonatomic, retain) NSNumber * currentClient;
@property (nonatomic, retain) NSSet *medicationHistory;
@property (nonatomic, retain) NSSet *diagnoses;
@property (nonatomic, retain) NSSet *vitals;
@property (nonatomic, retain) NSSet *accomodations;
@property (nonatomic, retain) DemographicProfileEntity *demographicInfo;
@property (nonatomic, retain) NSSet *logs;
@property (nonatomic, retain) NSSet *phoneNumbers;
@property (nonatomic, retain) NSSet *supervisonFeedback;
@property (nonatomic, retain) NSSet *clientPresentations;
@property (nonatomic, retain) NSSet *referrals;
@property (nonatomic, retain) NSSet *groups;
@property (nonatomic, retain) NSSet *substancesUse;
@property (nonatomic, weak) NSString *tempClientIDCode;
@property (nonatomic, weak) NSString *tempInitials;
@property (nonatomic, weak) NSDate *tempDateOfBirth;
@property (nonatomic, weak) NSString *tempNotes;

//-(void)rekeyEncryptedAttributes;
@end

@interface ClientEntity (CoreDataGeneratedAccessors)

- (void)addMedicationHistoryObject:(MedicationEntity *)value;
- (void)removeMedicationHistoryObject:(MedicationEntity *)value;
- (void)addMedicationHistory:(NSSet *)values;
- (void)removeMedicationHistory:(NSSet *)values;

- (void)addDiagnosesObject:(NSManagedObject *)value;
- (void)removeDiagnosesObject:(NSManagedObject *)value;
- (void)addDiagnoses:(NSSet *)values;
- (void)removeDiagnoses:(NSSet *)values;

- (void)addVitalsObject:(VitalsEntity *)value;
- (void)removeVitalsObject:(VitalsEntity *)value;
- (void)addVitals:(NSSet *)values;
- (void)removeVitals:(NSSet *)values;

- (void)addAccomodationsObject:(NSManagedObject *)value;
- (void)removeAccomodationsObject:(NSManagedObject *)value;
- (void)addAccomodations:(NSSet *)values;
- (void)removeAccomodations:(NSSet *)values;

- (void)addLogsObject:(LogEntity *)value;
- (void)removeLogsObject:(LogEntity *)value;
- (void)addLogs:(NSSet *)values;
- (void)removeLogs:(NSSet *)values;

- (void)addPhoneNumbersObject:(PhoneEntity *)value;
- (void)removePhoneNumbersObject:(PhoneEntity *)value;
- (void)addPhoneNumbers:(NSSet *)values;
- (void)removePhoneNumbers:(NSSet *)values;

- (void)addSupervisonFeedbackObject:(NSManagedObject *)value;
- (void)removeSupervisonFeedbackObject:(NSManagedObject *)value;
- (void)addSupervisonFeedback:(NSSet *)values;
- (void)removeSupervisonFeedback:(NSSet *)values;

- (void)addClientPresentationsObject:(NSManagedObject *)value;
- (void)removeClientPresentationsObject:(NSManagedObject *)value;
- (void)addClientPresentations:(NSSet *)values;
- (void)removeClientPresentations:(NSSet *)values;

- (void)addReferralsObject:(ReferralEntity *)value;
- (void)removeReferralsObject:(ReferralEntity *)value;
- (void)addReferrals:(NSSet *)values;
- (void)removeReferrals:(NSSet *)values;

- (void)addGroupssObject:(ReferralEntity *)value;
- (void)removeGroupssObject:(ReferralEntity *)value;
- (void)addGroups:(NSSet *)values;
- (void)removeGroups:(NSSet *)values;


- (void)setStringToPrimitiveData:(NSString *)strValue forKey:(NSString *)key ;
- (void)setDateToPrimitiveData:(NSDate *)dateToConvert forKey:(NSString *)key;

-(void)setInitials:(NSString *)initials;
-(void)setNotes:(NSString *)notes;
- (void)setClientIDCode:(NSString *)clientIDCode;

-(void)setDateOfBirth:(NSDate *)dateOfBirth;

//-(NSString *)initials;
//-(NSString *)notes;
-(NSString*)clientIDCode;
-(NSDate *)dateOfBirth;

@end
