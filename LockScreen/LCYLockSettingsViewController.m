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
    
    // Gracefully handle reloading the view controller after a memory warning
    tableModel = [[SCModelCenter sharedModelCenter] modelForViewController:self];
    if(tableModel)
    {
        [tableModel replaceModeledTableViewWith:self.tableView];
        return;
    }
    
    UIImage *lockImage=[UIImage imageNamed:@"lock.png"];
	UIBarButtonItem *stopButton = [[UIBarButtonItem alloc] initWithImage:lockImage style:UIBarButtonItemStyleDone target:self action:@selector(lockApplication)];
	
    self.navigationItem.rightBarButtonItem = stopButton;
    
    
    
    
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        
        [self.tableView setBackgroundView:nil];
        [self.tableView setBackgroundView:[[UIView alloc] init]];
        [self.tableView setBackgroundColor:UIColor.clearColor]; // Make the table view transparent
        
        
    }
//    NSString * lcyLockPath=[[NSBundle mainBundle] pathForResource:@"LCYLock"
//                                                           ofType:@"plist"];
//    
//    NSDictionary * lcyLockValuesDict=[NSDictionary dictionaryWithContentsOfFile:lcyLockPath];
//    
    


    SCSwitchCell *passCodeOnOffSwitchCell=[[SCSwitchCell alloc] initWithText:@"Passcode" withBoundKey:@"lock_screen_passcode_is_on" withValue:[NSNumber numberWithBool:(BOOL)[self passCodeLockIsOn]]];
    passCodeOnOffSwitchCell.tag=1;
    SCSwitchCell *lockOnStartUpSwitchCell=[[SCSwitchCell alloc] initWithText:@"Lock on Startup" withBoundKey:@"lock_screen_lock_at_startup" withSwitchOnValue:[NSNumber numberWithBool:[self isLockedAtStartup]]];
    lockOnStartUpSwitchCell.tag=2;
    // Create an array of objects section
   
   
  
    SCTableViewSection *settingsSection=[SCTableViewSection sectionWithHeaderTitle:@"Lock Screen Settings"];
    [settingsSection addCell:passCodeOnOffSwitchCell];
     [settingsSection addCell:lockOnStartUpSwitchCell];
   
    // Initialize tableModel
    tableModel = [[SCTableViewModel alloc] initWithTableView:self.tableView withViewController:self];

    [tableModel addSection:settingsSection];

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



}

-(void)tableViewModel:(SCTableViewModel *)tableViewModel didAddSectionAtIndex:(NSInteger)index{

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
    [self.tableView reloadData];
    
}
}
-(IBAction)updatePasscodeOnSwichCell{

    
   
  
                 BOOL passCodeIsOn=[self passCodeLockIsOn];
                 
    [tableModel.modelKeyValues setValue:[NSNumber numberWithBool:passCodeIsOn] forKey:@"lock_screen_passcode_is_on"];
                 if (!passCodeIsOn) {
                     [tableModel.modelKeyValues setValue:[NSNumber numberWithBool:passCodeIsOn] forKey:@"lock_screen_lock_at_startup"];
                     
                    
//                                        
                 }
            [tableModel.modeledTableView reloadData];
                 
       

}

#pragma mark -
#pragma mark LCYLockSettingsViewController handlers


- (void) handleTogglePasscode;
{

    NSString *passCodeEditorNibName;
    if ([SCHelper is_iPad])
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
    PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
    NSMutableDictionary *lockDictionary=(NSMutableDictionary *)[appDelegate lockValuesDictionary];
    
	[lockDictionary setValue:[NSNumber numberWithBool:value] forKey:K_LOCK_SCREEN_LOCK_AT_STARTUP];
    [appDelegate saveLockDictionarySettings];
    
}


- (NSString *) currentPasscode;
{
	PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
    NSMutableDictionary *lockDictionary=(NSMutableDictionary *)[appDelegate lockValuesDictionary];
    
	return [lockDictionary valueForKey: K_LOCK_SCREEN_PASSCODE];		
}

- (void) updatePasscodeSettings: (NSString *) newCode;
{
	PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
    NSMutableDictionary *lockDictionary=(NSMutableDictionary *)[appDelegate lockValuesDictionary];
    
	if (newCode == nil)
	{
        [lockDictionary setValue:[NSNumber numberWithBool:NO] forKey:K_LOCK_SCREEN_PASSCODE_IS_ON];
		
		
        
	}
	else 
	{
        
		 [lockDictionary setValue:[NSNumber numberWithBool:YES] forKey:K_LOCK_SCREEN_PASSCODE_IS_ON];
        [lockDictionary setValue:newCode forKey:K_LOCK_SCREEN_PASSCODE];
        [lockDictionary setValue:[appDelegate hashDataFromString:[NSString stringWithFormat:@"%@asdj9emV3k30wer93",newCode]] forKey:K_LOCK_SCREEN_P_HSH];
     
        //NSLog(@"lock dictionary value for key lcok pw hash%@",[lockDictionary valueForKey:K_LOCK_SCREEN_P_HSH]);
	}

	[appDelegate saveLockDictionarySettings];
    
    [self performSelector:@selector(updatePasscodeOnSwichCell)];
}

#pragma mark -
#pragma mark LCYPassCodeEditorDelegate protocol implementation...
- (void) passcodeEditor: (LCYPassCodeEditorViewController *) passcodeEditor newCode:(NSString *) newCode;
{
	//NSLog(@"editor: %@ | newCode: %@", passcodeEditor, newCode);
	[self.navigationController dismissModalViewControllerAnimated:YES];
	[self updatePasscodeSettings:newCode];	
	[self.tableView reloadData];	
}


@end

