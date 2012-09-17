//
//  DemographicDisabilityCount.h
//  PsyTrack
//
//  Created by Daniel Boice on 9/16/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DemographicDisabilityCount : NSObject{
    
    __weak NSMutableArray *disabilityMutableArray_;
    __weak NSSet *multiDisabilityOnlySet_;
    
}

@property (nonatomic, weak)NSMutableArray *disabilityMutableArray;
@property (nonatomic, weak)NSSet *multiDisabilityOnlySet;

@end
