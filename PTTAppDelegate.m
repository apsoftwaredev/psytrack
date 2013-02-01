/*
 *  PTTAppDelegate.m
 *  psyTrack Clinician Tools
 *  Version: 1.0
 *
 *
 *	THIS SOURCE CODE AND ANY ACCOMPANYING DOCUMENTATION ARE PROTECTED BY UNITED STATES 
 *	INTELLECTUAL PROPERTY LAW AND INTERNATIONAL TREATIES. UNAUTHORIZED REPRODUCTION OR 
 *	DISTRIBUTION IS SUBJECT TO CIVIL AND CRIMINAL PENALTIES. 
 *
 *  Created by Daniel Boice on 9/21/2011.
 *  Copyright (c) 2011 PsycheWeb LLC. All rights reserved.
 *
 *
 *	This notice may not be removed from this file.
 *
 */

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

#import "PTTAppDelegate.h"
#import "ClinicianViewController.h"
#import "ClientsViewController_iPhone.h"

#import "ClientsRootViewController_iPad.h"
#import "ClientsDetailViewController_iPad.h"
#import "CliniciansRootViewController_iPad.h"
#import "CliniciansDetailViewController_iPad.h"
#import "CliniciansViewController_Shared.h"
#import "TrainTrackViewController.h"

#import "TabFile.h"

#import "DrugProductEntity.h"
#import "DrugApplicationEntity.h"
#import "DrugProductTECodeEntity.h"
#import "DrugDoctypeLookupEntity.h"
#import "DrugAppDocTypeLookupEntity.h"
#import "DrugChemicalTypeLookupEntity.h"
#import "DrugRegActionDateEntity.h"
#import "DrugAppDocEntity.h"
#import "DrugReviewClassLookupEntity.h"

#import "LCYLockScreenViewController.h"
#import "LCYAppSettings.h"

#import "CasualAlertViewController.h"
#import "ClinicianGroupsViewController.h"
#import "PTTEncryption.h"
#import "KeyEntity.h"

#import "NSDictionaryHelpers.h"


#import "KeychainItemWrapper.h"
#import "Reachability.h"

#import <Security/Security.h>


#define kPTTAppSqliteFileName @"psyTrack.sqlite"
#define kPTTDrugDatabaseSqliteFileName @"drugs.sqlite"

@implementation PTTAppDelegate

@synthesize window = _window;
@synthesize managedObjectContext = managedObjectContext__;
@synthesize managedObjectModel = managedObjectModel__;
@synthesize persistentStoreCoordinator = persistentStoreCoordinator__;

@synthesize drugsManagedObjectContext = __drugsManagedObjectContext;
@synthesize drugsManagedObjectModel = __drugsManagedObjectModel;
@synthesize drugsPersistentStoreCoordinator = __drugsPersistentStoreCoordinator;

@synthesize disordersManagedObjectContext = __disordersManagedObjectContext;
@synthesize disordersManagedObjectModel = __disordersManagedObjectModel;
@synthesize disordersPersistentStoreCoordinator = __disordersPersistentStoreCoordinator;



@synthesize navigationControllerTrainTrack = _navigationControllerTrainTrack;
@synthesize splitViewControllerReports = _splitViewControllerReports;
@synthesize tabBarController, tabBar, tabBarControllerContainerView;
@synthesize  trainTrackViewController, clientsViewController_iPhone, clinicianViewController;
@synthesize reportsRootViewController_iPad, reportsDetailViewController_iPad,reportsViewController_iPhone;
@synthesize imageView=_imageView;
@synthesize masterViewController;
@synthesize reportsNavigationController_iPhone;
@synthesize psyTrackLabel,developedByLabel,clinicianToolsLabel;
@synthesize lockScreenVC = lockScreenVC_;
@synthesize casualAlertManager;
@synthesize tabBarView;
@synthesize viewController;

@synthesize encryption=encryption_;
@synthesize okayToDecryptBool=okayToDecryptBool_;
@synthesize passwordItem=passwordItem_,passCodeItem=passCodeItem_;
@synthesize colorSwitcher;
@synthesize stopScrollingMonthlyPracticumLog;
@synthesize changedPassword,changedToken;
@synthesize drugViewControllerIsInDetailSubview;

