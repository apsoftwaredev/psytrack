//
//  MyInformationAndTotalClients.h
//  PsyTrack
//
//  Created by Daniel Boice on 9/16/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyInformationAndTotalClients : NSObject
{

   __weak NSString *myName_;
    int totalClients_;


}
@property (nonatomic, weak) NSString *myName;
@property (nonatomic, assign) int totalClients;

@end
