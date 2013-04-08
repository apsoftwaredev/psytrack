//
//  MyInformationAndTotalClients.h
//  PsyTrack Clinician Tools
//  Version: 1.5.1
//
//  Created by Daniel Boice on 9/16/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyInformationAndTotalClients : NSObject
{
    NSString *myName_;
    int totalClients_;
}
@property (nonatomic, strong) NSString *myName;
@property (nonatomic, assign) int totalClients;

@end
