//
//  LCYInputDrivenStateMachine.h
//
//  Created by Krishna Kotecha on 25/11/2010.
//  Copyright 2010 Krishna Kotecha. All rights reserved.
//
// Edited by Dan Boice 1/20/2012
#import <Foundation/Foundation.h>


@interface LCYPasscodeUIStateMachine : NSObject 
{

}

@property (nonatomic, copy) NSString* theNewPasscode;
@property (nonatomic, copy) NSString* existingPasscode;
@property (nonatomic, readonly) NSString *currentErrorText;

- (NSString *) currentPromptText;

- (void) transitionWithInput:(NSString *) input;
- (BOOL) gotCompletionState;
- (void) reset;


@end
