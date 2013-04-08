//
//  DemographicGenderCounts.h
//  PsyTrack Clinician Tools
//  Version: 1.5.1
//
//  Created by Daniel Boice on 9/15/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DemographicGenderCounts : NSObject {
    NSMutableArray *genderMutableArray_;
}

@property (nonatomic, strong) NSMutableArray *genderMutableArray;

@property (nonatomic, assign) NSUInteger notSelectedCountUInteger;

@end
