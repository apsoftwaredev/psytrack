//
//  LCYLockSettingsViewController.m
//  LockScreen
//
//  Created by Krishna Kotecha on 22/11/2010.
//   Copyright 2010 Krishna Kotecha. All rights reserved.
//
// Edited by Dan Boice 1/20/2012
#import "LCYLockSettingsViewController.h"

#import "LCYAppSettings.h"
#import "PTTAppDelegate.h"
#import "ButtonCell.h"
#import "EncryptionTokenCell.h"
#import "LCYAppSettings.h"

@interface LCYLockSettingsViewController()
- (void) handleTogglePasscode;
@end


@implementation LCYLockSettingsViewController

- (id) initWithNibName: (NSString *) nibNameOrNil bundle: (NSBundle *) nibBundleOrNil
{
	if ( (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) )
	{
		sectionTitles_ = [[NSArray alloc] initWithObjects:@"", @"", nil];
		self.title = @"Passcode Lock";
	}
	return self;
}

#pragma mark -
#pragma mark Memory management


- (void) didReceiveMemoryWarning 
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc. that aren't in use.
    

        // Release any cached data, images, etc. that aren't in use.
        PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
        
        
        [appDelegate displayNotification:@"Memory Warning Received.  Try Closing Some Open Applications that are not needed at this time and restarting the application." forDuration:0 location:kPTTScreenLocationMiddle inView:nil];
        
        
        
  

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    
    return YES;
    
}
#pragma mark -
#pragma mark View lifecycle

- (void) viewDidUnload 
{
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
    [super viewDidUnload];
}


-(void) viewDidLoad{

    [super viewDidLoad];
    
    
    UIImage *lockImage=[UIImage imageNamed:@"lock.png"];
	UIBarButtonItem *stopButton = [[UIBarButtonItem alloc] initWithImage:lockImage style:UIBarButtonItemStyleDone target:self action:@selector(lockApplication)];
	
    self.navigationItem.rightBarButtonItem = stopButton;
    
    
    
    
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        
        [self.tableView setBackgroundView:nil];
        [self.tableView setBackgroundView:[[UIView alloc] init]];
               
        
    }
    [self.tableView setBackgroundColor:UIColor.clearColor]; // Make the table view transparent
    valuesDictionary_ = [NSMutableDictionary dictionary];

    
    NSString *encryptionTokenCellNibName=nil;
    
    if ([SCUtilities is_iPad]) {
        encryptionTokenCellNibName=@"EncryptionTokenCell_iPhone";
    }
    else {
        encryptionTokenCellNibName=@"EncryptionTokenCell_iPhone";
    }
    
  
    NSDictionary *tokenObjectBindingsDic=[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"viewTokenSwitch",@"generateButton",@"applyButton",nil] forKeys:[NSArray arrayWithObjects:@"401",@"402",@"403",nil]];
    
    EncryptionTokenCell *encrytptionTokenCell=[EncryptionTokenCell cellWithText:nil boundObject: valuesDictionary_
 objectBindings:tokenObjectBindingsDic nibName:encryptionTokenCellNibName];
    encrytptionTokenCell.tag=3;
    
    SCArrayOfObjectsSection *encryptionStringSection=[SCArrayOfObjectsSection sectionWithHeaderTitle:@"Encryption String"];
    
    [encryptionStringSection addCell:encrytptionTokenCell];
    
    
    
    //    NSString * lcyLockPath=[[NSBundle mainBundle] pathForResource:@"LCYLock"
//                                                           ofType:@"plist"];
//    
//    NSDictionary * lcyLockValuesDict=[NSDictionary dictionaryWithContentsOfFile:lcyLockPath];
//    
    

    SCSwitchCell *passCodeOnOffSwitchCell =[[SCSwitchCell alloc] initWithText:@"Passcode"];
    passCodeOnOffSwitchCell.switchControl.on=(BOOL)[self passCodeLockIsOn];
    
//    SCSwitchCell *passCodeOnOffSwitchCell=[[SCSwitchCell alloc] initWithText:@"Passcode" withBoundKey:@"lock_screen_passcode_is_on" withValue:[NSNumber numberWithBool:(BOOL)[self passCodeLockIsOn]]];
    passCodeOnOffSwitchCell.tag=1;
    
    SCSwitchCell *lockOnStartUpSwitchCell=[[SCSwitchCell alloc] initWithText:@"Lock on Startup"  boundObject:K_LOCK_SCREEN_LOCK_AT_STARTUP switchOnPropertyName:@"LockAtStartupSwitch"];
    lockOnStartUpSwitchCell.switchControl.on=[self isLockedAtStartup];
