/*
 *  PTTAppDelegate.h
 *  psyTrack Clinician Tools
 *  Version: 1.0
 *
 *
 *	THIS SOURCE CODE AND ANY ACCOMPANYING DOCUMENTATION ARE PROTECTED BY UNITED STATES 
 *	INTELLECTUAL PROPERTY LAW AND INTERNATIONAL TREATIES. UNAUTHORIZED REPRODUCTION OR 
 *	DISTRIBUTION IS SUBJECT TO CIVIL AND CRIMINAL PENALTIES. 
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

#define addSmtricStr @"iEn8ioesfec3"



@class ClientsRootViewController_iPad;
@class ClientsDetailViewController_iPad;
@class CliniciansRootViewController_iPad;
@class CliniciansDetailViewController_iPad;
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
static NSInteger const kPTTScreenLocationTop = 1;
static NSInteger const kPTTScreenLocationMiddle = 2;
static NSInteger const kPTTScreenLocationLeft = 3;
static NSInteger const kPTTScreenLocationRight = 4;
static NSInteger const kPTTScreenLocationBottom = 5;

static NSString * const kPTTAddressBookSourceIdentifier=@"address_book_source_identifier";
static NSString * const kPTTAddressBookGroupIdentifier=@"address_book_group_identifier";
static NSString * const kPTTAddressBookGroupName=@"address_book_group_name";
static NSString * const kPTTGloballyUniqueIdentifier=@"globally_unique_identifier";
static NSString * const kPTAutoAddClinicianToGroup=@"auto_add_clinician_to_group";
/****************************************************************************************/
/*	class PTTAppDelegate	*/
/****************************************************************************************/ 
/**
 This class is the delegate for the application.
 

 
 Architecture:
 

 */
@interface PTTAppDelegate : UIResponder <UIApplicationDelegate,UITabBarControllerDelegate,LCYLockScreenDelegate,UIAlertViewDelegate>{

     ClientsRootViewController_iPad *clientsRootViewController_iPad;
    ClientsDetailViewController_iPad *clientsDetailViewController_iPad;
     CliniciansRootViewController_iPad *cliniciansRootViewController_iPad;
	 CliniciansDetailViewController_iPad *cliniciansDetailViewController_iPad;
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
    
    
    NSMutableDictionary *lockValuesDictionary_;
    
    BOOL encryptedLockDictionarySuccess;
    
    BOOL setupDatabase;
    BOOL retrievedEncryptedDataFile;
    BOOL okayToDecryptBool_;
     PTTEncryption *encryption_;
    NSString *trustResultFailureString;
    BOOL addedPersistentStoreSuccess;
    
    Reachability* hostReach;
    Reachability* internetReach;
    Reachability* wifiReach;
}

@property (strong, nonatomic) IBOutlet UIWindow *window;

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
@property (weak, nonatomic)IBOutlet UIView *tabBarControllerContainerView;
@property (weak, nonatomic)IBOutlet UIViewController *viewController;
-(void)loadDatabaseData:(id)sender;
- (void)initializeiCloudAccess ;
-(NSURL *)applicationDrugsFileURL;
-(void)resetDrugsModel;

//-(NSURL *)applicationDisordersFileURL;
-(void)resetDisordersModel;


-(BOOL)setUpDrugStore;
- (void)saveContext;
+ (NSString*)retrieveFromUserDefaults:(NSString*)key;
-(void)flashAppTrainAndTitleGraphics;
- (NSString *)applicationDocumentsDirectoryString;
- (NSURL *)applicationDocumentsDirectory;
-(NSURL *)applicationSupportURL;
-(NSString *)applicationSupportPath;
-(NSString *)setupLockDictionaryResultStr;
-(NSString *)setupDefaultLockDictionaryResultStr;
- (void)saveDrugsContext;

-(BOOL)copyDrugsToMainContext;

-(void)displayMemoryWarning;
- (NSURL *)applicationDrugsDirectory;
-(NSString *)applicationDrugsPathString;

