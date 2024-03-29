/*
 *  PTTAppDelegate.h
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
 *  Created by Daniel Boice on 9/22/11.
 *  Copyright (c) 2011 PsycheWeb LLC. All rights reserved.
 *
 *
 *	This notice may not be removed from this file.
 *
 */

#import <UIKit/UIKit.h>
#import "LCYLockScreenViewController.h"
#import "ColorSwitcher.h"

#define addSmtricStr @"iEn8ioesfec3"

@class ClientsViewController_iPhone;
@class ClinicianViewController;

@class TrainTrackViewController;
@class ReportsRootViewController_iPad;
@class ReportsDetailViewController_iPad;
@class ReportsViewController_iPhone;

@class LCYAppSettings;
@class CasualAlertViewController;

@class PTTEncryption;
@class Reachability;
@class KeychainItemWrapper;

static NSInteger const kPTTScreenLocationTop = 1;
static NSInteger const kPTTScreenLocationMiddle = 2;
static NSInteger const kPTTScreenLocationLeft = 3;
static NSInteger const kPTTScreenLocationRight = 4;
static NSInteger const kPTTScreenLocationBottom = 5;
static NSInteger const kPTTMaximumSaveAttempts = 10;

static NSString *const kSCModelDidCommitData = @"SCModelDidCommitData";

static NSString *const kPTTAddressBookSourceIdentifier = @"address_book_source_identifier";
static NSString *const kPTTAddressBookGroupIdentifier = @"address_book_group_identifier";
static NSString *const kPTTAddressBookGroupName = @"address_book_group_name";
static NSString *const kPTTGloballyUniqueIdentifier = @"globally_unique_identifier";
static NSString *const kPTAutoAddClinicianToGroup = @"auto_add_clinician_to_group";
static NSString *const kPTCurrentKeyDictionary = @"current_key_dictonary";
static NSString *const kPTCurrentKeyDate = @"current_key_date";
static NSString *const kPTiCloudPreference = @"icloud_preference";
static NSString *const kPTMonthlyPracticumLogNumber = @"monthly_practicum_log_number";
static NSString *const kPTHasPrepopulated = @"hasPrepopulated";

static NSInteger const kAlertTagErrorExitApp = 1;

/*
 **************************************************************************************
        class PTTAppDelegate
 **************************************************************************************
 */
/**
   This class is the delegate for the application.



   Architecture:


 */
@interface PTTAppDelegate : UIResponder <UIApplicationDelegate,UITabBarControllerDelegate,LCYLockScreenDelegate,UIAlertViewDelegate>{
    TrainTrackViewController *trainTrackViewController;
    ClientsViewController_iPhone *clientsViewController_iPhone;
    ClinicianViewController *clinicianViewController;
    ReportsRootViewController_iPad *reportsRootViewController_iPad;
    ReportsDetailViewController_iPad *reportsDetailViewController_iPad;
    ReportsViewController_iPhone *reportsViewController_iPhone;
    int displayDevelopedByAttempt;

    LCYLockScreenViewController *lockScreenVC_;

    LCYAppSettings *appSettings_;

    CasualAlertViewController *casualAlertManager;

    BOOL encryptedLockDictionarySuccess;

    BOOL setupDatabase;
    BOOL retrievedEncryptedDataFile;
    BOOL okayToDecryptBool_;
    PTTEncryption *encryption_;
    NSString *trustResultFailureString;
    BOOL addedPersistentStoreSuccess;
    BOOL addedPrepopulatedData;
    Reachability *hostReach;
    Reachability *internetReach;
    Reachability *wifiReach;

    NSTimer *checkKeyEntityTimer;
    NSTimer *displayConnectingTimer;
    BOOL resetDatabase;
    BOOL firstRun;

    int secondsWaitingForICloud;
}

@property (strong, nonatomic) IBOutlet UIWindow *window;
@property (nonatomic, retain) ColorSwitcher *colorSwitcher;

- (void) customizeGlobalTheme;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (readonly, strong, nonatomic) NSManagedObjectContext *drugsManagedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *drugsManagedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *drugsPersistentStoreCoordinator;

@property (readonly, strong, nonatomic) NSManagedObjectContext *disordersManagedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *disordersManagedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *disordersPersistentStoreCoordinator;

@property (strong, nonatomic) IBOutlet UIView *tabBarView;
@property (strong, nonatomic) IBOutlet UITabBarController *tabBarController;
@property (weak, nonatomic) IBOutlet UIView *tabBarControllerContainerView;
@property (weak, nonatomic) IBOutlet UIView *viewController;
@property (nonatomic, retain) KeychainItemWrapper *passwordItem;
@property (nonatomic, retain) KeychainItemWrapper *passCodeItem;
@property (nonatomic,assign) BOOL stopScrollingMonthlyPracticumLog;
@property (nonatomic,assign) BOOL drugViewControllerIsInDetailSubview;
@property (nonatomic, assign) BOOL usingiCloudStore;

- (void) loadDatabaseData:(id)sender;
- (void) initializeiCloudAccess;
- (NSURL *) applicationDrugsFileURL;
- (void) resetDrugsModel;

