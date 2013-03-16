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

#import "LCYAppSettings.h"
#import "PTTEncryption.h"
@interface LCYLockSettingsViewController ()

- (void) handleTogglePasscode;

enum  {KTokenCellTokenFieldTag = 400, kTokenCellViewButtonTag, kTokenCellGenerateNewRandomTag, kTokenCellPasswordCurrentTag, kTokenCellPasswordNewTag, kTokenCellPasswordReenterTag,
       kTokenCellApplyChangesButtonTag,kTokenCellHintTextFieldTag};

enum {kTokenCellValidationTokenField = 500,kTokenCellValidationCurrentPassword,kTokenCellValidationNewPassword,kTokenCellValidationReenterPassword};
@end

@implementation LCYLockSettingsViewController
@synthesize clearValuesTimer = clearValuesTimer_;

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
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

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations

    return YES;
}


#pragma mark -
#pragma mark View lifecycle

- (void) viewDidUnload
{
    @try
    {
        [[NSNotificationCenter defaultCenter]removeObserver:self name:@"passcodeEditorCanceled" object:nil];
    }
    @catch (id anException)
    {
        //do nothing, obviously it wasn't attached because an exception was thrown
    }

    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
    [super viewDidUnload];
}


- (void) viewDidLoad
{
    [super viewDidLoad];

    UIImage *lockImage = [UIImage imageNamed:@"lock.png"];
    UIBarButtonItem *stopButton = [[UIBarButtonItem alloc] initWithImage:lockImage style:UIBarButtonItemStyleDone target:self action:@selector(lockApplication)];

    self.navigationItem.rightBarButtonItem = stopButton;

    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad || [SCUtilities systemVersion] >= 6)
    {
        [self.tableView setBackgroundView:nil];
        [self.tableView setBackgroundView:[[UIView alloc] init]];
    }

    [self.tableView setBackgroundColor:UIColor.clearColor]; // Make the table view transparent
    valuesDictionary_ = [NSMutableDictionary dictionary];

    SCSwitchCell *passCodeOnOffSwitchCell = [[SCSwitchCell alloc] initWithText:@"Passcode"];
    passCodeOnOffSwitchCell.switchControl.on = (BOOL)[self passCodeLockIsOn];

    passCodeOnOffSwitchCell.tag = 1;

    SCSwitchCell *lockOnStartUpSwitchCell = [[SCSwitchCell alloc] initWithText:@"Lock on Startup"  boundObject:K_LOCK_SCREEN_LOCK_AT_STARTUP switchOnPropertyName:nil];
    lockOnStartUpSwitchCell.switchControl.on = [self isLockedAtStartup];
    lockOnStartUpSwitchCell.tag = 2;
    // Create an array of objects section

    SCSwitchCell *lockSoundSwitchCell = [[SCSwitchCell alloc] initWithText:@"Padlock Sound"  boundObject:K_LOCK_SCREEN_PADLOCK_SOUND_IS_ON switchOnPropertyName:nil];

    lockSoundSwitchCell.switchControl.on = [[NSUserDefaults standardUserDefaults]boolForKey:K_LOCK_SCREEN_PADLOCK_SOUND_IS_ON];
    lockSoundSwitchCell.tag = 4;

    SCArrayOfObjectsSection *settingsSection = [SCArrayOfObjectsSection sectionWithHeaderTitle:@"Lock Screen Settings"];
    [settingsSection addCell:passCodeOnOffSwitchCell];
    [settingsSection addCell:lockOnStartUpSwitchCell];
    [settingsSection addCell:lockSoundSwitchCell];

    [self.tableViewModel setTableView:self.tableView];
    [self.tableViewModel addSection:settingsSection];
}


#pragma mark -
#pragma mark SCTableViewModelDelegate delegate

