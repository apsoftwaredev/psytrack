//
//  MediaAppearanceEntity.m
//  PsyTrack
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import "MediaAppearanceEntity.h"


@implementation MediaAppearanceEntity

@dynamic topics;
@dynamic audience;
@dynamic showName;
@dynamic notes;
@dynamic order;
@dynamic hours;
@dynamic host;
@dynamic showtimes;
@dynamic network;
@dynamic dateInterviewed;


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