+ (PTTAppDelegate *)appDelegate {
	return (PTTAppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{

    
#if !__has_feature(objc_arc)

    UIAlertView *anAlert = [[UIAlertView alloc] initWithTitle:@"Incompatable iOS Version" message:@"This App Requires iOS 5.0 or higher, please upgrade in iTunes" delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
    anAlert.tag=1;
    [anAlert show];

    
#endif
   
//    
      
   
    
//    // Observe the kNetworkReachabilityChangedNotification. When that notification is posted, the
//    // method "reachabilityChanged" will be called. 
//    @try {
//         [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(reachabilityChanged:) name: kReachabilityChangedNotification object: nil];
//    }
//    @catch (NSException *exception) {
//        //do nothing
//    }
//   
//   
//    hostReach = [Reachability reachabilityWithHostName: @"www.google.com"];
//	[hostReach startNotifier];
////	[self updateInterfaceWithReachability: hostReach];
//	
//    internetReach = [Reachability reachabilityForInternetConnection] ;
//	[internetReach startNotifier];
////	[self updateInterfaceWithReachability: internetReach];
//    
//    wifiReach = [Reachability reachabilityForLocalWiFi] ;
//	[wifiReach startNotifier];
////	[self updateInterfaceWithReachability: wifiReach];

	NSUbiquitousKeyValueStore* store = [NSUbiquitousKeyValueStore defaultStore];
    @try {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(updateKVStoreItems:)
                                                     name:NSUbiquitousKeyValueStoreDidChangeExternallyNotification
                                                   object:store];
    }
    @catch (NSException *exception) {
        //do nothing
    }
    
   
       [store synchronize];

    [self initializeiCloudAccess];
    
    
    
//    [Parse setApplicationId:@"UCK2PmpY8ufgbuLyJXqYM9HGdpFAsmPUxjbMDWee"
//                  clientKey:@"VN8MzEgoIcA9xUOe0rjaGuF1WmiKusiNmCFvAOP2"];
 
//    UIImage * sShot = [UIImage imageNamed:@"Dan Boice-46.jpg"];
//    UIImageWriteToSavedPhotosAlbum(sShot, nil, nil, nil);
//    
    //    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    NSString *bPath = [[NSBundle mainBundle] bundlePath];
    NSString *settingsPath = [bPath stringByAppendingPathComponent:@"Settings.bundle"];
    NSString *plistFile = [settingsPath stringByAppendingPathComponent:@"Root.plist"];
    
    //Get the Preferences Array from the dictionary
    NSDictionary *settingsDictionary = [NSDictionary dictionaryWithContentsOfFile:plistFile];
  
    
      [[NSUserDefaults standardUserDefaults] registerDefaults:settingsDictionary];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
        
               
    
    
    @try {
        [[NSNotificationCenter defaultCenter]
         addObserver:self
         selector:@selector(notifyTrustFailure:)
         name:@"trustFailureOccured"
         object:nil];
        
        
        
        [[NSNotificationCenter defaultCenter]
         addObserver:self
         selector:@selector(loadDatabaseData:)
         name:@"persistentStoreAdded"
         object:nil];
    }
    @catch (NSException *exception) {
        [self displayNotification:@"Error loading database" forDuration:0 location:kPTTScreenLocationTop inView:self.window];
    }
    
   
   
 
       
;
   
    
 
    UIImage *backgroundPattern=nil;
    NSString *tabBarImageNameStr=nil;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {

       
        tabBarImageNameStr=@"ipad-tabbar-right.png";
            backgroundPattern=[UIImage imageNamed:@"ipad-background-blue-plain-small.png"]; 
                
                
                [self.window addSubview:self.viewController];
//                 [self.masterViewController.view addSubview:self.tabBarController.view];  
                 UIImage *clininicansImage =[UIImage imageNamed:@"cliniciansTab.png"];
                
        
        
        
        CliniciansRootViewController_iPad *cliniciansRootViewController = [[CliniciansRootViewController_iPad alloc]initWithNibName:@"CliniciansRootViewController_iPad" bundle:[NSBundle mainBundle]];
        
        CliniciansDetailViewController_iPad *cliniciansDetailViewController_iPad=[[CliniciansDetailViewController_iPad alloc]initWithNibName:@"CliniciansDetailViewController_iPad" bundle:[NSBundle mainBundle]];
        
        
        
        
        //        
        // Establish the master-detail relationship between the models
        cliniciansRootViewController.tableViewModel.detailViewController = cliniciansDetailViewController_iPad;
        
        // Wrap the view controllers into navigation controllers
        UINavigationController *clinicianRootNav = [[UINavigationController alloc] initWithRootViewController:cliniciansRootViewController];
        UINavigationController *clinicianDetailNav = [[UINavigationController alloc] initWithRootViewController:cliniciansDetailViewController_iPad];
        clinicianRootNav.title=@"ClinicianRoot";
        clinicianRootNav.navigationBar.opaque=YES;
        clinicianRootNav.navigationBar.tintColor=[UIColor colorWithRed:0.317586 green:0.623853 blue:0.77796 alpha:1.0];
        
        clinicianDetailNav.navigationBar.opaque=YES;
        clinicianDetailNav.title=@"ClinicianDetail";
        clinicianDetailNav.navigationBar.tintColor=[UIColor colorWithRed:0.317586 green:0.623853 blue:0.77796 alpha:1.0];
        
        // Crea the split view and add it to the window
        UISplitViewController *cliniciansSplitViewController = [[UISplitViewController alloc] init];
        cliniciansSplitViewController.viewControllers = [NSArray arrayWithObjects:clinicianRootNav, clinicianDetailNav, nil];
        cliniciansSplitViewController.delegate = cliniciansDetailViewController_iPad;

        cliniciansSplitViewController.title=@"Clinicians";
        
        cliniciansSplitViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Clinicians" image:clininicansImage tag:90];
        
        
                
                UIImage *trainImage =[UIImage imageNamed:@"trainTab.png"];
               self.navigationControllerTrainTrack.tabBarItem=[[UITabBarItem alloc] initWithTitle:@"psyTrack" image:trainImage tag:91];

                
                UIImage *clientsImage =[UIImage imageNamed:@"clientsTab.png"];
                
       
        
        ClientsRootViewController_iPad *clientsRootViewController = [[ClientsRootViewController_iPad alloc]initWithNibName:@"ClientsRootViewController_iPad" bundle:[NSBundle mainBundle]];
        
        ClientsDetailViewController_iPad *clientsDetailViewController=[[ClientsDetailViewController_iPad alloc]initWithNibName:@"ClientsDetailViewController_iPad" bundle:[NSBundle mainBundle]];
        
        
        
        
        //        
        // Establish the master-detail relationship between the models
        clientsRootViewController.tableViewModel.detailViewController = clientsDetailViewController;
        
        // Wrap the view controllers into navigation controllers
        UINavigationController *clientsRootNav = [[UINavigationController alloc] initWithRootViewController:clientsRootViewController];
        UINavigationController *clientsDetailNav = [[UINavigationController alloc] initWithRootViewController:clientsDetailViewController];
        
        clientsRootNav.navigationBar.opaque=YES;
        clientsRootNav.navigationBar.tintColor=[UIColor colorWithRed:0.317586 green:0.623853 blue:0.77796 alpha:1.0];
        
        clientsDetailNav.navigationBar.opaque=YES;
        clientsDetailNav.navigationBar.tintColor=[UIColor colorWithRed:0.317586 green:0.623853 blue:0.77796 alpha:1.0];
        
        // Crea the split view and add it to the window
        UISplitViewController *clientsSplitViewController = [[UISplitViewController alloc] init];
        clientsSplitViewController.viewControllers = [NSArray arrayWithObjects:clientsRootNav, clientsDetailNav, nil];
        clientsSplitViewController.delegate = clientsDetailViewController;
        
        clientsSplitViewController.title=@"Clients";
        
        clientsSplitViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Clients" image:clientsImage tag:90];
        
        
               
        
        
        

        
        
        
        
               
                UIImage *reportsImage =[UIImage imageNamed:@"reportTab.png"];
                self.reportsNavigationController_iPhone.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Reports" image:reportsImage tag:92];
       
    
   
                NSArray *controllers = [NSArray arrayWithObjects:self.navigationControllerTrainTrack,cliniciansSplitViewController, clientsSplitViewController,  self.reportsNavigationController_iPhone,/*other controllers go here */ nil];
                tabBarController.viewControllers = controllers;
        
        
            self.tabBarController.delegate=self;
               clientsSplitViewController.view.backgroundColor=[UIColor clearColor];
       
                cliniciansSplitViewController.view.backgroundColor=[UIColor clearColor];
        
       
                
//                
            }
    else {
        [UIApplication sharedApplication].statusBarStyle=UIStatusBarStyleBlackTranslucent;
        
        backgroundPattern=[UIImage imageNamed:@"ipad-background-blue-plain-small.png"];
         tabBarImageNameStr=@"tabbar.png";
    }
    
    clinicianToolsLabel.text=NSLocalizedStringWithDefaultValue(@"Clinician Tools" , @"Root", [NSBundle mainBundle], @"Clinician Tools", @"subname for the application");
    
    CGRect clinicianToolsLabelFrame=clinicianToolsLabel.frame;
    
    clinicianToolsLabelFrame.origin.y=self.imageView.frame.origin.y+self.imageView.frame.size.height-35.0;
    clinicianToolsLabel.frame=clinicianToolsLabelFrame;
    
    CGRect developedByLabelFrame=self.developedByLabel.frame;
    
    developedByLabelFrame.origin.y=self.clinicianToolsLabel.frame.origin.y+self.clinicianToolsLabel.frame.size.height+5.0;
    self.developedByLabel.frame=developedByLabelFrame;
    
    CGRect psyTrackLabelFrame=self.psyTrackLabel.frame;
    psyTrackLabelFrame.origin.y=self.imageView.frame.origin.y-psyTrackLabelFrame.size.height+35.0;
    self.psyTrackLabel.frame=psyTrackLabelFrame;
    
      [[UITabBar appearance] setTintColor:[UIColor whiteColor]];       
    [[UITabBar appearance] setSelectedImageTintColor:[UIColor blueColor]]; 
    [self.tabBarController setDelegate:self];
               

    tabBarController.tabBar.userInteractionEnabled=NO;
    for (UIViewController *viewControllerInArray in tabBarController.viewControllers) {
        viewControllerInArray.view.userInteractionEnabled=NO;
    }
    
    [UIApplication sharedApplication].statusBarHidden = NO;
    
    self.colorSwitcher = [[ColorSwitcher alloc] initWithScheme:@"blue"];
    
    [self customizeGlobalTheme];

    UIImage *tabBarBackgroundImage=[UIImage imageNamed:tabBarImageNameStr];
    
    [tabBarController.tabBar setBackgroundImage:tabBarBackgroundImage];
    
     [self.window setBackgroundColor:[UIColor colorWithPatternImage:backgroundPattern]];
    
    [self.window makeKeyAndVisible];
    [self displayNotification:@"Configuring database settings for iCloud. One moment please..." forDuration:0.0 location:kPTTScreenLocationMiddle inView:self.window];
    displayConnectingTimer=[NSTimer scheduledTimerWithTimeInterval:0.5
                                                            target:self
                                                          selector:@selector(changeEstablishingConnectionMessage)
                                                          userInfo:NULL
                                                           repeats:YES];
    
    
    managedObjectContext__=[self managedObjectContext];
   
    if (self.tabBarController.view) {
        [self.tabBarController.view removeFromSuperview];
        
        
    }
   
                        
    
                        
                        
#if !TARGET_IPHONE_SIMULATOR
   
   
    
    [[UIApplication sharedApplication]
     registerForRemoteNotificationTypes:
     (UIRemoteNotificationTypeAlert |
      UIRemoteNotificationTypeBadge |
      UIRemoteNotificationTypeSound)];
	
	[application setApplicationIconBadgeNumber:0];
    
   
	
#endif
    
    // Clear application badge when app launches
	application.applicationIconBadgeNumber = 0;
    
    
    return YES;
}


- (void)customizeGlobalTheme
{
    
    NSString *menuBarImageName=nil;
    
   
    
    NSString *sliderFillImageName=nil;
    NSString *sliderTrackImageName=nil;
    
    NSString *sliderHandleImageName=nil;
    
    if ([SCUtilities systemVersion]>=6||[SCUtilities is_iPad]) {
       menuBarImageName=@"ipad-menubar-full";
    }
    else{
     menuBarImageName=@"menubar-full";
    
    }
    if ([SCUtilities is_iPad]) {
      
        
       
        
        sliderFillImageName=@"ipad-slider-fill.png";
        sliderTrackImageName=@"ipad-slider-track.png";
        
        sliderHandleImageName=@"ipad-slider-handle.png";
    }
    else {
       
        
        
        
        sliderFillImageName=@"slider-fill.png";
        sliderTrackImageName=@"slider-track.png";
        
        sliderHandleImageName=@"slider-handle.png";
    }
    
    
    
    UIImage *navBarImage = [colorSwitcher getImageWithName:menuBarImageName];
    
    [[UINavigationBar appearance] setBackgroundImage:navBarImage 
                                       forBarMetrics:UIBarMetricsDefault];
    
    
    UIImage *barButton = [[colorSwitcher getImageWithName:@"bar-button"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 5, 0, 5)];
    
    [[UIBarButtonItem appearance] setBackgroundImage:barButton forState:UIControlStateNormal 
                                          barMetrics:UIBarMetricsDefault];
    
    UIImage *backButton = [[colorSwitcher getImageWithName:@"back"] resizableImageWithCapInsets:UIEdgeInsetsMake(0,15,0,8)];
    
    
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backButton forState:UIControlStateNormal 
                                                    barMetrics:UIBarMetricsDefault];
    
    
    UIImage *minImage = [colorSwitcher getImageWithName:sliderFillImageName];
    UIImage *maxImage = [UIImage imageNamed:sliderTrackImageName];
    UIImage *thumbImage = [UIImage imageNamed:sliderHandleImageName];
    
    [[UISlider appearance] setMaximumTrackImage:maxImage 
                                       forState:UIControlStateNormal];
    [[UISlider appearance] setMinimumTrackImage:minImage 
                                       forState:UIControlStateNormal];
    [[UISlider appearance] setThumbImage:thumbImage 
                                forState:UIControlStateNormal];

    [[UISearchBar appearance] setBackgroundImage:navBarImage ];
    [[UISearchBar appearance]setScopeBarBackgroundImage:navBarImage];
    
    
}





-(void)changeEstablishingConnectionMessage{
    secondsWaitingForICloud++;
    UIView *messageView=nil;
    for (UIView *view in self.window.subviews) {
        if (view.tag==645) {
            messageView=view;
            break;
        }
    }
    
    if (messageView) {
         
       
            UIView *containerView=[messageView viewWithTag:655];
            
            if (containerView) {
                UILabel *label=(UILabel *)[containerView viewWithTag:656];
                NSString *labelText=(NSString *)label.text;
                
               
                if ([[label.text substringToIndex:11]isEqualToString:@"Configuring"] || [[label.text substringToIndex:10]isEqualToString:@"Attempting"]) {
               
             
                    NSString *message=nil;
                    if (secondsWaitingForICloud>13) {
                        message=@"Attempting to set up database for iCloud. Sorry this is taking so long. Please stand by and I will continue working on it. It could take a few minutes if the response from iCloud is slow";
                    }
                    else{
                        message=@"Configuring database for iCloud. One moment please";
                    
                    }
                    
                switch (labelText.length) {
                    case 50:
                    case 186:
                        message=[message stringByAppendingString:@"."];
                        break;
                    case 51:
                    case 187:
                        message=[message stringByAppendingString:@".."];
                        break;
                    case 52:
                    case 188:
                        message=[message stringByAppendingString:@"..."];
                        break;
                    case 53:
                    
                        message=[message substringToIndex:50];
                        break;
                    case 189:
                        message=[message substringToIndex:186];
                        break;
                    
                    
                    default:
                        break;
                }
                
                   
                
                label.text=message;
                
                    
                } 
                else {
                    [displayConnectingTimer invalidate];
                }
            }
            
        
    }
   
    else {
        [displayConnectingTimer invalidate];
    }


}
- (void)updateKVStoreItems:(NSNotification*)notification {
    // Get the list of keys that changed.
    NSDictionary* userInfo = [notification userInfo];
    NSNumber* reasonForChange = [userInfo objectForKey:NSUbiquitousKeyValueStoreChangeReasonKey];
    NSInteger reason = -1;
    
    // If a reason could not be determined, do not update anything.
    if (!reasonForChange)
        return;
    
    // Update only for changes from the server.
    reason = [reasonForChange integerValue];
    if ((reason == NSUbiquitousKeyValueStoreServerChange) ||
        (reason == NSUbiquitousKeyValueStoreInitialSyncChange)) {
        // If something is changing externally, get the changes
        // and update the corresponding keys locally.
        NSArray* changedKeys = [userInfo objectForKey:NSUbiquitousKeyValueStoreChangedKeysKey];
        NSUbiquitousKeyValueStore* store = [NSUbiquitousKeyValueStore defaultStore];
        NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
        
        // This loop assumes you are using the same key names in both
        // the user defaults database and the iCloud key-value store
        for (NSString* key in changedKeys) {
            id value = [store objectForKey:key];
            [userDefaults setObject:value forKey:key];
        }
    }
}



//-(void)checkKeyEntity {
//
//    
//    
//    
//    NSPredicate *keyStringPredicate=[NSPredicate predicateWithFormat:@"keyString MATCHES %@",[lockValuesDictionary_ valueForKey:K_LOCK_SCREEN_CREATE_KEY]];
//    
//    NSFetchRequest *newFetchRequest=[[NSFetchRequest alloc]init];
//    
//    [newFetchRequest setPredicate:keyStringPredicate];
//    
//    NSError *error=nil;
//    NSArray *fetchedObjects=[managedObjectContext__ executeFetchRequest:newFetchRequest error:&error];
//    
//    if(fetchedObjects.count){
//       KeyEntity *keyObject=[fetchedObjects objectAtIndex:0];
//        if ([keyObject.keyDate isEqualToDate:(NSDate *)[(NSDictionary *)[[NSUserDefaults standardUserDefaults]valueForKey:kPTCurrentKeyDictionary] valueForKey:kPTCurrentKeyDate] ] ) {
//            [checkKeyEntityTimer invalidate];
//            checkKeyEntityTimer=nil;
//            if (!lockValuesDictionary_) {
//                [self setupLockDictionaryResultStr];
//                
//                
//            }
//            
//            NSData *decryptedLockData;
//            decryptedLockData =(NSData *) [self decryptDataToPlainDataUsingKeyEntityWithString:(NSString *)keyObject.keyString encryptedData:(NSData *)keyObject.dataF];
//        
//            
//           
//            
//            
//            //            
//            NSString* newStr = [[NSString alloc] initWithData:decryptedLockData encoding:NSASCIIStringEncoding];;
//            //            
//            
//            if (decryptedLockData) {
//                
//                
//                NSDictionary *dictionaryFromDecryptedData=[NSKeyedUnarchiver unarchiveObjectWithData:decryptedLockData];
//                
//                if (dictionaryFromDecryptedData) {
//                    
//                    
//                    //                    
//                    
//                    id obj = [dictionaryFromDecryptedData objectForKey:K_LOCK_SCREEN_PASSCODE];
//                    
//                    if (obj) {
//                        // use obj
//                        
//                        NSString *pHash= [NSString stringWithFormat:@"%@asdj9emV3k30wer93",@""];
//                        NSString *checkHash=[dictionaryFromDecryptedData valueForKey:K_LOCK_SCREEN_P_HSH];
//                        
//                        //                        
//                        //                        
//                        if (checkHash && [checkHash isEqualToString:pHash]) {
//                            
//                            [lockValuesDictionary_ setValue:[dictionaryFromDecryptedData valueForKey:K_LOCK_SCREEN_PASSCODE] forKey:K_LOCK_SCREEN_PASSCODE];
//                            [self displayNotification:@"Passcode Updated" forDuration:3.0 location:kPTTScreenLocationTop inView:nil];
//                            
//                        }
//                        else {
//                            [self displayNotification:@"Problem updating Passcode occured" forDuration:3.0 location:kPTTScreenLocationTop inView:nil];
//                        }
//                        
//                        
//                        
//                    } 
//                    
//                    
//                    
//                    
//                }
//                else
//                    statusMessage=@"Unable to load necessary security data";
//            }
//            else
//                statusMessage=@"Unable to load necessary security data";
//            
//            
//        }
//
//            
//            lockValuesDictionary_ setValue:(NSString *)[(NSDictionary *)[[NSUserDefaults standardUserDefaults]valueForKey:kPTCurrentKeyDictionary] valueForKey:keyObject.da]  forUndefinedKey:<#(NSString *)#>                                 
//            
//        }
//        
//        [self saveContext];
//    }
//    else 
//    {
//        
//        [self displayNotification:@"Error 789: Unable to save settings." forDuration:3.0 location:kPTTScreenLocationTop inView:nil];                  
//        
//    }
//
//
//
//
//}
-(void)loadDatabaseData:(id)sender
{
    
    @try {
        [[NSNotificationCenter defaultCenter]removeObserver:self name:@"persistentStoreAdded" object:nil ];
    }
    @catch (NSException *exception) {
        //do nothing
    }

    if (!encryption_) {
         self.encryption=[[PTTEncryption alloc]init];
    }
   
    NSString *statusMessage;
    retrievedEncryptedDataFile=NO;
    
    statusMessage=[self setupDefaultLockKeychainSettingsWithReset:NO];
    statusMessage=[self setupLockDictionaryResultStr];
    [self checkKeyStringInKeyEntity];
    
    // if the file is not found, then this is the first time or there is a problem and database will reset


//    if (!encryptedLockDictionarySuccess &&!retrievedEncryptedDataFile) {
//        
//        statusMessage=[self setupDefaultLockDictionaryResultStrWithNewDeviceFile:YES];
//       
//    }
//    else 
//        if(retrievedEncryptedDataFile && !encryptedLockDictionarySuccess)
//        { statusMessage=@"Error in Loading Security Settings Occured";
//            self.okayToDecryptBool=FALSE;
//        }
//    


//    if (!(retrievedEncryptedDataFile && !encryptedLockDictionarySuccess)||(encryptedLockDictionarySuccess|| setupDatabase)) {
//        
       
        self.okayToDecryptBool=YES; 
         [self setupMyInfoRecord];
//    }
//    else {
//        statusMessage=@"Error in Loading Security Settings Occured";
//    }
    
    //    NSInteger screenLocationForMessage=kPTTScreenLocationTop;
    
    
    
    
//    if (([self isPasscodeOn]&&([self isAppLocked]||[self isLockedAtStartup]))) {
//        [self lockApplication];
//        
//    }

    BOOL isAppLocked=[self isAppLocked];
    BOOL isLockedAtStartup=[self isLockedAtStartup];
    if (statusMessage.length) {
        
        UIView *containerView=nil;
        if (okayToDecryptBool_==NO) {
            containerView=self.window;
            
        }else 
        {
             tabBarController.tabBar.userInteractionEnabled=YES;
            for (UIViewController *viewControllerInArray in tabBarController.viewControllers) {
                viewControllerInArray.view.userInteractionEnabled=YES;
            }
            [self.window addSubview:self.tabBarController.view];
             [self flashAppTrainAndTitleGraphics];
        }
        [self displayNotification:statusMessage forDuration:5.0 location:kPTTScreenLocationTop inView:containerView];
        
    }else if (!isAppLocked &&!isLockedAtStartup) {
        if (resetDatabase) {
            statusMessage=@"Reset Database. Ready to use now.";
        }
        else {
            statusMessage=@"Welcome. Ready to use now.";
        }
            [self displayNotification:statusMessage forDuration:5.0 location:kPTTScreenLocationTop inView:nil];
        tabBarController.tabBar.userInteractionEnabled=YES;
        for (UIViewController *viewControllerInArray in tabBarController.viewControllers) {
            viewControllerInArray.view.userInteractionEnabled=YES;
        }
        [self.window addSubview:self.tabBarController.view];
        
         [self flashAppTrainAndTitleGraphics];

        
    } else if(isAppLocked||isLockedAtStartup) {
            
        [self lockApplication];
        [self displayNotification:@"Application Locked."  forDuration:3.0 location:kPTTScreenLocationTop inView:self.window];
        [self flashAppTrainAndTitleGraphics];
    }
    
    if (trustResultFailureString.length) {
        [self displayNotification:trustResultFailureString forDuration:8.0 location:kPTTScreenLocationMiddle inView:self.window];
    }
//    [self saveLockDictionarySettings];
    

}
//- (void) updateInterfaceWithReachability: (Reachability*) curReach
//{
//    if(curReach == hostReach)
//	{
//		
////        NetworkStatus netStatus = [curReach currentReachabilityStatus];
//        BOOL connectionRequired= [curReach connectionRequired];
//        
//       
//        NSString* baseLabel=  @"";
//        if(connectionRequired)
//        {
//            baseLabel=  @"Cellular data network is available.\n  Internet traffic will be routed through it after a connection is established.";
//        }
//        else
//        {
//            baseLabel=  @"Cellular data network is active.\n  Internet traffic will be routed through it.";
//        }
//      
//    }
////	if(curReach == internetReach)
////	{	
//////		[self configureTextField: internetConnectionStatusField imageView: internetConnectionIcon reachability: curReach];
////	}
////	if(curReach == wifiReach)
////	{	
//////		[self configureTextField: localWiFiConnectionStatusField imageView: localWiFiConnectionIcon reachability: curReach];
////	}
//	
//}

//Called by Reachability whenever status changes.
//- (void) reachabilityChanged: (NSNotification* )note
//{
//	Reachability* curReach = [note object];
//	if (curReach) {
//         NSParameterAssert([curReach isKindOfClass: [Reachability class]]);
//    }
//   
////	[self updateInterfaceWithReachability: curReach];
//}


-(IBAction)notifyTrustFailure:(id)sender{


    
    if (self.window.isKeyWindow) {
        [self displayNotification:@"Problem with trust settings.  Check for software update or notify support." forDuration:5.0 location:kPTTScreenLocationMiddle inView:self.window];
    }
    else {
    trustResultFailureString=@"Problem with trust settings.  Check for software update or notify support.";
    }



}
-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{

    
      

   

        switch (alertView.tag) {
            case 38:
            case 1:
            {
                 exit(0);
            }
                break;
                    
        
    
    }





}
- (NSNumber * )iCloudPreferenceFromUserDefaults{
	NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
	NSNumber * val = nil;
    
	if (standardUserDefaults)
		val = [standardUserDefaults objectForKey:kPTiCloudPreference];
    
	// TODO: / apparent Apple bug: if user hasn't opened Settings for this app yet (as if?!), then
	// the defaults haven't been copied in yet.  So do so here.  Adds another null check
	// for every retrieve, but should only trip the first time
	if (val == nil) { 
		
		//Get the bundle path
		NSString *bPath = [[NSBundle mainBundle] bundlePath];
		NSString *settingsPath = [bPath stringByAppendingPathComponent:@"Settings.bundle"];
		NSString *plistFile = [settingsPath stringByAppendingPathComponent:@"Root.plist"];
        
		//Get the Preferences Array from the dictionary
		NSDictionary *settingsDictionary = [NSDictionary dictionaryWithContentsOfFile:plistFile];
		NSArray *preferencesArray = [settingsDictionary objectForKey:@"PreferenceSpecifiers"];
        
		//Loop through the array
		NSDictionary *item;
		for(item in preferencesArray)
		{
			//Get the key of the item.
			NSString *keyValue = [item objectForKey:@"Key"];
            
			//Get the default value specified in the plist file.
			id defaultValue = [item objectForKey:@"DefaultValue"];
            
			if (keyValue && defaultValue) {				
				[standardUserDefaults setObject:defaultValue forKey:keyValue];
				if ([keyValue compare:kPTiCloudPreference] == NSOrderedSame)
					val = defaultValue;
			}
		}
		[standardUserDefaults synchronize];
	}
    
	return val;


}
+ (NSString*)retrieveFromUserDefaults:(NSString*)key
{
	NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
	NSString *val = nil;
    
	if (standardUserDefaults) 
		val = [standardUserDefaults objectForKey:key];
    
	// TODO: / apparent Apple bug: if user hasn't opened Settings for this app yet (as if?!), then
	// the defaults haven't been copied in yet.  So do so here.  Adds another null check
	// for every retrieve, but should only trip the first time
	if (val == nil) { 
		
		//Get the bundle path
		NSString *bPath = [[NSBundle mainBundle] bundlePath];
		NSString *settingsPath = [bPath stringByAppendingPathComponent:@"Settings.bundle"];
		NSString *plistFile = [settingsPath stringByAppendingPathComponent:@"Root.plist"];
        
		//Get the Preferences Array from the dictionary
		NSDictionary *settingsDictionary = [NSDictionary dictionaryWithContentsOfFile:plistFile];
		NSArray *preferencesArray = [settingsDictionary objectForKey:@"PreferenceSpecifiers"];
        
		//Loop through the array
		NSDictionary *item;
		for(item in preferencesArray)
		{
			//Get the key of the item.
			NSString *keyValue = [item objectForKey:kPTTAddressBookGroupName];
            
			//Get the default value specified in the plist file.
			id defaultValue = [item objectForKey:@"DefaultValue"];
            
			if (keyValue && defaultValue) {				
				[standardUserDefaults setObject:defaultValue forKey:keyValue];
				if ([keyValue compare:key] == NSOrderedSame)
					val = defaultValue;
			}
		}
		[standardUserDefaults synchronize];
	}
    
	return val;
}

-(NSData *)getLocalSymetricData{

    KeychainItemWrapper *wrapper = [[KeychainItemWrapper alloc] initWithIdentifier:@"Password" accessGroup:nil];
	self.passwordItem = wrapper;
    NSString *password=[self.passwordItem objectForKey:(__bridge_transfer id)kSecValueData];
//    BOOL falseData=YES;
    if ( passwordItem_ && (!password ||!password.length)) {
       
        [self.passwordItem setObject:[self generateRandomStringOfLength:30] forKey:(__bridge id) kSecValueData];
    }
    password=(NSString *)[passwordItem_ objectForKey:(__bridge_transfer id)kSecValueData];
    
    NSString* symmetricString= [NSString stringWithFormat:@"%@%@",password,[self combSmString]];
    
    
        
//    NSData *data=[symmetricString dataUsingEncoding: [NSString defaultCStringEncoding] ];
    
    wrapper=nil;
    return [symmetricString dataUsingEncoding: [NSString defaultCStringEncoding] ];
}

-(NSData *)getSharedSymetricData{
    
    LCYAppSettings *appSettings=[[LCYAppSettings alloc]init];
    
    if (!self.encryption) {
        self.encryption=[[PTTEncryption alloc]init];
    }
    
    
    
    NSMutableData *tokenData =[NSMutableData dataWithData:(NSData *) [self convertStringToData:(NSString *)[appSettings currentSharedTokenString] ]];
    
    
    NSData *tokenHash=[encryption_ getHashBytes:tokenData];
    
    
    NSMutableData *passwordData=[NSMutableData dataWithData:(NSData *)[appSettings passwordData]];
    
    
    unsigned char *aBuffer;
    unsigned len;
    
    
   
       
    
    len = [tokenHash length];
    aBuffer = malloc(len);
    
    [tokenHash getBytes:aBuffer];
    [passwordData appendBytes:aBuffer length:len];

    
    NSData * symetricData=[encryption_ getHashBytes:passwordData];
    
    free(aBuffer);
    
    
    return symetricData;

}

-(NSData *)getOldSharedSymetricData{
    
    LCYAppSettings *appSettings=[[LCYAppSettings alloc]init];
    
    if (!self.encryption) {
        self.encryption=[[PTTEncryption alloc]init];
    }
    
    
    
    NSMutableData *tokenData =[NSMutableData dataWithData:(NSData *) [self convertStringToData:(NSString *)[appSettings oldSharedTokenString] ]];
    
    
    NSData *tokenHash=[encryption_ getHashBytes:tokenData];
    
    
    NSMutableData *passwordData=[NSMutableData dataWithData:(NSData *)[appSettings oldPasswordData]];
    
    
    unsigned char *aBuffer;
    unsigned len;
    
    
       
    len = [tokenHash length];
    aBuffer = malloc(len);
    
    [tokenHash getBytes:aBuffer];
    [passwordData appendBytes:aBuffer length:len];
    
    
    NSData * symetricData=[encryption_ getHashBytes:passwordData];
  
    free(aBuffer);
    
    
    return symetricData;

}






-(BOOL)setupDefaultSymetricData:(BOOL)reset{
    
    if (!encryption_) {
        self.encryption=[[PTTEncryption alloc]init];
    }
  
    
    KeychainItemWrapper *wrapper = [[KeychainItemWrapper alloc] init];
	
//    reset=YES;
    BOOL success=NO;
    
        NSData *passcodeData = [wrapper searchKeychainCopyMatching:K_LOCK_SCREEN_PASSCODE];
        if (!passcodeData) {
       
            success= [wrapper createKeychainValueWithData:[encryption_ getHashBytes:[self convertStringToData: @"o6fjZ4dhvKIUYVmaqnNJIPCBE2"]] forIdentifier:K_LOCK_SCREEN_PASSCODE];
//           passcodeData = [wrapper searchKeychainCopyMatching:@"Passcode"];
            
           
        }
        else if (reset){
           success= [wrapper updateKeychainValueWithData:[encryption_ getHashBytes:[self convertStringToData: @"o6fjZ4dhvKIUYVmaqnNJIPCBE2"]] forIdentifier:K_LOCK_SCREEN_PASSCODE];
        }
        else {
            success=YES;
        }
    
    NSData *tokenData = [wrapper searchKeychainCopyMatching:K_CURRENT_SHARED_TOKEN];
    if (!tokenData&&!reset &&success) {
        
        success= [wrapper createKeychainValueWithData:[self convertStringToData:@"wMbq-zvD2-6p"] forIdentifier:K_CURRENT_SHARED_TOKEN];
        //           passcodeData = [wrapper searchKeychainCopyMatching:@"Passcode"];
        
        
    }
    else if (reset){
        success= [wrapper updateKeychainValueWithData:[self convertStringToData:@"wMbq-zvD2-6p"] forIdentifier:K_CURRENT_SHARED_TOKEN];
    }
    else {
        success=YES;
    }
    NSData *passwordData = [wrapper searchKeychainCopyMatching:K_PASSWORD_CURRENT];
    
    
    if (!passwordData&&!reset&&success) {
        
        success= [wrapper createKeychainValueWithData:[encryption_ getHashBytes:[self convertStringToData: @"o6fjZ4dhvKIUYVmaqnNJIPCBE2"]] forIdentifier:K_PASSWORD_CURRENT];
        //           passcodeData = [wrapper searchKeychainCopyMatching:@"Passcode"];
        
        
    }
    else if (reset){
        success= [wrapper updateKeychainValueWithData:[encryption_ getHashBytes:[self convertStringToData: @"o6fjZ4dhvKIUYVmaqnNJIPCBE2"]] forIdentifier:K_PASSWORD_CURRENT];
    }
    else {
        success=YES;
    }

    
    
    wrapper=nil;
    
    return success;
    

}






+ (NSString *)GetUUID
{
    NSString *gui=[[NSUserDefaults standardUserDefaults] valueForKey:kPTTGloballyUniqueIdentifier];
    CFStringRef string;
    if (!gui ||!gui.length) {
        CFUUIDRef theUUID = CFUUIDCreate(NULL);
        string = CFUUIDCreateString(NULL, theUUID);
        CFRelease(theUUID);
        [[NSUserDefaults standardUserDefaults] setObject:(__bridge NSString *)string forKey:kPTTGloballyUniqueIdentifier];
        
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    else{
        
        return gui;
        
    }
    
    
    return (__bridge_transfer NSString *)string;
}


-(NSString *)generateRandomStringOfLength:(int )length{


    NSString *alphabet  = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXZY0123456789";
    NSMutableString *s = [NSMutableString stringWithCapacity:length];
    for (NSUInteger i = 0U; i < length; i++) {
        u_int32_t r = arc4random() % [alphabet length];
        unichar c = [alphabet characterAtIndex:r];
        [s appendFormat:@"%C", c];
    }
    
    
  
    return s;




}

-(NSString *)generateExposedKey{

   
    NSString *returnStr=[NSString stringWithFormat:@"%f%@",[[NSDate date] timeIntervalSince1970],[self generateRandomStringOfLength:3]];
    
 
    
    return returnStr;
}

-(NSString *)resetDefaultLockKeychainSettingsWithReset:(BOOL)reset{
    
    
    
    NSString *statusMessage=nil;
    
    
    
    KeychainItemWrapper *wrapper = [[KeychainItemWrapper alloc] init];
    //
   
    NSData *pascodeOnData = [wrapper searchKeychainCopyMatching:K_LOCK_SCREEN_PASSCODE_IS_ON];
    if (!pascodeOnData&&!reset) {
        
        [wrapper newSearchDictionary:K_LOCK_SCREEN_PASSCODE_IS_ON];
        [wrapper createKeychainValue:[NSString stringWithFormat:@"%i", NO] forIdentifier:K_LOCK_SCREEN_PASSCODE_IS_ON];
        statusMessage=@"Welcome to PsyTrack Clinician Tools.  Thank you for your purchase.";
        firstRun=YES;
        
    }else if(reset) {
        
        
        
            [wrapper updateKeychainValue:[NSString stringWithFormat:@"%i",NO] forIdentifier:K_LOCK_SCREEN_PASSCODE_IS_ON];
    
        
        
            statusMessage=@"Lock Settings Reset.";
        
    }
    
    
    NSData *tokenData = [wrapper searchKeychainCopyMatching:K_CURRENT_SHARED_TOKEN];
    if (!tokenData) {
        
        [wrapper newSearchDictionary:K_CURRENT_SHARED_TOKEN];
        [wrapper createKeychainValue:[NSString stringWithFormat:@"kd8934ngolKjhv7yknlk"] forIdentifier:K_CURRENT_SHARED_TOKEN];
        
    }else if(reset) {
        
        
        
                [wrapper updateKeychainValue:[NSString stringWithFormat:@"kd8934ngolKjhv7yknlk"] forIdentifier:K_CURRENT_SHARED_TOKEN];
        
        
        
                statusMessage=@"Lock Settings Reset.";
        
    }
    
    
    
    NSData *currentKeyStringData = [wrapper searchKeychainCopyMatching:K_LOCK_SCREEN_CURRENT_KEYSTRING];
    if (!currentKeyStringData) {
        
        [wrapper newSearchDictionary:K_LOCK_SCREEN_CURRENT_KEYSTRING];
        [wrapper createKeychainValue:[self generateExposedKey] forIdentifier:K_LOCK_SCREEN_CURRENT_KEYSTRING];
        
        
    }else if(reset) {
        
        
        
                [wrapper updateKeychainValue:[self generateExposedKey] forIdentifier:K_LOCK_SCREEN_CURRENT_KEYSTRING];
        
        
    }
    
    
    
    
    NSData *lockScreenPassCodeData = [wrapper searchKeychainCopyMatching:K_LOCK_SCREEN_PASSCODE];
    if (!lockScreenPassCodeData) {
        
        [self setupDefaultSymetricData: NO];
        
    }else if(reset) {
        
                [self setupDefaultSymetricData:YES];
    }
    
    
    NSData *lockScreenAttemptData = [wrapper searchKeychainCopyMatching:K_LOCK_SCREEN_ATTEMPT];
    if (!lockScreenAttemptData) {
        
        [wrapper newSearchDictionary:K_LOCK_SCREEN_ATTEMPT];
        [wrapper createKeychainValue:[NSString stringWithFormat:@"%i",0] forIdentifier:K_LOCK_SCREEN_ATTEMPT];
        
        
    }else if(reset) {
                 [wrapper updateKeychainValue:[NSString stringWithFormat:@"%i",0] forIdentifier:K_LOCK_SCREEN_ATTEMPT];
    }
    
    NSData *lockScreenStartupData = [wrapper searchKeychainCopyMatching:K_LOCK_SCREEN_LOCK_AT_STARTUP];
    if (!lockScreenStartupData) {
        
        [wrapper newSearchDictionary:K_LOCK_SCREEN_LOCK_AT_STARTUP];
        [wrapper createKeychainValue:[NSString stringWithFormat:@"%i", NO] forIdentifier:K_LOCK_SCREEN_LOCK_AT_STARTUP];
        
    }else if(reset) {
                [wrapper updateKeychainValue:[NSString stringWithFormat:@"%i",NO] forIdentifier:K_LOCK_SCREEN_LOCK_AT_STARTUP];
    }
    
    NSData *lockScreenTimerOnData = [wrapper searchKeychainCopyMatching:K_LOCK_SCREEN_TIMER_ON];
    if (!lockScreenTimerOnData) {
        
        [wrapper newSearchDictionary:K_LOCK_SCREEN_TIMER_ON];
        [wrapper createKeychainValue:[NSString stringWithFormat:@"%i", NO] forIdentifier:K_LOCK_SCREEN_TIMER_ON];
        
    }else if(reset) {
                [wrapper updateKeychainValue:[NSString stringWithFormat:@"%i",NO] forIdentifier:K_LOCK_SCREEN_TIMER_ON];
    }
    
    
    NSData *lockScreenLockedData = [wrapper searchKeychainCopyMatching:K_LOCK_SCREEN_LOCKED];
    
    if (!lockScreenLockedData) {
        
        [wrapper newSearchDictionary:K_LOCK_SCREEN_LOCKED];
        [wrapper createKeychainValue:[NSString stringWithFormat:@"%i", NO] forIdentifier:K_LOCK_SCREEN_LOCKED];
    }else if(reset) {
                 [wrapper updateKeychainValue:[NSString stringWithFormat:@"%i",NO] forIdentifier:K_LOCK_SCREEN_LOCKED];
        
    } 
//    wrapper=nil;
    return statusMessage;
}


-(NSString *)setupDefaultLockKeychainSettingsWithReset:(BOOL)reset{
    
    
    
    NSString *statusMessage;
    
   
    
    KeychainItemWrapper *wrapper = [[KeychainItemWrapper alloc] init];
//	
    reset=NO;
    NSData *pascodeOnData = [wrapper searchKeychainCopyMatching:K_LOCK_SCREEN_PASSCODE_IS_ON];
    if (!pascodeOnData) {
        
        [wrapper newSearchDictionary:K_LOCK_SCREEN_PASSCODE_IS_ON];
        [wrapper createKeychainValue:[NSString stringWithFormat:@"%i", NO] forIdentifier:K_LOCK_SCREEN_PASSCODE_IS_ON];
      statusMessage=@"Welcome to PsyTrack Clinician Tools.  Thank you for your purchase.";
        
    }
    
    
    if (firstRun) {
        statusMessage=@"Welcome to PsyTrack Clinician Tools.  Thank you for your purchase.";
    }
    
//            
//           [wrapper updateKeychainValue:[NSString stringWithFormat:@"%i",NO] forIdentifier:K_LOCK_SCREEN_PASSCODE_IS_ON];
//       
        
       
//        statusMessage=@"Lock Settings Reset.";
        

    
    
    NSData *tokenData = [wrapper searchKeychainCopyMatching:K_CURRENT_SHARED_TOKEN];
    if (!tokenData) {
        
        [wrapper newSearchDictionary:K_CURRENT_SHARED_TOKEN];
        [wrapper createKeychainValue:[NSString stringWithFormat:@"kd8934ngolKjhv7yknlk"] forIdentifier:K_CURRENT_SHARED_TOKEN];
               
    }else if(reset) {
        
        
        
//        [wrapper updateKeychainValue:[NSString stringWithFormat:@"%i",NO] forIdentifier:K_CURRENT_SHARED_TOKEN];
//        
//        
//        
//        statusMessage=@"Lock Settings Reset.";
        
    }
    
    
    
    NSData *currentKeyStringData = [wrapper searchKeychainCopyMatching:K_LOCK_SCREEN_CURRENT_KEYSTRING];
    if (!currentKeyStringData) {
        
        [wrapper newSearchDictionary:K_LOCK_SCREEN_CURRENT_KEYSTRING];
        [wrapper createKeychainValue:[self generateExposedKey] forIdentifier:K_LOCK_SCREEN_CURRENT_KEYSTRING];
       
        
    }else if(reset) {
        
        
//        
//        [wrapper updateKeychainValue:[self generateExposedKey] forIdentifier:K_LOCK_SCREEN_CURRENT_KEYSTRING];
//        
     
    }

    
    
    
    NSData *lockScreenPassCodeData = [wrapper searchKeychainCopyMatching:K_LOCK_SCREEN_PASSCODE];
    if (!lockScreenPassCodeData) {
        
        [self setupDefaultSymetricData: NO];
        
    }else if(reset) {
    
//        [self setupDefaultSymetricData:YES];
    }

    
    NSData *lockScreenAttemptData = [wrapper searchKeychainCopyMatching:K_LOCK_SCREEN_ATTEMPT];
    if (!lockScreenAttemptData) {
        
        [wrapper newSearchDictionary:K_LOCK_SCREEN_ATTEMPT];
        [wrapper createKeychainValue:[NSString stringWithFormat:@"%i",0] forIdentifier:K_LOCK_SCREEN_ATTEMPT];
        
        
    }else if(reset) {
//         [wrapper updateKeychainValue:[NSString stringWithFormat:@"%i",0] forIdentifier:K_LOCK_SCREEN_ATTEMPT];
    }
    
    NSData *lockScreenStartupData = [wrapper searchKeychainCopyMatching:K_LOCK_SCREEN_LOCK_AT_STARTUP];
    if (!lockScreenStartupData) {
        
        [wrapper newSearchDictionary:K_LOCK_SCREEN_LOCK_AT_STARTUP];
        [wrapper createKeychainValue:[NSString stringWithFormat:@"%i", NO] forIdentifier:K_LOCK_SCREEN_LOCK_AT_STARTUP];
        
    }else if(reset) {
//        [wrapper updateKeychainValue:[NSString stringWithFormat:@"%i",NO] forIdentifier:K_LOCK_SCREEN_LOCK_AT_STARTUP];
    }
    
    NSData *lockScreenTimerOnData = [wrapper searchKeychainCopyMatching:K_LOCK_SCREEN_TIMER_ON];
    if (!lockScreenTimerOnData) {
        
        [wrapper newSearchDictionary:K_LOCK_SCREEN_TIMER_ON];
        [wrapper createKeychainValue:[NSString stringWithFormat:@"%i", NO] forIdentifier:K_LOCK_SCREEN_TIMER_ON];
        
    }else if(reset) {
//        [wrapper updateKeychainValue:[NSString stringWithFormat:@"%i",NO] forIdentifier:K_LOCK_SCREEN_TIMER_ON];
    }
    
    
    NSData *lockScreenLockedData = [wrapper searchKeychainCopyMatching:K_LOCK_SCREEN_LOCKED];
     
    if (!lockScreenLockedData) {
        
        [wrapper newSearchDictionary:K_LOCK_SCREEN_LOCKED];
        [wrapper createKeychainValue:[NSString stringWithFormat:@"%i", NO] forIdentifier:K_LOCK_SCREEN_LOCKED];
    }else if(reset) {
//         [wrapper updateKeychainValue:[NSString stringWithFormat:@"%i",NO] forIdentifier:K_LOCK_SCREEN_LOCKED];
       
    } 
    wrapper=nil;
    return statusMessage;
}

-(void)setupMyInfoRecord{

    if ([self managedObjectContext]) {
    
    NSFetchRequest *myInfoFetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *clinicianEnitityDesc=[NSEntityDescription entityForName:@"ClinicianEntity" inManagedObjectContext:managedObjectContext__];
    
    NSPredicate *myInfoPredicate=[NSPredicate predicateWithFormat:@"myInformation==%@",[NSNumber numberWithBool:YES]];
    
    [myInfoFetchRequest setPredicate:myInfoPredicate];
    [myInfoFetchRequest setEntity:clinicianEnitityDesc];
    
    NSError *myInfoError = nil;
    NSArray *myInfoFetchedObjects = [managedObjectContext__ executeFetchRequest:myInfoFetchRequest error:&myInfoError];
    if (!myInfoFetchedObjects.count) {
        ClinicianEntity *myClinicianInfoObject=[[ClinicianEntity alloc]initWithEntity:clinicianEnitityDesc insertIntoManagedObjectContext:managedObjectContext__];
        
        myClinicianInfoObject.myInformation=[NSNumber numberWithBool:TRUE];
        
        myClinicianInfoObject.firstName=@"Enter Your";
        myClinicianInfoObject.lastName=@"Name Here";
        
    }
    else if (myInfoFetchedObjects.count>1){
        int myInfoFetchedObjectsCount=myInfoFetchedObjects.count;
        for (int i=0;i<myInfoFetchedObjectsCount; i++) {
            ClinicianEntity *myClinicianInfoObject=[myInfoFetchedObjects objectAtIndex:i];
            [myClinicianInfoObject willAccessValueForKey:@"firstName"];
            if ([myClinicianInfoObject.firstName isEqualToString:@"Enter Your"]) {
                if (myInfoFetchedObjectsCount>1) {
                     [managedObjectContext__ deleteObject:myClinicianInfoObject];
                    myInfoFetchedObjectsCount--;
                }
               
            }
            
            
            
        }
        
    }
//        myInfoFetchRequest=nil;
    }






}
-(NSString *)setupLockDictionaryResultStr{

   
    
    
    
    
    
    NSString *statusMessage=[NSString string];
    
    retrievedEncryptedDataFile=NO;
    
    @try {
    
        if (!encryption_) {
           self.encryption=[[PTTEncryption alloc]init];
        }
   
    
        retrievedEncryptedDataFile= [self setupDefaultSymetricData:NO];
      
  
  
        if (!retrievedEncryptedDataFile) {
            statusMessage=@"Unable to load necessary security data";
        }
    
      
                    
       
        
   
 
  
            
            //4
            
            
           
}
    @catch (NSException *exception) {
        
        if (!retrievedEncryptedDataFile) {
            statusMessage=@"Unable to load necessary security settings.";
        }
        
    }
    @finally {

    return statusMessage;


}





}

-(NSData *)encryptDictionaryToData:(NSDictionary *)unencryptedDictionary{


//    if (!encryption_) {
//        self.encryption=[[PTTEncryption alloc]init];
//    }
//    BOOL success=FALSE;
//    NSDictionary *symetricDictionary=[self unwrapAndCreateKeyDataFromKeyEntitywithKeyDate:nil];
//    NSData *symetricData=[self unwrapAndCreateKeyDataFromKeyEntitywithKeyDate:nil];
//    NSData * keyedArchiveData = [NSKeyedArchiver archivedDataWithRootObject:lockValuesDictionary_];
//    
//    NSData *encryptedArchivedLockData =(NSData *)[encryption_ doCipher:keyedArchiveData key:symetricData context:kCCEncrypt padding:(CCOptions *)kCCOptionPKCS7Padding];
//
//
//

    return [NSDictionary dictionary];
}
//-(NSDictionary *)decryptDataToDictionary:(NSData*)encryptedData{}


-(NSDate *)convertDataToDate:(NSData *)data{
    NSDate * restoredDate=nil;
    if (data) {
        restoredDate = [NSKeyedUnarchiver unarchiveObjectWithData:data];

    }

    
    return  restoredDate;
}


-(NSString *)convertDataToString:(NSData *)data{
    
    NSString* newStr;
    if (data.length) {
        newStr = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
    }
    return newStr;




}

-(NSData *)convertStringToData:(NSString *)string{
    
    NSData* data;
    if (string.length) {
       data=[string dataUsingEncoding: NSUTF8StringEncoding ];

    }
    return data;
    
    
    
    
}
#pragma mark -
#pragma mark Encryption Methods

-(NSData *)hashDataFromString:(NSString *)plainString{


    NSData* data=[plainString dataUsingEncoding: [NSString defaultCStringEncoding] ];
    NSData *newData;
    if (data.length>0 &&data.length <25) {
        newData=[encryption_ getHashBytes:data];

    }



    return newData;



}
-(NSDictionary *)encryptStringToEncryptedData:(NSString *)plainTextStr withKeyString:(NSString *)keyStringToSet{
   
    
    
    if ([self isAppLocked]) {
        return nil;
    }
    if (!encryption_) {
        self.encryption=[[PTTEncryption alloc]init];
    }
    KeychainItemWrapper *wrapper = [[KeychainItemWrapper alloc] init];
	
    
    
   NSMutableDictionary *returnDictionary=[NSMutableDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[NSData data], (NSString *)[ self convertDataToString:(NSData *)[wrapper searchKeychainCopyMatching:K_LOCK_SCREEN_CURRENT_KEYSTRING]], nil] forKeys:[NSArray arrayWithObjects:@"encryptedData", @"keyString", nil]]; 
    
    
    NSData *sharedSymetricData = [self getSharedSymetricData];
    
    if (!sharedSymetricData) {
        
            [self displayNotification:@"Unable to retrieve security information from keychain." forDuration:3.0 location:kPTTScreenLocationTop inView:nil];
            return nil;
     
        
    }

    
 
    
    NSData *encryptedData=nil;
    if (plainTextStr.length ) {
        
        
       
        
       
        if(sharedSymetricData.length==32){
            NSData* data=[self convertStringToData:plainTextStr ];
            
            
            
            //            
            
            encryptedData=(NSData *) [encryption_ doCipher:data key:sharedSymetricData context:kCCEncrypt padding:(CCOptions *) kCCOptionPKCS7Padding];
            
            if (encryptedData.length) {
                if ([returnDictionary.allKeys containsObject:@"encryptedData"]) {
                    [returnDictionary setValue:encryptedData forKey:@"encryptedData"];
                }
                [self checkKeyStringInKeyEntity];
            }
            else {
               
            }
            
        }
    }
//    wrapper=nil;
    return [NSDictionary dictionaryWithDictionary:returnDictionary];
    
    
    
    
}

-(NSDictionary *)encryptDataToEncryptedData:(NSData *) unencryptedData withKeyString:(NSString *)keyStringToSet{
    
    
    if ([self isAppLocked]) {
        return nil;
    }
    if (!encryption_) {
        self.encryption=[[PTTEncryption alloc]init];
    }
    KeychainItemWrapper *wrapper = [[KeychainItemWrapper alloc] init];
	
    NSMutableDictionary *returnDictionary=[NSMutableDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[NSData data], (NSString *)[ self convertDataToString:(NSData *)[wrapper searchKeychainCopyMatching:K_LOCK_SCREEN_CURRENT_KEYSTRING]], nil] forKeys:[NSArray arrayWithObjects:@"encryptedData", @"keyString", nil]]; 
    
   
    
    NSData *sharedSymetricData = [self getSharedSymetricData];
    
    if (!sharedSymetricData) {
        
            [self displayNotification:@"Unable to retrieve security information from keychain." forDuration:3.0 location:kPTTScreenLocationTop inView:nil];
            return nil;
        
        
    }
    
    
    
    

    NSData *encryptedData;
  
    if (unencryptedData.length) {
        
                
        if (sharedSymetricData.length==32) {
            encryptedData=(NSData *) [encryption_ doCipher:unencryptedData key:sharedSymetricData context:kCCEncrypt padding:(CCOptions *) kCCOptionPKCS7Padding];
        }
        
        
        
    }
    NSArray *returnDictionaryKeysArray=returnDictionary.allKeys;
    if (encryptedData && encryptedData.length && [returnDictionaryKeysArray containsObject:@"encryptedData"]) {
        
        [returnDictionary setValue:encryptedData forKey:@"encryptedData"];
        [self checkKeyStringInKeyEntity];
        
    }
    wrapper=nil;
    
    return  [NSDictionary dictionaryWithDictionary:returnDictionary];
    
}
-(NSData *)encryptDataToEncryptedData:(NSData *) unencryptedData {
    
    
    if ([self isAppLocked]) {
        return nil;
    }
    if (!encryption_) {
        self.encryption=[[PTTEncryption alloc]init];
    }
   
    
    
    NSData *sharedSymetricData = [self getSharedSymetricData];
    
    if (!sharedSymetricData) {
       
            [self displayNotification:@"Unable to retrieve security information from keychain." forDuration:3.0 location:kPTTScreenLocationTop inView:nil];
            return nil;
  
        
    }
    
    
    
    
    
    NSData *encryptedData=nil;
    
    if (unencryptedData.length) {
        
        
        if (sharedSymetricData.length==32) {
            encryptedData=(NSData *) [encryption_ doCipher:unencryptedData key:sharedSymetricData context:kCCEncrypt padding:(CCOptions *) kCCOptionPKCS7Padding];
        }
        
        
        
    }
       
    
    return  encryptedData;
    
}


