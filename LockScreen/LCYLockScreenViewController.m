//
//  LCYLockScreen.m
//  LockScreen
//
//  Created by Krishna Kotecha on 07/11/2010.
//   Copyright 2010 Krishna Kotecha. All rights reserved.
//
// Edited by Dan Boice 1/20/2012
#import "LCYLockScreenViewController.h"
#import "LCYAppSettings.h"
#import "PTTAppDelegate.h"

static int  const PTTUnlockSeed = 8730;//in case user needs to reset

 NSInteger userAttempts=0;

@interface LCYLockScreenViewController (UITextFieldDelegate)
- (BOOL) textField: (UITextField *) textField shouldChangeCharactersInRange: (NSRange) range replacementString: (NSString *) string;   // return NO to not change text
@end

@interface LCYLockScreenViewController()
- (BOOL) authenticatePassCode: (NSString *) userInput;
- (void) handleCompleteUserInput:(NSString *) userInput;

- (void) showBanner: (UIView *) bannerView;
- (void) hideBanner: (UIView *) bannerView;
- (BOOL) isShowingBanner: (UIView *) bannerView;

//- (NSString *) passCode;
@end



@implementation LCYLockScreenViewController

@synthesize enterPassCodeBanner = enterPassCodeBanner_;
@synthesize wrongPassCodeBanner = wrongPassCodeBanner_;
@synthesize tryAgainMessageLabel= tryAgainMessageLabel_;

@synthesize delegate;
@synthesize passCode = passCode_;

@synthesize soundFileURLRef;
@synthesize soundFileObject;
@synthesize window;
#pragma mark -
#pragma mark Memory Management


- (void) didReceiveMemoryWarning 
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
   
    PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
  
    [appDelegate displayNotification:@"Memory Warning Received.  Try Closing Some Open Applications that are not needed at this time and restarting the application." forDuration:0 location:kPTTScreenLocationMiddle inView:self.view];

    
    
}

#pragma mark -
#pragma mark View Lifecycle

- (void) viewDidUnload 
{
    [super viewDidUnload];
    PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
    
    
    if (![appDelegate saveLockDictionarySettings]) {
        NSLog(@"error syncronizing user defaults");
    };
	self.enterPassCodeBanner = nil;
	self.wrongPassCodeBanner = nil;	
  
  
    
    
}


