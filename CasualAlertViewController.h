/*
 *  CasualAlertViewController.h
 *  psyTrack Clinician Tools
 *  Version: 1.0
 *
 *
 *	THIS SOURCE CODE AND ANY ACCOMPANYING DOCUMENTATION ARE PROTECTED BY UNITED STATES 
 *	INTELLECTUAL PROPERTY LAW AND INTERNATIONAL TREATIES. UNAUTHORIZED REPRODUCTION OR 
 *	DISTRIBUTION IS SUBJECT TO CIVIL AND CRIMINAL PENALTIES. 
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
}

@property (nonatomic, strong) NSMutableDictionary *blockDictionary;
@property (nonatomic, assign) int currentAlerts;
@property (nonatomic,weak)IBOutlet UILabel *myLabel;
@property (nonatomic, weak)IBOutlet UIView *labelContainerView;
-(void)displayRegularAlert:(NSString*)alertText forDuration:(float)seconds location:(NSInteger )screenLocation  inView:(UIView *)containerView;
-(void)cleanAlertArea;
- (void) moveTo:(CGPoint)destination duration:(float)secs option:(UIViewAnimationOptions)option;
NSInteger intSort(id num1, id num2, void *context);
//-(IBAction)dismissPresentedView:(id)sender;
-(void)startFadeout;
-(void)cleanAlertArea;

-(CGPoint )makeStopPointForContainerSuperViewFrame:(CGRect)superViewFrame labelContainerFrame:(CGRect)labelContainer location:(NSInteger )screenLocation addtionalTopSpace:(float)additionalTopSpace additionalBottomSpace:(float)additionalBottomSpace;
-(CGRect )makeFrameForContainerSuperViewFrame:(CGRect)superViewFrame labelContainerFrame:(CGRect)labelContainer location:(NSInteger )screenLocation;

@end