-(NSData *)decryptDataToPlainData:(NSData *)encryptedData usingSymetricKey:(NSData *)symetricData{

    
    if ([self isAppLocked]) {
        return nil;
    }
    if (!encryption_) {
        self.encryption=[[PTTEncryption alloc]init];
    }
      
    
    
    NSData *decryptedData=nil;
    if (symetricData.length) {
        
        
   
        if (symetricData.length==32) {
            
            
            decryptedData=(NSData *) [encryption_ doCipher:encryptedData key:symetricData context:kCCDecrypt padding:(CCOptions *) kCCOptionPKCS7Padding];
            
        }
    }
    
    return decryptedData;





}

-(void)checkKeyStringInKeyEntity{
    
    if ([self isAppLocked]) {
        return ;
    }

    if ([self managedObjectContext]) {
  
        if (!encryption_) {
            self.encryption=[[PTTEncryption alloc]init];
        }
        KeychainItemWrapper *wrapper = [[KeychainItemWrapper alloc] init];
       
        NSString *keyString =[self convertDataToString:[wrapper searchKeychainCopyMatching:K_LOCK_SCREEN_CURRENT_KEYSTRING]];
        if (!keyString ) {
            [self setupDefaultLockKeychainSettingsWithReset:NO];
            keyString =[self convertDataToString:[wrapper searchKeychainCopyMatching:K_LOCK_SCREEN_CURRENT_KEYSTRING]];
            if (!keyString && keyString.length) {
                return;
            }
        } 
        NSData *sharedSymetricData=[self getSharedSymetricData];
 
               
       
        
     
       
        
        
        if (!sharedSymetricData) {
            [self setupDefaultSymetricData:NO];
            
                [self displayNotification:@"Unable to retrieve security information from keychain." forDuration:3.0 location:kPTTScreenLocationTop inView:nil];
           
            
        }
        
        
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        NSEntityDescription *keyEntity = [NSEntityDescription entityForName:@"KeyEntity" inManagedObjectContext:managedObjectContext__];
        [fetchRequest setEntity:keyEntity];
        NSPredicate *   keyStringPredicate=[NSPredicate predicateWithFormat:@"keyString MATCHES %@",keyString];
        
        
        [fetchRequest setPredicate: keyStringPredicate];   
        NSError *error = nil;
        NSArray *fetchedObjects = [managedObjectContext__ executeFetchRequest:fetchRequest error:&error];
        //4
        
        
//        fetchRequest=nil;
       
        
        KeyEntity *keyObject=nil;
     
        if (!fetchedObjects.count) 
        {
            
            
           
            
            for (KeyEntity *keyObjectInArray in fetchedObjects) {
                
                [keyObjectInArray willAccessValueForKey:@"keyString"];
                if ([keyObjectInArray.keyString isEqualToString:keyString]) {
                    
                    keyObject=keyObjectInArray;
                    break;
                }
                [keyObjectInArray didAccessValueForKey:@"keyString"];
            }
            
            
            
            NSData *symetricData=nil;
            if(!keyObject){
                
                keyObject=[[KeyEntity alloc]initWithEntity:keyEntity insertIntoManagedObjectContext:managedObjectContext__];
                
                
//                symetricData=  [encryption_ wrapSymmetricKey:sharedSymetricData keyRef:nil useDefaultPublicKey:YES];
             
                symetricData=[ self encryptDataToEncryptedData:sharedSymetricData];
                
                keyObject.dataF=symetricData;
                keyObject.keyString=keyString;
                keyObject.keyDate=[NSDate date];
              
            }
        }
        else {
            keyObject=[fetchedObjects objectAtIndex:0];
            
            [keyObject willAccessValueForKey:@"dataF"];
            if(keyObject &&!keyObject.dataF){
                [keyObject didAccessValueForKey:@"dataF"];
                
//                NSData * symetricData=  [encryption_ wrapSymmetricKey:sharedSymetricData keyRef:nil useDefaultPublicKey:YES];
                
                NSData * symetricData=[self encryptDataToEncryptedData:sharedSymetricData];
                
                [keyObject willChangeValueForKey:@"dataF"];
                keyObject.dataF=symetricData;
                [keyObject didChangeValueForKey:@"dataF"];
                
                [keyObject willChangeValueForKey:@"keyDate"];
                keyObject.keyDate=[NSDate date];
                [keyObject didChangeValueForKey:@"keyDate"];
               
            }
           
            
        
        
        
        }

    }




}

