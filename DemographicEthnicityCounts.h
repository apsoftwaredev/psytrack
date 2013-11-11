//
//  DemographicEthnicityCounts.h
//  PsyTrack Clinician Tools
//  Version: 1.5.5
//
//  Created by Daniel Boice on 9/16/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DemographicEthnicityCounts : NSObject {
    NSMutableArray *ethnicityMutableArray_;
    NSSet *multiEthnicityOnlySet_;
}

@property (nonatomic, strong) NSMutableArray *ethnicityMutableArray;
@property (nonatomic, strong) NSSet *multiEthnicityOnlySet;

@end
