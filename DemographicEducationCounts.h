//
//  DemographicEducationCounts.h
//  PsyTrack
//
//  Created by Daniel Boice on 9/16/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DemographicEducationCounts : NSObject {
    
    __weak NSMutableArray *educationMutableArray_;
    
    
}

@property (nonatomic, weak)NSMutableArray *educationMutableArray;



@end