-(NSData *)decryptDataToPlainDataUsingKeyEntityWithString:(NSString *)keyString encryptedData:(NSData *)encryptedData{
    
    
    if ([self isAppLocked]) {
        return nil;
    }
    if (!encryption_) {
        self.encryption=[[PTTEncryption alloc]init];
    }
    KeychainItemWrapper *wrapper = [[KeychainItemWrapper alloc] init];
    NSData *sharedSymetricData = [self getSharedSymetricData];
   
     NSData *decryptedData;

    
    if ([keyString isEqualToString:[self convertDataToString:[wrapper searchKeychainCopyMatching:K_LOCK_SCREEN_CURRENT_KEYSTRING]]]) {
    
           
        if (!sharedSymetricData) {
            [self setupDefaultSymetricData:NO];
            sharedSymetricData = [wrapper searchKeychainCopyMatching:K_LOCK_SCREEN_PASSCODE];
            if (!sharedSymetricData) {
                [self displayNotification:@"Unable to retrieve security information from keychain." forDuration:3.0 location:kPTTScreenLocationTop inView:nil];
                return nil;
            }
            
        }
    
    
    
    
        
       
        if (encryptedData.length ) {
            
            
            
            
            
            if (sharedSymetricData.length==32) {
                
                
                decryptedData=(NSData *) [encryption_ doCipher:encryptedData key:sharedSymetricData context:kCCDecrypt padding:(CCOptions *) kCCOptionPKCS7Padding];
                
            }
        } 
    }
    else if(keyString && keyString.length && [self managedObjectContext])
    {
        
        
         
            NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
            NSEntityDescription *keyEntity = [NSEntityDescription entityForName:@"KeyEntity" inManagedObjectContext:managedObjectContext__];
            [fetchRequest setEntity:keyEntity];
        
        
        NSPredicate *   keyStringPredicate=[NSPredicate predicateWithFormat:@"keyString MATCHES %@",keyString];
        [fetchRequest setPredicate: keyStringPredicate];   
        NSError *error = nil;
            NSArray *fetchedObjects = [managedObjectContext__ executeFetchRequest:fetchRequest error:&error];
            //4
            
            KeyEntity *keyObject=nil;
//            if (fetchedObjects == nil) 
//            {
//                                
//            }
//            //4
            //4
        
            if (fetchedObjects.count) 
            {
                
                
                

                    
                    for (KeyEntity *keyObjectInArray in fetchedObjects) {
                        
                        
                        [keyObjectInArray willAccessValueForKey:@"keyString"];
                        
                        if ([keyObjectInArray.keyString isEqualToString:keyString]) {
                            
                            keyObject=keyObjectInArray;
                            break;
                        }
                        [keyObjectInArray didAccessValueForKey:@"keyString"];
                    }
                    
               
                
                NSData *symetricData=nil;
                if(keyObject)
                {
                    
                    [keyObject willAccessValueForKey:@"dataF"];
                    
                    if (keyObject.dataF) {
                      
                        symetricData =[encryption_ doCipher:keyObject.dataF key:sharedSymetricData context:kCCDecrypt padding:(CCOptions *) kCCOptionPKCS7Padding];
                        
                        
                        DLog(@"symetric data is  %@",symetricData);
                        if (!symetricData||symetricData.length!=32) {
                            symetricData =[encryption_ doCipher:keyObject.dataF key:[self getOldSharedSymetricData] context:kCCDecrypt padding:(CCOptions *) kCCOptionPKCS7Padding];
                        }
//                        if (symetricData) {
//                             symetricData=  [encryption_ unwrapSymmetricKey:keyObject.dataF keyRef:nil useDefaultPrivateKey:YES];
//                        }
                       
                    } 
    
       
                    if (symetricData&&symetricData.length==32) {
                        decryptedData=(NSData *) [encryption_ doCipher:encryptedData key:symetricData context:kCCDecrypt padding:(CCOptions *) kCCOptionPKCS7Padding];
                        
                        
                    }
                    [keyObject didAccessValueForKey:@"dataF"];
            
            
                }
        
            }
      
        

     
    }
        
       
    
    else if(!decryptedData)
    {
      
        NSString *alertText=@"Error 790: Unable to decrypt data";
        
        [self displayNotification:alertText forDuration:3.0 location:kPTTScreenLocationTop  inView:nil];
        
        
    }
        
    
//    wrapper=nil;

    return decryptedData;  
    
}