- (void) tableViewModel:(SCTableViewModel *)tableViewModel valueChangedForRowAtIndexPath:(NSIndexPath *)indexPath
{
    timeOfLastUserInput = [NSDate date];

    if (!clearValuesTimer_)
    {
        NSTimeInterval clearUserInputInSeconds = 600.0;

        self.clearValuesTimer = [NSTimer scheduledTimerWithTimeInterval:clearUserInputInSeconds
                                                                 target:self
                                                               selector:@selector(clearUserInput)
                                                               userInfo:NULL
                                                                repeats:YES];
    }

    SCTableViewCell *cell = (SCTableViewCell *)[tableViewModel cellAtIndexPath:indexPath];

    if (cell.tag == 1 && [cell isKindOfClass:[SCSwitchCell class]])
    {
        [self handleTogglePasscode];

        if (![self passCodeLockIsOn])
        {
            [self setLockedAtStartup:NO];
            if (tableViewModel.sectionCount > 1)
            {
                SCTableViewSection *sectionAtOne = (SCTableViewSection *)[tableViewModel sectionAtIndex:1];

                SCTableViewCell *cellAtOne = (SCTableViewCell *)[sectionAtOne cellAtIndex:1];

                if ([cellAtOne isKindOfClass:[SCSwitchCell class]])
                {
                    SCSwitchCell *lockedAtStartupSwitchCell = (SCSwitchCell *)cellAtOne;

                    [lockedAtStartupSwitchCell.switchControl setOn:NO];
                }
            }
        }
    }

    if (cell.tag == 2 && [cell isKindOfClass:[SCSwitchCell class]])
    {
        SCSwitchCell *switchCell = (SCSwitchCell *)cell;

        if ([self passCodeLockIsOn])
        {
            [self setLockedAtStartup:[switchCell.switchControl isOn]];
        }
        else
        {
            [self handleTogglePasscode];
        }
    }

    if (cell.tag == 4 && [cell isKindOfClass:[SCSwitchCell class]])
    {
        SCSwitchCell *switchCell = (SCSwitchCell *)cell;

        [[NSUserDefaults standardUserDefaults]setBool:switchCell.switchControl.on forKey:K_LOCK_SCREEN_PADLOCK_SOUND_IS_ON];
    }
}


