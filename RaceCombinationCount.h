//
//  RaceCombinationCount.h
//  PsyTrack Clinician Tools
//  Version: 1.5.3
//
//  Created by Daniel Boice on 9/16/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RaceCombinationCount : NSObject {
    NSString *raceCombinationStr_;
    NSMutableSet *raceCombinationMutableSet_;
    NSUInteger raceCombinationCount_;
}

@property (nonatomic, strong) NSString *raceCombinationStr;
@property (nonatomic, strong) NSMutableSet *raceCombinationMutableSet;
@property (nonatomic, assign) NSUInteger raceCombinationCount;

- (id) initWithRaceCombinationStr:(NSString *)raceCombinationStrGiven raceMutableSet:(NSMutableSet *)raceMutableSetGiven;
- (id) initWithNilSelectionCount:(NSUInteger)countGiven;
@end
