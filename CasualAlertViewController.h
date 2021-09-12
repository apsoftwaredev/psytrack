/*
 *  CasualAlertViewController.h
 *  psyTrack Clinician Tools
 *  Version: 1.5.4
 *
 *
 The MIT License (MIT)
 Copyright © 2011- 2021 Daniel Boice
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 *
 *  Created by Daniel Boice on 2/2/12.
 *  Copyright (c) 2011 PsycheWeb LLC. All rights reserved.
 *
 *
 *	This notice may not be removed from this file.
 *
 */
#import <UIKit/UIKit.h>

#import "PTTAppDelegate.h"

@interface CasualAlertViewController : UIViewController {
    NSMutableDictionary *blockDictionary;
    int currentAlerts;
    float durationSecondsFloat;
    BOOL fading;
    __weak UILabel *myLabel_;
    __weak UIView *labelContainerView_;
    PTTAppDelegate *appDelegate;
    NSInteger screenLocationToSetView;
}

@property (nonatomic, strong) NSMutableDictionary *blockDictionary;
@property (nonatomic, assign) int currentAlerts;
@property (nonatomic,weak) IBOutlet UILabel *myLabel;
@property (nonatomic, weak) IBOutlet UIView *labelContainerView;
- (void) displayRegularAlert:(NSString *)alertText forDuration:(float)seconds location:(NSInteger)screenLocation inView:(UIView *)containerView;
- (void) cleanAlertArea;
- (void) moveTo:(CGPoint)destination duration:(float)secs option:(UIViewAnimationOptions)option;
NSInteger intSort(id num1, id num2, void *context);
//-(IBAction)dismissPresentedView:(id)sender;
- (void) startFadeout;

- (CGPoint) makeStopPointForContainerSuperViewFrame:(CGRect)superViewFrame labelContainerFrame:(CGRect)labelContainer location:(NSInteger)screenLocation addtionalTopSpace:(float)additionalTopSpace additionalBottomSpace:(float)additionalBottomSpace;
- (CGRect) makeFrameForContainerSuperViewFrame:(CGRect)superViewFrame labelContainerFrame:(CGRect)labelContainer location:(NSInteger)screenLocation;

@end
