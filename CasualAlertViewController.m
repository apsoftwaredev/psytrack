/*
 *  CasualAlertViewController.m
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
#import "CasualAlertViewController.h"




@interface CasualAlertViewController ()

@end

@implementation CasualAlertViewController


@synthesize blockDictionary;
@synthesize currentAlerts;
//@synthesize myContainerView;
@synthesize myLabel =myLabel_;
@synthesize labelContainerView=labelContainerView_;

NSInteger intSort(id num1, id num2, void *context)
{
    int v1 = [num1 intValue];
    int v2 = [num2 intValue];
    if (v1 < v2)
        return NSOrderedAscending;
    else if (v1 > v2)
        return NSOrderedDescending;
    else
        return NSOrderedSame;
}



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    

 
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

-(void)displayRegularAlert:(NSString*)alertText forDuration:(float)seconds location:(NSInteger )screenLocation  inView:(UIView *)containerView {

    screenLocationToSetView=screenLocation;
    self.labelContainerView=containerView;
   
    durationSecondsFloat=seconds;
   
    [myLabel_  setText:alertText];
    
    appDelegate = (PTTAppDelegate*)[[UIApplication sharedApplication] delegate];
//    if(containerView)
//    {
//        int alertDistance = 60;
//   
//    CasualAlertViewController *manager = appDelegate.casualAlertManager;
//    if (!manager) {
//        appDelegate.casualAlertManager = [[CasualAlertViewController alloc] init];
//        manager = appDelegate.casualAlertManager;
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
//    //CGRect appWindowFrame=[del.tabBarController.view frame];
////    CGRect frame = CGRectMake(0,0,419.0,112);
//    if (![manager.blockDictionary objectForKey:newBlockKey]) {
//        newLabel = [[UICasualAlertLabel alloc] initWithFrame:CGRectMake(0, (alertDistance+1)*manager.currentAlerts, containerView.frame.size.width, alertDistance)];
//        newLabel.manager = manager;
//        [manager.blockDictionary setObject:newLabel forKey:newBlockKey];
//    } else {
//        newLabel = [manager.blockDictionary objectForKey:newBlockKey];
//    }
//    [newLabel setText:alertText];
//    if (seconds != 0.0) {[newLabel setDuration:seconds];}
//    newLabel.alpha = 0.0;
//    manager.currentAlerts++;
//          [UIView setAnimationDelegate:self];
//        [UIView transitionWithView:containerView duration:5.0 options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionAllowUserInteraction animations:^{newLabel.alpha = 1.0;
//        } completion:^(BOOL finished) {
//           [containerView addSubview:newLabel];
//            fading = NO;
//           
//        }];
//
//        
//        CGRect frame= [self makeFrameForContainerSuperViewFrame:(CGRect)containerView.frame labelContainerFrame:(CGRect)newLabel.frame location:(NSInteger )screenLocation];
//        
//        //        CGRect myFrame=(CGRect) self.view.frame;
//        [self.view setFrame:frame];
//        
//        
//        float additionalTopSpace,additionalBottomSpace;
//        additionalTopSpace =0;
//        additionalBottomSpace=0;
//        CGPoint stopPoint=[self makeStopPointForContainerSuperViewFrame:(CGRect)containerView.frame  labelContainerFrame:(CGRect)newLabel.frame location:(NSInteger )screenLocation addtionalTopSpace:(float)additionalTopSpace additionalBottomSpace:(float)additionalBottomSpace];
//        
      

        
//        [self  moveTo:(CGPoint)stopPoint duration:(float)seconds option:(UIViewAnimationOptions)UIViewAnimationOptionTransitionCurlDown];

//    
//    }
//    else 
//    {
    float additionalTopSpace,additionalBottomSpace;
    CGRect appWindowFrame;
    UIInterfaceOrientation currentOrientation = 
    [UIApplication sharedApplication].statusBarOrientation;

    if (labelContainerView_) {
        [labelContainerView_ addSubview:self.view];
        
//        if ([labelContainerView_ superclass]==[UIWindow class]) {
//            additionalTopSpace=additionalTopSpace+20;
//            
//            
//        }
       
                
            additionalTopSpace =+self.view.frame.size.height;
        
        
     
       
        
        additionalBottomSpace=0;
        appWindowFrame=(CGRect )[labelContainerView_ frame];
    }
    else
    {
        UITabBarController *tabBarController=(UITabBarController*)appDelegate.tabBarController;
        [tabBarController.view addSubview:self.view];
        additionalTopSpace =50;
        additionalBottomSpace=100;
     
        if ((currentOrientation==UIInterfaceOrientationLandscapeLeft||currentOrientation==UIInterfaceOrientationLandscapeRight)){
            appWindowFrame=CGRectMake(appDelegate.window.frame.origin.x, appDelegate.window.frame.origin.y, appDelegate.window.frame.size.height, appDelegate.window.frame.size.width);
        }
        else {
            appWindowFrame=appDelegate.window.frame;
        }
        
        if ((currentOrientation==UIInterfaceOrientationLandscapeLeft||currentOrientation==UIInterfaceOrientationLandscapeRight)&&[[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
        
            additionalTopSpace =60;
         
        
        }
        
        
    }
        
         [UIView setAnimationDelegate:self];
        
        

       
    self.view.tag=645;
        appWindowFrame.size.height=appWindowFrame.size.height-additionalTopSpace;
    appWindowFrame.size.width=appWindowFrame.size.width;
//        switch (screenLocation) {
//            case kScreenLocationTop:
//                 frame = CGRectMake(0,-94,appWindowFrame.size.width,94);
//                 stopPoint= CGPointMake (0,65);
//                break;
//            case kScreenLocationMiddle:
//                 frame = CGRectMake(0,appWindowFrame.size.height/2-94/2,appWindowFrame.size.width,94);
//                stopPoint= CGPointMake (0,appWindowFrame.size.height/2-94/2);
//                break;
//            case kScreenLocationLeft:
//                frame = CGRectMake(-appWindowFrame.size.width,appWindowFrame.size.height/2-94/2,appWindowFrame.size.width,94);
//                stopPoint= CGPointMake (0,appWindowFrame.size.height/2-94/2);
//                break;
//            case kScreenLocationRight:
//                frame = CGRectMake(appWindowFrame.size.width,appWindowFrame.size.height/2-94/2,appWindowFrame.size.width,94);
//                stopPoint= CGPointMake (0,appWindowFrame.size.height/2-94/2);
//                break;
//            case kScreenLocationBottom:
//                frame = CGRectMake(0,appWindowFrame.size.height+94,appWindowFrame.size.width,94);
//                stopPoint= CGPointMake (0,appWindowFrame.size.height-49-94);
//                break;
//            default:
//                break;
//        }
        
      
        CGRect myViewFrame=(CGRect ) self.view.frame;
       
        CGRect frame= [self makeFrameForContainerSuperViewFrame:(CGRect)appWindowFrame labelContainerFrame:(CGRect)myViewFrame location:(NSInteger )screenLocation];
        
//        CGRect myFrame=(CGRect) self.view.frame;
        [self.view setFrame:frame];
            
        CGPoint stopPoint=[self makeStopPointForContainerSuperViewFrame:(CGRect)appWindowFrame  labelContainerFrame:(CGRect)myViewFrame location:(NSInteger )screenLocation addtionalTopSpace:(float)additionalTopSpace additionalBottomSpace:(float)additionalBottomSpace];
        
        
        
        
        
        [self  moveTo:(CGPoint)stopPoint duration:(float)seconds option:(UIViewAnimationOptions)UIViewAnimationOptionTransitionCrossDissolve];
        
        
//        if ([tabBarController.view viewWithTag:654]){
//            
//            CGRect appWindowFrame=[del.window frame];
//            //        CGRect frame = CGRectMake(appWindowFrame.size.width/2-419/2,appWindowFrame.size.height/2-112/2,419,112);
//            //        UIView *containerView=[[UIView alloc]initWithFrame:frame];
//            self.view.tag=654;
//            CGRect newLabelFrame=newLabel.frame;
//            newLabelFrame = CGRectMake(appWindowFrame.size.width/2-419/2,appWindowFrame.size.height/2-112/2,419,112);
//            
//            
//            
//             }
//             else {
//                 UIView *oldContainer=[tabBarController.view viewWithTag:654];
//                 
//                 UILabel *oldLabel=(UILabel *)[oldContainer viewWithTag:456];
//                 if(oldLabel)
//                 {
//                     oldLabel=nil;
//                     
//                 }
//                 
//                 [oldContainer ];
//                 [oldContainer removeFromSuperview];
//                 [tabBarController.view addSubview:oldContainer];
//             }
//             
//             }
          
             
             
 }

-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{


    [self makeFrame];



}
-(void )makeFrame{

    float additionalTopSpace,additionalBottomSpace;
    CGRect appWindowFrame;
    UIInterfaceOrientation currentOrientation = 
    [UIApplication sharedApplication].statusBarOrientation;
    
    if (labelContainerView_) {
        [labelContainerView_ addSubview:self.view];
        
//        if ([labelContainerView_ superclass]==[UIWindow class]) {
//            additionalTopSpace=additionalTopSpace+20;
//        
//       
//        
//        
//        }
//        
        
        
        
            
            additionalTopSpace =+self.view.frame.size.height-20;
            
            
      
        
        
        additionalBottomSpace=0;
        appWindowFrame=(CGRect )[labelContainerView_ frame];
    }
    else
    {
        UITabBarController *tabBarController=(UITabBarController*)appDelegate.tabBarController;
        [tabBarController.view addSubview:self.view];
        additionalTopSpace =32;
        additionalBottomSpace=49;
        
        appWindowFrame=(CGRect )[appDelegate.window frame];
        
        
        if ((currentOrientation==UIInterfaceOrientationLandscapeLeft||currentOrientation==UIInterfaceOrientationLandscapeRight)&&[[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
            
            additionalTopSpace =32+10;
            
            
        }
        
        
    }
    
    [UIView setAnimationDelegate:self];
    
    
    
    
    self.view.tag=645;
    if (screenLocationToSetView==kPTTScreenLocationTop) {
        appWindowFrame.size.height=appWindowFrame.size.height-additionalTopSpace;
    }else if (screenLocationToSetView ==kPTTScreenLocationBottom) 
    {
        appWindowFrame.size.height=appWindowFrame.size.height+additionalBottomSpace;
    }
    
    appWindowFrame.size.width=appWindowFrame.size.width;
    //        switch (screenLocation) {
    //            case kScreenLocationTop:
    //                 frame = CGRectMake(0,-94,appWindowFrame.size.width,94);
    //                 stopPoint= CGPointMake (0,65);
    //                break;
    //            case kScreenLocationMiddle:
    //                 frame = CGRectMake(0,appWindowFrame.size.height/2-94/2,appWindowFrame.size.width,94);
    //                stopPoint= CGPointMake (0,appWindowFrame.size.height/2-94/2);
    //                break;
    //            case kScreenLocationLeft:
    //                frame = CGRectMake(-appWindowFrame.size.width,appWindowFrame.size.height/2-94/2,appWindowFrame.size.width,94);
    //                stopPoint= CGPointMake (0,appWindowFrame.size.height/2-94/2);
    //                break;
    //            case kScreenLocationRight:
    //                frame = CGRectMake(appWindowFrame.size.width,appWindowFrame.size.height/2-94/2,appWindowFrame.size.width,94);
    //                stopPoint= CGPointMake (0,appWindowFrame.size.height/2-94/2);
    //                break;
    //            case kScreenLocationBottom:
    //                frame = CGRectMake(0,appWindowFrame.size.height+94,appWindowFrame.size.width,94);
    //                stopPoint= CGPointMake (0,appWindowFrame.size.height-49-94);
    //                break;
    //            default:
    //                break;
    //        }
    
    
    CGRect myViewFrame=(CGRect ) self.view.frame;
    
    CGRect frame= [self makeFrameForContainerSuperViewFrame:(CGRect)appWindowFrame labelContainerFrame:(CGRect)myViewFrame location:(NSInteger )screenLocationToSetView];
    
    //        CGRect myFrame=(CGRect) self.view.frame;
    [self.view setFrame:frame];








}

-(CGPoint )makeStopPointForContainerSuperViewFrame:(CGRect)superViewFrame labelContainerFrame:(CGRect)labelContainer location:(NSInteger )screenLocation addtionalTopSpace:(float)additionalTopSpace additionalBottomSpace:(float)additionalBottomSpace{

    
    float labelContainerHeight,superViewFrameHeight;
    labelContainerHeight=labelContainer.size.height;
   
    superViewFrameHeight=superViewFrame.size.height;
    CGPoint stopPoint;
    switch (screenLocation) {
        case kPTTScreenLocationTop:
            
            stopPoint= CGPointMake (0,labelContainerHeight-additionalTopSpace);
            break;
        case kPTTScreenLocationMiddle:
            
            stopPoint= CGPointMake (0,superViewFrameHeight/2-labelContainerHeight/2);
            break;
        case kPTTScreenLocationLeft:
            
            stopPoint= CGPointMake (0,superViewFrameHeight/2-labelContainerHeight/2);
            break;
        case kPTTScreenLocationRight:
            
            stopPoint= CGPointMake (0,superViewFrameHeight/2-labelContainerHeight/2);
            break;
        case kPTTScreenLocationBottom:
            
            stopPoint= CGPointMake (0,superViewFrameHeight-labelContainerHeight-additionalBottomSpace);
            break;
        default:
            break;
    }




    return stopPoint;

}
-(CGRect )makeFrameForContainerSuperViewFrame:(CGRect)superViewFrame labelContainerFrame:(CGRect)labelContainer location:(NSInteger )screenLocation{

 
    
    
    float labelContainerHeight,superViewFrameWidth,superViewFrameHeight;
    
    labelContainerHeight=labelContainer.size.height;
    superViewFrameWidth=superViewFrame.size.width;
    superViewFrameHeight=superViewFrame.size.height;
    CGRect frame;
  
    UIInterfaceOrientation currentOrientation = 
    [UIApplication sharedApplication].statusBarOrientation;
    
    if (currentOrientation==UIInterfaceOrientationLandscapeLeft||currentOrientation==UIInterfaceOrientationLandscapeRight)
    {
        
        
        switch (screenLocation) 
        {
            case kPTTScreenLocationTop:
                
                if (currentOrientation==UIInterfaceOrientationLandscapeRight) {
                    frame = CGRectMake(labelContainerHeight,-labelContainer.size.height,superViewFrameHeight+49,labelContainerHeight);
                }
                else {
                    frame = CGRectMake(labelContainerHeight,-labelContainer.size.height,superViewFrameHeight+49,labelContainerHeight);
                }
                
                
                break;
            case kPTTScreenLocationMiddle:
                frame = CGRectMake(0,superViewFrameWidth/2-labelContainerHeight/2,superViewFrameHeight+49,labelContainerHeight);
                
                break;
            case kPTTScreenLocationLeft:
                frame = CGRectMake(-superViewFrameHeight,superViewFrameWidth/2-labelContainerHeight/2,superViewFrameHeight+49,labelContainerHeight);
                
                break;
            case kPTTScreenLocationRight:
                frame = CGRectMake(superViewFrameWidth,superViewFrameWidth/2-labelContainerHeight/2,superViewFrameHeight+49,labelContainerHeight);
                
                break;
            case kPTTScreenLocationBottom:
                frame = CGRectMake(0,superViewFrameWidth+labelContainerHeight,superViewFrameWidth+49,labelContainerHeight);
                
                break;
            default:
                break;
        }
    }
        else 
    {
        
    
    switch (screenLocation) {
        case kPTTScreenLocationTop:
           
            frame = CGRectMake(0,-labelContainerHeight,superViewFrameWidth,labelContainerHeight);
           
            break;
        case kPTTScreenLocationMiddle:
            frame = CGRectMake(0,superViewFrameHeight/2-labelContainerHeight/2,superViewFrameWidth,labelContainerHeight);
            
            break;
        case kPTTScreenLocationLeft:
            frame = CGRectMake(-superViewFrameWidth,superViewFrameHeight/2-labelContainerHeight/2,superViewFrameWidth,labelContainerHeight);
            
            break;
        case kPTTScreenLocationRight:
            frame = CGRectMake(superViewFrameWidth,superViewFrameHeight/2-labelContainerHeight/2,superViewFrameWidth,labelContainerHeight);
           
            break;
        case kPTTScreenLocationBottom:
            frame = CGRectMake(0,superViewFrameHeight+labelContainerHeight,superViewFrameWidth,labelContainerHeight);
            
            break;
        default:
            break;
    }
    
    }
    
    
    





    return frame;

}
- (void) moveTo:(CGPoint)destination duration:(float)secs option:(UIViewAnimationOptions)option
{
//    PTTAppDelegate *del = (PTTAppDelegate*)[[UIApplication sharedApplication] delegate];

    
    

    [UIView animateWithDuration:2.5 delay:0.0 options:option
                     animations:^{
                         self.view.frame = CGRectMake(destination.x,destination.y, self.view.frame.size.width, self.view.frame.size.height);
                     }
                     completion:^(BOOL finished){
                         [self startFadeout];
                     }];

    
    
   
}

 -(void)cleanAlertArea {
     currentAlerts--;
 }
// 
-(void)setDuration:(float)seconds {
    [self performSelector:@selector(startFadeout) withObject:NULL afterDelay:seconds];
}


-(void)startFadeout  {
    if (fading != NO) {return;}
    fading = YES;
    
    if (durationSecondsFloat>0) {
     
    [UIView transitionWithView:self.view duration:durationSecondsFloat options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionAllowUserInteraction animations:^{self.view.alpha = 0.0;
	} completion:^(BOOL finished) {
        [self.view removeFromSuperview];
		
        
        fading = NO;
        [self cleanAlertArea];
        
        
	}];
        
    }
}


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
 //
 //    
 //    [redAlertViewController dismissModalViewControllerAnimated:YES];
 //
 //
 //}
 
 @end