//-(NSURL *)applicationDisordersFileURL;
- (void) resetDisordersModel;
+ (PTTAppDelegate *) appDelegate;
- (NSURL *) applicationPTFileDirectory;
- (void) saveContext;
+ (NSString *) retrieveFromUserDefaults:(NSString *)key;
- (void) flashAppTrainAndTitleGraphics;
- (NSString *) applicationDocumentsDirectoryString;

- (NSURL *) applicationSupportURL;
- (NSString *) applicationSupportPath;
- (NSString *) setupLockDictionaryResultStr;
- (void) setupMyInfoRecord;
- (void) saveDrugsContext;
- (NSNumber *) iCloudPreferenceFromUserDefaults;

- (BOOL) reachable;
- (void) displayMemoryWarning;
- (NSURL *) applicationDrugsDirectory;
- (NSString *) applicationDrugsPathString;
-(BOOL)validateRequiredFields;
//-(NSString *)decyptString:(NSString *) str;
//-(NSString *)decyptString:(NSString *) encryptedString usingKeyString:(NSString *)keyString;
- (NSDictionary *) encryptDataToEncryptedData:(NSData *)unencryptedData withKeyString:(NSString *)keyStringToSet;
- (NSDictionary *) encryptStringToEncryptedData:(NSString *)plainTextStr withKeyString:(NSString *)keyStringToSet;
- (NSString *) convertDataToString:(NSData *)data;
- (NSData *) decryptDataToPlainDataUsingKeyEntityWithString:(NSString *)keyString encryptedData:(NSData *)encryptedData;
//-(NSData *)decryptDataToPlainData:(NSData *) encryptedData;
//- (NSData *) encryptDictionaryToData:(NSDictionary *)unencryptedDictionary;
//-(NSDictionary *)decryptDataToDictionary:(NSData*)encryptedData;
- (NSString *) generateRandomStringOfLength:(int)length;
- (NSString *) combSmString;
- (NSData *) hashDataFromString:(NSString *)plainString;
- (NSData *) getOldSharedSymetricData;
- (NSDate *) convertDataToDate:(NSData *)data;
- (IBAction) notifyTrustFailure:(id)sender;
- (NSData *) encryptDataToEncryptedData:(NSData *)unencryptedData;
- (NSData *) decryptDataToPlainData:(NSData *)encryptedData usingSymetricKey:(NSData *)symetricData;
- (NSData *) convertStringToData:(NSString *)string;
- (NSData *) getSharedSymetricData;
- (NSURL *) applicationDocumentsDirectory;
- (NSURL *) applicationCachesDirectory;
- (NSString *) generateExposedKey;

- (BOOL) addSkipBackupAttributeToItemAtURL:(NSURL *)URL;

//-(IBAction)resaveLockDictionarySettings:(id)sender;
@property (nonatomic,assign) BOOL okayToDecryptBool;

@property (nonatomic, strong) PTTEncryption *encryption;

@property (nonatomic, strong) IBOutlet UIViewController *masterViewController;
@property (nonatomic, strong) IBOutlet TrainTrackViewController *trainTrackViewController;
@property (nonatomic, strong) IBOutlet ClinicianViewController *clinicianViewController;
@property (nonatomic, strong) IBOutlet ClientsViewController_iPhone *clientsViewController_iPhone;
@property (nonatomic, strong) IBOutlet ReportsRootViewController_iPad *reportsRootViewController_iPad;
@property (nonatomic, strong) IBOutlet ReportsDetailViewController_iPad *reportsDetailViewController_iPad;
@property (nonatomic, strong) IBOutlet ReportsViewController_iPhone *reportsViewController_iPhone;
@property (nonatomic, strong) IBOutlet UINavigationController *reportsNavigationController_iPhone;

@property (nonatomic, strong) IBOutlet UITabBar *tabBar;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UILabel *psyTrackLabel;
@property (strong, nonatomic) IBOutlet UILabel *clinicianToolsLabel;
@property (strong, nonatomic) IBOutlet UILabel *developedByLabel;

@property (nonatomic, assign) BOOL changedPassword;
@property (nonatomic, assign) BOOL changedToken;

@property (weak, nonatomic) IBOutlet UINavigationController *navigationControllerTrainTrack;
@property (weak, nonatomic) IBOutlet UISplitViewController *splitViewControllerReports;
#define degreesToRadian(x) (M_PI * (x) / 180.0)

@property (nonatomic, strong) IBOutlet LCYLockScreenViewController *lockScreenVC;
@property (nonatomic, strong) IBOutlet CasualAlertViewController *casualAlertManager;

- (void) lockScreen:(LCYLockScreenViewController *)lockScreen unlockedApp:(BOOL)unlocked;
- (LCYAppSettings *) appSettings;

//+(BOOL)getUseiCloud;

+ (NSString *) GetUUID;

- (NSData *) getLocalSymetricData;

@end

@interface PTTAppDelegate (AppLock)
- (BOOL) isAppLocked;
- (BOOL) isPasscodeOn;
- (BOOL) isLockedAtStartup;
- (BOOL) isLockedTimerOn;

- (void) lockApplication;
- (void) displayWrongPassword;

- (NSString *) lockSettingsFilePath;

@end

@interface PTTAppDelegate (CasualAlerts)

- (void) displayNotification:(NSString *)alertText forDuration:(float)seconds location:(NSInteger)screenLocation inView:(UIView *)viewSuperview;

- (void) displayNotification:(NSString *)alertText;

@end