- (void) viewWillAppear: (BOOL) animated;
{
	[super viewWillAppear: animated];
	[self showBanner:self.enterPassCodeBanner];
	
	// iOS 3.0 compatibility: change the background colour to one that is available on earlier versions of the OS...
	if (![UIColor respondsToSelector:@selector(scrollViewTexturedBackgroundColor)])
	{
		self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
	}
}
//-(NSString *)textMessageResetGenerator:(NSString *)textMessageNumber{
//
//    //the craziest algorithm for generating a pseudorandom number ever written that is specific to the device and lasts until the end of the day.
//    
//    
//     NSString * alternateString;
//    NSString *uuid=@"aldkjf";
//    if (uuid.length>5) {
//        int firstCharacter=[uuid characterAtIndex:0];
//        int fifthCharacter=[uuid characterAtIndex:4];
//        
//        NSLog(@"first character is %i fifth Character is %i",firstCharacter, fifthCharacter);
//        
//        NSString *firstNumberString=[NSString stringWithFormat:@"%i",firstCharacter]; 
//        NSString *secondNumberString=[NSString stringWithFormat:@"%i",fifthCharacter]; 
//        
//        NSString *subStringOne;
//        NSString *subStringTwo;
//        int subIntOne;
//        int subIntTwo;
//        if (firstNumberString.length) {
//            subStringOne=[firstNumberString substringFromIndex:firstNumberString.length-1];
//            subIntOne=(int)[(NSString *)subStringOne intValue];
//            NSLog(@"subint one is %i",subIntOne);
//        
//        }
//        if (subStringTwo.length) {
//            
//            
//            subStringTwo=[secondNumberString substringFromIndex:secondNumberString.length-1];
//            subIntTwo=(int)[(NSString *)subStringTwo intValue];
//            
//            NSLog(@"subint two is %i",subIntTwo);
//            
//        }
//        
//        
//    
//    
//    //creates a hard to guess number that is good for one day.
//    if (textMessageNumber.length>8) {
//        int thirdNumber, ninethNumber, fifthNumber,seventhNumber;
//        thirdNumber=(int )[[(NSString *)[textMessageNumber substringToIndex:3]substringFromIndex:2]intValue] ;
//        ninethNumber=(int )[[(NSString *)[textMessageNumber substringToIndex:8]substringFromIndex:7]intValue] ;
//        fifthNumber=(int )[[(NSString *)[textMessageNumber substringToIndex:5]substringFromIndex:4]intValue] ;
//        seventhNumber=(int )[[(NSString *)[textMessageNumber substringToIndex:7]substringFromIndex:6]intValue] ;
//        NSDate *currentDate=[NSDate date];
//   
//        if (thirdNumber==3||thirdNumber==4||thirdNumber==6) {
//            thirdNumber=thirdNumber*23785+subIntOne;   
//        }else {
//            thirdNumber=thirdNumber*17*subIntOne;
//        }
//        
//        if (ninethNumber==2||ninethNumber==5||ninethNumber==6) {
//            ninethNumber=ninethNumber*53+subIntTwo;   
//        }else {
//            ninethNumber=ninethNumber*24+subIntTwo;
//        }
//        
//        if (fifthNumber==2||fifthNumber==5||fifthNumber==9) {
//            fifthNumber=fifthNumber*3+subIntTwo;   
//        }else {
//            fifthNumber=fifthNumber*284*subIntOne;
//        }
//        
//        if (fifthNumber==1||fifthNumber==5||fifthNumber==7) {
//            fifthNumber=fifthNumber*13-subIntTwo;   
//        }else {
//            fifthNumber=fifthNumber*426+subIntTwo;
//        }
//        
//        NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
//    
//    [dateFormatter setDateFormat:@"M/dd/yyyy"];
//    
//    
//    NSDate *referenceDate=[dateFormatter dateFromString:@"06/06/2006"];
//    
//    NSLog(@"reference date is %@",[dateFormatter stringFromDate:referenceDate]);
//    
//    //define a gregorian calandar
//    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
//    
//    //define the calandar unit flags
//    NSUInteger unitFlags = NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
//    
//    //define the date components
//    NSDateComponents *dateComponents = [gregorianCalendar components:unitFlags
//                                                            fromDate:referenceDate
//                                                              toDate:currentDate
//                                                             options:0];
//    
//    
//    
//    
//    
//    int day=[dateComponents day];
//    
//    
//    
//    
//    
//    NSLog(@"days is %i",PTTUnlockSeed+day+day%7);
//    NSString *leftString=(NSString *)[NSString stringWithFormat:@"%i",PTTUnlockSeed+day+thirdNumber+2%7];
//    NSString *middleRString=(NSString *)[NSString stringWithFormat:@"%i",PTTUnlockSeed+ninethNumber+day%6];
//    NSLog(@"left string %@",leftString);
//    NSLog(@"left string %i",leftString.length);
//    NSString *middleLString=(NSString *)[NSString stringWithFormat:@"%i",PTTUnlockSeed+fifthNumber+day%3+2];
//    NSString *rightString=(NSString *)[NSString stringWithFormat:@"%i",PTTUnlockSeed+day+seventhNumber+day/9] ;
//    
//    
//    NSLog(@"right string is %@",rightString);
//    NSString *shortLeftStr, *shortRightStr, *shortMiddleRStr, *shortMiddleLStr;
//    
//    
//    shortLeftStr = [leftString substringFromIndex:[leftString length]-1];
//    shortRightStr = [rightString substringFromIndex:[rightString length]-1];
//    shortMiddleLStr = [middleLString substringFromIndex:[middleLString length]-1];
//    shortMiddleRStr = [middleRString substringFromIndex:[middleRString length]-1];
//    NSLog(@"new string is %@",[[(NSString *) [shortLeftStr stringByAppendingString:shortRightStr]stringByAppendingString:shortMiddleLStr]stringByAppendingString:shortMiddleRStr]);
//    
//    //just a pseudorandom string that can be generated based on date and the seed and text message number.  I can send a text message to the number to reset
//    
//    
//    alternateString=(NSString *) [[(NSString *) [shortLeftStr stringByAppendingString:shortRightStr]stringByAppendingString:shortMiddleLStr]stringByAppendingString:shortMiddleRStr];
//    
//    
//    
//    NSLog(@"alternate string%@",alternateString);
//    //    NSRange range;
//    //        range.length = 3;
//    //    range.location=alternateUnlockString.length-2;
//    //    
//    
//    
//    NSLog(@"alternate unlok string %@",alternateString);
//        
//    }
//    }
//    return alternateString;
//
//}

#pragma mark -
#pragma mark LCYLockScreenViewController()

