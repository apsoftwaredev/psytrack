//
//  LCYPassCodeEditorViewController.h
//  LockScreen
//
//  Created by Krishna Kotecha on 22/11/2010.
//   Copyright 2010 Krishna Kotecha. All rights reserved.
//
// Edited by Dan Boice 1/20/2012
#import <UIKit/UIKit.h>
#import "LCYPasscodeUIStateMachine.h"
#import "LCYPasscodeInputViewController.h"

@class LCYPassCodeEditorViewController;
@class LCYChangePasscodeStateMachine;
@class LCYTurnOffPasscodeStateMachine;
@class LCYSetPasscodeStateMachine;

@protocol LCYPassCodeEditorDelegate <NSObject>
- (void) passcodeEditor: (LCYPassCodeEditorViewController *) passcodeEditor newCode:(NSString *) newCode;
@end

@interface LCYPassCodeEditorViewController : LCYPasscodeInputViewController
{
	id<LCYPassCodeEditorDelegate> delegate_;
	
	__weak UIView *digitsContainerView_;

	__weak UILabel *promptLabel_;
	__weak UILabel *errorLabel_;
	
	NSString *passCode_;
	BOOL acceptInput_;
	LCYPasscodeUIStateMachine *stateMachine_;
	
	LCYChangePasscodeStateMachine  *changePasscodeStateMachine_;
	LCYTurnOffPasscodeStateMachine *turnOffPasscodeStateMachine_;
	LCYSetPasscodeStateMachine	*setPasscodeStateMachine_;
}

@property (nonatomic, weak)  id<LCYPassCodeEditorDelegate> delegate;

@property (nonatomic, weak) IBOutlet UIView *digitsContainerView;
@property (nonatomic, weak) IBOutlet UILabel *promptLabel;
@property (nonatomic, weak) IBOutlet UILabel *errorLabel;

@property (nonatomic, copy) NSString* passCode;

- (void) attemptToSetANewPassCode;
- (void) attemptToDisablePassCode;

- (IBAction) cancel;

@end