//    SCSwitchCell *lockOnStartUpSwitchCell=[[SCSwitchCell alloc] initWithText:@"Lock on Startup" withBoundKey:@"lock_screen_lock_at_startup" withSwitchOnValue:[NSNumber numberWithBool:[self isLockedAtStartup]]];
    lockOnStartUpSwitchCell.tag=2;
    // Create an array of objects section
   
    SCSwitchCell *lockSoundSwitchCell=[[SCSwitchCell alloc] initWithText:@"Lock on Startup"  boundObject:K_LOCK_SCREEN_PADLOCK_CLICK_SOUND switchOnPropertyName:@"PadlockClickSwich"];
    
    
    
//    SCTextFieldCell *oldEncryptionString=[SCTextFieldCell cellWithText:@"Old" withBoundKey:@"old_encryption_string" withValue:nil];
    
   
   
    
   

    
    
    SCArrayOfObjectsSection *settingsSection=[SCArrayOfObjectsSection sectionWithHeaderTitle:@"Lock Screen Settings"];
    [settingsSection addCell:passCodeOnOffSwitchCell];
     [settingsSection addCell:lockOnStartUpSwitchCell];
   
//    
        
    
    // Initialize tableModel
    objectsModel = [[SCArrayOfObjectsModel alloc] initWithTableView:self.tableView];

    [objectsModel addSection:encryptionStringSection];


     [objectsModel addSection:settingsSection];
  
         
    self.tableViewModel=objectsModel;
}


#pragma mark -
#pragma mark SCTableViewModelDelegate delegate

-(void)tableViewModel:(SCTableViewModel *)tableViewModel valueChangedForRowAtIndexPath:(NSIndexPath *)indexPath{

    SCTableViewCell *cell=(SCTableViewCell *)[tableViewModel cellAtIndexPath:indexPath];
    
    if (cell.tag==1 &&[cell isKindOfClass:[SCSwitchCell class]]) {
        [self handleTogglePasscode];
        
    }
    
    if (cell.tag==2 &&[cell isKindOfClass:[SCSwitchCell class]]) {
        
        SCSwitchCell *switchCell=(SCSwitchCell *)cell;
       //NSLog(@"switch cell value %i",[switchCell.switchControl isOn]);
        
        if ([self passCodeLockIsOn]) {
            [self setLockedAtStartup: [switchCell.switchControl isOn]];
        }
        else {
             [self handleTogglePasscode];
        }
        
        
    }

    if ([cell isKindOfClass:[EncryptionTokenCell class]]) {

        EncryptionTokenCell *encryptionTokenCell=(EncryptionTokenCell *)cell;
        
            UISwitch *viewTokenSwitch=(UISwitch *)encryptionTokenCell.viewTokenSwitch;
            
            if (viewTokenSwitch.on) {
                
                
                
                
            }
            
        
        
    }

}


-(void)tableViewModel:(SCTableViewModel *)tableModel customButtonTapped:(UIButton *)button forRowWithIndexPath:(NSIndexPath *)indexPath{

    SCTableViewCell *cell=(SCTableViewCell *)[tableModel cellAtIndexPath:indexPath];
    
    if ([cell isKindOfClass:[EncryptionTokenCell class]]) {
        
        EncryptionTokenCell *encryptionTokenCell=(EncryptionTokenCell *)cell;
        
        switch (button.tag) {
            case 402:
            {
            //generate new token
            
            
            
            }
                break;
            case 403:
            {
                //Change password
                
                encryptionTokenCell.validateCurrentPasswordLabel.hidden=NO;
                encryptionTokenCell.validateNewPasswordLabel.hidden=NO;
                encryptionTokenCell.validateReenterNewPasswordLabel.hidden=NO;
                
            }
                break;
            case 404:
            {
                //apply token and password to fields
                
                
                
            }
                break;
            default:
                break;
        }
        
    }
    



}
-(void)tableViewModel:(SCTableViewModel *)tableViewModel didAddSectionAtIndex:(NSUInteger)index{

    SCTableViewSection *section=(SCTableViewSection *)[tableViewModel sectionAtIndex:index];
if(section.headerTitle !=nil)
{
    
    UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 60)];
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, 300, 40)];
    
    
    
    
    headerLabel.text = section.headerTitle;
    
    
    headerLabel.backgroundColor = [UIColor clearColor];
    headerLabel.textColor = [UIColor whiteColor];
    
    [containerView addSubview:headerLabel];
    
    section.headerView = containerView;