//-(NSString *)decyptString:(NSString *) str;
-(NSString *)decyptString:(NSString *) encryptedString usingKeyWithDate:(NSDate *)keyDate;
-(NSDictionary *)encryptDataToEncryptedData:(NSData *) unencryptedData withKeyDate:(NSDate *)keyDateToSet;
-(NSDictionary *)encryptStringToEncryptedData:(NSString *)plainTextStr withKeyDate:(NSDate *)keyDateToSet;
-(NSString *)convertDataToString:(NSData *)data;
-(NSData *)decryptDataToPlainDataUsingKeyEntityWithDate:(NSDate *)keyDate encryptedData:(NSData *)encryptedData;
//-(NSData *)decryptDataToPlainData:(NSData *) encryptedData;
-(NSData *)encryptDictionaryToData:(NSDictionary *)unencryptedDictionary;
//-(NSDictionary *)decryptDataToDictionary:(NSData*)encryptedData;
-(NSString *)generateRandomStringOfLength:(int )length;
-(NSString *)combSmString;
-(NSData *)hashDataFromString:(NSString *)plainString;
-(NSDictionary*)unwrapAndCreateKeyDataFromKeyEntitywithKeyDate:(NSDate *)keyDate;
-(NSDate *)convertDataToDate:(NSData *)data;
-(IBAction)notifyTrustFailure:(id)sender;
-(NSData *)decryptDataToPlainData:(NSData *)encryptedData usingSymetricKey:(NSData *)symetricData;
-(NSData *)convertStringToData:(NSString *)string;

//-(IBAction)resaveLockDictionarySettings:(id)sender;
@property (nonatomic,assign)BOOL okayToDecryptBool;

@property (nonatomic, strong) PTTEncryption *encryption;
@property (nonatomic, strong) IBOutlet UIViewController *masterViewController;
@property (nonatomic, strong) IBOutlet ClientsRootViewController_iPad *clientsRootViewController_iPad;
@property (nonatomic, strong) IBOutlet ClientsDetailViewController_iPad *clientsDetailViewController_iPad;
@property (nonatomic, strong) IBOutlet CliniciansRootViewController_iPad *cliniciansRootViewController_iPad;
@property (nonatomic, strong) IBOutlet CliniciansDetailViewController_iPad *cliniciansDetailViewController_iPad;
@property (nonatomic, strong) IBOutlet TrainTrackViewController *trainTrackViewController;
@property (nonatomic, strong) IBOutlet ClinicianViewController *clinicianViewController;
@property (nonatomic, strong) IBOutlet ClientsViewController_iPhone *clientsViewController_iPhone;
@property (nonatomic, strong) IBOutlet ReportsRootViewController_iPad *reportsRootViewController_iPad;
@property (nonatomic, strong) IBOutlet ReportsDetailViewController_iPad *reportsDetailViewController_iPad;
@property (nonatomic, strong) IBOutlet ReportsViewController_iPhone *reportsViewController_iPhone;

@property (nonatomic, strong) IBOutlet UITabBar *tabBar;
@property (strong, nonatomic)IBOutlet UIImageView *imageView;
@property (strong, nonatomic)IBOutlet UILabel *psyTrackLabel;
@property (strong, nonatomic)IBOutlet UILabel *clinicianToolsLabel;
@property (strong, nonatomic)IBOutlet UILabel *developedByLabel;


@property (strong, nonatomic) IBOutlet UISplitViewController *splitViewControllerClients;
@property (weak, nonatomic) IBOutlet UISplitViewController *splitViewControllerClinicians;
@property (weak, nonatomic) IBOutlet UINavigationController *navigationControllerTrainTrack;
@property (weak, nonatomic) IBOutlet UISplitViewController *splitViewControllerReports;
#define degreesToRadian(x) (M_PI * (x) / 180.0)

@property (nonatomic, strong) NSMutableDictionary *lockValuesDictionary;
@property (nonatomic, strong) IBOutlet LCYLockScreenViewController *lockScreenVC;
@property (nonatomic, strong)IBOutlet CasualAlertViewController *casualAlertManager;

-(void)saveContextsAndSettings;

- (void) lockScreen: (LCYLockScreenViewController *) lockScreen unlockedApp: (BOOL) unlocked;
-(LCYAppSettings *) appSettings;

//+(BOOL)getUseiCloud;

+ (NSString *)GetUUID;
-(void)setLCYLockPlist;
-(NSData*)getSymetricData;
@end


@interface PTTAppDelegate (AppLock)
- (BOOL) isAppLocked;
- (BOOL) isPasscodeOn;
- (BOOL) isLockedAtStartup;
-(BOOL)isLockedTimerOn;
- (NSString *) appLockPasscode;
- (void) lockApplication;
-(void)displayWrongPassword;
- (void) setLockedAtStartup:(BOOL)value;

-(BOOL)saveLockDictionarySettings;
-(NSString *)lockSettingsFilePath;



@end


@interface PTTAppDelegate (CasualAlerts)

-(void)displayNotification:(NSString *)alertText forDuration:(float)seconds location:(NSInteger )screenLocation inView:(UIView *)viewSuperview;



@end

