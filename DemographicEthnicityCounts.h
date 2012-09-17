//
//  DemographicEthnicityCounts.h
//  PsyTrack
//
//  Created by Daniel Boice on 9/16/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DemographicEthnicityCounts : NSObject{
    
    __weak NSMutableArray *ethnicityMutableArray_;
    __weak NSSet *multiEthnicityOnlySet_;
    
}

@property (nonatomic, weak)NSMutableArray *ethnicityMutableArray;
@property (nonatomic, weak)NSSet *multiEthnicityOnlySet;


@end
