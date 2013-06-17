//
//  DemographicSex.h
//  PsyTrack Clinician Tools
//  Version: 1.5.2
//
//  Created by Daniel Boice on 9/15/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DemographicSex : NSObject

@property (nonatomic, weak) NSString *sex;
@property (nonatomic, assign) int count;

- (id) initWithSex:(NSString *)sexGiven fromDemographicArray:(NSArray *)demographicArrayGiven;
- (id) initWithSex:(NSString *)sexGiven count:(int)countGiven;

@end
