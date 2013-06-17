//
//  DisabilityCombinationCount.h
//  PsyTrack Clinician Tools
//  Version: 1.5.2
//
//  Created by Daniel Boice on 9/16/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DisabilityCombinationCount : NSObject {
    NSString *disabilityCombinationStr_;
    NSMutableSet *disabilityCombinationMutableSet_;
    int disabilityCombinationCount_;
}

@property (nonatomic, strong) NSString *disabilityCombinationStr;
@property (nonatomic, strong) NSMutableSet *disabilityCombinationMutableSet;
@property (nonatomic, assign) int disabilityCombinationCount;

- (id) initWithDisabilityCombinationStr:(NSString *)disabilityCombinationStrGiven disabilityMutableSet:(NSMutableSet *)disabilityMutableSetGiven;

@end
