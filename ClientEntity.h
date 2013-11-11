//
//  ClientEntity.h
//  PsyTrack Clinician Tools
//  Version: 1.5.5
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class AccomodationEntity, ClientGroupEntity, ClientPresentationEntity, DemographicProfileEntity, DiagnosisHistoryEntity, ExpertTestemonyEntity, FeeEntity, HospitalizationEntity, LogEntity, MedicationEntity, OtherReferralSourceEntity, PaymentEntity, PhoneEntity, ReferralEntity, SubstanceUseEntity, SupervisionFeedbackEntity, SupportActivityClientEntity, VitalsEntity;

@interface ClientEntity : NSManagedObject

@property (nonatomic, retain) NSDate *dateOfBirth;
@property (nonatomic, retain) NSString *lastName;
@property (nonatomic, retain) NSString *middleName;
@property (nonatomic, retain) NSString *firstName;
@property (nonatomic, retain) NSString *address;
@property (nonatomic, retain) NSString *initials;
@property (nonatomic, retain) NSString *clientIDCode;
@property (nonatomic, retain) NSString *suffix;
@property (nonatomic, retain) NSNumber *currentClient;
@property (nonatomic, retain) NSString *prefix;
@property (nonatomic, retain) NSNumber *order;
@property (nonatomic, retain) NSString *keyString;
@property (nonatomic, retain) NSDate *dateAdded;
@property (nonatomic, retain) NSString *familyHistory;
@property (nonatomic, retain) NSString *notes;
@property (nonatomic, retain) NSString *historical;
@property (nonatomic, retain) NSData *fData;
@property (nonatomic, retain) NSSet *logs;
@property (nonatomic, retain) NSSet *substanceUse;
@property (nonatomic, retain) NSSet *groups;
@property (nonatomic, retain) NSSet *supportActivityClients;
@property (nonatomic, retain) NSSet *accomodations;
@property (nonatomic, retain) NSSet *fees;
@property (nonatomic, retain) NSSet *phoneNumbers;
@property (nonatomic, retain) NSSet *hospitalizations;
@property (nonatomic, retain) NSSet *clientPresentations;
@property (nonatomic, retain) NSSet *supervisonFeedback;
@property (nonatomic, retain) NSSet *expertTestemony;
@property (nonatomic, retain) NSSet *diagnoses;
@property (nonatomic, retain) DemographicProfileEntity *demographicInfo;
@property (nonatomic, retain) NSSet *referrals;
@property (nonatomic, retain) NSSet *payments;
@property (nonatomic, retain) NSSet *medicationHistory;
@property (nonatomic, retain) NSSet *vitals;
@property (nonatomic, retain) OtherReferralSourceEntity *otherReferralSource;
@end

@interface ClientEntity (CoreDataGeneratedAccessors)

- (void) addLogsObject:(LogEntity *)value;
- (void) removeLogsObject:(LogEntity *)value;
- (void) addLogs:(NSSet *)values;
- (void) removeLogs:(NSSet *)values;

- (void) addSubstanceUseObject:(SubstanceUseEntity *)value;
- (void) removeSubstanceUseObject:(SubstanceUseEntity *)value;
- (void) addSubstanceUse:(NSSet *)values;
- (void) removeSubstanceUse:(NSSet *)values;

- (void) addGroupsObject:(ClientGroupEntity *)value;
- (void) removeGroupsObject:(ClientGroupEntity *)value;
- (void) addGroups:(NSSet *)values;
- (void) removeGroups:(NSSet *)values;

- (void) addSupportActivityClientsObject:(SupportActivityClientEntity *)value;
- (void) removeSupportActivityClientsObject:(SupportActivityClientEntity *)value;
- (void) addSupportActivityClients:(NSSet *)values;
- (void) removeSupportActivityClients:(NSSet *)values;

- (void) addAccomodationsObject:(AccomodationEntity *)value;
- (void) removeAccomodationsObject:(AccomodationEntity *)value;
- (void) addAccomodations:(NSSet *)values;
- (void) removeAccomodations:(NSSet *)values;

- (void) addFeesObject:(FeeEntity *)value;
- (void) removeFeesObject:(FeeEntity *)value;
- (void) addFees:(NSSet *)values;
- (void) removeFees:(NSSet *)values;

- (void) addPhoneNumbersObject:(PhoneEntity *)value;
- (void) removePhoneNumbersObject:(PhoneEntity *)value;
- (void) addPhoneNumbers:(NSSet *)values;
- (void) removePhoneNumbers:(NSSet *)values;

- (void) addHospitalizationsObject:(HospitalizationEntity *)value;
- (void) removeHospitalizationsObject:(HospitalizationEntity *)value;
- (void) addHospitalizations:(NSSet *)values;
- (void) removeHospitalizations:(NSSet *)values;

- (void) addClientPresentationsObject:(ClientPresentationEntity *)value;
- (void) removeClientPresentationsObject:(ClientPresentationEntity *)value;
- (void) addClientPresentations:(NSSet *)values;
- (void) removeClientPresentations:(NSSet *)values;

- (void) addSupervisonFeedbackObject:(SupervisionFeedbackEntity *)value;
- (void) removeSupervisonFeedbackObject:(SupervisionFeedbackEntity *)value;
- (void) addSupervisonFeedback:(NSSet *)values;
- (void) removeSupervisonFeedback:(NSSet *)values;

- (void) addExpertTestemonyObject:(ExpertTestemonyEntity *)value;
- (void) removeExpertTestemonyObject:(ExpertTestemonyEntity *)value;
- (void) addExpertTestemony:(NSSet *)values;
- (void) removeExpertTestemony:(NSSet *)values;

- (void) addDiagnosesObject:(DiagnosisHistoryEntity *)value;
- (void) removeDiagnosesObject:(DiagnosisHistoryEntity *)value;
- (void) addDiagnoses:(NSSet *)values;
- (void) removeDiagnoses:(NSSet *)values;

- (void) addReferralsObject:(ReferralEntity *)value;
- (void) removeReferralsObject:(ReferralEntity *)value;
- (void) addReferrals:(NSSet *)values;
- (void) removeReferrals:(NSSet *)values;

- (void) addPaymentsObject:(PaymentEntity *)value;
- (void) removePaymentsObject:(PaymentEntity *)value;
- (void) addPayments:(NSSet *)values;
- (void) removePayments:(NSSet *)values;

- (void) addMedicationHistoryObject:(MedicationEntity *)value;
- (void) removeMedicationHistoryObject:(MedicationEntity *)value;
- (void) addMedicationHistory:(NSSet *)values;
- (void) removeMedicationHistory:(NSSet *)values;

- (void) addVitalsObject:(VitalsEntity *)value;
- (void) removeVitalsObject:(VitalsEntity *)value;
- (void) addVitals:(NSSet *)values;
- (void) removeVitals:(NSSet *)values;

@end