//
//-(void)tableViewModel:(SCTableViewModel *)tableModel customButtonTapped:(UIButton *)button forRowWithIndexPath:(NSIndexPath *)indexPath{
//
//    SCTableViewCell *cell=(SCTableViewCell *)[tableModel cellAtIndexPath:indexPath];
//    PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
//
//
//    if ([cell isKindOfClass:[EncryptionTokenCell class]]) {
//
//        EncryptionTokenCell *encryptionTokenCell=(EncryptionTokenCell *)cell;
//
//
//
//        switch (button.tag) {
//
//
//            case kTokenCellViewButtonTag:
//            {
//                //get shared token and view it
//
//
//                UIView *textFieldView=(UIView *)[cell viewWithTag:400];
//                if ([textFieldView isKindOfClass:[UITextField class]]) {
//                    UITextField *tokenTextField=(UITextField *)textFieldView;
//                    [tokenTextField setSecureTextEntry:NO];
//
//                    LCYAppSettings *appSettings=[[LCYAppSettings alloc]init];
//
//                    NSString *sharedToken=  [appSettings currentSharedTokenString];
//
//                    if ([sharedToken isEqualToString:@"wMbq-zvD2-6p"]) {
//                        PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
//
//                        [appDelegate displayNotification:@"The token has not been set yet."];
//
//
//                    }
//                    else
//                    {
//
//
//
//
//                        if ([self validatePasswordsFromEncrytpionTokenCell:encryptionTokenCell buttonTapped:kTokenCellViewButtonTag]) {
//
//                            tokenTextField.text=[appSettings currentSharedTokenString];
//
//
//                        }
//
//                    }
//                appSettings=nil;
//
//            }
//
//
//
//
//
//
//
//
//            }
//                break;
//
//
//            case kTokenCellGenerateNewRandomTag:
//            {
//            //generate new token
//                LCYAppSettings *appSettings=[[LCYAppSettings alloc]init];
//
//
//
//                UIView *textFieldView=(UIView *)[cell viewWithTag:400];
//                if ([textFieldView isKindOfClass:[UITextField class]]) {
//                    UITextField *tokenTextField=(UITextField *)textFieldView;
//                    [tokenTextField setText:[appSettings generateToken]];
//
//
//
//
//                }
//
//                  appSettings=nil;
//
//            }
//                break;
//            case kTokenCellApplyChangesButtonTag:
//            {
//                //Change password
//                LCYAppSettings *appSettings=[[LCYAppSettings alloc]init];
//                BOOL shouldChangeToken=NO;
//                if (![encryptionTokenCell.tokenField.text isEqualToString:[appSettings currentSharedTokenString]]) {
//                    shouldChangeToken=YES;
//                }
//
//                BOOL passwordsAreValid=[self validatePasswordsFromEncrytpionTokenCell:encryptionTokenCell buttonTapped:kTokenCellApplyChangesButtonTag];
//
//                if (passwordsAreValid&&shouldChangeToken) {
//
//
//                    UIView *textFieldView=(UIView *)[cell viewWithTag:KTokenCellTokenFieldTag];
//                    if ([textFieldView isKindOfClass:[UITextField class]]) {
//                        UITextField *tokenTextField=(UITextField *)textFieldView;
//                                                 NSString *displayMessage=nil;
//                        if (tokenTextField.text.length<12) {
//
//
//                            encryptionTokenCell.validateEncryptionTokenButton.hidden=NO;
//                             encryptionTokenCell.validateCurrentPasswordButton.hidden=NO;
//                            displayMessage= @"Token must be at least 12 characters in length";
//
//
//                        }
//                        else {
//
//
//                            [appSettings setTokenDataWithString:tokenTextField.text];
//                            [appDelegate setChangedToken:YES];
//                            if ([appSettings rekeyKeyEntityKeys]) {
//                                displayMessage=@"Changes applied successfully.";
//                                encryptionTokenCell.validateEncryptionTokenButton.hidden=YES;
//                                encryptionTokenCell.validateCurrentPasswordButton.hidden=YES;
//                                encryptionTokenCell.validateNewPasswordButton.hidden=YES;
//                                encryptionTokenCell.validateReenterNewPasswordButton.hidden=YES;
//                                encryptionTokenCell.tokenField.text=@"";
//                                encryptionTokenCell.passwordFieldNew.text=@"";
//                                encryptionTokenCell.passowrdFieldReenter.text=@"";
//                                encryptionTokenCell.passwordFieldCurrent.text=@"";
//                            }
//                            else {
//                                displayMessage=@"Error occured in saving new encrytion data.";
//                            }
//
//
//
//                        }
//
//
//                        [appDelegate displayNotification:displayMessage];
//
//                    }
//
//                }
//                else if (passwordsAreValid && !shouldChangeToken){
//                    NSString *displayMessage=nil;
//                    if ([appSettings rekeyKeyEntityKeys]) {
//                        displayMessage=@"Changes applied successfully.";
//                        encryptionTokenCell.validateEncryptionTokenButton.hidden=YES;
//                        encryptionTokenCell.validateCurrentPasswordButton.hidden=YES;
//                        encryptionTokenCell.validateNewPasswordButton.hidden=YES;
//                        encryptionTokenCell.validateReenterNewPasswordButton.hidden=YES;
//                        encryptionTokenCell.tokenField.text=@"";
//                        encryptionTokenCell.passwordFieldNew.text=@"";
//                        encryptionTokenCell.passowrdFieldReenter.text=@"";
//                        encryptionTokenCell.passwordFieldCurrent.text=@"";
//                    }
//                    else {
//                        displayMessage=@"Error occured in saving new encrytion data.";
//                    }
//
//                    if (displayMessage&&displayMessage.length) {
//                        [appDelegate displayNotification:displayMessage];
//                    }
//                }
//                  appSettings=nil;
//            }
//                break;
//            case 404:
//            {
//                //apply token and password to fields
//
//
//
//            }
//                break;
//            default:
//                break;
//        }
//
//    }
//
//
//
//
//}