//    [self.tableView reloadData];
    
}
}
-(IBAction)updatePasscodeOnSwichCell{

   
    
   
                 BOOL passCodeIsOn=[self passCodeLockIsOn];
    if (objectsModel.sectionCount >0) {
       
        SCTableViewSection *section=(SCTableViewSection *)[objectsModel sectionAtIndex:0];
        if (section.cellCount) {
            SCSwitchCell *switchCell=(SCSwitchCell *)[section cellAtIndex:0];
            [switchCell.switchControl setOn:passCodeIsOn];
            if (!passCodeIsOn) {
                
                if (section.cellCount>1) {
                    SCSwitchCell *startUpSwitchCell=(SCSwitchCell *)[section cellAtIndex:1];
                    [startUpSwitchCell.switchControl setOn:passCodeIsOn] ;
                    

                }
                                
                //                                        
            }
            [objectsModel.modeledTableView reloadData];
        }
        
    }
   
                 
       

}

#pragma mark -
#pragma mark LCYLockSettingsViewController handlers


- (void) handleTogglePasscode;
{

    NSString *passCodeEditorNibName;
    if ([SCUtilities is_iPad])
       passCodeEditorNibName=[NSString stringWithString:@"LCYPassCodeEditorViewController_iPad"];
    else 
     passCodeEditorNibName=[NSString stringWithString:@"LCYPassCodeEditorViewController_iPhone"];


	LCYPassCodeEditorViewController *passCodeEditor = [[LCYPassCodeEditorViewController alloc] initWithNibName:passCodeEditorNibName bundle:nil];
	passCodeEditor.passCode = [self currentPasscode];
	passCodeEditor.delegate = self;
	
	if ([self passCodeLockIsOn])
	{
		[passCodeEditor attemptToDisablePassCode];
        
        
	}
	else 
	{
		[passCodeEditor attemptToSetANewPassCode];				
	}
	
	UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:passCodeEditor];	
    
   
	[[self navigationController] presentModalViewController:navController animated:YES];
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(updatePasscodeOnSwichCell)
     name:@"passcodeEditorCanceled"
     object:nil];
		
}



- (BOOL) passCodeLockIsOn;
{
	PTTAppDelegate * applicationDelegate = (PTTAppDelegate *)[[UIApplication sharedApplication] delegate];
//	LCYAppSettings *appSettings =(LCYAppSettings *) [applicationDelegate appSettings];			
	return [applicationDelegate isPasscodeOn];	
}

- (void) lockApplication;
{
	PTTAppDelegate * applicationDelegate = (PTTAppDelegate *)[[UIApplication sharedApplication] delegate];
    //	LCYAppSettings *appSettings =(LCYAppSettings *) [applicationDelegate appSettings];			
	 [applicationDelegate lockApplication];	
}



- (BOOL) isLockedAtStartup
{
	PTTAppDelegate * applicationDelegate = (PTTAppDelegate *)[[UIApplication sharedApplication] delegate];
    //	LCYAppSettings *appSettings =(LCYAppSettings *) [applicationDelegate appSettings];			
	return [applicationDelegate isLockedAtStartup];	
}

- (void) setLockedAtStartup:(BOOL)value;
{
    
    LCYAppSettings *appSettings=[[LCYAppSettings alloc]init];
	
    [appSettings setLockScreenStartup:value];
    
    
}


- (NSData *) currentPasscode;
{
    
	LCYAppSettings *appSettings=[[LCYAppSettings alloc]init];
	return [appSettings passcodeData];		
}

- (void) updatePasscodeSettings: (NSData *) newCode;
{
	
    LCYAppSettings *appSettings=[[LCYAppSettings alloc]init]; 
	if (newCode == nil)
	{
        
        
        
		[appSettings setLockScreenPasscodeIsOn:NO];
		
        
	}
	else 
	{
        
        [appSettings setLockScreenPasscodeIsOn:YES];
		[appSettings setPasscodeDataWithData:newCode];
        
	}

	
    
    [self performSelector:@selector(updatePasscodeOnSwichCell)];
}

#pragma mark -
#pragma mark LCYPassCodeEditorDelegate protocol implementation...
- (void) passcodeEditor: (LCYPassCodeEditorViewController *) passcodeEditor newCode:(NSData *) newCode;
{
	//NSLog(@"editor: %@ | newCode: %@", passcodeEditor, newCode);
	[self.navigationController dismissModalViewControllerAnimated:YES];
	[self updatePasscodeSettings:newCode];	
	[self.tableView reloadData];	
}


@end

