//
//  EthnicityCombinationCount.h
//  PsyTrack
//
//  Created by Daniel Boice on 9/16/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EthnicityCombinationCount : NSObject {
    
    __weak NSString *ethnicityCombinationStr_;
    __weak NSMutableSet *ethnicityCombinationMutableSet_;
    int ethnicityCombinationCount_;
    
    
    
}

@property (nonatomic, weak) NSString *ethnicityCombinationStr;
@property (nonatomic, weak) NSMutableSet *ethnicityCombinationMutableSet;
@property (nonatomic, assign) int ethnicityCombinationCount;

-(id)initWithEthnicityCombinationStr:(NSString *)ethnicityCombinationStrGiven ethnicityMutableSet:(NSMutableSet *)ethnicityMutableSetGiven;



@end
