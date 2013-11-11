//
//  LanguageSpokenEntity.h
//  PsyTrack Clinician Tools
//  Version: 1.5.5
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class DemographicProfileEntity, LanguageEntity;

@interface LanguageSpokenEntity : NSManagedObject

@property (nonatomic, retain) NSNumber *onlyLanguage;
@property (nonatomic, retain) NSNumber *order;
@property (nonatomic, retain) NSString *notes;
@property (nonatomic, retain) NSDate *startedSpeaking;
@property (nonatomic, retain) NSNumber *nativeSpeaker;
@property (nonatomic, retain) NSNumber *primaryLanguage;
@property (nonatomic, retain) NSNumber *fluencyLevel;
@property (nonatomic, retain) LanguageEntity *language;
@property (nonatomic, retain) DemographicProfileEntity *demographics;

@end
