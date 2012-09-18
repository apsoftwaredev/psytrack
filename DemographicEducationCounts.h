//
//  DemographicEducationCounts.h
//  PsyTrack
//
//  Created by Daniel Boice on 9/16/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DemographicEducationCounts : NSObject {
    
     NSMutableArray *educationMutableArray_;
    
    
}

@property (nonatomic, strong)NSMutableArray *educationMutableArray;

@property (nonatomic, assign)NSUInteger notSelectedCountUInteger;


@end