- (BOOL) authenticatePassCode: (NSString *) userInput;
{
	BOOL result = NO;
	//NSLog(@"userInput: %@", userInput);
    PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
    
    NSMutableDictionary *lockDictionary=(NSMutableDictionary *)[appDelegate lockValuesDictionary];

     BOOL ableToSave=NO;
   NSLog(@"lock dic value for key lock p hash %@",[lockDictionary valueForKey:K_LOCK_SCREEN_P_HSH]);
    
    NSLog(@"user input %@",userInput);
    
    NSLog(@"userinput hash %@",[appDelegate hashDataFromString:[NSString stringWithFormat:@"%@asdj9emV3k30wer93",userInput]]);
    
    NSLog(@"passcode is %@",[self passCode]);
    //1
    if (userInput.length==4&& [userInput isEqualToString:[self passCode]]&&[[appDelegate hashDataFromString:[NSString stringWithFormat:@"%@asdj9emV3k30wer93",userInput]]isEqualToData:[lockDictionary valueForKey:K_LOCK_SCREEN_P_HSH]])
    {
        result = YES;
       
       //2
        if (lockDictionary) {
            ableToSave=YES;
            //3
            if ([lockDictionary objectForKey:K_LOCK_SCREEN_ATTEMPT]) {
                NSInteger userAttempts=0;
                
                 [lockDictionary setValue:[NSNumber numberWithInteger:userAttempts] forKey:K_LOCK_SCREEN_ATTEMPT];
               
            } 
            
            //3
                isLocked_=NO;
            //3
            if (lockDictionary && [[lockDictionary allKeys ]containsObject:K_LOCK_SCREEN_LOCKED]) {
                [lockDictionary setValue:[NSNumber numberWithBool:isLocked_] forKey:K_LOCK_SCREEN_LOCKED ];
            
                
            }
            //3
        }
        //2
        else 
        {
            
            [appDelegate displayNotification:@"Warning: unable to save settings" forDuration:2.0 location:kPTTScreenLocationTop inView:appDelegate.window];
            
            ableToSave=NO;
        }
        //2
        
        if (ableToSave==YES) {
        
        [appDelegate saveLockDictionarySettings];
            
            
        }
        AudioServicesPlaySystemSound (soundFileObject);
            
    }
    //1
        
    
    else 
    {
       
       
        
        userAttempts++;
        NSLog(@"user attempts %i",userAttempts);
        
       
        //2
        if (lockDictionary&& [lockDictionary objectForKey:K_LOCK_SCREEN_ATTEMPT]) {
            [lockDictionary setValue:[NSNumber numberWithInteger:userAttempts] forKey:K_LOCK_SCREEN_ATTEMPT];
            
             [appDelegate saveLockDictionarySettings];
            ableToSave=YES;
        }
       //2
   
        //2
        if (userAttempts>3 ||ableToSave==NO) {
           
            [self turnOnTimer];
            
            
            
           
            
           
        }
        //2
        else 
        {
            [self.enterPassCodeBanner removeFromSuperview];		
            [self showBanner:self.wrongPassCodeBanner];
            [self resetUIState];
        }
        //2
  
       
           
      
      
	}
	//1

	return result;

	
}