#pragma mark -
#pragma mark Apple Push Notification Servieces
//-(void)application:(UIApplication*)app didFailtoRegisterForRemoteNotificationsWithError:(NSError*)err{
//    NSString *str = [NSString stringWithFormat:@"Error: %@", err];
//    DLog(@"%@", str);
//}

-(void)application:(UIApplication*)app didReceiveRemoteNotification:(NSDictionary*)userInfo{
    /* If our app is in the background iOS shows our push notification in the notification center.
     If our app is in the foreground it is up to the app to handle it as shown below. */
    
    
    NSDictionary *apsInfo = [userInfo objectForKey:@"aps"];
    NSString *alert = [apsInfo objectForKey:@"alert"];
//    NSString *sound = [apsInfo objectForKey:@"sound"];
    DLog(@"user info is  %@",userInfo);
    [self displayNotification:alert];
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    NSString *badge = [apsInfo objectForKey:@"badge"];
    app.applicationIconBadgeNumber = [badge integerValue];
    
//    UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"" message:alert delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
//    [av show];
  
}

- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
	NSString *appname = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
	NSString *type = @"ios";
	NSString *devToken = [[[[deviceToken description]
        stringByReplacingOccurrencesOfString:@"<"withString:@""]stringByReplacingOccurrencesOfString:@">"
                             withString:@""]stringByReplacingOccurrencesOfString:@" "withString:@""];
	
    NSString *savedDevToken=[[NSUserDefaults standardUserDefaults] valueForKey:@"devtoken"];
	
    if (savedDevToken && deviceToken && [savedDevToken isKindOfClass:[NSString class]]&&![devToken isEqualToString:savedDevToken]) {
        [[NSUserDefaults standardUserDefaults] setValue:deviceToken forKey:@"devtoken"];
        
        NSString *host = @"https://HoT0rJxAX40XqiJZHSVE3J:r7uv5ARVQ76jMNaMSNqO4X@api.appsidekick.com/v1/register_push_device?type=%@&devicetoken=%@&appname=%@";
        
        NSString *urlString = [NSString stringWithFormat:host, type, devToken, appname];
        NSURL *url = [NSURL URLWithString:urlString];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        [request setHTTPMethod:@"POST"];
        DLog(@"url %@",url);
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse *response,
                                                                                                                   NSData *data,
                                                                                                                   NSError *error)
         {
             
             if ([data length] >0 && error == nil)
             {
                 
                 // DO YOUR WORK HERE
                 DLog(@"response received");
//                 NSString *strReply = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//                 DLog(@"%@", strReply);
             }
             else if ([data length] == 0 && error == nil)
             {
                 DLog( @"Nothing was downloaded.");
             }
             else if (error != nil){
                 DLog(@"Error = %@", error);
             }
             
         }];

    }
    
//	NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
//	NSString *strReply = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
//	NSLog(@"%@", strReply);

       
    
//    
	    

}

/*
 * --------------------------------------------------------------------------------------------------------------
 *  BEGIN APNS CODE
 * --------------------------------------------------------------------------------------------------------------
 */

/**
 * Fetch and Format Device Token and Register Important Information to Remote Server
 */
//- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)newDeviceToken{
//#if !TARGET_IPHONE_SIMULATOR
//    
////	// Get Bundle Info for Remote Registration (handy if you have more than one app)
////	NSString *appName = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
////	NSString *appVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
////	
////	// Check what Notifications the user has turned on.  We registered for all three, but they may have manually disabled some or all of them.
////	NSUInteger rntypes = [[UIApplication sharedApplication] enabledRemoteNotificationTypes];
////	
////	// Set the defaults to disabled unless we find otherwise...
////	NSString *pushBadge = (rntypes & UIRemoteNotificationTypeBadge) ? @"enabled" : @"disabled";
////	NSString *pushAlert = (rntypes & UIRemoteNotificationTypeAlert) ? @"enabled" : @"disabled";
////	NSString *pushSound = (rntypes & UIRemoteNotificationTypeSound) ? @"enabled" : @"disabled";	
////	
////	// Get the users Device Model, Display Name, Unique ID, Token & Version Number
////	UIDevice *dev = [UIDevice currentDevice];
////	NSString *deviceUuid = [PTTAppDelegate GetUUID]  ;
////	
////		
////	
////	NSString *deviceName = dev.name;
////	NSString *deviceModel = dev.model;
////	NSString *deviceSystemVersion = dev.systemVersion;
////	
////	// Prepare the Device Token for Registration (remove spaces and < >)
////	NSString *deviceToken = [[[[devToken description] 
////                               stringByReplacingOccurrencesOfString:@"<"withString:@""] 
////                              stringByReplacingOccurrencesOfString:@">" withString:@""] 
////                             stringByReplacingOccurrencesOfString: @" " withString: @""];
////	
////	// Build URL String for Registration
////	// !!! CHANGE "www.mywebsite.com" TO YOUR WEBSITE. Leave out the http://
////	// !!! SAMPLE: "secure.awesomeapp.com"
////	NSString *host = @"www.psytrack.com";
////	
////	// !!! CHANGE "/apns.php?" TO THE PATH TO WHERE apns.php IS INSTALLED 
////	// !!! ( MUST START WITH / AND END WITH ? ). 
////	// !!! SAMPLE: "/path/to/apns.php?"
////	NSString *urlString = [NSString stringWithFormat:@"/apns/apns.php?task=%@&appname=%@&appversion=%@&deviceuid=%@&devicetoken=%@&devicename=%@&devicemodel=%@&deviceversion=%@&pushbadge=%@&pushalert=%@&pushsound=%@", @"register", appName,appVersion, deviceUuid, deviceToken, deviceName, deviceModel, deviceSystemVersion, pushBadge, pushAlert, pushSound];
////	
////	// Register the Device Data
////	// !!! CHANGE "http" TO "https" IF YOU ARE USING HTTPS PROTOCOL
////	NSURL *url = [[NSURL alloc] initWithScheme:@"http" host:host path:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
////    
////    
////    
////    
////    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
////
////   [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:nil];
//
// 
//        // Tell Parse about the device token.
//        [PFPush storeDeviceToken:newDeviceToken];
//        // Subscribe to the global broadcast channel.
//        [PFPush subscribeToChannelInBackground:@"PsyTrack" target:self selector:@selector(subscribeFinished:error:)];
// 
//    
//	
//#endif
//}
//
///**
// * Failed to Register for Remote Notifications
// */
//- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
//    if (error.code == 3010) {
//        NSLog(@"Push notifications are not supported in the iOS Simulator.");
//    } else {
//        // show some alert or otherwise handle the failure to register.
//        [self displayNotification:@"Unable to register for remote notifications at this time."];
//	}
//}
///**
// * Remote Notification Received while application was open.
// */
//- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
//	
//#if !TARGET_IPHONE_SIMULATOR
//    
//	
////	NSDictionary *apsInfo = [userInfo objectForKey:@"aps"];
////	
////	NSString *alert = [apsInfo objectForKey:@"alert"];
////	[self displayNotification:alert];
////	
//////	NSString *sound = [apsInfo objectForKey:@"sound"];
////    
////	AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
////	
////	NSString *badge = [apsInfo objectForKey:@"badge"];
////	
////	application.applicationIconBadgeNumber = [badge integerValue];
//
//
//   
//
//    [PFPush handlePush:userInfo];
//
//       
//    
//    
//#endif
//}
//
//- (void)subscribeFinished:(NSNumber *)result error:(NSError *)error {
//    
//#ifdef DEBUG
//    if ([result boolValue]) {
//        NSLog(@"PsyTrack successfully subscribed to push notifications on the PsyTrack channel.");
//    } else {
//        NSLog(@"PsyTrack failed to subscribe to push notifications on the PsyTrack channel.");
//    }
//#endif
//}
///* 
// * --------------------------------------------------------------------------------------------------------------
// *  END APNS CODE 
// * --------------------------------------------------------------------------------------------------------------
// */
//

