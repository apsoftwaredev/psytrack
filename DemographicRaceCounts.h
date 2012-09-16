//
//  DemographicRaceCounts.h
//  PsyTrack
//
//  Created by Daniel Boice on 9/15/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DemographicRaceCounts : NSObject {
    
    __weak NSMutableArray *raceMutableArray_;
    __weak NSSet *multiRacialOnlySet_;
    
}

@property (nonatomic, weak)NSMutableArray *raceMutableArray;
@property (nonatomic, weak)NSSet *multiRacialOnlySet;
@end
