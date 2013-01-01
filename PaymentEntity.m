//
//  PaymentEntity.m
//  PsyTrack
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import "PaymentEntity.h"
#import "ClientEntity.h"
#import "ConsultationEntity.h"


@implementation PaymentEntity

@dynamic amount;
@dynamic order;
@dynamic notes;
@dynamic dateCleared;
@dynamic dateReceived;
@dynamic client;
@dynamic paymentType;
@dynamic paymentSource;
@dynamic consultation;

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