#pragma mark -
#pragma mark change statusbar orientation psytrack image move
- (void) application:(UIApplication *)application
willChangeStatusBarOrientation:(UIInterfaceOrientation)newStatusBarOrientation
            duration:(NSTimeInterval)duration
{

    if (newStatusBarOrientation == UIInterfaceOrientationPortrait){
       

        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        
            self.viewController.transform      = CGAffineTransformIdentity;
            
            CGRect frame= CGRectMake(self.window.frame.size.width/2 - self.viewController.frame.size.width/2,self.window.frame.size.height/2-self.viewController.frame.size.height/2, self.viewController.frame.size.width, self.viewController.frame.size.height);
            
            
            //                        [UIView animateWithDuration:secs delay:0.0 options:option
            //                                         animations:^{
            //                                             self.view.frame = CGRectMake(destination.x,destination.y, self.view.frame.size.width, self.view.frame.size.height);
            //                                         }
            //                                         completion:^(BOOL finished){
            //                                             [self startFadeout];
            //                                         }];
            
            
            self.viewController.frame      =frame;
            
        
        }
        else
        {
        self.imageView.transform      = CGAffineTransformIdentity;
        self.psyTrackLabel.transform = CGAffineTransformIdentity;
     
        self.clinicianToolsLabel.transform      = CGAffineTransformIdentity;
        self.developedByLabel.transform        = CGAffineTransformIdentity;
       
        
        }
    }        
    else if (newStatusBarOrientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        

        
        
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        
            //ipad upside down
           self.viewController.transform       = CGAffineTransformMakeRotation(-M_PI);
           
            CGRect frame= CGRectMake(self.window.frame.size.width/2 - self.viewController.frame.size.width/2,self.window.frame.size.height/2-self.viewController.frame.size.height/2, self.viewController.frame.size.width, self.viewController.frame.size.height);
            
            
            //                        [UIView animateWithDuration:secs delay:0.0 options:option
            //                                         animations:^{
            //                                             self.view.frame = CGRectMake(destination.x,destination.y, self.view.frame.size.width, self.view.frame.size.height);
            //                                         }
            //                                         completion:^(BOOL finished){
            //                                             [self startFadeout];
            //                                         }];
            
            
            self.viewController.frame      =frame;

            
            
//            self.viewController.view.transform     = CGAffineTransformTranslate(self.viewController.view.transform,0,((-self.window.frame.size.height/2)+self.viewController.view.frame.size.height)/2);
        
        
       
        } else {
            self.imageView.transform      = CGAffineTransformMakeRotation(-M_PI);
        self.psyTrackLabel.transform      = CGAffineTransformMakeRotation(M_PI);
         self.clinicianToolsLabel.transform      = CGAffineTransformMakeRotation(M_PI);
         self.developedByLabel.transform      = CGAffineTransformMakeRotation(M_PI);
        //iPhone upside down
            if ([SCUtilities systemVersion]<6) {
                self.imageView.transform      = CGAffineTransformTranslate(self.psyTrackLabel.transform,0,75);
                
                self.psyTrackLabel.transform      = CGAffineTransformTranslate(self.psyTrackLabel.transform,0,-130);
                
                
                self.developedByLabel.transform      = CGAffineTransformTranslate(self.developedByLabel.transform,0,340);
                self.clinicianToolsLabel.transform      = CGAffineTransformTranslate(self.clinicianToolsLabel.transform,0,280);
                
                
            }
            else{
            
                
            
            
            }
            
        }
        
    }
    else if (UIInterfaceOrientationIsLandscape(newStatusBarOrientation))
    { 
       
        
            if (newStatusBarOrientation == UIInterfaceOrientationLandscapeLeft) 
            {
                
          
                float rotate    = ((newStatusBarOrientation == UIInterfaceOrientationLandscapeLeft) ? -1:1) * (M_PI / 2.0);
                           
                
                
                if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
                    self.viewController.transform      = CGAffineTransformMakeRotation(rotate);

                   
                    
                    
                    if ([[self.tabBarController.selectedViewController class] isSubclassOfClass:[UISplitViewController class]]) {
                    
                 
                        
                        
                        
                        CGRect frame= CGRectMake(((self.window.frame.size.width-self.tabBarController.tabBar.frame.size.height)/2)-self.tabBarController.tabBar.frame.size.height- self.viewController.frame.size.height/2,(self.window.frame.size.height/2-self.viewController.frame.size.height/2)-160, self.viewController.frame.size.width, self.viewController.frame.size.height);     
                        
                        
//                        [UIView animateWithDuration:secs delay:0.0 options:option
//                                         animations:^{
//                                             self.view.frame = CGRectMake(destination.x,destination.y, self.view.frame.size.width, self.view.frame.size.height);
//                                         }
//                                         completion:^(BOOL finished){
//                                             [self startFadeout];
//                                         }];

                        
                        self.viewController.frame      =frame;
                   
                        
                        
                                        
                    } else
                        
                    {
//                        self.viewController.view.transform      = CGAffineTransformTranslate(self.viewController.view.transform,-130 , -140);
                        
                        
                        
                           CGRect frame= CGRectMake(((self.window.frame.size.width-self.tabBarController.tabBar.frame.size.height)/2)-self.tabBarController.tabBar.frame.size.height- self.viewController.frame.size.height/2,(self.window.frame.size.height/2-self.viewController.frame.size.height/2), self.viewController.frame.size.width, self.viewController.frame.size.height); 
                      
                        self.viewController.frame     =frame;

                        
                        
                    
                    }
                    
                   
                    
                    
                } 
                else
                {
                   
                    //iphone left
                    self.imageView.transform      = CGAffineTransformMakeRotation(rotate);
                self.psyTrackLabel.transform =CGAffineTransformMakeRotation(rotate);
                 self.clinicianToolsLabel.transform =CGAffineTransformMakeRotation(rotate);
                self.developedByLabel.transform =CGAffineTransformMakeRotation(rotate);                    
                    
                    self.imageView.transform      = CGAffineTransformTranslate(self.imageView.transform, 38, 0);
                  
                    
                    self.psyTrackLabel.transform      = CGAffineTransformTranslate(self.psyTrackLabel.transform,-64 , -99);
                    
                    
                    self.clinicianToolsLabel.transform      = CGAffineTransformTranslate(self.clinicianToolsLabel.transform,135,98);
                    self.developedByLabel.transform      = CGAffineTransformTranslate(self.developedByLabel.transform,240, 74);

                    
                  
                    
                                       

                }
            }
            if (newStatusBarOrientation == UIInterfaceOrientationLandscapeRight) 
            {
            
                float rotate    = ((newStatusBarOrientation == UIInterfaceOrientationLandscapeRight) ? 1:1) * (M_PI / 2.0);
                
                                
                if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) 
               {
                 self.viewController.transform      = CGAffineTransformMakeRotation(rotate);
                   
                   if ([self.tabBarController.selectedViewController class]==[UISplitViewController class]) 
                   {
                   
//                       UISplitViewController *splitViewController=(UISplitViewController*) self.tabBarController.selectedViewController;
                       
                       
                       
                      
                       
                          
                        CGRect frame= CGRectMake(((self.window.frame.size.width-self.tabBarController.tabBar.frame.size.height)/2)-self.tabBarController.tabBar.frame.size.height- self.viewController.frame.size.height/2,(self.window.frame.size.height/2-self.viewController.frame.size.height/2)+160, self.viewController.frame.size.width, self.viewController.frame.size.height);                           
                       
                       
                       //                        [UIView animateWithDuration:secs delay:0.0 options:option
                       //                                         animations:^{
                       //                                             self.view.frame = CGRectMake(destination.x,destination.y, self.view.frame.size.width, self.view.frame.size.height);
                       //                                         }
                       //                                         completion:^(BOOL finished){
                       //                                             [self startFadeout];
                       //                                         }];
                       
                       
                       self.viewController.frame      =frame;
                       
                       
//                   self.viewController.view.transform      = CGAffineTransformTranslate(self.viewController.view.transform, 140, self.imageView.frame.origin.x);
                 
                  
                   
                   } 
                   else
                       
                   {
                       
                       
//                       self.viewController.view.transform     = CGAffineTransformTranslate(self.viewController.view.transform,130 , -140);
                       
                      
                       
                     
                           CGRect frame= CGRectMake(((self.window.frame.size.width-self.tabBarController.tabBar.frame.size.height)/2)-self.tabBarController.tabBar.frame.size.height- self.viewController.frame.size.height/2,(self.window.frame.size.height/2-self.viewController.frame.size.height/2), self.viewController.frame.size.width, self.viewController.frame.size.height);                      
                        self.viewController.frame      =frame;
                       
                   }
                   
                   
                   
                   
                   
                   
                   
                   
                   
                   
                   
               }
               else
               {
                   self.imageView.transform      = CGAffineTransformMakeRotation(rotate);
                self.psyTrackLabel.transform      = CGAffineTransformMakeRotation(rotate);
                
                self.clinicianToolsLabel.transform      = CGAffineTransformMakeRotation(rotate);
                self.developedByLabel.transform     = CGAffineTransformMakeRotation(rotate);
                   //iphone right
                   
                   self.imageView.transform      = CGAffineTransformTranslate(self.imageView.transform,-38, 0);
                   
                   self.psyTrackLabel.transform      = CGAffineTransformTranslate(self.psyTrackLabel.transform, 64, -99);
                   self.clinicianToolsLabel.transform      = CGAffineTransformTranslate(self.clinicianToolsLabel.transform,-135,98);
                   
                   self.developedByLabel.transform =CGAffineTransformTranslate(self.clinicianToolsLabel.transform,30,-30);

//                   //clinicians view controller total clinicians label transform

         
                   
                                     
               }
            }
       

    } 
       
}











-(void)tabBarController:(UITabBarController *)tabBarControllerSelected didSelectViewController:(UIViewController *)viewController{

   
//[self application:[UIApplication sharedApplication]
//willChangeStatusBarOrientation:[[UIApplication sharedApplication] statusBarOrientation]
//    duration:5];
//    [viewController reloadInputViews];
//    
//    
    [self application:(UIApplication *)[UIApplication sharedApplication]
willChangeStatusBarOrientation:(UIInterfaceOrientation)[[UIDevice currentDevice] orientation]
duration:(NSTimeInterval)1.0];
    if ([managedObjectContext__ hasChanges] ) {
        
   
   if ([[UIDevice currentDevice] userInterfaceIdiom] != UIUserInterfaceIdiomPad) {
       switch (tabBarControllerSelected.selectedIndex) {
           case 0:
               if (clinicianViewController ) {
                
                   [clinicianViewController.tableViewModel reloadBoundValues];
                   [clinicianViewController.tableView reloadData];
                   [clinicianViewController updateClinicianTotalLabel];
               }

               break;
           case 1:
               if (clientsViewController_iPhone ) {
                  
                      
                   [clientsViewController_iPhone.tableViewModel reloadBoundValues];
                   [clientsViewController_iPhone updateClientsTotalLabel];
               }

               break;
           case 2:
               if (trainTrackViewController ) {
                 
//                   [trainTrackViewController.tableModel reloadBoundValues];
//                   [trainTrackViewController tableViewModel:(SCTableViewModel *)[trainTrackViewController tableModel] didAddSectionAtIndex:(NSInteger)0];
                   
               }
               break;
           default:
               break;
       }
       
              
       
   }
   else
   {
       
       switch (tabBarControllerSelected.selectedIndex) {
           case 0:
//               if (cliniciansRootViewController_iPad) {
//                   if ([managedObjectContext__ hasChanges]) 
//                       [self saveContext];
//                   
//                   [cliniciansRootViewController_iPad.tableModel reloadBoundValues];
//                   [cliniciansRootViewController_iPad.tableView reloadData];
//                   //           [clinicianViewController updateClinicianTotalLabel];
//               }
//               
               break;
           case 1:
//               if (clientsRootViewController_iPad) {
//                if ([managedObjectContext__ hasChanges]) 
//                   [self saveContext];
//                   //       
//                   //      
//                   [clientsRootViewController_iPad.tableViewModel.masterModel reloadBoundValues];
//                   [clientsRootViewController_iPad.tableViewModel.masterModel.modeledTableView reloadData];
//                   
//                   //           [clientsRootViewController_iPad updateClientsTotalLabel];
//               }
               break;
               
           case 2:
//               if (trainTrackViewController ) {
//                if ([managedObjectContext__ hasChanges]) 
//                 
//                  
//                   
//                  
////                   [trainTrackViewController tableViewModel:(SCTableViewModel *)[trainTrackViewController tableModel] didAddSectionAtIndex:(NSInteger)0];
//                   
//               }
               break;
               
    
           default:
               break;
       }
       
       
      

   }     
    }
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
    [self saveContext];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
    application.applicationIconBadgeNumber = 0;
    
}


-(void)displayMemoryWarning{


    
  
//    if (!self.drugViewControllerIsInDetailSubview) {
//  
//    NSFileManager *fileManager=[[NSFileManager alloc]init];
//    NSError *error=nil;
//        float freeSpace = 0.0f;
//        float totalSpace=0.0f;
//        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//        NSDictionary *dictionary = [[NSFileManager defaultManager] attributesOfFileSystemForPath:[paths lastObject] error: &error];
//        
//        
//        if (dictionary) {
//            NSNumber *fileSystemFreeSizeInBytes = [dictionary objectForKey: NSFileSystemFreeSize];
//            freeSpace = [fileSystemFreeSizeInBytes floatValue];
//        } else { 
//            //Handle error
//        }
//       
//        if (dictionary) {
//            NSNumber *fileSystemTotalSizeInBytes = [dictionary objectForKey: NSFileSystemSize];
//            totalSpace = [fileSystemTotalSizeInBytes floatValue];
//        } else {
//            //Handle error
//        }
//
//        float percentageFreeSpace=freeSpace/totalSpace *100;
//        
//
//        if(percentageFreeSpace <7.0 ){
//            if ( __drugsPersistentStoreCoordinator&&__drugsPersistentStoreCoordinator.persistentStores.count) {
//              
//                NSPersistentStore *drugsPersisstentStore=[__drugsPersistentStoreCoordinator.persistentStores objectAtIndex:0];
//                
//                [__drugsPersistentStoreCoordinator removePersistentStore:drugsPersisstentStore  error:nil];
//                
//                __drugsPersistentStoreCoordinator=nil;
//                __drugsManagedObjectContext=nil;
//                __drugsManagedObjectModel=nil;
//            }
//        [ fileManager removeItemAtURL:[self applicationDrugsFileURL] error:&error];
//        }
//    }
//    
    [self saveContext];




}
- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

-(void)saveContext
{
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    if (managedObjectContext != nil &&persistentStoreCoordinator__!=nil)
    {
    [managedObjectContext__ performBlock:^{
        if ( managedObjectContext__.hasChanges ) {
            NSUInteger attempts = 0;
            NSError *error = nil;
            while ( ![managedObjectContext__ save:&error] && ++attempts <= kPTTMaximumSaveAttempts ) {
                [self repairForSaveError:error];
            }
            
            if ( attempts > kPTTMaximumSaveAttempts ) {
                NSString *question = NSLocalizedString(@"A problem arose. Could not save changes.", @"Save fail \n");
                NSString *info = NSLocalizedString(@"You should quit as soon as possible, "
                                                   @"because continuing could cause other problems.", @"");
                [self displayNotification:[question stringByAppendingFormat:@"\n %@",info]  forDuration:7.0 location:kPTTScreenLocationMiddle inView:self.window];
            }
        }
    }];
    }
}


-(void)repairForSaveError:(NSError *)error
{
    [managedObjectContext__ processPendingChanges];
    [managedObjectContext__.undoManager disableUndoRegistration];
    
    if ( error.code != NSValidationMultipleErrorsError ) {
        NSObject *object = [error.userInfo objectForKey:@"NSValidationErrorObject"];
        
        if ([object.class isSubclassOfClass:[PTManagedObject class]]){
        
            PTManagedObject *ptManagedObject=(PTManagedObject*)object;
            [ptManagedObject repairForError:error];
        
        
        
        }
        
    }
    else {
        NSArray *detailedErrors = [[error userInfo] objectForKey:NSDetailedErrorsKey];
        for ( NSError *error in detailedErrors ) {
            NSDictionary *detailedInfo = error.userInfo;
            id object = [detailedInfo objectForKey:@"NSValidationErrorObject"];
            [object repairForError:error];
        }
    }
    
    [managedObjectContext__ processPendingChanges];
    [managedObjectContext__.undoManager enableUndoRegistration];
}


- (void)saveDrugsContext
{
    NSError *error = nil;
    NSManagedObjectContext *drugsManagedObjectContext = self.drugsManagedObjectContext;
    if (drugsManagedObjectContext != nil)
    {
        if ([drugsManagedObjectContext hasChanges] && ![drugsManagedObjectContext save:&error])
        {
            /*
             Replace this implementation with code to handle the error appropriately.
             
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
             */
            
        [self displayNotification:@"Error Saving Drug Store"];
    }
        else
        {
        
            
        
        }
    }
}
#pragma mark - Core Data stack

