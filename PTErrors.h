//
//  PTErrors.h
//  PsyTrack Clinician Tools
//
//  Created by Daniel Boice on 2/21/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

#define logLine [pttError logLineStr];

@interface PTErrors : NSObject

+ (void) notification:(NSNotification *)notification error:(NSError**)error exception:(NSException *)exception;

-(void)logLineStr;

@end
