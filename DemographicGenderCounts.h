//
//  DemographicGenderCounts.h
//  PsyTrack
//
//  Created by Daniel Boice on 9/15/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DemographicGenderCounts : NSObject{
    
    __weak NSMutableArray *genderMutableArray_;
    
    
}

@property (nonatomic, weak)NSMutableArray *genderMutableArray;



@end