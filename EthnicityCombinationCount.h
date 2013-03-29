//
//  EthnicityCombinationCount.h
//  PsyTrack Clinician Tools
//  Version: 1.0.6
//
//  Created by Daniel Boice on 9/16/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EthnicityCombinationCount : NSObject {
    NSString *ethnicityCombinationStr_;
    NSMutableSet *ethnicityCombinationMutableSet_;
    int ethnicityCombinationCount_;
}

@property (nonatomic, strong) NSString *ethnicityCombinationStr;
@property (nonatomic, strong) NSMutableSet *ethnicityCombinationMutableSet;
@property (nonatomic, assign) int ethnicityCombinationCount;

- (id) initWithEthnicityCombinationStr:(NSString *)ethnicityCombinationStrGiven ethnicityMutableSet:(NSMutableSet *)ethnicityMutableSetGiven;

@end
