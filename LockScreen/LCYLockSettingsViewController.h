//
//  LCYLockSettingsViewController.h
//  LockScreen
//
//  Created by Krishna Kotecha on 22/11/2010.
//   Copyright 2010 Krishna Kotecha. All rights reserved.
//
//Edited by Dan Boice 1/20/2012


#import "LCYPassCodeEditorViewController.h"

#import <UIKit/UIKit.h>

@interface LCYLockSettingsViewController : SCTableViewController  <LCYPassCodeEditorDelegate,SCTableViewModelDelegate>
{
	NSArray *sectionTitles_;
    SCArrayOfObjectsModel *objectsModel;
     NSMutableDictionary *valuesDictionary_;
}

// LCYPassCodeEditorDelegate protocol...


- (void) passcodeEditor: (LCYPassCodeEditorViewController *) passcodeEditor newCode:(NSData *) newCode;

- (BOOL) passCodeLockIsOn;
- (NSData *) currentPasscode;
- (void) updatePasscodeSettings: (NSData *) newCode;
- (void) lockApplication;
-(IBAction)updatePasscodeOnSwichCell;

- (BOOL) isLockedAtStartup;
- (void) setLockedAtStartup:(BOOL)value;
@end