- (void) tableViewModel:(SCTableViewModel *)tableViewModel didAddSectionAtIndex:(NSUInteger)index
{
    SCTableViewSection *section = (SCTableViewSection *)[tableViewModel sectionAtIndex:index];
    if (section.headerTitle != nil)
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


- (BOOL) authenticatePassword:(NSString *)userInput;
{
    BOOL result = NO;
    //
    PTTAppDelegate *appDelegate = (PTTAppDelegate *)[UIApplication sharedApplication].delegate;

    LCYAppSettings *appSettings = [[LCYAppSettings alloc]init];

    if (userInput && !userInput.length)
    {
        userInput = nil;
    }

    NSString *passwordToCheck = (userInput) ? [NSString stringWithFormat:@"%@kdieJsi3ea18ki",userInput ] : @"o6fjZ4dhvKIUYVmaqnNJIPCBE2";
    PTTEncryption *encryption = [[PTTEncryption alloc]init];

    if ( [ (NSData *)[encryption getHashBytes:[appDelegate convertStringToData:passwordToCheck]] isEqualToData :[appSettings passwordData]] )
    {
        result = YES;
    }

    appSettings = nil;
    encryption = nil;
    return result;
}
//-(void)tableViewModel:(SCTableViewModel *)tableModel willConfigureCell:(SCTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
//
//    if ([cell isKindOfClass:[EncryptionTokenCell class]]) {
//        EncryptionTokenCell *encryptionTokenCell=(EncryptionTokenCell *)cell;
//        LCYAppSettings *appSettings=[[LCYAppSettings alloc]init];
//
//
//        encryptionTokenCell.hintField.text=appSettings.hintString;
//
//
//    }
//
//
//
//
//}
//-(BOOL)validatePasswordsFromEncrytpionTokenCell:(EncryptionTokenCell*)encryptionTokenCell buttonTapped:(int)buttonTapped{
//
//    // the button tapped is the view button, it returnes a yes if the password provided is valid otherwise returnes no and displays validation warnings.  If a password has not been set it requests to set a new password first.
//
//    //if the button tapped is the apply button, there are changes, and the token and password are valid, it sets the new token and password
//
//    PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
//
//
//    LCYAppSettings *appSettings=[[LCYAppSettings alloc]init];
//    PTTEncryption *encryption=(PTTEncryption *)appDelegate.encryption;
//
//    BOOL valid=NO;
//
//    appDelegate.changedPassword=NO;
//    appDelegate.changedToken=NO;
//
//    UITextField * currentTokenTextField=(UITextField *)encryptionTokenCell.tokenField;
//
//
//    UITextField *currentPasswordTextField=encryptionTokenCell.passwordFieldCurrent;
//
//
//    UITextField *newPasswordTextField=encryptionTokenCell.passwordFieldNew;
//
//
//    UITextField *reenterPasswordTextField=encryptionTokenCell.passowrdFieldReenter;
//    UITextField *hintTexttField=encryptionTokenCell.hintField;
//
//
//    UIButton *validateTokenButton=encryptionTokenCell.validateEncryptionTokenButton;
//
//
//    UIButton *validateCurrentPasswordButton=encryptionTokenCell.validateCurrentPasswordButton;
//
//    UIButton *validateNewPasswordButton=encryptionTokenCell.validateNewPasswordButton;
//
//    UIButton *validateReenterPasswordButton=encryptionTokenCell.validateReenterNewPasswordButton;
//
//
//    validateNewPasswordButton.hidden=YES;
//    validateReenterPasswordButton.hidden=YES;
//    validateTokenButton.hidden=YES;
//    validateCurrentPasswordButton.hidden=YES;
//
//    NSString *tokenFieldStr=currentTokenTextField.text;
//    NSString *currentPasswordAttemptStr=currentPasswordTextField.text;
//    NSString *newPassword=newPasswordTextField.text;
//    NSString *reenterPassword=reenterPasswordTextField.text;
//    NSString *hintStr=hintTexttField.text;
//    BOOL currentPasswordMatchesPasswordAttempt=NO;
//
//    if (currentPasswordAttemptStr.length>5&&[[appSettings passwordData] isEqualToData:[encryption getHashBytes:[appDelegate convertStringToData:[NSString stringWithFormat:@"%@iJsi3" ,currentPasswordAttemptStr ]]]]) {
//        currentPasswordMatchesPasswordAttempt=YES;
//
//
//
//    }
//
//    if (buttonTapped==kTokenCellApplyChangesButtonTag&& currentPasswordMatchesPasswordAttempt&&!((newPasswordTextField.text.length||reenterPasswordTextField.text.length)||[newPassword isEqualToString:currentPasswordAttemptStr]) &&[[appSettings currentSharedTokenString]isEqualToString:currentTokenTextField.text]) {
//
//        if ([[appSettings hintString]isEqualToString:hintStr]) {
//            [appDelegate displayNotification:@"Nothing Changed"];
//        }
//        else {
//
//           BOOL successAtSettingHint= [appSettings setPasscodeHintWithString:hintStr];
//
//            if (successAtSettingHint) {
//                [appDelegate displayNotification:@"Successfully changed the hint."];
//            }
//            else {
//                [appDelegate displayNotification:@"Error the new hint was not saved."];
//            }
//        }
//
//        validateTokenButton.hidden=YES;
//        validateCurrentPasswordButton.hidden=YES;
//        validateNewPasswordButton.hidden=YES;
//        validateReenterPasswordButton.hidden=YES;
//
//        return NO;
//    }
//
//    BOOL okayToSetNewPassword=NO;
//
//
//
//
//    if (!currentPasswordAttemptStr.length) {
//
//
//        if ([appSettings passwordDataIsEqualToDefaultPasswordData] )
//        {
//            okayToSetNewPassword=YES;
//
//
//
//
//        }
//        else
//        {
//            validateCurrentPasswordButton.hidden=NO;
//            [appDelegate displayNotification:@"Please enter the current password."];
//            [encryptionTokenCell.passwordFieldCurrent becomeFirstResponder];
//            return NO;
//        }
//
//
//    }
//    //length is greater than zero
//    else if (!currentPasswordMatchesPasswordAttempt) {
//
//
//        currentPasswordTextField.text=@"";
//        if ([appSettings passwordDataIsEqualToDefaultPasswordData]) {
//            [appDelegate displayNotification:@"The password has not been set yet for this app on this device."];
//            validateCurrentPasswordButton.hidden=YES;
//            validateNewPasswordButton.hidden=NO;
//            validateReenterPasswordButton.hidden=NO;
//
//        }
//
//        else {
//        validateCurrentPasswordButton.hidden=NO;
//            if ([appSettings isPasscodeOn]) {
//                [appDelegate lockApplication];
//                [appDelegate displayNotification:@"Encryption password attept failed. Please enter the current four digit lock screen passcode." forDuration:5.0 location:kPTTScreenLocationTop inView:appDelegate.window];
//
//
//            }
//            else {
//                 [appDelegate displayNotification:@"Password entered was incorrect."];
//            }
//        }
//            return NO;
//    }
//    else if (currentPasswordMatchesPasswordAttempt && !newPassword.length&&!reenterPassword.length ){
//
//
//        validateCurrentPasswordButton.hidden=YES;
//        validateNewPasswordButton.hidden=YES;
//        validateReenterPasswordButton.hidden=YES;
//
//        return YES;
//    }
//
//    if (okayToSetNewPassword||currentPasswordMatchesPasswordAttempt) {
//        if (buttonTapped==kTokenCellApplyChangesButtonTag) {
//            BOOL setNewPassword=NO;
//            NSString *displayMessage=nil;
//            if ([newPassword isEqualToString:reenterPassword]) {
//
//                if (newPassword.length<5) {
//
//                    displayMessage=@"Please enter a new password at least six characters long.";
//                    validateNewPasswordButton.hidden=NO;
//                    validateReenterPasswordButton.hidden=NO;
//
//                }else
//                {
//                    setNewPassword=YES;
//
//
//                }
//
//            }
//            else
//            {
//                displayMessage=@"The new passwords you entered did not match.";
//                newPasswordTextField.text=@"";
//                reenterPasswordTextField.text=@"";
//                validateNewPasswordButton.hidden=NO;
//                validateReenterPasswordButton.hidden=NO;
//            }
//
//
//
//
//            if (setNewPassword) {
//
//
//                if (tokenFieldStr.length<12) {
//                    validateTokenButton.hidden=NO;
//                    [appDelegate displayNotification:@"Token must be at least 12 characters."];
//                    return NO;
//                }
//                else {
//
//
//
//                    if (tokenFieldStr.length>16) {
//                        validateTokenButton.hidden=NO;
//                        [appDelegate displayNotification:@"Token must be at less than 16 characters."];
//                        return NO;
//
//                    }
//
//                    if (newPassword.length>18) {
//                        validateNewPasswordButton.hidden=NO;
//                        validateReenterPasswordButton.hidden=NO;
//                        newPasswordTextField.text=@"";
//                        reenterPasswordTextField.text=@"";
//
//                        [appDelegate displayNotification:@"New password should be less than 18 characters."];
//
//                        return NO;
//
//                    }
//
//                    setNewPassword=[appSettings setPasswordCurrentDataWithString:(NSString *)newPassword];
//
//
//
//
//
//                    if (!setNewPassword) {
//                        displayMessage=@"Error saving password";
//                    }
//                    else {
//                        appDelegate.changedPassword=YES;
//
//                        NSString *passwordHint=encryptionTokenCell.hintField.text;
//                        BOOL setHint=NO;
//                        if (passwordHint.length) {
//                            setHint=[appSettings setPasscodeHintWithString:passwordHint];
//                        }
//                        else {
//                            [appSettings setPasscodeHintWithString:@""];
//                            setHint=NO;
//                        }
//
//                        if (setHint) {
//                            displayMessage=@"New password set with hint";
//
//
//                        }
//                        else {
//                            displayMessage=@"New passowrd set without hint.";
//                        }
//
//                        validateCurrentPasswordButton.hidden=YES;
//                        validateNewPasswordButton.hidden=YES;
//                        validateReenterPasswordButton.hidden=YES;
//                        currentPasswordTextField.text=@"";
//
//                    }
//
//
//                }
//
//
//
//
//
//
//
//
//            }
//            else
//            {
//
//                validateNewPasswordButton.hidden=NO;
//                validateReenterPasswordButton.hidden=NO;
//
//            }
//
//            if (displayMessage.length) {
//                [appDelegate displayNotification:displayMessage];
//                return setNewPassword;
//            }
//
//
//        }
//
//
//        else if(okayToSetNewPassword && buttonTapped == kTokenCellViewButtonTag && !currentPasswordMatchesPasswordAttempt)
//        {
//
//
//            validateNewPasswordButton.hidden=NO;
//            validateReenterPasswordButton.hidden=NO;
//            [appDelegate displayNotification:@"Please create a new password and store it in a safe location first."];
//            return NO;
//        }
//        else if (currentPasswordMatchesPasswordAttempt&&buttonTapped==kTokenCellViewButtonTag){
//            validateNewPasswordButton.hidden=YES;
//            validateTokenButton.hidden=YES;
//            validateNewPasswordButton.hidden=YES;
//            validateReenterPasswordButton.hidden=YES;
//
//            return YES;
//
//
//        }
//
//    }
//
//
//    appSettings=nil;
//
//
//
//    return valid;
//
//}
- (IBAction) updatePasscodeOnSwichCell
{
    BOOL passCodeIsOn = [self passCodeLockIsOn];
    if (self.tableViewModel.sectionCount > 1)
    {
        SCTableViewSection *section = (SCTableViewSection *)[self.tableViewModel sectionAtIndex:1];
        if (section.cellCount)
        {
            SCSwitchCell *switchCell = (SCSwitchCell *)[section cellAtIndex:0];
            [switchCell.switchControl setOn:passCodeIsOn];
            if (!passCodeIsOn)
            {
                if (section.cellCount > 1)
                {
                    SCSwitchCell *startUpSwitchCell = (SCSwitchCell *)[section cellAtIndex:1];
                    [startUpSwitchCell.switchControl setOn:passCodeIsOn];
                }

                //
            }

            [self.tableViewModel.modeledTableView reloadData];
        }
    }
}


#pragma mark -
#pragma mark LCYLockSettingsViewController handlers

- (void) handleTogglePasscode;
{
    NSString *passCodeEditorNibName;
    if ([SCUtilities is_iPad])
    {
        passCodeEditorNibName = @"LCYPassCodeEditorViewController_iPad";
    }
    else
    {
        passCodeEditorNibName = @"LCYPassCodeEditorViewController_iPhone";
    }

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
    @try
    {
        [[NSNotificationCenter defaultCenter]
         addObserver:self
            selector:@selector(updatePasscodeOnSwichCell)
                name:@"passcodeEditorCanceled"
              object:nil];
    }
    @catch (NSException *exception)
    {
        //nothing
    }
}

- (BOOL) passCodeLockIsOn;
{
    PTTAppDelegate *applicationDelegate = (PTTAppDelegate *)[[UIApplication sharedApplication] delegate];
//	LCYAppSettings *appSettings =(LCYAppSettings *) [applicationDelegate appSettings];
    return [applicationDelegate isPasscodeOn];
}

- (void) lockApplication;
{
    PTTAppDelegate *applicationDelegate = (PTTAppDelegate *)[[UIApplication sharedApplication] delegate];
    //	LCYAppSettings *appSettings =(LCYAppSettings *) [applicationDelegate appSettings];
    [applicationDelegate lockApplication];
}

- (BOOL) isLockedAtStartup
{
    PTTAppDelegate *applicationDelegate = (PTTAppDelegate *)[[UIApplication sharedApplication] delegate];
    //	LCYAppSettings *appSettings =(LCYAppSettings *) [applicationDelegate appSettings];
    return [applicationDelegate isLockedAtStartup];
}


- (void) setLockedAtStartup:(BOOL)value;
{
    LCYAppSettings *appSettings = [[LCYAppSettings alloc]init];

    [appSettings setLockScreenStartup:value];
    appSettings = nil;
}

- (NSData *) currentPasscode;
{
    LCYAppSettings *appSettings = [[LCYAppSettings alloc]init];
    return [appSettings passcodeData];
}

- (void) updatePasscodeSettings:(NSData *)newCode;
{
    LCYAppSettings *appSettings = [[LCYAppSettings alloc]init];
    if (newCode == nil)
    {
        [appSettings setLockScreenPasscodeIsOn:NO];
    }
    else
    {
        [appSettings setLockScreenPasscodeIsOn:YES];
        [appSettings setPasscodeDataWithData:newCode];
    }

    appSettings = nil;

    [self performSelector:@selector(updatePasscodeOnSwichCell)];
}

#pragma mark -
#pragma mark LCYPassCodeEditorDelegate protocol implementation...
- (void) passcodeEditor:(LCYPassCodeEditorViewController *)passcodeEditor newCode:(NSData *)newCode;
{
    [self.navigationController dismissModalViewControllerAnimated:YES];
    [self updatePasscodeSettings:newCode];
    [self.tableView reloadData];
}

//-(void)clearUserInput{
//
//    if (self.tableViewModel.sectionCount) {
//        SCTableViewSection *section=(SCTableViewSection *)[self.tableViewModel sectionAtIndex:0];
//        if (section.cellCount && [section isKindOfClass:[SCArrayOfObjectsSection class]]) {
//            SCArrayOfObjectsSection *arrayOfObjectsSection=(SCArrayOfObjectsSection *)section;
//
//            SCTableViewCell *cell=(SCTableViewCell *)[arrayOfObjectsSection cellAtIndex:0];
//            if ([cell isKindOfClass:[EncryptionTokenCell class]]) {
//                EncryptionTokenCell *encryptionTokenCell=(EncryptionTokenCell *)cell;
//
//                NSTimeInterval timeSinceLastUserImput=[timeOfLastUserInput timeIntervalSinceNow];
//                NSTimeInterval timeToClearFields=-580.0;
//                if (timeSinceLastUserImput<timeToClearFields) {
//                    encryptionTokenCell.tokenField.text=@"";
//                    encryptionTokenCell.passwordFieldCurrent.text=@"";
//                    encryptionTokenCell.passwordFieldNew.text=@"";
//                    encryptionTokenCell.passowrdFieldReenter.text=@"";
//                    encryptionTokenCell.validateEncryptionTokenButton.hidden=YES;
//                    encryptionTokenCell.validateCurrentPasswordButton.hidden=YES;
//                    encryptionTokenCell.validateNewPasswordButton.hidden=YES;
//                    encryptionTokenCell.validateReenterNewPasswordButton.hidden=YES;
//                    [clearValuesTimer_ invalidate];
//                    self.clearValuesTimer=nil;
//                }
//
//            }
//
//
//        }
//
//    }
//
//
//}
@end
