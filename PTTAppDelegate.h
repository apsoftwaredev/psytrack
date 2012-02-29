/*
 *  PTTAppDelegate.h
 *  psyTrack
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

static NSInteger const kPTTScreenLocationTop = 1;
static NSInteger const kPTTScreenLocationMiddle = 2;
static NSInteger const kPTTScreenLocationLeft = 3;
static NSInteger const kPTTScreenLocationRight = 4;
static NSInteger const kPTTScreenLocationBottom = 5;

static NSString * const kAddressBookIdentifier=@"address_book_identifier";
static NSString * const kPTTAddressBookGroupIdentifier=@"address_book_group_identifier";
static NSString * const kPTTAddressBookGroupName=@"address_book_group_name";
static NSString * const kPTTGloballyUniqueIdentifier=@"globally_unique_identifier";

/****************************************************************************************/
/*	class PTTAppDelegate	*/
/****************************************************************************************/ 
/**
 This class is the delegate for the application.
 
 psyTrack is an applicaion designed to help clinical psychologists, psychiatrists, and and other clinical trainees track their training hours for practicum, internship, or other licensing requirements.  It allows clinicians to keep a record of services provided to clients, including, tests administered and types of treatments provided.  It allows clinicians to track their continuing education hours and classes needed for certifications.  It allows clinicians to easily track additional user defined demographic information of thier clients as well other clinicians, which is needed for licensing and useful for therapist matching.  It allows clinicians to keep a record of their and other clinician's previous employment, publications, licences, and other curriculum vitae information.  It allows the clicinian to easily track client referrals to other clinicians.  It is integrated with the Apple Address book to allow connection with and importing of existing contacts.  It is also integrated with the Apple Calander and allows the clinician to easily schedule clients, using a secure client code.  It also provides a complete interface to the entire FDA drug database, which links to downloadable pdfs containing drug labeling, medication guides, and other information.  It allows the clinician to keep track of the medications prescribed to clients and any side effects.  It keeps track of disorders that the clinician is treating.  The database is encrypted using industry standard encryption and the application has an in-app locking screen for additonal security.  It is enabled for iCloud and works on iPhone, iPad, and iPod touch.  If iCloud is enabled, the database is synced accross devices.  It also provides additonal tools such as current age and Wechsler 30 day Month test age calculators, height and weight conversions.  The time tracking tools include a stopwatch and start and stop times, and allows adjust the times and record breaks, to compute a total service time. The application was designed by practicum student in a doctoral clinical psychology program.
 
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
    
    
}

@property (strong, nonatomic) IBOutlet UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (readonly, strong, nonatomic) NSManagedObjectContext *drugsManagedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *drugsManagedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *drugsPersistentStoreCoordinator;
@property (strong, nonatomic) IBOutlet UIView *tabBarView;
@property (strong, nonatomic) IBOutlet UITabBarController *tabBarController;
@property (weak, nonatomic)IBOutlet UIView *tabBarControllerContainerView;
@property (weak, nonatomic)IBOutlet UIViewController *viewController;

-(NSURL *)applicationDrugsFileURL;
-(void)resetDrugsModel;
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
-(BOOL)setUpDrugStore;
-(BOOL)copyDrugsToMainContext;

-(void)displayMemoryWarning;
- (NSURL *)applicationDrugsDirectory;
-(NSString *)applicationDrugsPathString;

-(NSString *)decyptString:(NSString *) str;
-(NSData *)encryptDataToEncryptedData:(NSData *) unencryptedData;
-(NSData *)encryptStringToEncryptedData:(NSString *)plainTextStr;
-(NSString *)convertDataToString:(NSData *)data;
-(NSData *)decryptDataToPlainData:(NSData *) encryptedData;
-(NSString *)generateRandomStringOfLength:(int )length;
-(NSString *)combSmString;
-(NSData *)hashDataFromString:(NSString *)plainString;
-(NSData*)unwrapAndCreateKeyDataFromKeyEntity;
-(IBAction)notifyTrustFailure:(id)sender;
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
@property (strong, nonatomic)IBOutlet UILabel *psyTrainTrackLabel;
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

+(BOOL)getUseiCloud;

+ (NSString *)GetUUID;

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
-(void)setLCYLockPlist;


@end


@interface PTTAppDelegate (CasualAlerts)

-(void)displayNotification:(NSString *)alertText forDuration:(float)seconds location:(NSInteger )screenLocation inView:(UIView *)viewSuperview;



@end

