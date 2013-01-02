//
//  InstrumentScoreEntity.m
//  PsyTrack
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import "InstrumentScoreEntity.h"
#import "ClientInstrumentScoresEntity.h"
#import "InstrumentScoreNameEntity.h"


@implementation InstrumentScoreEntity

@dynamic confidence;
@dynamic tScore;
@dynamic cIFloor;
@dynamic cICeiling;
@dynamic scaledScore;
@dynamic notes;
@dynamic order;
@dynamic zScore;
@dynamic baseRate;
@dynamic standardScore;
@dynamic rawScore;
@dynamic percentile;
@dynamic clientInstrumentScore;
@dynamic scoreName;

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
