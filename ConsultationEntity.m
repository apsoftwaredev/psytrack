//
//  ConsultationEntity.m
//  PsyTrack
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import "ConsultationEntity.h"
#import "FeeEntity.h"
#import "LogEntity.h"
#import "OrganizationEntity.h"
#import "PaymentEntity.h"
#import "ReferralEntity.h"


@implementation ConsultationEntity

@dynamic proBono;
@dynamic hours;
@dynamic endDate;
@dynamic notes;
@dynamic startDate;
@dynamic paid;
@dynamic organization;
@dynamic payments;
@dynamic rateCharges;
@dynamic logs;
@dynamic fees;
@dynamic referrals;


-(BOOL)validateValue:(__autoreleasing id *)value forKey:(NSString *)key error:(NSError *__autoreleasing *)error
{
    if ( ![self.managedObjectContext isKindOfClass:[PTManagedObjectContext class]] ) {
        return YES;
    }
    else {
        return [super validateValue:value forKey:key error:error];
    }
}

@end
