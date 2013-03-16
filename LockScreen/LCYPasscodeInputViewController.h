//
//  LCYPasscodeInputHandler.h
//  LockScreen
//
//  Created by Krishna Kotecha on 28/11/2010.
//   Copyright 2010 Krishna Kotecha. All rights reserved.
//
// Edited by Dan Boice 1/20/2012
#import <UIKit/UIKit.h>

@class LCYLockDigitView;

@interface LCYPasscodeInputViewController : UIViewController <UITextFieldDelegate>
{
    __weak LCYLockDigitView *lockDigit_0_;
    __weak LCYLockDigitView *lockDigit_1_;
    __weak LCYLockDigitView *lockDigit_2_;
    __weak LCYLockDigitView *lockDigit_3_;

    __weak UITextField *passCodeInputField_;
}

@property (nonatomic, weak) IBOutlet LCYLockDigitView *lockDigit_0;
@property (nonatomic, weak) IBOutlet LCYLockDigitView *lockDigit_1;
@property (nonatomic, weak) IBOutlet LCYLockDigitView *lockDigit_2;
@property (nonatomic, weak) IBOutlet LCYLockDigitView *lockDigit_3;

@property (nonatomic, weak) IBOutlet UITextField *passCodeInputField;

- (void) resetUIState;

@end
