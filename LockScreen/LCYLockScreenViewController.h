//
//  LCYLockScreen.h
//  LockScreen
//
//  Created by Krishna Kotecha on 07/11/2010.
//   Copyright 2010 Krishna Kotecha. All rights reserved.
//
// Edited by Dan Boice 1/20/2012
#import <UIKit/UIKit.h>
#include <AudioToolbox/AudioToolbox.h>
#import "LCYPasscodeInputViewController.h"


@class LCYLockScreenViewController;

@protocol LCYLockScreenDelegate <NSObject>
- (void) lockScreen: (LCYLockScreenViewController *) lockScreen unlockedApp: (BOOL) unlocked;
@end


@interface LCYLockScreenViewController : LCYPasscodeInputViewController
{		
	__weak UIView *enterPassCodeBanner_;
	 UIView *wrongPassCodeBanner_;
	
	id<LCYLockScreenDelegate> delegate_;
	
	NSString *passCode_;	
    NSTimer *timer_;
    UILabel *tryAgainMessageLabel_;
    BOOL isLocked_;
    BOOL isTimerOn_;
    
    CFURLRef		soundFileURLRef;
	SystemSoundID	soundFileObject;
   
    __weak UIWindow *window;
//    PTTAppDelegate *appDelegate;
   
}

@property (nonatomic, weak) IBOutlet UIWindow *window;
@property (nonatomic, weak) IBOutlet UIView *enterPassCodeBanner;
@property (nonatomic, strong) IBOutlet UIView *wrongPassCodeBanner;
@property (nonatomic, strong) IBOutlet UILabel *tryAgainMessageLabel;
@property (weak)  id<LCYLockScreenDelegate> delegate;
@property (readwrite)	CFURLRef		soundFileURLRef;
@property (readonly)	SystemSoundID	soundFileObject;


@property (nonatomic, copy) NSString* passCode;

//-(NSString *)textMessageResetGenerator:(NSString *)textMessageNumber;
-(void)resetTimer;
-(void)turnOnTimer;
- (void) showBanner: (UIView *) bannerView;


NSString *FZARandomSalt(void);

NSData *FZAHashPassword(NSString *password, NSString *salt);


@end

