//
//  LCYPasscodeInputHandler.m
//  LockScreen
//
//  Created by Krishna Kotecha on 28/11/2010.
//   Copyright 2010 Krishna Kotecha. All rights reserved.
//
// Edited by Dan Boice 1/20/2012
#import "LCYPasscodeInputViewController.h"
#import "LCYLockDigitView.h"
#import "LCYAppSettings.h"
#import "PTTAppDelegate.h"
@interface LCYPasscodeInputViewController()

- (void) adjustLockDigitsForDeletePress;
- (void) updateLockDigitsForKeyPress;
- (void) setLockDigit: (int) lockDigitPosition isOn: (BOOL) on;
- (BOOL) haveCompletePassCode;

- (void) handleCompleteUserInput:(NSString *) userInput;
@end



@implementation LCYPasscodeInputViewController

const int PASSCODE_INPUT_HANDLER_PASSCODE_LENGTH = 4;

@synthesize lockDigit_0 = lockDigit_0_;
@synthesize lockDigit_1 = lockDigit_1_;
@synthesize lockDigit_2 = lockDigit_2_;
@synthesize lockDigit_3 = lockDigit_3_;

@synthesize passCodeInputField = passCodeInputField_;

- (void) dealloc 
{
	self.passCodeInputField = nil;

	self.lockDigit_0 = nil;
	self.lockDigit_1 = nil;
	self.lockDigit_2 = nil;
	self.lockDigit_3 = nil;	
			

}

#pragma mark -
#pragma mark View Lifecycle

- (void) viewDidUnload 
{
    [super viewDidUnload];
	
    // Release any retained subviews of the main view.
	self.lockDigit_0 = nil;
	self.lockDigit_1 = nil;
	self.lockDigit_2 = nil;
	self.lockDigit_3 = nil;	
	
	self.passCodeInputField = nil;	
}

- (void) viewWillAppear: (BOOL) animated;
{
	[super viewWillAppear: animated];
	[self.passCodeInputField becomeFirstResponder];	
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(appUnlocked:)
     name:@"appUnlocked"
     object:nil];
    
    

    
}
//- (void) didReceiveMemoryWarning 
//{
//    // Releases the view if it doesn't have a superview.
//    [super didReceiveMemoryWarning];
//    
//    // Release any cached data, images, etc. that aren't in use.
//    PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
//    
//    
//    [appDelegate displayNotification:@"Memory Warning Received.  Try Closing Some Open Applications that are not needed at this time and restarting the application." forDuration:0 location:kScreenLocationMiddle inView:appDelegate.window];
//    
//    
//    
//}


#pragma mark -
#pragma mark LCYLockScreenViewController()



- (void) adjustLockDigitsForDeletePress;
{
	if (self.passCodeInputField.text.length > 0)
	{
		int lockDigitPosition = self.passCodeInputField.text.length - 1;		
		[self setLockDigit: lockDigitPosition isOn: NO];		
	}
}

- (void) updateLockDigitsForKeyPress;
{
   
    LCYAppSettings *appSettings=[[LCYAppSettings alloc]init];

    BOOL isTimerOn_=FALSE;
    isTimerOn_=(BOOL)[appSettings isLockedTimerOn];
	if (isTimerOn_) {
       
        [self adjustLockDigitsForDeletePress];
        self.passCodeInputField.text=@"";
       
    }
    else {
        int lockDigitPosition = self.passCodeInputField.text.length;
        [self setLockDigit: lockDigitPosition isOn: YES];
    }
    
}


- (void) setLockDigit: (int) lockDigitPosition isOn: (BOOL) on;
{	
    
        switch (lockDigitPosition) 
        {
            case 0:
                self.lockDigit_0.isFilled = on;
                [self.lockDigit_0 setNeedsDisplay];
                break;
                
            case 1:
                self.lockDigit_1.isFilled = on;
                [self.lockDigit_1 setNeedsDisplay];
                break;
                
            case 2:
                self.lockDigit_2.isFilled = on;
                [self.lockDigit_2 setNeedsDisplay];
                break;
                
            case 3:
                self.lockDigit_3.isFilled = on;
                [self.lockDigit_3 setNeedsDisplay];
                
                
                break;
                
            default:
                NSAssert(NO, @"Input exceeded number of lock digits");
                break;
        }
	
}

- (BOOL) haveCompletePassCode;
{
	return (self.passCodeInputField.text.length == PASSCODE_INPUT_HANDLER_PASSCODE_LENGTH - 1);
}


- (void) resetUIState;
{
	self.passCodeInputField.text = @"";
	[self setLockDigit: 0 isOn: NO];
	[self setLockDigit: 1 isOn: NO];
	[self setLockDigit: 2 isOn: NO];
	[self setLockDigit: 3 isOn: NO];
}


- (void) handleCompleteUserInput:(NSString *) userInput;
{
		// client dependent stuff...
}


-(IBAction)appUnlocked:(id)sender{
    
    //NSLog(@"app unlocked");
  
    [self.passCodeInputField becomeFirstResponder ];	
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"appUnlocked" object:nil];
    
    
}
- (BOOL) textField: (UITextField *) textField shouldChangeCharactersInRange: (NSRange) range replacementString: (NSString *) string;   // return NO to not change text
{	
	BOOL acceptInputChanges = YES;
	
	if (range.length == 1 && [string length] == 0)
	{
		////NSLog(@"got a delete press");
		[self adjustLockDigitsForDeletePress];
	}
	else 
	{
		[self updateLockDigitsForKeyPress];
		if ([self haveCompletePassCode])
		{
			NSString *completeUserInput = [NSString stringWithFormat:@"%@%@", self.passCodeInputField.text, string]; 
			[self performSelector:@selector(handleCompleteUserInput:) withObject:completeUserInput afterDelay:0.1];
		}
	}
	
	return acceptInputChanges;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{

	
     [self.passCodeInputField becomeFirstResponder];	

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Ensure that the view controller supports rotation and that the split view can therefore show in both portrait and landscape.    
    return YES;
}
@end
