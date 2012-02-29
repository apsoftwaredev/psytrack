//
//  UICasualAlert.h
//  UICasualAlert
//
//  Created by Nils Munch on 7/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>
#import "RedAlertViewController.h"

@interface UICasualAlert : UIViewController {
    NSMutableDictionary *blockDictionary;
    int currentAlerts;
    NSTimer *timer;
//    RedAlertViewController *redAlertViewController;
}

@property (nonatomic, strong) NSMutableDictionary *blockDictionary;
@property (nonatomic) int currentAlerts;

-(void)displayRegularAlert:(NSString*)alertText forDuration:(float)seconds location:(NSInteger )screenLocation  inView:(UIView *)containerView;
-(void)cleanAlertArea;

NSInteger intSort(id num1, id num2, void *context);
//-(IBAction)dismissPresentedView:(id)sender;
@property (nonatomic, weak)IBOutlet UIView *myContainerView;
@property (nonatomic, weak)IBOutlet UILabel *myLabel;

@end
