//
//  RaceCombinationCount.h
//  PsyTrack
//
//  Created by Daniel Boice on 9/16/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RaceCombinationCount : NSObject {

   __weak NSString *raceCombinationStr_;
    __weak NSMutableSet *raceCombinationMutableSet_;
     int raceCombinationCount_;



}

@property (nonatomic, weak) NSString *raceCombinationStr;
@property (nonatomic, weak) NSMutableSet *raceCombinationMutableSet;
@property (nonatomic, assign) int raceCombinationCount;

-(id)initWithRaceCombinationStr:(NSString *)raceCombinationStrGiven raceMutableSet:(NSMutableSet *)raceMutableSetGiven;

@end
