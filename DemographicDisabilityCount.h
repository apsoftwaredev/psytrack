//
//  DemographicDisabilityCount.h
//  PsyTrack Clinician Tools
//  Version: 1.5.2
//
//  Created by Daniel Boice on 9/16/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DemographicDisabilityCount : NSObject {
    NSMutableArray *disabilityMutableArray_;
    NSSet *multiDisabilityOnlySet_;
}

@property (nonatomic, strong) NSMutableArray *disabilityMutableArray;
@property (nonatomic, strong) NSSet *multiDisabilityOnlySet;

@end
