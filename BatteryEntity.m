//
//  BatteryEntity.m
//  PsyTrack
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import "BatteryEntity.h"
#import "ExistingBatteryEntity.h"
#import "InstrumentEntity.h"
#import "InstrumentLogEntity.h"
#import "InstrumentPublisherEntity.h"


@implementation BatteryEntity

@dynamic numberReportsWritten;
@dynamic numberAdminstered;
@dynamic numberScored;
@dynamic notes;
@dynamic order;
@dynamic ages;
@dynamic acronym;
@dynamic batteryName;
@dynamic sampleSize;
@dynamic logs;
@dynamic publisher;
@dynamic instruments;
@dynamic existingBatteries;
@dynamic clientBatteryNotes;


-(BOOL)validateValue:(__autoreleasing id *)value forKey:(NSString *)key error:(NSError *__autoreleasing *)error
{
    if ( ![self.managedObjectContext isKindOfClass:[PTManagedObjectContext class]] ) {
        return YES;
    }
    else {
        return [super validateValue:value forKey:key error:error];
    }
}

+(BOOL)deletesInvalidObjectsAfterFailedSave
{
    return NO;
}

-(void)repairForError:(NSError *)error
{
    if ( [self.class deletesInvalidObjectsAfterFailedSave] ) {
        [self.managedObjectContext deleteObject:self];
    }
}


@end