-(void)turnOnTimer{

    PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
     NSMutableDictionary *lockDictionary=(NSMutableDictionary *)[appDelegate lockValuesDictionary];
    
    [self.enterPassCodeBanner removeFromSuperview];		
    [self showBanner:self.wrongPassCodeBanner];
    [self resetUIState];
    
   
   
        isLocked_=TRUE;
    
        isTimerOn_=TRUE;
        BOOL success=NO;
    if (lockDictionary ){
        
        
        
        if ([lockDictionary objectForKey:K_LOCK_SCREEN_LOCKED]) {
    
    [lockDictionary setValue:[NSNumber numberWithBool:isLocked_] forKey:K_LOCK_SCREEN_LOCKED];
            success=YES;

    }
        else {
            success=NO;
        }
   
    if (success && [lockDictionary objectForKey:K_LOCK_SCREEN_PASSCODE_IS_ON]){    
        
        [lockDictionary setValue:[NSNumber numberWithBool:isTimerOn_] forKey:K_LOCK_SCREEN_TIMER_ON];
        success=YES;
        
    }  
    else {
        success=NO;
    }
        
}
    if (success==YES) {
       success= [appDelegate saveLockDictionarySettings];
    }
   
    if (success==NO) {
        userAttempts=userAttempts +20;
    }
    
        NSTimeInterval timeInterval=1*60;
    if (userAttempts>3&&userAttempts<6) {
        tryAgainMessageLabel_.text=@"App Locked For 1 Minute";
        
    }
    else if (userAttempts >5 && userAttempts <20){
        tryAgainMessageLabel_.text =[NSString stringWithFormat:@"App Locked For %i minutes",userAttempts];
        timeInterval=userAttempts *60;
        
    }else if (userAttempts>19){
        tryAgainMessageLabel_.text =[NSString stringWithFormat:@"Too many unlock attempts. App locked."];

        timeInterval=(userAttempts *60)+(172800);
    }
    
    if (!timer_) {
        
        
         
        timer_ = [NSTimer scheduledTimerWithTimeInterval:timeInterval
                                                  target:self
                                                selector:@selector(resetTimer)
                                                userInfo:NULL
                                                 repeats:NO];
    }



}
-(void)viewDidLoad{

    [super viewDidLoad];
     PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
    NSMutableDictionary *lockDictionary=(NSMutableDictionary *)[appDelegate lockValuesDictionary];
    
        
    userAttempts=0;
    
    if (lockDictionary&&[lockDictionary objectForKey:K_LOCK_SCREEN_ATTEMPT]) 
    {
        userAttempts=[(NSNumber *)[lockDictionary valueForKey:K_LOCK_SCREEN_ATTEMPT]integerValue];
    }
    else 
    {
        userAttempts=20;
    }
    isTimerOn_=FALSE;
   NSLog(@"timer is %i",isTimerOn_);
    
    if (lockDictionary&&[lockDictionary objectForKey:K_LOCK_SCREEN_TIMER_ON]) 
    {
    isTimerOn_=(BOOL)[(NSNumber *)[lockDictionary valueForKey:K_LOCK_SCREEN_TIMER_ON]boolValue];
  NSLog(@"timer is %i",isTimerOn_);
    }
    else {
        isTimerOn_=YES;
    }
    
    
    
    if (isTimerOn_) {
            
        [self turnOnTimer];
//        [self showBanner:self.wrongPassCodeBanner];
    
    }
    
    if (isTimerOn_ ||userAttempts>0) {
    [self.enterPassCodeBanner removeFromSuperview];		
    [self showBanner:self.wrongPassCodeBanner];
    [self resetUIState];
    
    }
    
    
    isLocked_=TRUE;
    [lockDictionary setValue:[NSNumber numberWithBool:isLocked_] forKey:K_LOCK_SCREEN_LOCKED];
    
    [appDelegate saveLockDictionarySettings];
    // Create the URL for the source audio file. The URLForResource:withExtension: method is
    //    new in iOS 4.0.
    NSURL *padlockClick   = [[NSBundle mainBundle] URLForResource: @"padlock_click"
                                                    withExtension: @"m4a"];
    
    // Store the URL as a CFURLRef instance
    self.soundFileURLRef = (__bridge CFURLRef) padlockClick ;
    
    // Create a system sound object representing the sound file.
    AudioServicesCreateSystemSoundID (
                                      
                                      soundFileURLRef,
                                      &soundFileObject
                                      );

    AudioServicesPlaySystemSound (soundFileObject);
  
  
  
    [self.passCodeInputField becomeFirstResponder];

}

-(void)resetTimer{

   
    [self resetUIState];
    [timer_ invalidate];
    tryAgainMessageLabel_.text=@"Try Again";
    isTimerOn_=FALSE;
    timer_=nil;
    
    PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
    NSMutableDictionary *lockDictionary=(NSMutableDictionary *)[appDelegate lockValuesDictionary];
    
    [lockDictionary setValue:[NSNumber numberWithBool:isTimerOn_] forKey:K_LOCK_SCREEN_TIMER_ON];
    if (![appDelegate saveLockDictionarySettings]) {
        NSLog(@"unable to syncronize defaults");
    }
}
- (void) handleCompleteUserInput:(NSString *) userInput;
{
    
   
	if ([self authenticatePassCode: userInput] )	
	{
		[self.delegate lockScreen:self unlockedApp:YES];
        
        [[NSNotificationCenter defaultCenter]
         postNotificationName:@"appUnlocked"
         object:nil];
        
	}
        
    
}


- (void) showBanner: (UIView *) bannerView;
{	
	if ( ![self isShowingBanner:bannerView] )
	{
		// TODO: we should only do the statusBar check if we are running on an iPhone.
		//		 On the iPad we should display the lock screen in a window.
		
		UIApplication *app = [UIApplication sharedApplication];	
		if (!app.statusBarHidden)
		{	
			bannerView.frame = CGRectOffset(bannerView.frame, 0, [app statusBarFrame].size.height);
		}
		
		[self.view addSubview:bannerView];
     
	}
}

- (void) hideBanner: (UIView *) bannerView;
{
	if ( [self isShowingBanner:bannerView] )
	{
		[bannerView removeFromSuperview];
	}
}

- (BOOL) isShowingBanner: (UIView *) bannerView;
{
	return (bannerView.superview == self.view);
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Ensure that the view controller supports rotation and that the split view can therefore show in both portrait and landscape.    
    return NO;
}



@end


