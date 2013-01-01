//
//  ClientEntity.m
//  PsyTrack
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import "ClientEntity.h"
#import "AccomodationEntity.h"
#import "ClientGroupEntity.h"
#import "ClientPresentationEntity.h"
#import "DemographicProfileEntity.h"
#import "DiagnosisHistoryEntity.h"
#import "ExpertTestemonyEntity.h"
#import "FeeEntity.h"
#import "HospitalizationEntity.h"
#import "LogEntity.h"
#import "MedicationEntity.h"
#import "OtherReferralSourceEntity.h"
#import "PaymentEntity.h"
#import "PhoneEntity.h"
#import "ReferralEntity.h"
#import "SubstanceUseEntity.h"
#import "SupervisionFeedbackEntity.h"
#import "SupportActivityClientEntity.h"
#import "VitalsEntity.h"


@implementation ClientEntity

@dynamic dateOfBirth;
@dynamic lastName;
@dynamic middleName;
@dynamic firstName;
@dynamic address;
@dynamic initials;
@dynamic clientIDCode;
@dynamic suffix;
@dynamic currentClient;
@dynamic prefix;
@dynamic order;
@dynamic keyString;
@dynamic dateAdded;
@dynamic familyHistory;
@dynamic notes;
@dynamic historical;
@dynamic fData;
@dynamic logs;
@dynamic substanceUse;
@dynamic groups;
@dynamic supportActivityClients;
@dynamic accomodations;
@dynamic fees;
@dynamic phoneNumbers;
@dynamic hospitalizations;
@dynamic clientPresentations;
@dynamic supervisonFeedback;
@dynamic expertTestemony;
@dynamic diagnoses;
@dynamic demographicInfo;
@dynamic referrals;
@dynamic payments;
@dynamic medicationHistory;
@dynamic vitals;
@dynamic otherReferralSource;

@end
