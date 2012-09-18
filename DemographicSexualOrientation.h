//
//  DemographicSexualOrientation.h
//  PsyTrack
//
//  Created by Daniel Boice on 9/15/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DemographicSexualOrientation : NSObject


@property (nonatomic, strong) NSString *sexualOrientation;
@property (nonatomic, assign) int count;

-(id)initWithSexualOrientation:(NSString *)sexOrientationGiven fromDemographicArray:(NSArray *)demographicArrayGiven;
-(id)initWithSexualOrientation:(NSString *)sexOrientationGiven count:(int)countGiven;
@end