/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
//- (NSManagedObjectContext *)managedObjectContext
//{
//    if (__managedObjectContext != nil)
//    {
//        return __managedObjectContext;
//    }
//    
//    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
//    if (coordinator != nil)
//    {
//        __managedObjectContext = [[NSManagedObjectContext alloc] init];
//        [__managedObjectContext setPersistentStoreCoordinator:coordinator];
//        
//    }
//    return __managedObjectContext;
//}
/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */

-(void)resetDrugsModel{

    __drugsManagedObjectModel=nil;
    __drugsManagedObjectContext=nil;
    __drugsPersistentStoreCoordinator=nil;
    
}

- (NSManagedObjectContext *)drugsManagedObjectContext
{
    if (__drugsManagedObjectContext != nil)
    {
        return __drugsManagedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self drugsPersistentStoreCoordinator];
    if (coordinator != nil)
    {
        __drugsManagedObjectContext = [[NSManagedObjectContext alloc] init];
        [__drugsManagedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    
  
    return __drugsManagedObjectContext;
}

/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created from the application's model.
 */
//- (NSManagedObjectModel *)managedObjectModel
//{
//    if (__managedObjectModel != nil)
//    {
//        return __managedObjectModel;
//    }
//    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"psyTrack" withExtension:@"momd"];
//    __managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
//    return __managedObjectModel;
//}


/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created from the application's model.
 */
- (NSManagedObjectModel *)drugsManagedObjectModel
{
    if (__drugsManagedObjectModel != nil)
    {
        return __drugsManagedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"drugs" withExtension:@"momd"];
    __drugsManagedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    

    return __drugsManagedObjectModel;
}



/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
//- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
//{
//    if (__persistentStoreCoordinator != nil)
//    {
//        return __persistentStoreCoordinator;
//    }
//    
//    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"psyTrack.sqlite"];
//    
//    NSError *error = nil;
//    
//   
//    
//    
//    
//
//
//    
//    __persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
//    if (![__persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:@"main" URL:storeURL options:nil error:&error])
//    {
//        /*
//         Replace this implementation with code to handle the error appropriately.
//         
//         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
//         
//         Typical reasons for an error here include:
//         * The persistent store is not accessible;
//         * The schema for the persistent store is incompatible with current managed object model.
//         Check the error message to determine what the actual problem was.
//         
//         
//         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
//         
//         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
//         * Simply deleting the existing store:
//         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
//         
//         * Performing automatic lightweight migration by passing the following dictionary as the options parameter: 
//         [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
//         
//         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
//         
//         */
//        
//        abort();
//    }   
//    
//    
//          //add the drug data
//    
//   
//    
//    return __persistentStoreCoordinator;
//}
/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)drugsPersistentStoreCoordinator
{
    if (__drugsPersistentStoreCoordinator != nil)
    {
        return __drugsPersistentStoreCoordinator;
    }
    
    BOOL addDrugData=TRUE;
    
    if (addDrugData) {
        
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            NSString *drugsDatabase = [[self applicationDrugsPathString]stringByAppendingPathComponent:@"drugs.sqlite"];
            
            
            NSFileManager *fileManager = [NSFileManager defaultManager];
            
//            NSUndoManager *undoManager=[[NSUndoManager alloc]init];
//            undoManager=(NSUndoManager *)__drugsManagedObjectContext.undoManager;
//            [__drugsManagedObjectContext setUndoManager:nil];
            // If the expected store doesn't exist, copy the default store.
            
            if (![fileManager fileExistsAtPath:drugsDatabase]) {
                NSString *drugTextDocPath = [[NSBundle mainBundle] pathForResource:@"drugs" ofType:@"sqlite"];
                
                if (drugTextDocPath) {
                    
                    [fileManager copyItemAtPath:drugTextDocPath toPath:drugsDatabase error:NULL];
                     
                    
                }
                
            }
   
//        if ([fileManager fileExistsAtPath:drugsDatabase]) {
                    NSError *drugError = nil;
                    NSURL *drugsStoreURL = [[self applicationDrugsDirectory] URLByAppendingPathComponent:@"drugs.sqlite"];
                    __drugsPersistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self drugsManagedObjectModel]];
                    if (![__drugsPersistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:@"DrugsConfig" URL:drugsStoreURL options:nil error:&drugError])
                    {
                        /*
                         Replace this implementation with code to handle the error appropriately.
                         
                         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
                         
                         Typical reasons for an error here include:
                         * The persistent store is not accessible;
                         * The schema for the persistent store is incompatible with current managed object model.
                         Check the error message to determine what the actual problem was.
                         
                         
                         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
                         
                         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
                         * Simply deleting the existing store:
                         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
                         
                         * Performing automatic lightweight migration by passing the following dictionary as the options parameter: 
                         [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
                         
                         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
                         
                         */
                        
        
                    }   
                   
                  
                    
                
    }
    
     return __drugsPersistentStoreCoordinator;
}


-(void)resetDisordersModel{
    
    __disordersManagedObjectModel=nil;
    __disordersManagedObjectContext=nil;
    __disordersPersistentStoreCoordinator=nil;
    
}

- (NSManagedObjectContext *)disordersManagedObjectContext
{
    if (__disordersManagedObjectContext != nil)
    {
        return __disordersManagedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self disordersPersistentStoreCoordinator];
    if (coordinator != nil)
    {
        __disordersManagedObjectContext = [[NSManagedObjectContext alloc] init];
        [__disordersManagedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    
    
    return __disordersManagedObjectContext;
}


/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created from the application's model.
 */
- (NSManagedObjectModel *)disordersManagedObjectModel
{
    if (__disordersManagedObjectModel != nil)
    {
        return __disordersManagedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"disorders" withExtension:@"momd"];
    __disordersManagedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    
    
    return __disordersManagedObjectModel;
}

- (NSPersistentStoreCoordinator *)disorderPersistentStoreCoordinator
{
    if (__disordersPersistentStoreCoordinator != nil)
    {
        return __disordersPersistentStoreCoordinator;
    }
    
   
    
  
        
        //        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        
        //        if ([fileManager fileExistsAtPath:drugsDatabase]) {
        NSError *disorderError = nil;
        NSURL *disordersStoreURL = [[self applicationDrugsDirectory] URLByAppendingPathComponent:@"disorders.sqlite"];
        __disordersPersistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self disordersManagedObjectModel]];
        if (![__disordersPersistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:@"disordersConfig" URL:disordersStoreURL options:nil error:&disorderError])
        {
            /*
             Replace this implementation with code to handle the error appropriately.
             
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
             
             Typical reasons for an error here include:
             * The persistent store is not accessible;
             * The schema for the persistent store is incompatible with current managed object model.
             Check the error message to determine what the actual problem was.
             
             
             If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
             
             If you encounter schema incompatibility errors during development, you can reduce their frequency by:
             * Simply deleting the existing store:
             [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
             
             * Performing automatic lightweight migration by passing the following dictionary as the options parameter: 
             [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
             
             Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
             
             */
                    }
        else 
        {
            
            
            
        }    
        
        
        
  
    
    return __disordersPersistentStoreCoordinator;
}
-(NSString *)combSmString{

    NSString *addStr=[NSString stringWithFormat:@"%@",addSmtricStr];


   
        int firstCharacter=[addStr characterAtIndex:0];
        int fifthCharacter=[addStr characterAtIndex:4];
        
        
        
        NSString *firstNumberString=[NSString stringWithFormat:@"%i",firstCharacter]; 
        NSString *secondNumberString=[NSString stringWithFormat:@"%i",fifthCharacter]; 
        
        NSString *subStringOne;
        NSString *subStringTwo;
        int subIntOne;
        int subIntTwo;
        if (firstNumberString.length &&secondNumberString.length) {
            subStringOne=[firstNumberString substringFromIndex:firstNumberString.length-1];
            subIntOne=(int)[(NSString *)subStringOne intValue];
            
            
            
            subStringTwo=[secondNumberString substringFromIndex:secondNumberString.length-1];
            subIntTwo=(int)[(NSString *)subStringTwo intValue];
            
            int newInt=subIntOne+subIntTwo*addSmNr;
            
            NSString *newIntStringValue=[NSString stringWithFormat:@"%i",newInt];
            
            NSRange range;
            range.length=2;
            range.location=1;
            addStr=[newIntStringValue substringWithRange:range];
                        
            
        }
        
    return addStr;
    
}


#pragma mark - Application's Directories

/**
 Returns the URL to the application's Documents directory.
 */
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}
- (NSURL *)applicationCachesDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSCachesDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSURL *)applicationDrugsDirectory
{
    NSFileManager *fileManager=[[NSFileManager alloc]init];
    NSString *dirToCreate = [NSString stringWithFormat:@"%@/drugDatabase.nosync",[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject]];
    BOOL isDir=YES;
    NSError *error=[[NSError alloc]init];
    if(![fileManager fileExistsAtPath:dirToCreate isDirectory:&isDir])
        [fileManager createDirectoryAtPath:dirToCreate withIntermediateDirectories:YES attributes:nil error:&error];
            

    
    
    NSURL *drugUrl=[NSURL fileURLWithPath:dirToCreate isDirectory:YES];
    
    fileManager=nil;
    
    return drugUrl;
}

- (NSURL *)applicationDisordersDirectory
{
    NSFileManager *fileManager=[[NSFileManager alloc]init];
    NSString *dirToCreate = [NSString stringWithFormat:@"%@/disorderDatabase",[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject]];
    BOOL isDir=YES;
    NSError *error=[[NSError alloc]init];
    if(![fileManager fileExistsAtPath:dirToCreate isDirectory:&isDir])
        [fileManager createDirectoryAtPath:dirToCreate withIntermediateDirectories:YES attributes:nil error:&error];
            
    
    
    
    NSURL *disorderUrl=[NSURL fileURLWithPath:dirToCreate isDirectory:YES];
    fileManager=nil;
    
    
    return disorderUrl;
}


- (NSURL *)applicationPTTDirectory
{
    NSFileManager *fileManager=[[NSFileManager alloc]init];
    NSString *dirToCreate = [NSString stringWithFormat:@"%@/pttDatabase.nosync",[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject]];
    BOOL isDir=YES;
    NSError *error=[[NSError alloc]init];
    if(![fileManager fileExistsAtPath:dirToCreate isDirectory:&isDir])
        [fileManager createDirectoryAtPath:dirToCreate withIntermediateDirectories:YES attributes:nil error:&error];
            
    
    
    
    NSURL *pttDatabaseUrl=[NSURL fileURLWithPath:dirToCreate isDirectory:YES];
    
    fileManager=nil;
    
    return pttDatabaseUrl;
}
- (NSURL *)applicationPTFileDirectory
{
    NSFileManager *fileManager=[[NSFileManager alloc]init];
    NSString *dirToCreate = [NSString stringWithFormat:@"%@/ptFile.nosync",[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject]];
    BOOL isDir=YES;
    NSError *error=[[NSError alloc]init];
    if(![fileManager fileExistsAtPath:dirToCreate isDirectory:&isDir])
        [fileManager createDirectoryAtPath:dirToCreate withIntermediateDirectories:YES attributes:nil error:&error];
    
    
    
    
    NSURL *pttDatabaseUrl=[NSURL fileURLWithPath:dirToCreate isDirectory:YES];
    
    fileManager=nil;
    
    return pttDatabaseUrl;
}

- (NSString *)applicationDocumentsDirectoryString {
	return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

-(NSString *)applicationDrugsPathString{

return [self applicationDrugsDirectory].path;

}

-(NSURL *)applicationDrugsFileURL{
    
    return [[self applicationDrugsDirectory] URLByAppendingPathComponent:@"drugs.sqlite"];
    
}


-(NSURL *)applicationSupportURL{

    NSFileManager* fm = [[NSFileManager alloc] init];
    // ...
    NSError* err = nil;
    
    
    NSURL* suppurl = [fm URLForDirectory:NSApplicationSupportDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:YES error:&err];

    fm=nil;
    return suppurl;

}

-(NSString *)applicationSupportPath{

    return (NSString *)[[self applicationSupportURL] path];


}

//-(NSString *)settingPlistPathString{
//
//
//
//return (NSString *)[(NSString *)[self applicationDocumentsDirectoryString] stringByAppendingPathComponent:@"settings.plist"];
//
//}
//
//-(NSDictionary *)settingsPlistDictionary{
//NSFileManager *fileManager=[[NSFileManager alloc]init];
//    NSString *plistPath = [self settingPlistPathString];
//if (![fileManager fileExistsAtPath: plistPath])
//{
//    NSError *error;
//    
//    NSString *settingsInBundle = [[NSBundle mainBundle] pathForResource:@"settings" ofType:@"plist"];
//    if (settingsInBundle){
//        [fileManager copyItemAtPath:settingsInBundle toPath:plistPath error:&error];
//        
//    }
//    else {
//        NSDictionary *settingsDictionary=[[NSDictionary alloc]initWithObjects:[NSArray arrayWithObjects:@"Client Schedule",@"",@"My Clinic", nil] forKeys:[NSArray arrayWithObjects:@"calendarName",@"calendarIdentifier",@"calendarLocation", nil]];
//        
//        [settingsDictionary writeToFile:plistPath atomically: YES];
//
//    }
//    
//    
//}
//    
//    return [[NSDictionary alloc]initWithContentsOfFile:plistPath];;
//}

#pragma mark -
#pragma mark iCloud initialize
- (void)initializeiCloudAccess {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        if ([[NSFileManager defaultManager]
             URLForUbiquityContainerIdentifier:nil] != nil){
            
        }
       
            
    });
}

//
//#pragma mark - Core Data stack
////begin icloud paste
#pragma mark -
#pragma mark Core Data stack

// this takes the NSPersistentStoreDidImportUbiquitousContentChangesNotification
// and transforms the userInfo dictionary into something that
// -[NSManagedObjectContext mergeChangesFromContextDidSaveNotification:] can consume
// then it posts a custom notification to let detail views know they might want to refresh.
// The main list view doesn't need that custom notification because the NSFetchedResultsController is
// already listening directly to the NSManagedObjectContext
- (void)mergeiCloudChanges:(NSNotification*)note forContext:(NSManagedObjectContext*)moc {
   
        [moc mergeChangesFromContextDidSaveNotification:note];
        [self displayNotification:@"Merged Changes from iCloud"];
   
    
   

    
   
}

