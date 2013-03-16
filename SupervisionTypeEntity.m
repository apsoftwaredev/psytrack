//
//  SupervisionTypeEntity.m
//  PsyTrack Clinician Tools
//  Version: 1.05
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import "SupervisionTypeEntity.h"
#import "ExistingSupervisionEntity.h"
#import "SupervisionGivenEntity.h"
#import "SupervisionReceivedEntity.h"
#import "SupervisionTypeSubtypeEntity.h"

@implementation SupervisionTypeEntity

@dynamic order;
@dynamic notes;
@dynamic supervisionType;
@dynamic existingSupervision;
@dynamic supervisionRecieved;
@dynamic supervisionGiven;
@dynamic subTypes;

@end
