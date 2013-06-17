//
//  DemographicSexualOrientationCounts.h
//  PsyTrack Clinician Tools
//  Version: 1.5.2
//
//  Created by Daniel Boice on 9/15/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DemographicSexualOrientationCounts : NSObject {
    NSMutableArray *sexualOrientationMutableArray_;
}

@property (nonatomic, strong) NSMutableArray *sexualOrientationMutableArray;

@end