/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (PTManagedObjectContext *)managedObjectContext {
	
    if (managedObjectContext__ != nil) {
        return managedObjectContext__;
    }
	
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    
    if (coordinator != nil) {
        // Make life easier by adopting the new NSManagedObjectContext concurrency API
        // the NSMainQueueConcurrencyType is good for interacting with views and controllers since
        // they are all bound to the main thread anyway
        PTManagedObjectContext* moc = [[PTManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        
        [moc performBlockAndWait:^{
            // even the post initialization needs to be done within the Block
            [moc setPersistentStoreCoordinator: coordinator];
            @try {
                [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(mergeChangesFrom_iCloud:) name:NSPersistentStoreDidImportUbiquitousContentChangesNotification object:coordinator];
            }
            @catch (NSException *exception) {
                [self displayNotification:@"Error adding observer to iCloud merges" ];
            }
         
         
        }];
        managedObjectContext__ = moc;
    }
    
    return managedObjectContext__;
}

// NSNotifications are posted synchronously on the caller's thread
// make sure to vector this back to the thread we want, in this case
// the main thread for our views & controller
- (void)mergeChangesFrom_iCloud:(NSNotification *)notification {
	NSManagedObjectContext* moc = [self managedObjectContext];
    
    // this only works if you used NSMainQueueConcurrencyType
    // otherwise use a dispatch_async back to the main thread yourself
    [moc performBlock:^{
       
        [self mergeiCloudChanges:notification forContext:moc];
        
    }];
}


/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created by merging all of the models found in the application bundle.
 */
- (NSManagedObjectModel *)managedObjectModel {
	
    if (managedObjectModel__ != nil) {
        return managedObjectModel__;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"psyTrainTrack" withExtension:@"momd"];
    managedObjectModel__ = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];  
    return managedObjectModel__;
}



-(BOOL)reachable {
    Reachability *r = [Reachability reachabilityWithHostName:@"google.com"];
    NetworkStatus internetStatus = [r currentReachabilityStatus];
    if(internetStatus == NotReachable) {
        return NO;
    }
    return YES;
}



/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
	
    if (persistentStoreCoordinator__ != nil) {
        return persistentStoreCoordinator__;
    }
    
    // assign the PSC to our app delegate ivar before adding the persistent store in the background
    // this leverages a behavior in Core Data where you can create NSManagedObjectContext and fetch requests
    // even if the PSC has no stores.  Fetch requests return empty arrays until the persistent store is added
    // so it's possible to bring up the UI and then fill in the results later
    persistentStoreCoordinator__ = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel: [self managedObjectModel]];
    
    
    // prep the store path and bundle stuff here since NSBundle isn't totally thread safe
    NSPersistentStoreCoordinator* psc = persistentStoreCoordinator__;
	NSString *storePath = [[self applicationPTTDirectory].path  stringByAppendingPathComponent:kPTTAppSqliteFileName];
//    NSURL *storeURL = [[self applicationPTTDirectory] URLByAppendingPathComponent:[NSString stringWithFormat:@"psyTrack.sqlite"]];
    // do this asynchronously since if this is the first time this particular device is syncing with preexisting
    // iCloud content it may take a long long time to download
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSFileManager *fileManager = [NSFileManager defaultManager];
//
//       
        // If the expected store doesn't exist, copy the default store.
        
        if (![fileManager fileExistsAtPath:storePath]) {
            NSString *defaultStorePath = [[NSBundle mainBundle] pathForResource:@"psyTrack" ofType:@"sqlite"];
            if (defaultStorePath&&[fileManager fileExistsAtPath:defaultStorePath]) {
                [fileManager copyItemAtPath:defaultStorePath toPath:storePath error:NULL];
                NSString *statusMessage=[self resetDefaultLockKeychainSettingsWithReset:YES];
                if (![statusMessage isEqualToString:@"Welcome to PsyTrack Clinician Tools.  Thank you for your purchase."]) {
                    NSString *displaymessage=[NSString stringWithFormat:@"Configuring database for iCloud. One moment Please. %@",statusMessage];
                    [self displayNotification:displaymessage];
                    resetDatabase=YES;
                }
                else{
                
                    firstRun=YES;
                
                }
                
                
            }
        }
       
//        if (![fileManager fileExistsAtPath:storePath]) {
//           
//                NSString *statusMessage=[self resetDefaultLockKeychainSettingsWithReset:YES];
//                if (![statusMessage isEqualToString:@"Welcome to PsyTrack Clinician Tools.  Thank you for your purchase."]) {
//                    NSString *displaymessage=[NSString stringWithFormat:@"Configuring database for iCloud. One moment Please. %@",statusMessage];
//                    [self displayNotification:displaymessage];
//                    resetDatabase=YES;
//                }
//                else{
//                    
//                    firstRun=YES;
//                    
//                }
//                
//               
//        }
        
        
        
        NSURL *storeUrl = [NSURL fileURLWithPath:storePath];
        NSURL *cloudURL =nil;
        // this needs to match the entitlements and provisioning profile
#if !TARGET_IPHONE_SIMULATOR
        cloudURL = [fileManager URLForUbiquityContainerIdentifier:nil];
#endif
       
        
        NSString* coreDataCloudContent =nil;
             if (cloudURL) {
                  coreDataCloudContent=     [[cloudURL path] stringByAppendingPathComponent:@"psyTrack"];
             }
            NSDictionary* options;
      
       
        if (!firstRun && !resetDatabase&&[coreDataCloudContent length] != 0 &&[self reachable]) {
                // iCloud is available
                cloudURL = [NSURL fileURLWithPath:coreDataCloudContent];
            
           
            
                options = [NSDictionary dictionaryWithObjectsAndKeys:@"SL2GGUR9DM.com.psychewebLLC.psytrack.cliniciantools", NSPersistentStoreUbiquitousContentNameKey, cloudURL, NSPersistentStoreUbiquitousContentURLKey, [NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption,nil]; 
             
            } else {
                // iCloud is not available
                options = [NSDictionary dictionaryWithObjectsAndKeys:
                           [NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption,
                           [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption,
                           nil];

                
                
            }

        
       
        
        //  The API to turn on Core Data iCloud support here.
       
        
                
        NSError *error = nil;
        
        [psc lock];
       
       
        if (![psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeUrl options:options error:&error]) {
            
            
          

            
            
            if (cloudURL) {
                
//                NSError *removeError=nil;
//                [[NSFileManager defaultManager] removeItemAtURL:cloudURL error:&removeError];
               
                
               
                
                
                
                              
                [self displayNotification:@"An unresolved error occured possibly while setting up iCloud.  Try restarting and checking your internet connection. If it persists, consider disabling or reseting the app iCloud access or internet for a while in the device settings and restarting. Check http://www.apple.com/support/systemstatus/ for iCloud availability." forDuration:0 location:kPTTScreenLocationMiddle inView:self.window];
            
                
            }else{
            
                [self displayNotification:@"App was unable to load database at this time." forDuration:0 location:kPTTScreenLocationTop inView:self.window];
            
            }
            
            
            
            /*
             Replace this implementation with code to handle the error appropriately.
             
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
             
             Typical reasons for an error here include:
             * The persistent store is not accessible
             * The schema for the persistent store is incompatible with current managed object model
             Check the error message to determine what the actual problem was.
             */
            
//            abort();
        }
        else
        
            
        {
            

        [psc unlock];
         NSError *errorSettingAttributes = nil;
            NSDictionary *fileAttributes = [NSDictionary dictionaryWithObject:NSFileProtectionComplete forKey:NSFileProtectionKey];
        
                if(![fileManager setAttributes:fileAttributes ofItemAtPath:storePath error:&errorSettingAttributes])
                {
                    
                    [self displayNotification:[NSString stringWithFormat:@"Error occured while setting data protection. %@", errorSettingAttributes.description]];
                }
            
            if (![self addSkipBackupAttributeToItemAtURL:storeUrl]) {
               
                [self displayNotification:@"Error occured while setting setting file attribute."];
            }
        // tell the UI on the main thread we finally added the store and then
        // post a custom notification to make your views do whatever they need to such as tell their
        // NSFetchedResultsController to -performFetch again now there is a real store
        dispatch_async(dispatch_get_main_queue(), ^{
            
            @try {
               
                 [[NSNotificationCenter defaultCenter] postNotificationName:@"persistentStoreAdded" object:self userInfo:nil];
            }
            @catch (NSException *exception) {
                [self displayNotification:@"Error setting up database. App will now close." forDuration:10.0 location:kPTTScreenLocationTop inView:self.window];
                
                sleep(10);
                abort();
            }
            
           
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"RefetchAllDatabaseData" object:self userInfo:nil];
            
            
            
        });
        }
    });
    
    return persistentStoreCoordinator__;
}

- (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL
{
    BOOL success=NO;
    
    if ([[NSFileManager defaultManager] fileExistsAtPath: [URL path]]);
    {
        NSError *error = nil;
        success = [URL setResourceValue: [NSNumber numberWithBool: YES]
                                      forKey: NSURLIsExcludedFromBackupKey error: &error];
    }
    return success;
}

#pragma mark -
#pragma mark psytrack image fading

-(void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    
   
    
    if(event.type == UIEventTypeMotion && event.subtype == UIEventSubtypeMotionShake)
    { 
        
        
        [self flashAppTrainAndTitleGraphics];
    }
}


-(void)flashAppTrainAndTitleGraphics{
     int duration=5;
    if (self.psyTrackLabel.alpha==1) {
        duration=2;
       displayDevelopedByAttempt=3;
    }
    
    

    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView setAnimationDuration:1];
    
    
    
    if (displayDevelopedByAttempt==3){
        self.developedByLabel.alpha=1;
        
        displayDevelopedByAttempt=0;
        if ([[UIDevice currentDevice] userInterfaceIdiom] != UIUserInterfaceIdiomPad)
        {
          
           
                
            
            if (clinicianViewController.totalCliniciansLabel.alpha) {
           
            clinicianViewController.totalCliniciansLabel.alpha=0;
            }
            if (clientsViewController_iPhone) {
                
            clientsViewController_iPhone.totalClientsLabel.alpha=0;
            }
//            self.trainTrackViewController.tableView.alpha=0;
            
        }
    
    }
     displayDevelopedByAttempt=displayDevelopedByAttempt+1;
    self.clinicianToolsLabel.alpha=1;
    self.psyTrackLabel.alpha=1;
    self.imageView.alpha = 1;
    [UIView commitAnimations];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:duration];
	self.developedByLabel.alpha=0;
    self.clinicianToolsLabel.alpha=0;
    self.psyTrackLabel.alpha=0;
    self.imageView.alpha = 0.3;
    if ([[UIDevice currentDevice] userInterfaceIdiom] != UIUserInterfaceIdiomPad)
    {
               clinicianViewController.totalCliniciansLabel.alpha=1;
        
        
        clientsViewController_iPhone.totalClientsLabel.alpha=1;
        
        
//        self.trainTrackViewController.tableView.alpha=1;
       
        
    }

    
    [UIView commitAnimations];

}



#pragma mark -
#pragma mark LockScreenAppDelegate implementation

- (void) lockScreen: (LCYLockScreenViewController *) lockScreen unlockedApp: (BOOL) unlocked
{
	if (unlocked)
	{
		[lockScreenVC_.view removeFromSuperview];
		self.lockScreenVC = nil;
        ; 
        if (![self.window.subviews containsObject:tabBarController.view]) {
            [self.window addSubview:tabBarController.view];
        }
    self.tabBarController.view.hidden=NO;
    self.tabBarController.tabBar.userInteractionEnabled=YES;
    
    for (UIViewController *viewControllerInArray in tabBarController.viewControllers) {
        viewControllerInArray.view.userInteractionEnabled=YES;
    }
        
        LCYAppSettings *appsettings=[[LCYAppSettings alloc]init];
        
        [appsettings setLockScreenLocked:NO];
        
}
}

#pragma mark -
#pragma mark App Settings stuff

- (LCYAppSettings *) appSettings
{
    if (appSettings_ != nil) 
	{
        return appSettings_;
    }

	appSettings_ = [[LCYAppSettings alloc] init];
	return appSettings_;
}
@end



@implementation PTTAppDelegate (AppLock)

- (BOOL) isPasscodeOn
{	
    KeychainItemWrapper *wrapper = [[KeychainItemWrapper alloc] init];
    
    NSData *  lockedData= [wrapper searchKeychainCopyMatching:K_LOCK_SCREEN_PASSCODE_IS_ON];
    BOOL passcodeOn=(BOOL)[(NSString * )[self convertDataToString:lockedData]boolValue];
    wrapper=nil;
    lockedData=nil;
    
    return passcodeOn;

}
- (BOOL) isLockedAtStartup
{	
    KeychainItemWrapper *wrapper = [[KeychainItemWrapper alloc] init];
    
    NSData *  lockedData= [wrapper searchKeychainCopyMatching:K_LOCK_SCREEN_LOCK_AT_STARTUP];
    BOOL lockedOnStartup=(BOOL)[(NSString * )[self convertDataToString:lockedData]boolValue];
    
    wrapper=nil;
    lockedData=nil;
    return lockedOnStartup;
}



-(BOOL)isAppLocked{

 KeychainItemWrapper *wrapper = [[KeychainItemWrapper alloc] init];

  NSData *  lockedData= [wrapper searchKeychainCopyMatching:K_LOCK_SCREEN_LOCKED];
BOOL isLocked= (BOOL)[(NSString * )[self convertDataToString:lockedData]boolValue];	
    lockedData=nil;
    wrapper=nil;
    return isLocked;

}
-(BOOL)isLockedTimerOn{
    
    KeychainItemWrapper *wrapper = [[KeychainItemWrapper alloc] init];
    
    NSData *  lockedData= [wrapper searchKeychainCopyMatching:K_LOCK_SCREEN_TIMER_ON];
   BOOL isLockedTimerOn=(BOOL)[(NSString * )[self convertDataToString:lockedData]boolValue];
   
    wrapper=nil;
    lockedData=nil;
    return isLockedTimerOn;
    
}


-(void)displayWrongPassword{

    [lockScreenVC_ showBanner:lockScreenVC_.wrongPassCodeBanner];
    [lockScreenVC_.enterPassCodeBanner removeFromSuperview];	

}
- (void) lockApplication
{
    BOOL passcodeON=[self isPasscodeOn];
//    BOOL isLockedAtStartup= [self isLockedAtStartup];
	if (! lockScreenVC_ && passcodeON )
	{
        NSString *lockScreenNibName;
        if ([[UIDevice currentDevice] userInterfaceIdiom] != UIUserInterfaceIdiomPad)
            lockScreenNibName=@"LCYLockScreen_iPhone";
        else 
            lockScreenNibName=@"LCYLockScreen_iPad";
        
        
		self.lockScreenVC = [[LCYLockScreenViewController alloc] initWithNibName:lockScreenNibName bundle:[NSBundle mainBundle]];
        
		
		self.lockScreenVC.delegate = self;
       
        

        
        
        
	}
	
    if (passcodeON) 
    {
//        [self.window addSubview:lockScreenVC_.window];
//        [self.lockScreenVC loadView];

        [self.window addSubview:self.lockScreenVC.view];
     
        self.tabBarController.view.hidden=YES;
        self.tabBarController.tabBar.userInteractionEnabled=NO;
        
        for (UIViewController *viewControllerInArray in tabBarController.viewControllers) {
            viewControllerInArray.view.userInteractionEnabled=NO;
        }
        LCYAppSettings *appsettings=[[LCYAppSettings alloc]init];
        
        [appsettings setLockScreenLocked:YES];
        
        if ([self isLockedTimerOn]) {
            [self displayWrongPassword];
        }
        appsettings=nil;
    }
    else {
        
       
        NSString *alertText=@"Need To Set Passcode in Lock Screen Settings";
    
        [self displayNotification:alertText forDuration:3.0 location:kPTTScreenLocationTop  inView:nil];
    }
   
} 

-(NSString *)lockSettingsFilePath{

    NSString *encryptedFileName=@"ptdata.001";
    
    
    return [[self applicationPTFileDirectory].path stringByAppendingPathComponent:encryptedFileName];

}


@end



@implementation PTTAppDelegate (CasualAlerts)

#pragma mark -
#pragma notification controller implementation

-(void)displayNotification:(NSString *)alertText forDuration:(float)seconds location:(NSInteger )screenLocation inView:(UIView *)viewSuperview{

    
   
    
    if (casualAlertManager) {
        casualAlertManager.view=nil;
        casualAlertManager=nil;
    }
    self.casualAlertManager=[[CasualAlertViewController alloc] initWithNibName:@"CasualAlertViewController"  bundle:nil];
    
    [casualAlertManager loadView];
        [casualAlertManager displayRegularAlert:alertText forDuration:seconds location:screenLocation inView:viewSuperview];


}


-(void)displayNotification:(NSString *)alertText{

    [self displayNotification:(NSString *)alertText forDuration:(float)4.0 location:(NSInteger )kPTTScreenLocationTop   inView:nil];

}


@end


