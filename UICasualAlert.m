////
////  UICasualAlert.m
////  UICasualAlert
////
////  Created by Nils Munch on 7/3/11.
////  Copyright 2011 LizardFactory. All rights reserved.
////
//
//#import "UICasualAlert.h"
//#import "PTTAppDelegate.h"
//#import "UICasualAlertLabel.h"
//
//
//@implementation UICasualAlert
//
//@synthesize blockDictionary;
//@synthesize currentAlerts;
//@synthesize myContainerView;
//@synthesize myLabel;
//
//NSInteger intSort(id num1, id num2, void *context)
//{
//    int v1 = [num1 intValue];
//    int v2 = [num2 intValue];
//    if (v1 < v2)
//        return NSOrderedAscending;
//    else if (v1 > v2)
//        return NSOrderedDescending;
//    else
//        return NSOrderedSame;
//}
//
//-(void)displayRegularAlert:(NSString*)alertText forDuration:(float)seconds location:(NSInteger )screenLocation  inView:(UIView *)containerView {
////    int alertDistance = 30;
//	PTTAppDelegate *del = (PTTAppDelegate*)[[UIApplication sharedApplication] delegate];
//    UICasualAlert *manager = del.casualAlertManager;
//    if (!manager) {
//        del.casualAlertManager = [[UICasualAlert alloc] init];
//        manager = del.casualAlertManager;
//    }
//    
//    if (!manager.blockDictionary) {
//        manager.blockDictionary = [[NSMutableDictionary alloc] init];
//    }
//    UICasualAlertLabel *newLabel = nil;
//    NSString *newBlockKey = [NSString stringWithFormat:@"%i",manager.currentAlerts];
//    NSArray* values = [manager.blockDictionary allKeys];
//    NSArray* sortedKeys = [values sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
//    
//    for (NSString *existingKey in sortedKeys) {
//        UICasualAlertLabel *reviveLabel = [manager.blockDictionary objectForKey:existingKey];
//        if (newLabel == nil && reviveLabel.alpha == 0.0) { newLabel = reviveLabel; newBlockKey = existingKey; }
//    }
////CGRect appWindowFrame=[del.tabBarController.view frame];
//CGRect frame = CGRectMake(0,0,419.0,112);
//    if (![manager.blockDictionary objectForKey:newBlockKey]) {
//        newLabel = [[UICasualAlertLabel alloc] initWithFrame:frame];
//        newLabel.manager = manager;
//        [manager.blockDictionary setObject:newLabel forKey:newBlockKey];
//    } else {
//        newLabel = [manager.blockDictionary objectForKey:newBlockKey];
//    }
//    [newLabel setText:alertText];
//    if (seconds != 0.0) {[newLabel setDuration:seconds];}
//    newLabel.alpha = 1.0;
//    manager.currentAlerts++;
//
//if(!containerView)
//{
//   
//    
//
//
//    UITabBarController *tabBarController=(UITabBarController*)del.tabBarController;
//    
//   
//    if (![tabBarController.view viewWithTag:654]){
//        NSLog(@"newlabel class is%@", [newLabel class] );
//        CGRect appWindowFrame=[del.window frame];
////        CGRect frame = CGRectMake(appWindowFrame.size.width/2-419/2,appWindowFrame.size.height/2-112/2,419,112);
////        UIView *containerView=[[UIView alloc]initWithFrame:frame];
//        myContainerView.tag=654;
//        CGRect newLabelFrame=newLabel.frame;
//        newLabelFrame = CGRectMake(appWindowFrame.size.width/2-419/2,appWindowFrame.size.height/2-112/2,419,112);
//        
//        
//        [myContainerView.;
//    
//        [tabBarController.view addSubview:myContainerView];
//    }
//    else {
//        UIView *oldContainer=[tabBarController.view viewWithTag:654];
//        
//        UILabel *oldLabel=(UILabel *)[oldContainer viewWithTag:456];
//        if(oldLabel)
//        {
//            oldLabel=nil;
//            
//        }
//       
//        [oldContainer addSubview:newLabel];
//        [oldContainer removeFromSuperview];
//        [tabBarController.view addSubview:oldContainer];
//    }
//
//}
//else 
//{
//    [containerView addSubview:newLabel];
//}
//
//    
//}
//
//-(void)cleanAlertArea {
//    currentAlerts--;
//}

//-(void)displayRedAlertWithMessageText:(NSString *)message forDuration:(float)seconds inViewController:(UIViewController *)viewController{
//PTTAppDelegate *del = (PTTAppDelegate*)[[UIApplication sharedApplication] delegate];
//
//           redAlertViewController=[[RedAlertViewController alloc]initWithNibName:@"RedAlertViewController" bundle:[NSBundle mainBundle] ];
//            
////UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:redAlertViewController];	
////
////
////[[viewController navigationController] presentModalViewController:navController animated:YES];
//    
////
//CGRect frame = CGRectMake(del.window.frame.size.width/2-redAlertViewController.view.frame.size.width/2,del.window.frame.size.height/2-redAlertViewController.view.frame.size.height/2,redAlertViewController.view.frame.size.width,redAlertViewController.view.frame.size.height);
//[redAlertViewController view].frame = frame;
////
//
//    UITabBarController *tabBarController=(UITabBarController*)del.tabBarController;
//    
//    [tabBarController.view addSubview:redAlertViewController.view];
//
//[self  displayRegularAlert:(NSString*)message forDuration:(float)seconds inView:(UIView *)redAlertViewController.view];
//timer = [NSTimer scheduledTimerWithTimeInterval:5.0
//                                         target:self
//                                       selector:@selector(dismissPresentedView:)
//                                       userInfo:NULL
//                                        repeats:NO];
//
//}
//
//-(IBAction)dismissPresentedView:(id)sender{
//
//    
//NSLog(@"timer should dismiss view");
//    
//    [redAlertViewController dismissModalViewControllerAnimated:YES];
//
//
//}

//@end
