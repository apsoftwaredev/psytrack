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
#import "CliniciansRootViewController_iPad.h"
#import "TrainTrackViewController.h"
#import "TestAdministrationsViewController_iPad.h"
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
#import "InAppSettingsViewController.h"
#import "PTTEncryption.h"
#import "KeyEntity.h"

#import "NSDictionaryHelpers.h"

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


@synthesize splitViewControllerClients = _splitViewControllerClients;
@synthesize splitViewControllerClinicians = _splitViewControllerClinicians;
@synthesize navigationControllerTrainTrack = _navigationControllerTrainTrack;
@synthesize splitViewControllerReports = _splitViewControllerReports;
@synthesize tabBarController, tabBar, tabBarControllerContainerView;
@synthesize clientsDetailViewController_iPad,clientsRootViewController_iPad,cliniciansRootViewController_iPad,cliniciansDetailViewController_iPad, trainTrackViewController, clientsViewController_iPhone, clinicianViewController;
@synthesize reportsRootViewController_iPad, reportsDetailViewController_iPad,reportsViewController_iPhone;
@synthesize imageView=_imageView;
@synthesize masterViewController;

@synthesize psyTrackLabel,developedByLabel,clinicianToolsLabel;
@synthesize lockScreenVC = lockScreenVC_;
@synthesize casualAlertManager;
@synthesize tabBarView;
@synthesize viewController;
@synthesize lockValuesDictionary=lockValuesDictionary_;
@synthesize encryption=encryption_;
@synthesize okayToDecryptBool=okayToDecryptBool_;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{

    
#if !__has_feature(objc_arc)

    UIAlertView *anAlert = [[UIAlertView alloc] initWithTitle:@"Incompatable iOS Version" message:@"This App Requires iOS 5.0 or higher, please upgrade in iTunes" delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
    anAlert.tag=1;
    [anAlert show];

    
#endif
    
    
    
 
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
    
        if (![[NSUserDefaults standardUserDefaults] synchronize])
        //NSLog(@"not successful in writing the default prefs");

    
    //NSLog(@"user defaults are %@",[[NSUserDefaults standardUserDefaults].dictionaryRepresentation allKeys]);
    
    self.encryption=[[PTTEncryption alloc]init];
  
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(notifyTrustFailure:)
     name:@"trustFailureOccured"
     object:nil];
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(resaveLockDictionarySettings:)
     name:@"RefetchAllDatabaseData"
     object:nil];
    
    NSString *statusMessage;

   retrievedEncryptedDataFile=NO;
    
    statusMessage=[self setupLockDictionaryResultStr];
    
    // if the file is not found, then this is the first time or there is a problem and database will reset
    //NSLog(@"encrypted lock dictionary success is %i",encryptedLockDictionarySuccess);
    //NSLog(@"retrieved encrypted data file is %i",retrievedEncryptedDataFile);
   
    if (!encryptedLockDictionarySuccess &&!retrievedEncryptedDataFile) {
   
        statusMessage=[self setupDefaultLockDictionaryResultStr];
    }
    else 
    if(retrievedEncryptedDataFile && !encryptedLockDictionarySuccess)
    { statusMessage=@"Error in Loading Security Settings Occured";
        self.okayToDecryptBool=FALSE;
    }
        

    //NSLog(@"lcock dictionary is %@",[lockValuesDictionary_ allKeys]);
    

  
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {

       
        
            
                
                
                [self.window addSubview:self.viewController.view];
//                 [self.masterViewController.view addSubview:self.tabBarController.view];  
                 UIImage *clininicansImage =[UIImage imageNamed:@"cliniciansTab.png"];
                self.splitViewControllerClinicians.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Clinicians" image:clininicansImage tag:90];
                
                UIImage *trainImage =[UIImage imageNamed:@"trainTab.png"];
               self.navigationControllerTrainTrack.tabBarItem=[[UITabBarItem alloc] initWithTitle:@"psyTrack" image:trainImage tag:91];

                
                UIImage *clientsImage =[UIImage imageNamed:@"clientsTab.png"];
                self.splitViewControllerClients.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Clients" image:clientsImage tag:89];
               
                UIImage *reportsImage =[UIImage imageNamed:@"reportTab.png"];
                self.splitViewControllerReports.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Reports" image:reportsImage tag:92];
                
                NSArray *controllers = [NSArray arrayWithObjects:self.navigationControllerTrainTrack,self.splitViewControllerClinicians, self.splitViewControllerClients,  self.splitViewControllerReports,/*other controllers go here */ nil];
                tabBarController.viewControllers = controllers;
                self.tabBarController.delegate=self;
                self.splitViewControllerClients.view.backgroundColor=[UIColor clearColor];
              
                self.splitViewControllerClinicians.view.backgroundColor=[UIColor clearColor];
                //NSLog(@"window background color is %@", self.window.backgroundColor);
//                
            }
    
    clinicianToolsLabel.text=NSLocalizedStringWithDefaultValue(@"Clinician Tools" , @"Root", [NSBundle mainBundle], @"Clinician Tools", @"subname for the application");
    
   
   
    
    
            
    [self flashAppTrainAndTitleGraphics];
    [self.tabBarController setDelegate:self];
               
//       dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{                          
//         
//           
//           if (!([[NSUserDefaults standardUserDefaults] objectForKey:kPTTAddressBookGroupName]&&![[NSUserDefaults standardUserDefaults] valueForKey:kPTTAddressBookGroupName])||(![[NSUserDefaults standardUserDefaults]objectForKey:kPTTAddressBookGroupIdentifier]&&![[NSUserDefaults standardUserDefaults]valueForKey:kPTTAddressBookGroupIdentifier])) 
//           {
//               InAppSettingsViewController *inAppSettingsViewController=[[InAppSettingsViewController alloc]init ];
//                
//               if([[NSUserDefaults standardUserDefaults] objectForKey:kPTTAddressBookGroupName]){
//               NSString *groupName=[[NSUserDefaults standardUserDefaults] valueForKey:kPTTAddressBookGroupName];
//              
//               [inAppSettingsViewController changeABGroupNameTo:(NSString *)groupName addNew:NO];
//               }
//               else {
//                   [inAppSettingsViewController changeABGroupNameTo:(NSString *)[NSString string] addNew:NO];
//               }
//               
//           }
//       });
    if (!(retrievedEncryptedDataFile && !encryptedLockDictionarySuccess)||(encryptedLockDictionarySuccess|| setupDatabase)) {
   
    [self.window addSubview:self.tabBarController.view];
        self.okayToDecryptBool=YES; 
    }
    else {
        statusMessage=@"Error in Loading Security Settings Occured";
    }
    
//    NSInteger screenLocationForMessage=kPTTScreenLocationTop;
    
    //NSLog(@"app is locked:  %i  app is locked at startup%i passcode is on %i",[self isAppLocked],[self isLockedAtStartup],[self isPasscodeOn]);
    
    
    if ((retrievedEncryptedDataFile && !encryptedLockDictionarySuccess)||([self isPasscodeOn]&&([self isAppLocked]||[self isLockedAtStartup]))) {
        [self lockApplication];
        
    }
    
    [self.window makeKeyAndVisible];
    if (statusMessage.length) {
        
        UIView *containerView=nil;
        if (okayToDecryptBool_==NO) {
            containerView=self.window;
        }
        [self displayNotification:statusMessage forDuration:5.0 location:kPTTScreenLocationTop inView:containerView];
        
    }
    
    if (trustResultFailureString.length) {
         [self displayNotification:trustResultFailureString forDuration:8.0 location:kPTTScreenLocationMiddle inView:self.window];
    }
    
   
#if !TARGET_IPHONE_SIMULATOR
    // Add registration for remote notifications
	[[UIApplication sharedApplication] 
     registerForRemoteNotificationTypes:(UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound)];
	
	
#endif
    
    // Clear application badge when app launches
	application.applicationIconBadgeNumber = 0;
    
    
    return YES;
}



-(IBAction)notifyTrustFailure:(id)sender{


    //NSLog(@"sender class is %@",[sender class]);
    if (self.window.isKeyWindow) {
        [self displayNotification:@"Problem with trust settings.  Check for software update or notify support." forDuration:5.0 location:kPTTScreenLocationMiddle inView:self.window];
    }
    else {
    trustResultFailureString=@"Problem with trust settings.  Check for software update or notify support.";
    }



}
-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{

    
    if (alertView.tag==1) {
        exit(0);
    }    




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
		//NSLog(@"user defaults may not have been loaded from Settings.bundle ... doing that now ...");
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

-(NSData *)getSymetricData{


    NSString* symmetricString= [NSString stringWithFormat:@"qu1shZEM196kibsiBh7h%@hsiwoai4js",[self combSmString]];
    //NSLog(@"semetric string is %@",symmetricString);
//    NSData *data=[symmetricString dataUsingEncoding: [NSString defaultCStringEncoding] ];
    
//NSLog(@"data length is %i",[data length]);
    return [symmetricString dataUsingEncoding: [NSString defaultCStringEncoding] ];
}

-(NSMutableDictionary*)unwrapAndCreateKeyDataFromKeyEntitywithKeyDate:(NSDate *)keyDate{

    NSMutableDictionary *returnDictionary=[[NSMutableDictionary alloc] initWithObjects:[NSArray arrayWithObjects:[NSData data],[NSDate date], nil] forKeys:[NSArray arrayWithObjects:@"symetricData",@"keyDate", nil]];
    
    NSString *symetricStr;
    
    //    //NSLog(@"semetric string is %@",symetricStringOne);
    NSRange rangeOne,rangeTwo,rangeThree;
    
    rangeOne.length=9;
    
    rangeTwo.length=14;
    rangeTwo.location=4;
    
    rangeThree.length=9;
    rangeThree.location=0;
    NSString* symetricStringOne= [NSString stringWithFormat:@"qu1shZEM196kibsiBh7h%@hsiwoai4js",[self combSmString]];
    
    //NSLog(@" combinesmetric string is %@",[self combSmString]);
    rangeOne.location=symetricStringOne.length-15;
    
    symetricStringOne=[symetricStringOne substringWithRange:rangeOne];
       
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"KeyEntity" inManagedObjectContext:[self managedObjectContext]];
    [fetchRequest setEntity:entity];
    
    NSError *error = nil;
    NSArray *fetchedObjects = [managedObjectContext__ executeFetchRequest:fetchRequest error:&error];
    if (fetchedObjects == nil) 
    {
        [self displayNotification:@"Error Accessing the database occured" forDuration:3.0 location:kPTTScreenLocationTop inView:nil];
    }
    KeyEntity *keyObject;
    NSPredicate *keyDatePredicate;
    if (keyDate) {
        //NSLog(@"key date is %@",keyDate);
       keyDatePredicate=[NSPredicate predicateWithFormat:@"dateCreated == %@",keyDate];
//        if (fetchedObjects.count) {
//            fetchedObjects=[fetchedObjects filteredArrayUsingPredicate:keyDatePredicate];
//        }
    }
    if (fetchedObjects.count) 
    {
        keyObject=[fetchedObjects objectAtIndex:0];
        //NSLog(@"keydate is %@",keyObject.dateCreated);
    }
    else {
        [self setupDefaultLockDictionaryResultStr];
        fetchedObjects = [managedObjectContext__ executeFetchRequest:fetchRequest error:&error];
        if (fetchedObjects == nil) 
        {
            [self displayNotification:@"Error Accessing the database occured" forDuration:3.0 location:kPTTScreenLocationTop inView:nil];
        }
        if (!fetchedObjects.count) 
        {
            [self displayNotification:@"Unable to retrieve security key needed to decrypt data" forDuration:3.0 location:kPTTScreenLocationTop inView:nil];
        }
    }
    
    
    
    
    NSData *unwrappedSymetricString;
    NSString *symetricStringThree;
    if (keyObject && keyObject.keyF) {
        
        if (keyObject.dateCreated) {
            if ([returnDictionary.allKeys containsObject:@"keyDate"]) {
                [returnDictionary setValue:keyObject.dateCreated forKey:@"keyDate"];
            }
        }
        
    
     unwrappedSymetricString   =[encryption_ unwrapSymmetricKey:keyObject.keyF keyRef:nil useDefaultPrivateKey:YES];
        
         symetricStringThree=[self convertDataToString:unwrappedSymetricString];
    }
    NSString *symetricStringTwo;
    if (keyObject.dataF && ![keyObject.dateCreated isEqualToDate:keyDate]) {
        
              
        NSData *symetricData=[self getSymetricData];
        NSData *hash; 
        //NSLog(@"symetric data lenthg %i",symetricData.length);
        if (symetricData.length==32) {
            
            hash=[encryption_ getHashBytes:symetricData];
            //NSLog(@"hash is %@",hash);
            
        }
        NSString* hashStr = [[NSString alloc] initWithData:hash encoding:NSASCIIStringEncoding];
    
        
        
        NSData *wrapedSymmetricKey;
        if (symetricData.length==32) {
            
            wrapedSymmetricKey =[encryption_ encryptData:symetricData keyRef:nil useDefaultPublicKey:YES];
            
        }
        //NSLog(@"wrapped symetrick key length is %i",[wrapedSymmetricKey length]);
        
        if (![wrapedSymmetricKey length]) {
            
            [self displayNotification:@"Security key needs to be updated.  Check for an software update." forDuration:3.0 location:kPTTScreenLocationTop inView:nil] ;
        }
        
        NSData *decryptedLockData;
        
        decryptedLockData =(NSData *)[encryption_ doCipher:keyObject.dataF key:symetricData context:kCCDecrypt padding:(CCOptions *) kCCOptionPKCS7Padding];
        
        
        //            //NSLog(@"decrypted Lock data is %@",decryptedLockData);
        //            
        //            NSString* newStr = [[NSString alloc] initWithData:decryptedLockData encoding:NSASCIIStringEncoding];;
        //            
        //            //NSLog(@"newstring is %@",newStr);
        if (decryptedLockData) {
            
            
            NSDictionary *dictionaryFromDecryptedData=[NSKeyedUnarchiver unarchiveObjectWithData:decryptedLockData];
            
            if (dictionaryFromDecryptedData) {
                
                
                //                    //NSLog(@"lockvalues dictionary %@",[dictionaryFromDecryptedData allKeys]);
                
                id obj = [dictionaryFromDecryptedData objectForKey:K_LOCK_SCREEN_DF_HASH];
                
                if (obj) {
                    // use obj
                    NSString *checkHash=[dictionaryFromDecryptedData valueForKey:K_LOCK_SCREEN_DF_HASH];
                    
                    //                        //NSLog(@"check hash string is %@",checkHash);
                    //                        //NSLog(@"hash str is %@",hashStr);
                    if (checkHash && [checkHash isEqualToString:hashStr]) {
                        
                        if ([dictionaryFromDecryptedData objectForKey:K_LOCK_SCREEN_RAN]) {
                             symetricStringTwo=[dictionaryFromDecryptedData valueForKey:K_LOCK_SCREEN_RAN];
                        }
                        
                    }
                    else {
                        
                        [self displayNotification:@"Error: Problem loading securtity key." forDuration:3.0 location:kPTTScreenLocationTop inView:nil];
                    }
                    
                    
                    
                } 
                
                
                
                
            }
            else
                [self displayNotification:@"Error: Problem loading securtity key." forDuration:3.0 location:kPTTScreenLocationTop inView:nil];
        }
        else
            [self displayNotification:@"Error: Problem loading securtity key." forDuration:3.0 location:kPTTScreenLocationTop inView:nil];
        
        
    }
    else {
        symetricStringTwo=[lockValuesDictionary_ valueForKey:K_LOCK_SCREEN_RAN];
    }
    

    
    
   
    if (symetricStringTwo.length!=21) {
        symetricStringTwo=@"";
    }
    else {
        symetricStringTwo=[symetricStringTwo substringWithRange:rangeTwo];
    }

   
    if (symetricStringThree.length>7) {
        
        symetricStringThree=[symetricStringThree substringWithRange:rangeThree];
    }
    else {
        symetricStringThree=[self generateRandomStringOfLength:8];
    }
    symetricStr=[NSString stringWithFormat:@"%@%@%@",symetricStringOne,symetricStringTwo,symetricStringThree];
    
    
    //NSLog(@"symetric string %@",symetricStr);
    //NSLog(@"@Symetrick string lenght is %i",symetricStr.length);
    //    NSData *data=[symetricStringOne dataUsingEncoding: [NSString defaultCStringEncoding] ];
    
    
    
    ////NSLog(@"data length is %i",[data length]);
   

 
    
    NSData *symetricData=[symetricStr dataUsingEncoding: [NSString defaultCStringEncoding] ];


    if (symetricData.length &&[returnDictionary.allKeys containsObject:@"symetricData"]) {
        
        [returnDictionary setValue:symetricData forKey:@"symetricData"];
       
    } 
//NSLog(@"return dictionary right before return %@",returnDictionary);

    return ( NSMutableDictionary*) returnDictionary;
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

-(void)setLCYLockPlist{

// bit.ly/zpnxI6 file

    NSString * lcyLockPath=[[NSBundle mainBundle] pathForResource:@"LCYLock"
                                                           ofType:@"plist"];
    
    if (![[NSUserDefaults standardUserDefaults]objectForKey:@"passCodeIsOn"]) {
        NSDictionary * lcyLockValuesDict=[NSDictionary dictionaryWithContentsOfFile:lcyLockPath];
        [[NSUserDefaults standardUserDefaults] registerDefaults:lcyLockValuesDict];
    }
   
if (lockValuesDictionary_ &&[lockValuesDictionary_ objectForKey:K_LOCK_SCREEN_ATTEMPT]) {
    [[NSUserDefaults standardUserDefaults]setValue:[lockValuesDictionary_ valueForKey:K_LOCK_SCREEN_ATTEMPT]  forKey:@"attempt"];
}



if (lockValuesDictionary_ &&[lockValuesDictionary_ objectForKey:K_LOCK_SCREEN_PASSCODE]&&[lockValuesDictionary_ valueForKey:K_LOCK_SCREEN_PASSCODE]) {
    
    int randomNumber = (arc4random() % 9999) + 1000;
    
    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%i", randomNumber]  forKey:@"pw"];
}
if (lockValuesDictionary_ &&[lockValuesDictionary_ objectForKey:K_LOCK_SCREEN_ATTEMPT]) {
    [[NSUserDefaults standardUserDefaults]setValue:[lockValuesDictionary_ valueForKey:K_LOCK_SCREEN_ATTEMPT]  forKey:@"screenLocked"];
}
if (lockValuesDictionary_ &&[lockValuesDictionary_ objectForKey:K_LOCK_SCREEN_TIMER_ON]) {
    [[NSUserDefaults standardUserDefaults]setValue:[lockValuesDictionary_ valueForKey:K_LOCK_SCREEN_TIMER_ON]  forKey:@"timer"];
}
    
if (lockValuesDictionary_ &&[lockValuesDictionary_ objectForKey:K_LOCK_SCREEN_LOCK_AT_STARTUP]) {
    [[NSUserDefaults standardUserDefaults]setValue:[lockValuesDictionary_ valueForKey:K_LOCK_SCREEN_LOCK_AT_STARTUP]  forKey:@"startupLock"];
}
    
    [[NSUserDefaults standardUserDefaults] synchronize];

}
-(NSString *)generateRandomStringOfLength:(int )length{


    NSString *alphabet  = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXZY0123456789";
    NSMutableString *s = [NSMutableString stringWithCapacity:length];
    for (NSUInteger i = 0U; i < length; i++) {
        u_int32_t r = arc4random() % [alphabet length];
        unichar c = [alphabet characterAtIndex:r];
        [s appendFormat:@"%C", c];
    }
    
    
    //NSLog(@"random string is %@",s);
    return s;




}



-(NSString *)setupDefaultLockDictionaryResultStr{
    
     NSString *statusMessage;
    if (!retrievedEncryptedDataFile) {
        statusMessage=@"Welcome to PsyTrack Clinician Tools.  Thank you for your purchase.";
    }
    
    if (encryptedLockDictionarySuccess && lockValuesDictionary_) {
        return[NSString stringWithString:@"Lock Screen Settings Loaded"];
    }
    @try {
    
    
    if (!encryption_) 
    {
        encryption_=[[PTTEncryption alloc]init];
    }
    
    
    // for setting up and accessing the dataf attribute in the KeyEntity
    
            
    NSData *symetricData=[self getSymetricData];
    
    NSData *hash=[encryption_ getHashBytes:symetricData];
    
    //NSLog(@"hash is %@",hash);
    
    NSString* hashStr = [[NSString alloc] initWithData:hash encoding:NSASCIIStringEncoding];
    
    //NSLog(@"newstring is %@",hashStr);
    
    
    
    
    
    NSString *encryptedDataPath = [self lockSettingsFilePath];
    
    
   
        if (!self.lockValuesDictionary) {

    NSArray *lockKeys=[NSArray arrayWithObjects:K_LOCK_SCREEN_PASSCODE_IS_ON, K_LOCK_SCREEN_PASSCODE, K_LOCK_SCREEN_ATTEMPT,  K_LOCK_SCREEN_LOCK_AT_STARTUP,K_LOCK_SCREEN_TIMER_ON,K_LOCK_SCREEN_LOCKED, K_LOCK_SCREEN_P_HSH  ,K_LOCK_SCREEN_DF_HASH,K_LOCK_SCREEN_RAN, K_LOCK_SCREEN_CREATE_DATE,nil];
    
    
    //NSLog(@"hash string is %@",hashStr);
    NSArray *lockValues=[NSArray arrayWithObjects:[NSNumber numberWithBool:NO],[NSString string],[NSNumber numberWithInteger:0],[NSNumber numberWithBool:NO],[NSNumber numberWithBool:NO],[NSNumber numberWithBool:NO],[NSString stringWithFormat:@"%@asdj9emV3k30wer93",@""],hashStr,[self generateRandomStringOfLength:21],[NSDate date], nil];
    
    self.lockValuesDictionary=[NSMutableDictionary dictionaryWithObjects:lockValues forKeys:lockKeys];
        }
    //NSLog(@"lock values dictionary %@",[lockValuesDictionary_ allKeys]);
    //        [lockValuesDictionary_ setValue:[NSString stringWithUTF8String:[hash bytes]]
    // forKey:@"pw_hash"];
    
    NSData * encodedData = [NSKeyedArchiver archivedDataWithRootObject:lockValuesDictionary_];
    
    
    
   
    NSData *wrapedSymmetricKey;
    if (symetricData.length==32) {
  
        wrapedSymmetricKey=[encryption_ encryptData:symetricData keyRef:nil useDefaultPublicKey:YES];
        
    }
    
    if (![wrapedSymmetricKey length]) {
        statusMessage=@"Check for a software update";
    }
    NSData* encryptedArchivedLockData; 
    
    if (symetricData.length==32) {
        encryptedArchivedLockData =(NSData *)[encryption_ doCipher:encodedData key:symetricData context:kCCEncrypt padding:(CCOptions *)kCCOptionPKCS7Padding];
    
    }
    
       
    
    //        NSData *dataFromDictionary=[NSData dataWithBytesNoCopy:(void *) length:lockValuesDictionary_ b
    
    
    //        NSString *encryptedStr;
    //        
    //        encryptedStr = [[NSString alloc] initWithData:encryptedArchivedLockData encoding:NSASCIIStringEncoding];
    //        
    //        //NSLog(@"newstring is %@",encryptedStr);
    //        
    //        //NSLog(@"encrypted lock data is %@", encryptedArchivedLockData);
    
    
    if ([encryptedArchivedLockData length]) 
    {
        setupDatabase=(BOOL)[encryptedArchivedLockData writeToFile:encryptedDataPath atomically:YES];
        
        //NSLog(@"setup database is %i",setupDatabase);
    }
            
    
    //1
    if (!setupDatabase) 
    {
        statusMessage=@"Unable to write data to file. Please check to see if you have adequate memory and disk space.  If the problem persists contact support.";
    }

    //1
    else
    //1
    {
        
        //create a unique key
        
        NSString *newRandomString=[self generateRandomStringOfLength:15];
        
        //wrap it into encrypted data
        NSData *newKeyData=[newRandomString dataUsingEncoding: [NSString defaultCStringEncoding] ];
        
       
        
        NSData *wrappedNewKeyData=[encryption_ wrapSymmetricKey:newKeyData keyRef:nil useDefaultPublicKey:YES];
        
        //inset it into managed object context into key database
        
            
        //2
        if ([wrappedNewKeyData length]) 
        {
            //3
            if (!managedObjectContext__) 
            {
                managedObjectContext__=[self managedObjectContext];
            }
            //3
            //3
            if (managedObjectContext__) 
            {
          
                NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
                NSEntityDescription *keyEntity = [NSEntityDescription entityForName:@"KeyEntity" inManagedObjectContext:managedObjectContext__];
                [fetchRequest setEntity:keyEntity];

                NSError *error = nil;
                NSArray *fetchedObjects = [managedObjectContext__ executeFetchRequest:fetchRequest error:&error];
                //4
                if (fetchedObjects == nil) 
                {
                    return  statusMessage=[statusMessage stringByAppendingString:error.localizedFailureReason];
                }
                //4
                //4
                if (!fetchedObjects.count) 
                {
                     
                    KeyEntity *newKeyObject=[[KeyEntity alloc]initWithEntity:keyEntity insertIntoManagedObjectContext:managedObjectContext__];
                    
                    newKeyObject.keyF=wrappedNewKeyData;
                    newKeyObject.dataF=encryptedArchivedLockData;
                    newKeyObject.dateCreated=[lockValuesDictionary_ valueForKey:K_LOCK_SCREEN_CREATE_DATE];
                  
                                //NSLog(@"newkey object is %@",newKeyObject.dateCreated);       
                    
                }
               //4
                       


            }
            //3
     
            else 
            //3
            {
                statusMessage=@"Error setting up database";
                return   statusMessage;
            }
            //3
        } 
        //2   
        else
        //2
        {
        
            statusMessage=@"Error setting up database";
            return   statusMessage;

        
        }
        //2   
    }
    //1
        
            
     

        
       

//0
} 
@catch (NSException *exception) 
{ 
    statusMessage=[NSString stringWithFormat: @"Error Setting up Security Settings. %@",exception.name];
    return statusMessage;
}
@finally 
//0
{ 
    return statusMessage;

}
}

-(NSString *)setupLockDictionaryResultStr{

    if (lockValuesDictionary_ && [lockValuesDictionary_ allKeys].count==6) {
        return @"Lock settings loaded";
    }
    
    
    
    
    
    NSString *statusMessage=[NSString string];
    
    retrievedEncryptedDataFile=NO;
    
    @try {
    
        if (!encryption_) {
           self.encryption=[[PTTEncryption alloc]init];
        }
   
    
        
        
  
  
    
    
    NSData *symetricData=[self getSymetricData];
        NSData *hash; 
         //NSLog(@"symetric data lenthg %i",symetricData.length);
        if (symetricData.length==32) {
     
            hash=[encryption_ getHashBytes:symetricData];
    //NSLog(@"hash is %@",hash);
            
        }
    NSString* hashStr = [[NSString alloc] initWithData:hash encoding:NSASCIIStringEncoding];
    
    //NSLog(@"newstring is %@",hashStr);
    
    
    
    
    
    NSString *encryptedDataPath = [self lockSettingsFilePath];
    
    NSData *retrievedEncryptedData=[NSData dataWithContentsOfFile:encryptedDataPath];
    
    

   
    if (retrievedEncryptedData) {
        
        retrievedEncryptedDataFile=YES;
               
        
    

        
        NSData *wrapedSymmetricKey;
        if (symetricData.length==32) {
        
            wrapedSymmetricKey =[encryption_ encryptData:symetricData keyRef:nil useDefaultPublicKey:YES];
            
        }
        //NSLog(@"wrapped symetrick key length is %i",[wrapedSymmetricKey length]);
        
        if (![wrapedSymmetricKey length]) {
            
            statusMessage=@"Security key needs to be updated.  Check for an software update.";
        }
            
            NSData *decryptedLockData;
            
            decryptedLockData =(NSData *)[encryption_ doCipher:retrievedEncryptedData key:symetricData context:kCCDecrypt padding:(CCOptions *) kCCOptionPKCS7Padding];
            
            
//            //NSLog(@"decrypted Lock data is %@",decryptedLockData);
//            
//            NSString* newStr = [[NSString alloc] initWithData:decryptedLockData encoding:NSASCIIStringEncoding];;
//            
//            //NSLog(@"newstring is %@",newStr);
            if (decryptedLockData) {
                
                
                NSDictionary *dictionaryFromDecryptedData=[NSKeyedUnarchiver unarchiveObjectWithData:decryptedLockData];
                
                if (dictionaryFromDecryptedData) {
                    
                    
//                    //NSLog(@"lockvalues dictionary %@",[dictionaryFromDecryptedData allKeys]);
                    
                    id obj = [dictionaryFromDecryptedData objectForKey:K_LOCK_SCREEN_DF_HASH];
                    
                    if (obj) {
                        // use obj
                        NSString *checkHash=[dictionaryFromDecryptedData valueForKey:K_LOCK_SCREEN_DF_HASH];
                        
//                        //NSLog(@"check hash string is %@",checkHash);
//                        //NSLog(@"hash str is %@",hashStr);
                        if (checkHash && [checkHash isEqualToString:hashStr]) {
                            encryptedLockDictionarySuccess=YES;
                            self.lockValuesDictionary=[NSMutableDictionary dictionaryWithDictionary:dictionaryFromDecryptedData];
                            
                        }
                        else {
                            encryptedLockDictionarySuccess=NO;
                            statusMessage=@"Error: Corrupted Security Data. Resetting to default state.";
                        }
                        
                        
                        
                    } 
                    
                    
                    
                    
                }
                else
                    statusMessage=@"Unable to load necessary security data";
            }
            else
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
       data=[string dataUsingEncoding: [NSString defaultCStringEncoding] ];

    }
    return data;
    
    
    
    
}


-(NSData *)hashDataFromString:(NSString *)plainString{


    NSData* data=[plainString dataUsingEncoding: [NSString defaultCStringEncoding] ];
    NSData *newData;
    if (data.length>0 &&data.length <25) {
        newData=[encryption_ getHashBytes:data];

    }



    return newData;



}
-(NSDictionary *)encryptStringToEncryptedData:(NSString *)plainTextStr withKeyDate:(NSDate *)keyDateToSet{

    NSMutableDictionary *returnDictionary=[NSMutableDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[NSData data], [NSDate date], nil] forKeys:[NSArray arrayWithObjects:@"encryptedData", @"keyDate", nil]];
    if (!encryption_) {
        self.encryption=[[PTTEncryption alloc]init];
    }
    
    NSData *encryptedData;
    if (plainTextStr.length &&okayToDecryptBool_) {
    
       
        NSDictionary *symetricDictionary=[self unwrapAndCreateKeyDataFromKeyEntitywithKeyDate:keyDateToSet];
        NSData *symetricData;
        if ([symetricDictionary.allKeys containsObject:@"symetricData"]) {
            symetricData =[symetricDictionary valueForKey:@"symetricData"];
        }
        if ([symetricDictionary objectForKey:@"keyDate"]) {
            NSDate *keyDate=(NSDate *)[symetricDictionary valueForKey:@"keyDate"];
            if (keyDate && [returnDictionary objectForKey:@"keyDate"]) {
                [returnDictionary setValue:keyDate forKey:@"keyDate"];
            }
        }
    
        //NSLog(@"symetric data length is %i",symetricData.length);
        if(symetricData.length==32){
    NSData* data=[plainTextStr dataUsingEncoding: [NSString defaultCStringEncoding] ];
    
    
            
//            //NSLog(@"keystring is %@",keyString);
           
    encryptedData=(NSData *) [encryption_ doCipher:data key:symetricData context:kCCEncrypt padding:(CCOptions *) kCCOptionPKCS7Padding];
            
            if (encryptedData.length) {
                if ([returnDictionary.allKeys containsObject:@"encryptedData"]) {
                    [returnDictionary setValue:encryptedData forKey:@"encryptedData"];
                }
                
            }
    
    }
    }

    return [NSDictionary dictionaryWithDictionary:returnDictionary];




}

-(NSDictionary *)encryptDataToEncryptedData:(NSData *) unencryptedData withKeyDate:(NSDate *)keyDateToSet{
    
   
    if (!encryption_) {
        self.encryption=[[PTTEncryption alloc]init];
    }
    NSDictionary *returnDictionary=[NSMutableDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[NSData data],[NSDate date], nil] forKeys:[NSArray arrayWithObjects:@"encryptedData",@"keyDate", nil]];
    NSData *encryptedData;
    NSDate *keyDate;
    if (unencryptedData.length) {
  
        NSDictionary *symetricDataDictionary=[self unwrapAndCreateKeyDataFromKeyEntitywithKeyDate:keyDateToSet];
        NSData *symetricData;
        
        if ([symetricDataDictionary.allKeys containsObject:@"symetricData"]) {
            symetricData=[symetricDataDictionary valueForKey:@"symetricData"];
        }
        if ([symetricDataDictionary.allKeys containsObject:@"keyDate"]) {
            keyDate=[symetricDataDictionary valueForKey:@"keyDate"];
        }

        if (symetricData.length==32) {
             encryptedData=(NSData *) [encryption_ doCipher:unencryptedData key:symetricData context:kCCEncrypt padding:(CCOptions *) kCCOptionPKCS7Padding];
        }
       
            
        
    }
    NSArray *returnDictionaryKeysArray=returnDictionary.allKeys;
    if (encryptedData.length && [returnDictionaryKeysArray containsObject:@"encryptedData"]) {
        
        [returnDictionary setValue:encryptedData forKey:@"encryptedData"];
        
        if (keyDate&&[returnDictionaryKeysArray containsObject:@"keyDate"]) {
            [returnDictionary setValue:keyDate forKey:@"keyDate"];
        }
    }

    
    return  [NSDictionary dictionaryWithDictionary:returnDictionary];
    
}


-(NSData *)decryptDataToPlainData:(NSData *)encryptedData usingSymetricKey:(NSData *)symetricData{

    
    if (!encryption_) {
        self.encryption=[[PTTEncryption alloc]init];
    }
    
    NSData *decryptedData;
    if (encryptedData.length &&okayToDecryptBool_) {
        
        
   
        if (symetricData.length==32) {
            
            
            decryptedData=(NSData *) [encryption_ doCipher:encryptedData key:symetricData context:kCCDecrypt padding:(CCOptions *) kCCOptionECBMode];
            
        }
    }
    
    return decryptedData;





}


-(NSData *)decryptDataToPlainDataUsingKeyEntityWithDate:(NSDate *)keyDate encryptedData:(NSData *)encryptedData{
    
    
    if (!encryption_) {
        self.encryption=[[PTTEncryption alloc]init];
    }
    
    NSData *decryptedData;
    if (encryptedData.length &&okayToDecryptBool_) {
  
     
        NSDictionary *symetricDataDictionary=[self unwrapAndCreateKeyDataFromKeyEntitywithKeyDate:keyDate];
        NSData *symetricData;
        
        if ([symetricDataDictionary.allKeys containsObject:@"symetricData"]) {
            symetricData=[symetricDataDictionary valueForKey:@"symetricData"];
        }
        

        if (symetricData.length==32) {
           
       
    decryptedData=(NSData *) [encryption_ doCipher:encryptedData key:symetricData context:kCCDecrypt padding:(CCOptions *) kCCOptionPKCS7Padding];
    
         }
    }
    
    return decryptedData;
    
}


-(NSString *)decyptString:(NSString *) encryptedString usingKeyWithDate:(NSDate *)keyDate{
    
    if (!encryption_) {
        self.encryption=[[PTTEncryption alloc]init];
    }
    
    NSString* newStr;
    if (encryptedString.length&&okayToDecryptBool_) {
    
      
        
        NSDictionary *symetricDataDictionary=[self unwrapAndCreateKeyDataFromKeyEntitywithKeyDate:keyDate];
        NSData *symetricData;
        
        if ([symetricDataDictionary.allKeys valueForKey:@"symetricData"]) {
            symetricData=[symetricDataDictionary valueForKey:@"symetricData"];
        }
    if (symetricData.length==32) {
  
            NSData* data=[encryptedString dataUsingEncoding: [NSString defaultCStringEncoding] ];
    
            
       
    NSData *decyptedData=(NSData *) [encryption_ doCipher:data key:symetricData context:kCCDecrypt padding:(CCOptions *) kCCOptionPKCS7Padding];
    
    newStr = [[NSString alloc] initWithData:decyptedData encoding:NSASCIIStringEncoding];
       }  
    }
    return newStr;
    
}



/* 
 * --------------------------------------------------------------------------------------------------------------
 *  BEGIN APNS CODE 
 * --------------------------------------------------------------------------------------------------------------
 */

/**
 * Fetch and Format Device Token and Register Important Information to Remote Server
 */
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)devToken {
	
#if !TARGET_IPHONE_SIMULATOR
    
	// Get Bundle Info for Remote Registration (handy if you have more than one app)
	NSString *appName = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
	NSString *appVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
	
	// Check what Notifications the user has turned on.  We registered for all three, but they may have manually disabled some or all of them.
	NSUInteger rntypes = [[UIApplication sharedApplication] enabledRemoteNotificationTypes];
	
	// Set the defaults to disabled unless we find otherwise...
	NSString *pushBadge = (rntypes & UIRemoteNotificationTypeBadge) ? @"enabled" : @"disabled";
	NSString *pushAlert = (rntypes & UIRemoteNotificationTypeAlert) ? @"enabled" : @"disabled";
	NSString *pushSound = (rntypes & UIRemoteNotificationTypeSound) ? @"enabled" : @"disabled";	
	
	// Get the users Device Model, Display Name, Unique ID, Token & Version Number
	UIDevice *dev = [UIDevice currentDevice];
	NSString *deviceUuid = [PTTAppDelegate GetUUID]  ;
	
		
	
	NSString *deviceName = dev.name;
	NSString *deviceModel = dev.model;
	NSString *deviceSystemVersion = dev.systemVersion;
	
	// Prepare the Device Token for Registration (remove spaces and < >)
	NSString *deviceToken = [[[[devToken description] 
                               stringByReplacingOccurrencesOfString:@"<"withString:@""] 
                              stringByReplacingOccurrencesOfString:@">" withString:@""] 
                             stringByReplacingOccurrencesOfString: @" " withString: @""];
	
	// Build URL String for Registration
	// !!! CHANGE "www.mywebsite.com" TO YOUR WEBSITE. Leave out the http://
	// !!! SAMPLE: "secure.awesomeapp.com"
	NSString *host = @"www.psycheweb.com";
	
	// !!! CHANGE "/apns.php?" TO THE PATH TO WHERE apns.php IS INSTALLED 
	// !!! ( MUST START WITH / AND END WITH ? ). 
	// !!! SAMPLE: "/path/to/apns.php?"
	NSString *urlString = [NSString stringWithFormat:@"/psytrack/apns/apns.php?task=%@&appname=%@&appversion=%@&deviceuid=%@&devicetoken=%@&devicename=%@&devicemodel=%@&deviceversion=%@&pushbadge=%@&pushalert=%@&pushsound=%@", @"register", appName,appVersion, deviceUuid, deviceToken, deviceName, deviceModel, deviceSystemVersion, pushBadge, pushAlert, pushSound];
	
	// Register the Device Data
	// !!! CHANGE "http" TO "https" IF YOU ARE USING HTTPS PROTOCOL
	NSURL *url = [[NSURL alloc] initWithScheme:@"http" host:host path:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
	NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
	NSLog(@"Register URL: %@", url);
	NSLog(@"Return Data: %@", returnData);
	
#endif
}

/**
 * Failed to Register for Remote Notifications
 */
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
	
#if !TARGET_IPHONE_SIMULATOR
	
	//NSLog(@"Error in registration. Error: %@", error);
	
#endif
}

/**
 * Remote Notification Received while application was open.
 */
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
	
#if !TARGET_IPHONE_SIMULATOR
    
	NSLog(@"remote notification: %@",[userInfo description]);
	NSDictionary *apsInfo = [userInfo objectForKey:@"aps"];
	
	NSString *alert = [apsInfo objectForKey:@"alert"];
	NSLog(@"Received Push Alert: %@", alert);
	
	NSString *sound = [apsInfo objectForKey:@"sound"];
    NSLog(@"Received Push Sound: %@", sound);
	AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
	
	NSString *badge = [apsInfo objectForKey:@"badge"];
	NSLog(@"Received Push Badge: %@", badge);
	application.applicationIconBadgeNumber = [[apsInfo objectForKey:@"badge"] integerValue];
	
#endif
}

/* 
 * --------------------------------------------------------------------------------------------------------------
 *  END APNS CODE 
 * --------------------------------------------------------------------------------------------------------------
 */

- (void) application:(UIApplication *)application
willChangeStatusBarOrientation:(UIInterfaceOrientation)newStatusBarOrientation
            duration:(NSTimeInterval)duration
{

    if (newStatusBarOrientation == UIInterfaceOrientationPortrait){
       

        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        
            self.viewController.view.transform      = CGAffineTransformIdentity;
            
            CGRect frame= CGRectMake(self.window.frame.size.width/2 - self.viewController.view.frame.size.width/2,self.window.frame.size.height/2-self.viewController.view.frame.size.height/2, self.viewController.view.frame.size.width, self.viewController.view.frame.size.height);
            
            
            //                        [UIView animateWithDuration:secs delay:0.0 options:option
            //                                         animations:^{
            //                                             self.view.frame = CGRectMake(destination.x,destination.y, self.view.frame.size.width, self.view.frame.size.height);
            //                                         }
            //                                         completion:^(BOOL finished){
            //                                             [self startFadeout];
            //                                         }];
            
            
            self.viewController.view.frame      =frame;
            
        
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
           self.viewController.view.transform       = CGAffineTransformMakeRotation(-M_PI);
           
            CGRect frame= CGRectMake(self.window.frame.size.width/2 - self.viewController.view.frame.size.width/2,self.window.frame.size.height/2-self.viewController.view.frame.size.height/2, self.viewController.view.frame.size.width, self.viewController.view.frame.size.height);
            
            
            //                        [UIView animateWithDuration:secs delay:0.0 options:option
            //                                         animations:^{
            //                                             self.view.frame = CGRectMake(destination.x,destination.y, self.view.frame.size.width, self.view.frame.size.height);
            //                                         }
            //                                         completion:^(BOOL finished){
            //                                             [self startFadeout];
            //                                         }];
            
            
            self.viewController.view.frame      =frame;

            
            
//            self.viewController.view.transform     = CGAffineTransformTranslate(self.viewController.view.transform,0,((-self.window.frame.size.height/2)+self.viewController.view.frame.size.height)/2);
        
        
       
        } else {
            self.imageView.transform      = CGAffineTransformMakeRotation(-M_PI);
        self.psyTrackLabel.transform      = CGAffineTransformMakeRotation(M_PI);
         self.clinicianToolsLabel.transform      = CGAffineTransformMakeRotation(M_PI);
         self.developedByLabel.transform      = CGAffineTransformMakeRotation(M_PI);
        //iPhone upside down
        
            self.imageView.transform      = CGAffineTransformTranslate(self.psyTrackLabel.transform,0,75);

            self.psyTrackLabel.transform      = CGAffineTransformTranslate(self.psyTrackLabel.transform,0,-130);
            
            
            self.developedByLabel.transform      = CGAffineTransformTranslate(self.developedByLabel.transform,0,340);
            self.clinicianToolsLabel.transform      = CGAffineTransformTranslate(self.clinicianToolsLabel.transform,0,280);
            
                                
        }
        
    }
    else if (UIInterfaceOrientationIsLandscape(newStatusBarOrientation))
    { 
       
        
            if (newStatusBarOrientation == UIInterfaceOrientationLandscapeLeft) 
            {
                
          
                float rotate    = ((newStatusBarOrientation == UIInterfaceOrientationLandscapeLeft) ? -1:1) * (M_PI / 2.0);
                           
                
                
                if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
                    self.viewController.view.transform      = CGAffineTransformMakeRotation(rotate);

                   
                    
                    
                    if ([[self.tabBarController.selectedViewController class] isSubclassOfClass:[UISplitViewController class]]) {
                    
                 
                        //NSLog(@"tabbar selected item index landscape left is %i",self.tabBarController.selectedIndex);
                        
                        
                        CGRect frame= CGRectMake(((self.window.frame.size.width-self.tabBarController.tabBar.frame.size.height)/2)-self.tabBarController.tabBar.frame.size.height- self.viewController.view.frame.size.height/2,(self.window.frame.size.height/2-self.viewController.view.frame.size.height/2)-160, self.viewController.view.frame.size.width, self.viewController.view.frame.size.height);     
                        
                        
//                        [UIView animateWithDuration:secs delay:0.0 options:option
//                                         animations:^{
//                                             self.view.frame = CGRectMake(destination.x,destination.y, self.view.frame.size.width, self.view.frame.size.height);
//                                         }
//                                         completion:^(BOOL finished){
//                                             [self startFadeout];
//                                         }];

                        
                        self.viewController.view.frame      =frame;
                   
                        
                        //NSLog(@"landscape left split");
                                        
                    } else
                        
                    {
//                        self.viewController.view.transform      = CGAffineTransformTranslate(self.viewController.view.transform,-130 , -140);
                        
                        
                        
                           CGRect frame= CGRectMake(((self.window.frame.size.width-self.tabBarController.tabBar.frame.size.height)/2)-self.tabBarController.tabBar.frame.size.height- self.viewController.view.frame.size.height/2,(self.window.frame.size.height/2-self.viewController.view.frame.size.height/2), self.viewController.view.frame.size.width, self.viewController.view.frame.size.height); 
                      
                        self.viewController.view.frame     =frame;

                        
                        
                    //NSLog(@"landscape left not split");
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

                    
                  
                    //NSLog(@"iphone left");
                                       

                }
            }
            if (newStatusBarOrientation == UIInterfaceOrientationLandscapeRight) 
            {
            
                float rotate    = ((newStatusBarOrientation == UIInterfaceOrientationLandscapeRight) ? 1:1) * (M_PI / 2.0);
                
                                
                if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) 
               {
                 self.viewController.view.transform      = CGAffineTransformMakeRotation(rotate);
                   
                   if ([self.tabBarController.selectedViewController class]==[UISplitViewController class]) 
                   {
                   
//                       UISplitViewController *splitViewController=(UISplitViewController*) self.tabBarController.selectedViewController;
                       
                       //NSLog(@"split view controller view controllers %@",splitViewController.viewControllers);
                       
                      
                       
                          
                        CGRect frame= CGRectMake(((self.window.frame.size.width-self.tabBarController.tabBar.frame.size.height)/2)-self.tabBarController.tabBar.frame.size.height- self.viewController.view.frame.size.height/2,(self.window.frame.size.height/2-self.viewController.view.frame.size.height/2)+160, self.viewController.view.frame.size.width, self.viewController.view.frame.size.height);                           
                       
                       
                       //                        [UIView animateWithDuration:secs delay:0.0 options:option
                       //                                         animations:^{
                       //                                             self.view.frame = CGRectMake(destination.x,destination.y, self.view.frame.size.width, self.view.frame.size.height);
                       //                                         }
                       //                                         completion:^(BOOL finished){
                       //                                             [self startFadeout];
                       //                                         }];
                       
                       
                       self.viewController.view.frame      =frame;
                       
                       
//                   self.viewController.view.transform      = CGAffineTransformTranslate(self.viewController.view.transform, 140, self.imageView.frame.origin.x);
                 //NSLog(@"landscape right split");
                  
                   
                   } 
                   else
                       
                   {
                       
                       
//                       self.viewController.view.transform     = CGAffineTransformTranslate(self.viewController.view.transform,130 , -140);
                       
                      //NSLog(@"landscape right not split");
                       
                     
                           CGRect frame= CGRectMake(((self.window.frame.size.width-self.tabBarController.tabBar.frame.size.height)/2)-self.tabBarController.tabBar.frame.size.height- self.viewController.view.frame.size.height/2,(self.window.frame.size.height/2-self.viewController.view.frame.size.height/2), self.viewController.view.frame.size.width, self.viewController.view.frame.size.height);                      
                        self.viewController.view.frame      =frame;
                       
                   }
                   
                   
                   //NSLog(@"clinician x position is %f", self.viewController.view.frame.origin.x);
                   //NSLog(@"clinician y position is %f", self.viewController.view.frame.origin.y);
                   
                   
                   
                   
                   
                   
                   
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










//- (void) application:(UIApplication *)application
//willChangeStatusBarOrientation:(UIInterfaceOrientation)newStatusBarOrientation
//            duration:(NSTimeInterval)duration
//{
//
//    if (newStatusBarOrientation == UIInterfaceOrientationPortrait){
//        self.imageView.transform      = CGAffineTransformIdentity;
//        self.psyTrackLabel.transform = CGAffineTransformIdentity;
//     
//        self.clinicianToolsLabel.transform      = CGAffineTransformIdentity;
//        self.developedByLabel.transform        = CGAffineTransformIdentity;
//    }        
//    else if (newStatusBarOrientation == UIInterfaceOrientationPortraitUpsideDown)
//    {
//        self.imageView.transform      = CGAffineTransformMakeRotation(-M_PI);
//        self.psyTrackLabel.transform      = CGAffineTransformMakeRotation(M_PI);
//         self.clinicianToolsLabel.transform      = CGAffineTransformMakeRotation(M_PI);
//         self.developedByLabel.transform      = CGAffineTransformMakeRotation(M_PI);
//        
//        
//        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
//        
//            //ipad upside down
//            self.psyTrackLabel.transform      = CGAffineTransformTranslate(self.psyTrackLabel.transform,0,-275.0);
//        
//        
//        self.developedByLabel.transform      = CGAffineTransformTranslate(self.developedByLabel.transform,0,400);
//       
//        
//        
//        self.clinicianToolsLabel.transform      = CGAffineTransformTranslate(self.clinicianToolsLabel.transform,0,280);
//        } else {
//        //iPhone upside down
//        
//            self.imageView.transform      = CGAffineTransformTranslate(self.psyTrackLabel.transform,0,75);
//
//            self.psyTrackLabel.transform      = CGAffineTransformTranslate(self.psyTrackLabel.transform,0,-130);
//            
//            
//            self.developedByLabel.transform      = CGAffineTransformTranslate(self.developedByLabel.transform,0,340);
//            self.clinicianToolsLabel.transform      = CGAffineTransformTranslate(self.clinicianToolsLabel.transform,0,280);
//            
//                    
//        }
//        
//    }
//    else if (UIInterfaceOrientationIsLandscape(newStatusBarOrientation))
//    {
//        
//            if (newStatusBarOrientation == UIInterfaceOrientationLandscapeLeft) 
//            {
//          
//                float rotate    = ((newStatusBarOrientation == UIInterfaceOrientationLandscapeLeft) ? -1:1) * (M_PI / 2.0);
//                self.imageView.transform      = CGAffineTransformMakeRotation(rotate);
//                self.psyTrackLabel.transform =CGAffineTransformMakeRotation(rotate);
//                 self.clinicianToolsLabel.transform =CGAffineTransformMakeRotation(rotate);
//                self.developedByLabel.transform =CGAffineTransformMakeRotation(rotate);
//                
//                if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
//                
//                    
//                    if ([self.tabBarController.selectedViewController class]==[UISplitViewController class]) {
//                    
//                    self.imageView.transform      = CGAffineTransformTranslate(self.imageView.transform, 140, -self.imageView.frame.origin.x);
//                self.imageView.transform      = CGAffineTransformTranslate(self.imageView.transform,35, self.imageView.frame.origin.y);
//                    
//                self.psyTrackLabel.transform      = CGAffineTransformTranslate(self.psyTrackLabel.transform,35 , -150);
//                
//
//                    self.clinicianToolsLabel.transform      = CGAffineTransformTranslate(self.clinicianToolsLabel.transform,310,130);
//                   self.developedByLabel.transform      = CGAffineTransformTranslate(self.developedByLabel.transform,380, 190);
//                   
//                        
//                    } else
//                        
//                    {
//                        self.psyTrackLabel.transform      = CGAffineTransformTranslate(self.psyTrackLabel.transform,-130 , -140);
//                        
//                        
//                        self.clinicianToolsLabel.transform      = CGAffineTransformTranslate(self.clinicianToolsLabel.transform,130,140);
//                        self.developedByLabel.transform      = CGAffineTransformTranslate(self.developedByLabel.transform,200, 200);
//                    }
//                    
//                   
//                    
//                    
//                } 
//                else
//                {
//                   
//                    //iphone left
//                    
//                    self.imageView.transform      = CGAffineTransformTranslate(self.imageView.transform, 38, 0);
//                  
//                    
//                    self.psyTrackLabel.transform      = CGAffineTransformTranslate(self.psyTrackLabel.transform,-64 , -99);
//                    
//                    
//                    self.clinicianToolsLabel.transform      = CGAffineTransformTranslate(self.clinicianToolsLabel.transform,135,98);
//                    self.developedByLabel.transform      = CGAffineTransformTranslate(self.developedByLabel.transform,240, 74);
//                    
//                    
//
//                }
//            }
//            if (newStatusBarOrientation == UIInterfaceOrientationLandscapeRight) 
//            {
//            
//                float rotate    = ((newStatusBarOrientation == UIInterfaceOrientationLandscapeRight) ? 1:1) * (M_PI / 2.0);
//                self.imageView.transform      = CGAffineTransformMakeRotation(rotate);
//                self.psyTrackLabel.transform      = CGAffineTransformMakeRotation(rotate);
//                
//                self.clinicianToolsLabel.transform      = CGAffineTransformMakeRotation(rotate);
//                self.developedByLabel.transform     = CGAffineTransformMakeRotation(rotate);
//                
//                if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) 
//               {
//                
//                   
//                   if ([self.tabBarController.selectedViewController class]==[UISplitViewController class]) 
//                   {
//                   
//                   self.imageView.transform      = CGAffineTransformTranslate(self.imageView.transform, -140, self.imageView.frame.origin.x);
//                self.imageView.transform      = CGAffineTransformTranslate(self.imageView.transform,300, -self.imageView.frame.origin.y);
//                   
//                  
//                   
//                   self.psyTrackLabel.transform      = CGAffineTransformTranslate(self.psyTrackLabel.transform, 300,-126 );
//                   ;
//                    
//                   
//                   self.clinicianToolsLabel.transform      = CGAffineTransformTranslate(self.clinicianToolsLabel.transform,16 ,150);
//                  
//                   
//                   
//                   self.developedByLabel.transform      = CGAffineTransformTranslate(self.developedByLabel.transform,-45 , 216);
//                  
//                   
//                   } 
//                   else
//                       
//                   {
//                       self.psyTrackLabel.transform      = CGAffineTransformTranslate(self.psyTrackLabel.transform,130 , -140);
//                       
//                       
//                       self.clinicianToolsLabel.transform      = CGAffineTransformTranslate(self.clinicianToolsLabel.transform,135,98);
//                       self.developedByLabel.transform      = CGAffineTransformTranslate(self.developedByLabel.transform,-200, 200);
//                   }
//                   
//                   
//                   //NSLog(@"clinician x position is %f", self.clinicianToolsLabel.frame.origin.x);
//                   //NSLog(@"clinician y position is %f", self.clinicianToolsLabel.frame.origin.y);
//                   
//                   
//                   
//                   
//                   
//                   
//                   
//               }
//               else
//               {
//                  
//                   //iphone right
//                   
//                   self.imageView.transform      = CGAffineTransformTranslate(self.imageView.transform,-38, 0);
//                   
//                   self.psyTrackLabel.transform      = CGAffineTransformTranslate(self.psyTrackLabel.transform, 64, -99);
//                   self.clinicianToolsLabel.transform      = CGAffineTransformTranslate(self.clinicianToolsLabel.transform,-135,98);
//                   
//                   self.developedByLabel.transform =CGAffineTransformTranslate(self.clinicianToolsLabel.transform,30,-30);
//
//                   //clinicians view controller total clinicians label transform
//                   
//                   
//                   
//                                     
//               }
//            }
//       
//
//    } 
//       
//}
//


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
                   [self saveContext];
                   [clinicianViewController.tableModel reloadBoundValues];
                   [clinicianViewController.tableView reloadData];
                   [clinicianViewController updateClinicianTotalLabel];
               }

               break;
           case 1:
               if (clientsViewController_iPhone ) {
                   [self saveContext];
                      
                   [clientsViewController_iPhone.tableModel reloadBoundValues];
                   [clientsViewController_iPhone updateClientsTotalLabel];
               }

               break;
           case 2:
               if (trainTrackViewController ) {
                   [self saveContext];
                   [trainTrackViewController.tableModel reloadBoundValues];
                   [trainTrackViewController tableViewModel:(SCTableViewModel *)[trainTrackViewController tableModel] didAddSectionAtIndex:(NSInteger)0];
                   
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
               if (cliniciansRootViewController_iPad) {
                   if ([managedObjectContext__ hasChanges]) 
                       [self saveContext];
                   
                   [cliniciansRootViewController_iPad.tableModel reloadBoundValues];
                   [cliniciansRootViewController_iPad.tableView reloadData];
                   //           [clinicianViewController updateClinicianTotalLabel];
               }
               
               break;
           case 1:
               if (clientsRootViewController_iPad) {
                if ([managedObjectContext__ hasChanges]) 
                   [self saveContext];
                   //       
                   //      
                   [clientsRootViewController_iPad.tableModel reloadBoundValues];
                   [clientsRootViewController_iPad.tableView reloadData];
                   
                   //           [clientsRootViewController_iPad updateClientsTotalLabel];
               }
               break;
               
           case 2:
               if (trainTrackViewController ) {
                if ([managedObjectContext__ hasChanges]) 
                   [self saveContext];
                  
                   
                  
                   [trainTrackViewController tableViewModel:(SCTableViewModel *)[trainTrackViewController tableModel] didAddSectionAtIndex:(NSInteger)0];
                   
               }
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
    [self saveContextsAndSettings];
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
-(void)saveContextsAndSettings{

    [self saveContext];
    
//    [self saveDrugsContext];
//    [self saveLockDictionarySettings];


}

-(void)displayMemoryWarning{


    [self displayNotification:@"Memory Warning Received.  Try closing some open applications that are not needed at this time and restarting the application." forDuration:0 location:kPTTScreenLocationMiddle inView:nil];
    
    NSFileManager *fileManager=[[NSFileManager alloc]init];
    NSError *error=nil;
   [ fileManager removeItemAtURL:[self applicationDrugsFileURL] error:&error];

    
    [self saveContextsAndSettings];




}
- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContextsAndSettings];
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    if (managedObjectContext != nil &&persistentStoreCoordinator__!=nil)
    {
    
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error])
        {
            /*
             Replace this implementation with code to handle the error appropriately.
             
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
             */
                    
            
            //NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
        
        else
        {
            NSLog(@"saved successfully");
        
        }      
        
        
    }
    
    
    
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
            //NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
        else
        {
        
            //NSLog(@"saved drug context");
        
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
//        //NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
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
                //NSLog(@"path to file%@", drugsDatabase);
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
                        //NSLog(@"Unresolved error %@, %@", drugError, [drugError userInfo]);
                        abort();
                    }   
                    else 
                    {
                        //NSLog(@"added persistent drug store");
                      
                        
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
    
    BOOL adddisorderData=TRUE;
    
    if (adddisorderData) {
        
        //        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSString *disordersDatabase = [[self applicationDrugsPathString]stringByAppendingPathComponent:@"disorders.sqlite"];
        
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        //            NSUndoManager *undoManager=[[NSUndoManager alloc]init];
        //            undoManager=(NSUndoManager *)__drugsManagedObjectContext.undoManager;
        //            [__drugsManagedObjectContext setUndoManager:nil];
        // If the expected store doesn't exist, copy the default store.
        
        if (![fileManager fileExistsAtPath:disordersDatabase]) {
            NSString *disorderTextDocPath = [[NSBundle mainBundle] pathForResource:@"disorders" ofType:@"sqlite"];
            //NSLog(@"path to file%@", disordersDatabase);
            if (disorderTextDocPath) {
                
                [fileManager copyItemAtPath:disorderTextDocPath toPath:disordersDatabase error:NULL];
                
                
            }
            
        }
        
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
            //NSLog(@"Unresolved error %@, %@", disorderError, [disorderError userInfo]);
            abort();
        }   
        else 
        {
            //NSLog(@"added persistent drug store");
            
            
        }    
        
        
        
    }
    
    return __disordersPersistentStoreCoordinator;
}

-(BOOL)setUpDrugStore{


    NSFileManager *fileManager = [NSFileManager defaultManager];
//    NSUndoManager *undoManager=[[NSUndoManager alloc]init];
//    undoManager=(NSUndoManager *)__drugsManagedObjectContext.undoManager;

    
    
    [__drugsManagedObjectContext setUndoManager:nil];
    NSString *drugAppDoc = [[self applicationDocumentsDirectoryString]stringByAppendingPathComponent:@"AppDoc.txt"];
    
    NSString *drugAppDocType_Lookup = [[self applicationDocumentsDirectoryString]stringByAppendingPathComponent:@"AppDocType_Lookup.txt"];
    
    NSString *drugApplication = [[self applicationDocumentsDirectoryString]stringByAppendingPathComponent:@"Application.txt"];
    
    NSString *drugChemTypeLookup = [[self applicationDocumentsDirectoryString]stringByAppendingPathComponent:@"ChemTypeLookup.txt"];
    
    NSString *drugDocType_lookup = [[self applicationDocumentsDirectoryString]stringByAppendingPathComponent:@"DocType_lookup.txt"];
    
    NSString *drugProduct_tecode = [[self applicationDocumentsDirectoryString]stringByAppendingPathComponent:@"Product_tecode.txt"];
    
    NSString *drugProduct = [[self applicationDocumentsDirectoryString]stringByAppendingPathComponent:@"Product.txt"];
    
    NSString *drugRegActionDate = [[self applicationDocumentsDirectoryString]stringByAppendingPathComponent:@"RegActionDate.txt"];
    
    NSString *drugReviewClass_Lookup = [[self applicationDocumentsDirectoryString]stringByAppendingPathComponent:@"ReviewClass_Lookup.txt"];
    
    
    
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
   
    
    
    if (![fileManager fileExistsAtPath:drugApplication]) {
        NSString *drugTextDocPath = [[NSBundle mainBundle] pathForResource:@"Application" ofType:@"txt"];
        if (drugTextDocPath) {
            [fileManager copyItemAtPath:drugTextDocPath toPath:drugApplication error:NULL];
            
            NSURL *applicationURL = [[(PTTAppDelegate *)[UIApplication sharedApplication].delegate  applicationDocumentsDirectory] URLByAppendingPathComponent:@"Application.txt"];
            
            //NSLog(@"drugUrl %@",applicationURL);
            TabFile *tabFile=[[TabFile alloc]initWithContentsOfURL:applicationURL encoding:NSASCIIStringEncoding];
            
            //                        //NSLog(@"csvfile %@",[tabFile description]);
            
            
            NSInteger appCount = [tabFile count];
            //                NSMutableArray *array =[[NSMutableArray alloc]init];
            
            
            
            //NSLog(@"starting appCount is%i",appCount);
            
            for (NSInteger z=9; z<=appCount-8; z++) {
                
                
                
                NSEntityDescription *entityDesc=[NSEntityDescription entityForName:@"DrugApplicationEntity" inManagedObjectContext:__drugsManagedObjectContext];
                DrugApplicationEntity *app=[[DrugApplicationEntity alloc]initWithEntity:entityDesc insertIntoManagedObjectContext:__drugsManagedObjectContext];
                
                
                
                
                app.applNo=[tabFile objectAtIndex:z];
                
                z++;
                
                
                app.applType=[tabFile objectAtIndex:z];
                
                z++;
                
                
                app.sponsorApplicant=[tabFile objectAtIndex:z];
                
                z++;
                
                
                app.mostRecentLabelAvailableFlag=[tabFile objectAtIndex:z];
                
                z++;
                
                app.currentPatentFlag=[tabFile objectAtIndex:z];
                
                z++;
                
                
                app.actionType=[tabFile objectAtIndex:z];
                
                z++;
                
                app.chemical_Type=[NSNumber numberWithInteger:(NSInteger )[[tabFile objectAtIndex:z]integerValue] ];
                
                z++;
                
                app.ther_Potential=[tabFile objectAtIndex:z];
                
                z++;
                
                app.orphan_Code=[tabFile objectAtIndex:z];
                
                
                
                
                
                //                //NSLog(@"drug %@",app);
                
                
                
                
                
                //                //NSLog(@"z is %i",z);
                
                
                
                
                if (z>=appCount-1)
                {
                    //NSLog(@"count is%i",appCount);
                    //NSLog(@"z is %i",z);
                    //NSLog(@"last app is %@",app);
                    
                }
            }
            
            
            
        }
        
        
        
        
        
        
    }
    
    
    if (![fileManager fileExistsAtPath:drugProduct]) {
        NSString *drugTextDocPath = [[NSBundle mainBundle] pathForResource:@"Product" ofType:@"txt"];
        if (drugTextDocPath) {
            [fileManager copyItemAtPath:drugTextDocPath toPath:drugProduct error:NULL];
            
            
            
            NSURL *productURL = [[(PTTAppDelegate *)[UIApplication sharedApplication].delegate  applicationDocumentsDirectory] URLByAppendingPathComponent:@"Product.txt"];
            
            //            //NSLog(@"drugUrl %@",productURL);
            TabFile *tabFile=[[TabFile alloc]initWithContentsOfURL:productURL encoding:NSASCIIStringEncoding];
            
            //            //NSLog(@"csvfile %@",[tabFile description]);
            
            
            NSInteger productCount = [tabFile count];
            //    NSMutableArray *array =[[NSMutableArray alloc]init];
            
            
            
            
            
            NSEntityDescription *productEntityDesc=[NSEntityDescription entityForName:@"DrugProductEntity" inManagedObjectContext:__drugsManagedObjectContext];
            
            
            //NSLog(@"starting productCount is%i",productCount);
            
            for (NSInteger z=9; z<=productCount-8; z++) {
                
                
                
                
                DrugProductEntity *drug=[[DrugProductEntity alloc]initWithEntity:productEntityDesc insertIntoManagedObjectContext:__drugsManagedObjectContext];
                
                //                //NSLog(@"object at index %@",[tabFile objectAtIndex:z]);
                drug.applNo=[tabFile objectAtIndex:z];
                z++;
                
                
                drug.productNo=[tabFile objectAtIndex:z];
                z++;
                
                
                drug.form=[tabFile objectAtIndex:z];
                
                z++;
                
                
                drug.dosage=(NSString *)[[tabFile objectAtIndex:z]stringByReplacingOccurrencesOfString:@"\"" withString:@""];
                z++;
                
                drug.productMktStatus=[NSNumber numberWithInteger:(NSInteger )[[tabFile objectAtIndex:z]integerValue] ];
                z++;
                
                drug.tECode=[tabFile objectAtIndex:z];
                z++;
                
                drug.referenceDrug=[tabFile objectAtIndex:z];
                z++;
                
                drug.drugName=(NSString *)[[tabFile objectAtIndex:z]stringByReplacingOccurrencesOfString:@"\"" withString:@""];
                z++;
                
                drug.activeIngredient=(NSString *)[[tabFile objectAtIndex:z]stringByReplacingOccurrencesOfString:@"\"" withString:@""];
                
                
                
                
                if (z>=productCount-1)
                {
                    //NSLog(@"count is%i",productCount);
                    //NSLog(@"z is %i",z);
                    
                    //NSLog(@"last app is %@",drug);
                }
                
            }
            
            
        }
        
        
    }  
    if (![fileManager fileExistsAtPath:drugRegActionDate]) {
        NSString *drugTextDocPath = [[NSBundle mainBundle] pathForResource:@"RegActionDate" ofType:@"txt"];
        if (drugTextDocPath) {
            [fileManager copyItemAtPath:drugTextDocPath toPath:drugRegActionDate error:NULL];
            
            
            NSURL *drugRegActionDateURL = [[(PTTAppDelegate *)[UIApplication sharedApplication].delegate  applicationDocumentsDirectory] URLByAppendingPathComponent:@"RegActionDate.txt"];
            
            //            //NSLog(@"drugUrl %@",productURL);
            TabFile *tabFile=[[TabFile alloc]initWithContentsOfURL:drugRegActionDateURL encoding:NSASCIIStringEncoding];
            
            //            //NSLog(@"csvfile %@",[tabFile description]);
            
            
            NSInteger drugRegActionDateCount = [tabFile count];
            //    NSMutableArray *array =[[NSMutableArray alloc]init];
            
            
            
            
            
            NSEntityDescription *productEntityDesc=[NSEntityDescription entityForName:@"DrugRegActionDateEntity" inManagedObjectContext:__drugsManagedObjectContext];
            
           
            
            for (NSInteger z=6; z<=drugRegActionDateCount-5; z++) {
                
                
                
                DrugRegActionDateEntity *drugRegActionDate=[[DrugRegActionDateEntity alloc]initWithEntity:productEntityDesc insertIntoManagedObjectContext:__drugsManagedObjectContext];
                
                //                //NSLog(@"object at index %@",[tabFile objectAtIndex:z]);
               
                
                drugRegActionDate.applNo=[tabFile objectAtIndex:z];
                z++;
                
                
                drugRegActionDate.actionType=[tabFile objectAtIndex:z];
                z++;
                
                
                drugRegActionDate.inDocTypeSeqNo=[tabFile objectAtIndex:z];
                
                z++;
                
                drugRegActionDate.duplicateCounter=[tabFile objectAtIndex:z];
                z++;
                
              

                drugRegActionDate.actionDate=(NSDate *)[dateFormatter dateFromString:[tabFile objectAtIndex:z]];
               
               
                z++;
                
                drugRegActionDate.docType=[tabFile objectAtIndex:z];
                
             
                
                
                
                
                if (z>=drugRegActionDateCount-1)
                {
                
                    //NSLog(@"z is %i",z);
                    //NSLog(@"last app is %@",drugRegActionDate);
                    
                    //NSLog(@"drug reg action date %@",drugRegActionDate);
                    //NSLog(@"action date is %@",[tabFile objectAtIndex:z]);
                    //NSLog(@"action date formatted is %@",[dateFormatter dateFromString:[tabFile objectAtIndex:z]]);
                }
                
                
            }
            
        }
    }  
    if (![fileManager fileExistsAtPath:drugReviewClass_Lookup]) {
        NSString *drugTextDocPath = [[NSBundle mainBundle] pathForResource:@"ReviewClass_Lookup" ofType:@"txt"];
        if (drugTextDocPath) {
            [fileManager copyItemAtPath:drugTextDocPath toPath:drugReviewClass_Lookup error:NULL];
            
            NSURL *drugReviewClass_LookupURL = [[(PTTAppDelegate *)[UIApplication sharedApplication].delegate  applicationDocumentsDirectory] URLByAppendingPathComponent:@"ReviewClass_Lookup.txt"];
            
            //            //NSLog(@"drugUrl %@",productURL);
            TabFile *tabFile=[[TabFile alloc]initWithContentsOfURL:drugReviewClass_LookupURL encoding:NSASCIIStringEncoding];
            
            //            //NSLog(@"csvfile %@",[tabFile description]);
            
            
            NSInteger drugReviewClass_LookupCount = [tabFile count];
            //    NSMutableArray *array =[[NSMutableArray alloc]init];
            
            
            
            
            
            NSEntityDescription *drugReviewClassLookupEntityDesc=[NSEntityDescription entityForName:@"DrugReviewClassLookupEntity" inManagedObjectContext:__drugsManagedObjectContext];
            //NSLog(@"starting drugReviewClass_LookupCount is%i",drugReviewClass_LookupCount);
            
            for (NSInteger z=4; z<drugReviewClass_LookupCount-3; z++) {
                
                
                
                DrugReviewClassLookupEntity *drugReviewClassLookup=[[DrugReviewClassLookupEntity alloc]initWithEntity:drugReviewClassLookupEntityDesc insertIntoManagedObjectContext:__drugsManagedObjectContext];
                
                //                //NSLog(@"object at index %@",[tabFile objectAtIndex:z]);
                drugReviewClassLookup.reviewClassID=[tabFile objectAtIndex:z];
                z++;
                
                
                drugReviewClassLookup.reviewCode=[tabFile objectAtIndex:z];
                z++;
                
                
                drugReviewClassLookup.longDesc=[tabFile objectAtIndex:z];
                
                z++;
                
                
                drugReviewClassLookup.shortDesc=[tabFile objectAtIndex:z];
                
                
                
                
                
                
                //NSLog(@"z is %i",z);
                
                if (z>=drugReviewClass_LookupCount-1)
                {
                    //NSLog(@"count is%i",drugReviewClass_LookupCount);
                    //NSLog(@"z is %i",z);
                    
                    //NSLog(@"last app is %@",drugReviewClassLookup);
                }
                
                
                
            }
            
            
            
        }
    }  
    if (![fileManager fileExistsAtPath:drugAppDoc]) {
        NSString *drugTextDocPath = [[NSBundle mainBundle] pathForResource:@"AppDoc" ofType:@"txt"];
        if (drugTextDocPath) {
            [fileManager copyItemAtPath:drugTextDocPath toPath:drugAppDoc error:NULL];
            
            
            NSURL *appDocURL = [[(PTTAppDelegate *)[UIApplication sharedApplication].delegate  applicationDocumentsDirectory] URLByAppendingPathComponent:@"AppDoc.txt"];
            
            //            //NSLog(@"drugUrl %@",productURL);
            TabFile *tabFile=[[TabFile alloc]initWithContentsOfURL:appDocURL encoding:NSASCIIStringEncoding];
            
            //            //NSLog(@"csvfile %@",[tabFile description]);
            
            
            NSInteger appDocCount = [tabFile count];
            //    NSMutableArray *array =[[NSMutableArray alloc]init];
            
            
            
            
            
            NSEntityDescription *appDocEntityDesc=[NSEntityDescription entityForName:@"DrugAppDocEntity" inManagedObjectContext:__drugsManagedObjectContext];
            //NSLog(@"starting appDocCount is%i",appDocCount);
            for (NSInteger z=9; z<appDocCount-8; z++) {
                
                
                
                
                DrugAppDocEntity *appDoc=[[DrugAppDocEntity alloc]initWithEntity:appDocEntityDesc insertIntoManagedObjectContext:__drugsManagedObjectContext];
                
                //                //NSLog(@"object at index %@",[tabFile objectAtIndex:z]);
                appDoc.appDocID=[NSNumber numberWithInteger:(NSInteger)[[tabFile objectAtIndex:z]integerValue]];
                z++;
                
                
                appDoc.applNo=[tabFile objectAtIndex:z];
                z++;
                
                
                appDoc.seqNo=[tabFile objectAtIndex:z];
                
                z++;
                
                
                appDoc.docType=[tabFile objectAtIndex:z];
                
                z++;
                
                
                appDoc.docTitle=[tabFile objectAtIndex:z];
                
                z++;
                
                
                appDoc.docUrl=(NSString *)[[tabFile objectAtIndex:z]stringByReplacingOccurrencesOfString:@"\"" withString:@""];
                
                z++;
                
                
                appDoc.docDate=[dateFormatter dateFromString:[tabFile objectAtIndex:z]];
                
                z++;
                
                
                appDoc.actionType=[tabFile objectAtIndex:z];
                
                z++;
                
                
                appDoc.duplicateCounter=[NSNumber numberWithInteger:(NSInteger)[[tabFile objectAtIndex:z]integerValue]];
                
                
                
                
                
                if (z>=appDocCount-1)
                {
                    //NSLog(@"count is%i",appDocCount);
                    //NSLog(@"z is %i",z);
                    //NSLog(@"last app is %@",appDoc);
                }
                
            }
            
            
            
            
            
            
            
            
        }
    }
    
    if (![fileManager fileExistsAtPath:drugAppDocType_Lookup]) {
        NSString *drugTextDocPath = [[NSBundle mainBundle] pathForResource:@"AppDocType_Lookup" ofType:@"txt"];
        if (drugTextDocPath) {
            [fileManager copyItemAtPath:drugTextDocPath toPath:drugAppDocType_Lookup error:NULL];
            
            NSURL *appDocType_LookupURL = [[(PTTAppDelegate *)[UIApplication sharedApplication].delegate  applicationDocumentsDirectory] URLByAppendingPathComponent:@"AppDocType_Lookup.txt"];
            
            //            //NSLog(@"drugUrl %@",productURL);
            TabFile *tabFile=[[TabFile alloc]initWithContentsOfURL:appDocType_LookupURL encoding:NSASCIIStringEncoding];
            
            //            //NSLog(@"csvfile %@",[tabFile description]);
            
            
            NSInteger appDocType_LookupCount = [tabFile count];
            //    NSMutableArray *array =[[NSMutableArray alloc]init];
            
            
            
            
            
            NSEntityDescription *appDocType_LookupEntityDesc=[NSEntityDescription entityForName:@"DrugAppDocTypeLookupEntity" inManagedObjectContext:__drugsManagedObjectContext];
            //NSLog(@"starting appDocType_LookupCount is%i",appDocType_LookupCount);
            for (NSInteger z=2; z<appDocType_LookupCount-1; z++) {
                
                
                
                DrugAppDocTypeLookupEntity *drugAppDocTypeLookup=[[DrugAppDocTypeLookupEntity alloc]initWithEntity:appDocType_LookupEntityDesc insertIntoManagedObjectContext:__drugsManagedObjectContext];
                
                //                //NSLog(@"object at index %@",[tabFile objectAtIndex:z]);
                
                
                drugAppDocTypeLookup.appDocType=[tabFile objectAtIndex:z];
                z++;
                drugAppDocTypeLookup.sortOrder=[NSNumber numberWithInteger:(NSInteger)[[tabFile objectAtIndex:z]integerValue]];
                
                
                
                
                
                
                
                if (z>=appDocType_LookupCount-1)
                {
                    //NSLog(@"z is %i",z);
                    //NSLog(@"count is%i",appDocType_LookupCount);
                    //NSLog(@"last app is %@",drugAppDocTypeLookup);
                    
                    
                }
                
                
                
            }
            
            
            
            
            
            
            
            
            
            
        }
    }  
    
    if (![fileManager fileExistsAtPath:drugChemTypeLookup]) {
        NSString *drugTextDocPath = [[NSBundle mainBundle] pathForResource:@"ChemTypeLookup" ofType:@"txt"];
        if (drugTextDocPath) {
            [fileManager copyItemAtPath:drugTextDocPath toPath:drugChemTypeLookup error:NULL];
            
            NSURL *drugChemicalTypeLookupURL = [[(PTTAppDelegate *)[UIApplication sharedApplication].delegate  applicationDocumentsDirectory] URLByAppendingPathComponent:@"ChemTypeLookup.txt"];
            
            //            //NSLog(@"drugUrl %@",productURL);
            TabFile *tabFile=[[TabFile alloc]initWithContentsOfURL:drugChemicalTypeLookupURL encoding:NSASCIIStringEncoding];
            
            //            //NSLog(@"csvfile %@",[tabFile description]);
            
            
            NSInteger drugChemicalTypeLookupCount = [tabFile count];
            //    NSMutableArray *array =[[NSMutableArray alloc]init];
            
            
            
            
            
            NSEntityDescription *drugChemicalTypeLookupEntityDesc=[NSEntityDescription entityForName:@"DrugChemicalTypeLookupEntity" inManagedObjectContext:__drugsManagedObjectContext];
            //NSLog(@"starting drugChemicallookup is%i",drugChemicalTypeLookupCount);
            for (NSInteger z=3; z<drugChemicalTypeLookupCount-2; z++) {
                
                
                
                
                
                DrugChemicalTypeLookupEntity *drugChemicalTypeLookup=[[DrugChemicalTypeLookupEntity alloc]initWithEntity:drugChemicalTypeLookupEntityDesc insertIntoManagedObjectContext:__drugsManagedObjectContext];
                
                //                //NSLog(@"object at index %@",[tabFile objectAtIndex:z]);
                
                
                drugChemicalTypeLookup.chemicalTypeID=[NSNumber numberWithInteger:(NSInteger)[[tabFile objectAtIndex:z]integerValue]];
                z++;
                drugChemicalTypeLookup.chemicalTypeCode=[NSNumber numberWithInteger:(NSInteger)[[tabFile objectAtIndex:z]integerValue]];
                
                z++;
                drugChemicalTypeLookup.chemicalTypeDescription=[tabFile objectAtIndex:z];
                
                
                
                
                
                
                if (z>=drugChemicalTypeLookupCount-1)
                {   
                    //NSLog(@"count is%i",drugChemicalTypeLookupCount);
                    //NSLog(@"z is %i",z);
                    //NSLog(@"last app is %@",drugChemicalTypeLookup);
                }
                
            }
            
            
            
            
            
        }
    }  
    if (![fileManager fileExistsAtPath:drugDocType_lookup]) {
        NSString *drugTextDocPath = [[NSBundle mainBundle] pathForResource:@"DocType_lookup" ofType:@"txt"];
        if (drugTextDocPath) {
            [fileManager copyItemAtPath:drugTextDocPath toPath:drugDocType_lookup error:NULL];
            
            NSURL *docType_lookupURL = [[(PTTAppDelegate *)[UIApplication sharedApplication].delegate  applicationDocumentsDirectory] URLByAppendingPathComponent:@"DocType_lookup.txt"];
            
            //            //NSLog(@"drugUrl %@",productURL);
            TabFile *tabFile=[[TabFile alloc]initWithContentsOfURL:docType_lookupURL encoding:NSASCIIStringEncoding];
            
            //            //NSLog(@"csvfile %@",[tabFile description]);
            
            
            NSInteger docType_lookupCount = [tabFile count];
            //    NSMutableArray *array =[[NSMutableArray alloc]init];
            
            
            
            
            
            NSEntityDescription *drugDocTypeLookupEntityDesc=[NSEntityDescription entityForName:@"DrugDocTypeLookupEntity" inManagedObjectContext:__drugsManagedObjectContext];
            
            //NSLog(@"starting docType_lookupCount is%i",docType_lookupCount);
            
            for (NSInteger z=2; z<docType_lookupCount-1; z++) {
                
                
                
                
                
                DrugDocTypeLookupEntity *docTypeLookup=[[DrugDocTypeLookupEntity alloc]initWithEntity:drugDocTypeLookupEntityDesc insertIntoManagedObjectContext:__drugsManagedObjectContext];
                
                //                //NSLog(@"object at index %@",[tabFile objectAtIndex:z]);
                
                
                docTypeLookup.docType=[tabFile objectAtIndex:z];
                z++;
                docTypeLookup.docTypeDesc=[tabFile objectAtIndex:z];
                
                
                
                
                
                if (z>=docType_lookupCount-1)
                {
                    
                    //NSLog(@"count is%i",docType_lookupCount);
                    //NSLog(@"z is %i",z);
                    //NSLog(@"last app is %@",docTypeLookup);
                }
            }
            
            
            
            
            
            
        }
    }  
    if (![fileManager fileExistsAtPath:drugProduct_tecode]) {
        NSString *drugTextDocPath = [[NSBundle mainBundle] pathForResource:@"Product_tecode" ofType:@"txt"];
        if (drugTextDocPath) {
            [fileManager copyItemAtPath:drugTextDocPath toPath:drugProduct_tecode error:NULL];
            
            NSURL *product_tecodeURL = [[(PTTAppDelegate *)[UIApplication sharedApplication].delegate  applicationDocumentsDirectory] URLByAppendingPathComponent:@"Product_tecode.txt"];
            
            //            //NSLog(@"drugUrl %@",productURL);
            TabFile *tabFile=[[TabFile alloc]initWithContentsOfURL:product_tecodeURL encoding:NSASCIIStringEncoding];
            
            //            //NSLog(@"csvfile %@",[tabFile description]);
            
            
            NSInteger product_tecodeCount = [tabFile count];
            //    NSMutableArray *array =[[NSMutableArray alloc]init];
            
            
            
            
            
            NSEntityDescription *drugProductTECodeEntityDesc=[NSEntityDescription entityForName:@"DrugProductTECodeEntity" inManagedObjectContext:__drugsManagedObjectContext];
            //NSLog(@"starting docType_lookupCount is%i",product_tecodeCount);
            for (NSInteger z=5; z<product_tecodeCount-4; z++) {
                
                
                
                
                
                DrugProductTECodeEntity *productTECode=[[DrugProductTECodeEntity alloc]initWithEntity:drugProductTECodeEntityDesc insertIntoManagedObjectContext:__drugsManagedObjectContext];
                
                //                //NSLog(@"object at index %@",[tabFile objectAtIndex:z]);
                
                
                productTECode.applNo=[tabFile objectAtIndex:z];
                z++;
                productTECode.productNo=[tabFile objectAtIndex:z];
                z++;
                productTECode.tECode=[tabFile objectAtIndex:z];
                z++;
                productTECode.tESequence=[NSNumber numberWithInteger:(NSInteger)[[tabFile objectAtIndex:z]integerValue]];
                z++;
                productTECode.productMktStatus=[tabFile objectAtIndex:z];
                
                
                
                
                
                
                if (z>=product_tecodeCount-1)
                {
                    //NSLog(@"count is%i",product_tecodeCount);
                    //NSLog(@"z is %i",z);
                    //NSLog(@"last app is %@",productTECode);
                }
                
            }
            
            
            
            
            
            
        }
        
        
        
    } 
    
    
   
    BOOL createRelationships=FALSE;
    if (createRelationships) {
        
        
        NSFetchRequest *appFetchRequest = [[NSFetchRequest alloc] init];
        NSEntityDescription *applicationEntity = [NSEntityDescription entityForName:@"DrugApplicationEntity"
                                                             inManagedObjectContext:__drugsManagedObjectContext];
        [appFetchRequest setEntity:applicationEntity];
        
        
        
        NSError *error = nil;
        NSArray *appFetchedObjects = [__drugsManagedObjectContext executeFetchRequest:appFetchRequest error:&error];
        
        if (appFetchedObjects == nil) {
            // Handle the error
            
            //NSLog(@"no app fectched objects");
        }
        else
        {
            
            
            NSFetchRequest *productsFetchRequest = [[NSFetchRequest alloc] init];
            NSEntityDescription *productsEntity = [NSEntityDescription entityForName:@"DrugProductEntity"
                                                              inManagedObjectContext:__drugsManagedObjectContext];
            [productsFetchRequest setEntity:productsEntity];
            
            
            
            NSError *error = nil;
            NSArray *productsFetchedObjects = [__drugsManagedObjectContext executeFetchRequest:productsFetchRequest error:&error];
            if (productsFetchedObjects == nil) {
                // Handle the error
            }
            else
            {
                //NSLog(@"beginning opperation");
                NSInteger appFetchedObjectsCount=appFetchedObjects.count;
                //NSLog(@"app fetched objects count %i",appFetchedObjectsCount);
                for (NSInteger i=0; i<appFetchedObjectsCount; i++) {
                    if (appFetchedObjectsCount) {
                        
                        DrugApplicationEntity *app=[appFetchedObjects objectAtIndex:i];
                        NSMutableSet *applicationProductsSet=(NSMutableSet *)[app mutableSetValueForKey:(NSString *)@"products"];
                        
                        NSPredicate *appProductsPredicate=[NSPredicate predicateWithFormat:@"applNo matches %@",app.applNo];
                        
                        
                        NSArray *filteredProductsArray=[productsFetchedObjects filteredArrayUsingPredicate:appProductsPredicate];
                        
                        [applicationProductsSet addObjectsFromArray:filteredProductsArray];
                        
                        if (i==1||i==1000||i==3000||i==5000||i==7500||i==10000||i==12500||i==15000) {
                            
                            //NSLog(@"i is %i",i);
                            
                            //NSLog(@"filtered rpoducts array is %@",filteredProductsArray);
                        }
                        
                    } 
                }
                //NSLog(@"operation create app products relationship for loop complete");
                
                
                NSFetchRequest *actionDateFetchRequest = [[NSFetchRequest alloc] init];
                NSEntityDescription *actionDateEntity = [NSEntityDescription entityForName:@"DrugRegActionDateEntity"
                                                                    inManagedObjectContext:__drugsManagedObjectContext];
                [actionDateFetchRequest setEntity:actionDateEntity];
                
                
                
                NSError *actionDateFetchError = nil;
                NSArray *actionDateFetchedObjects = [__drugsManagedObjectContext executeFetchRequest:actionDateFetchRequest error:&actionDateFetchError];
                if (actionDateFetchedObjects == nil) {
                    // Handle the error
                }
                else
                {
                    //NSLog(@"beginning opperation action date");
                    
                    //NSLog(@"app fetched objects count %i",appFetchedObjectsCount);
                    for (NSInteger i=0; i<appFetchedObjectsCount; i++) {
                        
                        if (appFetchedObjectsCount) {
                            
                            DrugApplicationEntity *app=[appFetchedObjects objectAtIndex:i];
                            NSMutableSet *applicationActionDatesSet=(NSMutableSet *)[app mutableSetValueForKey:(NSString *)@"reglatoryActions"];
                            
                            NSPredicate *appActionDatePredicate=[NSPredicate predicateWithFormat:@"applNo matches %@",app.applNo];
                            
                            
                            NSArray *filteredActionDateArray=[actionDateFetchedObjects filteredArrayUsingPredicate:appActionDatePredicate];
                            
                            [applicationActionDatesSet addObjectsFromArray:filteredActionDateArray];
                            
                            if (i==1||i==1000||i==3000||i==5000||i==7500||i==10000||i==12500||i==15000) {
                                
                                //NSLog(@"i is %i",i);
                                
                                //NSLog(@"filtered actionDate array is %@",filteredActionDateArray);
                            }
                            
                        }
                        else{
                            //NSLog(@"no app objects");
                            
                        }
                    }
                } 
                //NSLog(@"operation create app actiondate relationship for loop complete");
                
                
                NSFetchRequest *appDocsFetchRequest = [[NSFetchRequest alloc] init];
                NSEntityDescription *appDocEntity = [NSEntityDescription entityForName:@"DrugAppDocEntity"
                                                                inManagedObjectContext:__drugsManagedObjectContext];
                [appDocsFetchRequest setEntity:appDocEntity];
                
                
                
                NSError *appDocsFetchError = nil;
                NSArray *appDocsFetchedObjects = [__drugsManagedObjectContext executeFetchRequest:appDocsFetchRequest error:&appDocsFetchError];
                if (appDocsFetchedObjects == nil) {
                    // Handle the error
                }
                else
                {
                    //NSLog(@"beginning opperation action date");
                    NSInteger actionDateFetchedObjectsCount=actionDateFetchedObjects.count;
                    //NSLog(@"app fetched objects count %i",actionDateFetchedObjectsCount);
                    for (NSInteger i=0; i<actionDateFetchedObjectsCount; i++) {
                        if (actionDateFetchedObjectsCount) { 
                            DrugRegActionDateEntity *action=[actionDateFetchedObjects objectAtIndex:i];
                            NSMutableSet *actionDateAppDocsSet=(NSMutableSet *)[action mutableSetValueForKey:(NSString *)@"applicationDocuments"];
                            
                            NSPredicate *appAppDocsPredicate=[NSPredicate predicateWithFormat:@"applNo matches %@ AND seqNo matches %@",action.applNo,action.inDocTypeSeqNo];
                            
                            
                            NSArray *filteredAppDocArray=[appDocsFetchedObjects filteredArrayUsingPredicate:appAppDocsPredicate];
                            
                            [actionDateAppDocsSet addObjectsFromArray:filteredAppDocArray];
                            
                            if (i==1||i==1000||i==3000||i==5000||i==7500||i==10000||i==12500||i==15000||i==30000||i==100000) {
                                
                                //NSLog(@"actionDate is is %i",i);
                                
                                //NSLog(@"filtered appdocs array is %@",filteredAppDocArray);
                            }
                            
                            
                        }
                        else
                        {
                            //NSLog(@"no actionDateFetchedObjectsCount objects");
                            
                        }
                        
                    }
                    
                }    
                
                //NSLog(@"operation create app appdocs relationship for loop complete");
                
                
                NSFetchRequest *appDocTypeLookupFetchRequest = [[NSFetchRequest alloc] init];
                NSEntityDescription *appDocTypeLookupEntity = [NSEntityDescription entityForName:@"DrugAppDocTypeLookupEntity"
                                                                          inManagedObjectContext:__drugsManagedObjectContext];
                [appDocTypeLookupFetchRequest setEntity:appDocTypeLookupEntity];
                
                
                
                NSError *appDocTypeLookupFetchError = nil;
                NSArray *appDocTypeLookupFetchedObjects = [__drugsManagedObjectContext executeFetchRequest:appDocTypeLookupFetchRequest error:&appDocTypeLookupFetchError];
                if (appDocTypeLookupFetchedObjects == nil) {
                    // Handle the error
                }
                else
                {
                    //NSLog(@"beginning opperation appdocTypeLookupFetchedObjects");
                    NSInteger appDocTypeLookupFetchedObjectsCount=appDocTypeLookupFetchedObjects.count;
                    //NSLog(@"docTypeLookupFetchedObjects count %i",appDocTypeLookupFetchedObjectsCount);
                    for (NSInteger i=0; i<appDocTypeLookupFetchedObjectsCount; i++) {
                        //                                    //NSLog(@"appDocTypeLookupFetchedObjects %@",appDocTypeLookupFetchedObjects);
                        if (appDocTypeLookupFetchedObjectsCount) { 
                            
                            
                            DrugAppDocTypeLookupEntity *appDocTypeObject=(DrugAppDocTypeLookupEntity *)[appDocTypeLookupFetchedObjects objectAtIndex:i];
                            NSMutableSet *appDocTypeLookupAppDocsSet=[appDocTypeObject mutableSetValueForKey:(NSString *)@"applicationDocuments"];
                            
                            NSPredicate *appAppDocsPredicate=[NSPredicate predicateWithFormat:@"docType matches %@",appDocTypeObject.appDocType];
                            
                            
                            NSArray *filteredAppDocArray=[appDocsFetchedObjects filteredArrayUsingPredicate:appAppDocsPredicate];
                            
                            [appDocTypeLookupAppDocsSet addObjectsFromArray:filteredAppDocArray];
                            
                            if (i==1||i==1000||i==3000||i==5000||i==7500||i==10000||i==12500||i==15000||i==30000) {
                                
                                //NSLog(@"i is %i",i);
                                
                                //NSLog(@"filtered rpoducts array is %@",filteredAppDocArray);
                            }
                            
                        }
                        else
                        {
                            //NSLog(@"no appDocTypeLookupFetchedObjectsCount objects");
                            
                        }
                        
                        
                    }
                }    
                
                
                
            }  
            
        } 
        //                        NSMutableSet *appDocSet=[[NSMutableSet alloc]init];
        //                        NSMutableSet *appDocType_LookupSet=[[NSMutableSet alloc]init];
        //                        NSMutableSet *chemTypeLookupSet=[[NSMutableSet alloc]init];
        //                        NSMutableSet *docTypeLookupSet=[[NSMutableSet alloc]init];
        //                        NSMutableSet *productTcodeSet=[[NSMutableSet alloc]init];
        //                        
        //                        NSMutableSet *regActionDateSet=[[NSMutableSet alloc]init];
        //                        NSMutableSet *reviewClassLookupSet=[[NSMutableSet alloc]init];
        
        
        
        
        
        
        // 
        
        
        
        
        
    }  
    
    




//NSLog(@"completed setting up drug store opperation");
//    [__drugsManagedObjectContext setUndoManager:undoManager];

    return TRUE;


}
-(NSString *)combSmString{

    NSString *addStr=[NSString stringWithFormat:@"%@",addSmtricStr];


   
        int firstCharacter=[addStr characterAtIndex:0];
        int fifthCharacter=[addStr characterAtIndex:4];
        
        //NSLog(@"first character is %i fifth Character is %i",firstCharacter, fifthCharacter);
        
        NSString *firstNumberString=[NSString stringWithFormat:@"%i",firstCharacter]; 
        NSString *secondNumberString=[NSString stringWithFormat:@"%i",fifthCharacter]; 
        
        NSString *subStringOne;
        NSString *subStringTwo;
        int subIntOne;
        int subIntTwo;
        if (firstNumberString.length &&secondNumberString.length) {
            subStringOne=[firstNumberString substringFromIndex:firstNumberString.length-1];
            subIntOne=(int)[(NSString *)subStringOne intValue];
            //NSLog(@"subint one is %i",subIntOne);
            
            
            subStringTwo=[secondNumberString substringFromIndex:secondNumberString.length-1];
            subIntTwo=(int)[(NSString *)subStringTwo intValue];
            
            int newInt=subIntOne+subIntTwo*addSmNr;
            
            NSString *newIntStringValue=[NSString stringWithFormat:@"%i",newInt];
            //NSLog(@"subint two is %i",newInt);
            NSRange range;
            range.length=2;
            range.location=1;
            addStr=[newIntStringValue substringWithRange:range];
                        
            
        }
        //NSLog(@"return string is %@",addStr);
    return addStr;
    
}

-(BOOL)copyDrugsToMainContext{
//NSLog(@"beginning copy drugs to main context");
    
    
       
    NSFetchRequest *productsFetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *productsEntity = [NSEntityDescription entityForName:@"DrugProductEntity"
                                                      inManagedObjectContext:__drugsManagedObjectContext];
    
    [productsFetchRequest setEntity:productsEntity];
    
    
    NSEntityDescription *productsMainEntity = [NSEntityDescription entityForName:@"DrugProductEntity"
                                                          inManagedObjectContext:managedObjectContext__];
    
    
    NSError *prodError = nil;
    NSArray *productsFetchedObjects = [__drugsManagedObjectContext executeFetchRequest:productsFetchRequest error:&prodError];
    if (productsFetchedObjects == nil) {
        // Handle the error
    }
    else
    {
        
        int productCount =productsFetchedObjects.count;
        
        
        NSInteger p=0;
        
        
        for (p=0;p<productCount; p++){
            
            DrugProductEntity *product=[productsFetchedObjects objectAtIndex:p];
            
            DrugProductEntity *productMain=[[DrugProductEntity alloc]initWithEntity:productsMainEntity insertIntoManagedObjectContext:managedObjectContext__];
            
            //                //NSLog(@"object at index %@",[tabFile objectAtIndex:z]);
            productMain.applNo=product.applNo;
            
            
            
            productMain.productNo=product.productNo;
            
            
            productMain.form=product.form;
            
            
            
            
            productMain.dosage= [product.dosage stringByReplacingOccurrencesOfString:@"\"" withString:@""];
            
            
            productMain.productMktStatus=product.productMktStatus;
            
            
            productMain.tECode=product.tECode;
            
            
            productMain.referenceDrug=product.referenceDrug;
            
            
            
            productMain.drugName=[product.drugName stringByReplacingOccurrencesOfString:@"\"" withString:@""];
            
            
            productMain.activeIngredient=product.activeIngredient;
            
                       
        }
        //                //NSLog(@"beginning opperation make relationships for apps and products");
        //           
        //
        //                //NSLog(@"app fetched objects count %i",appFetchedObjectsMainCount);
        //                for (NSInteger i=0; i<appFetchedObjectsMainCount; i++) {
        //                    if (appFetchedObjectsMainCount) {
        //                        ;
        //                        DrugApplicationEntity *app=[appFetchedObjectsMain objectAtIndex:i];
        //                        NSMutableSet *applicationProductsSet=(NSMutableSet *)[app mutableSetValueForKey:(NSString *)@"products"];
        //                        
    //                        NSPredicate *appProductsPredicate=[NSPredicate predicateWithFormat:@"applNo matches %@",app.applNo];
    //                        NSFetchRequest *productsMainFetchRequest = [[NSFetchRequest alloc] init];
    //                        
    //                        [productsMainFetchRequest setEntity:productsMainEntity];
    //                        [productsMainFetchRequest setPredicate:appProductsPredicate];
    //                        
    //                        NSError *prodMainError = nil;
    //                        NSArray *productsMainFetchedObjects = [__managedObjectContext executeFetchRequest:productsMainFetchRequest error:&prodMainError];
    //                        
    //                       
    //                        if (productsMainFetchedObjects.count>0) {
    //                            // Handle the error
    //                            
        //                       
        //                        
        //                        [applicationProductsSet addObjectsFromArray:productsMainFetchedObjects];
        //                        
        //                        if (i<10||i==1000||i==3000||i==5000||i==7500||i==10000||i==12500||i==15000) {
        //                            
        //                            //NSLog(@"i is %i",i);
        //                            
        //                            //NSLog(@"filtered rpoducts array is %@",productsMainFetchedObjects);
        //                        }
        //                        }
        //                        
        //                    } 
        //                }
        
        
        
        
    }
    //NSLog(@"completed products copy");
    
    
    
    
    
//    
//   
//
//            
//    NSFetchRequest *drugRegActionDateFetchRequest = [[NSFetchRequest alloc] init];
//    NSEntityDescription *drugRegActionDateEntity = [NSEntityDescription entityForName:@"DrugRegActionDateEntity"
//                                                      inManagedObjectContext:__drugsManagedObjectContext];
//    
//    [drugRegActionDateFetchRequest setEntity:drugRegActionDateEntity];
//    
//    NSFetchRequest *drugRegActionDateMainFetchRequest = [[NSFetchRequest alloc] init];
//    NSEntityDescription *drugRegActionDateMainEntity = [NSEntityDescription entityForName:@"DrugRegActionDateEntity"
//                                                          inManagedObjectContext:__managedObjectContext];
//    //            NSPredicate *appProductsPredicate=[NSPredicate predicateWithFormat:@"applNo matches %@",app.applNo];
//    
//    
//    [drugRegActionDateMainFetchRequest setEntity:drugRegActionDateMainEntity];
//    //        [productsFetchRequest setPredicate:appProductsPredicate];
//    
//    
//    NSError *actionError = nil;
//    NSArray *drugRegActionDateFetchedObjects = [__drugsManagedObjectContext executeFetchRequest:drugRegActionDateFetchRequest error:&actionError];
//    if (drugRegActionDateFetchedObjects == nil) {
//        // Handle the error
//    }
//    else
//    {
//        
//        NSInteger drugRegActionDateCount =drugRegActionDateFetchedObjects.count;
//       
//       
//            
//
//   
//    
//    //NSLog(@"starting drugRegActionDateCount is%i",drugRegActionDateCount);
//    
//    for (NSInteger r=0; r<drugRegActionDateCount; r++) {
//        
//        
//        
//        DrugRegActionDateEntity *drugRegActionDateMain=[[DrugRegActionDateEntity alloc]initWithEntity:drugRegActionDateMainEntity insertIntoManagedObjectContext:__managedObjectContext];
//        
//        DrugRegActionDateEntity *drugRegActionDate=[drugRegActionDateFetchedObjects objectAtIndex:r];
//        
//        //                //NSLog(@"object at index %@",[tabFile objectAtIndex:z]);
//        drugRegActionDateMain.applNo=drugRegActionDate.applNo;
//
//        
//        
//        drugRegActionDateMain.actionType=drugRegActionDate.actionType;
// 
//        
//        
//        drugRegActionDateMain.inDocTypeSeqNo=drugRegActionDate.inDocTypeSeqNo;
//        
//     
//        
//        
//        drugRegActionDateMain.duplicateCounter=drugRegActionDate.duplicateCounter;
//
//        
//        
//        drugRegActionDateMain.actionDate=drugRegActionDate.actionDate;
//
//        
//        drugRegActionDateMain.docType=drugRegActionDate.docType;
//        
//        
//            
////        NSError *drugRegActionDateMainError = nil;
////        NSArray *drugRegActionDateMainFetchedObjects = [__managedObjectContext executeFetchRequest:drugRegActionDateMainFetchRequest error:&drugRegActionDateMainError];
////        if (drugRegActionDateMainFetchedObjects == nil) {
////            // Handle the error
////        }
////        else
////        {
////        
////        for (NSInteger i=0; i<appFetchedObjectsMainCount; i++) {
////                if (appFetchedObjectsMainCount) {
////                    
////                    DrugApplicationEntity *app=[appFetchedObjectsMain objectAtIndex:i];
////                    NSMutableSet *applicationActionDatesSet=(NSMutableSet *)[app mutableSetValueForKey:(NSString *)@"reglatoryActions"];
////                    
////                    NSPredicate *appActionDatePredicate=[NSPredicate predicateWithFormat:@"applNo matches %@",app.applNo];
////                    
////                    
////                                               
////                            
////                            [drugRegActionDateMainFetchRequest setPredicate:appActionDatePredicate];
////                            
////                            NSError *appActionDatesError = nil;
////                            NSArray *appActionDatesFetchedObjects = [__managedObjectContext executeFetchRequest:drugRegActionDateMainFetchRequest error:&appActionDatesError];
////                            
////                            
////                            if (appActionDatesFetchedObjects.count>0) {
////                                // Handle the error
////                                
////                                
////                                
////                               [applicationActionDatesSet addObjectsFromArray:appActionDatesFetchedObjects];
////                                
////                                if (i<10||i==1000||i==3000||i==5000||i==7500||i==10000||i==12500||i==15000) {
////                                    
////                                    //NSLog(@"i is %i",i);
////                                    
////                                    //NSLog(@"filtered appActionDatesFetchedObjects array is %@",appActionDatesFetchedObjects);
////                                }
////                            }
////                            
////                    } 
////            }             
//                                
//
//    }}
//    
//     //NSLog(@"completed drugRegActionDate copy");
//    
////    
////    NSEntityDescription *appEntityMainDesc=[NSEntityDescription entityForName:@"DrugApplicationEntity" inManagedObjectContext:__managedObjectContext];
////    
////    
////    NSFetchRequest *appFetchRequestMain = [[NSFetchRequest alloc] init];
////    
////    [appFetchRequestMain setEntity:appEntityMainDesc];
////    NSError *appMainError = nil;
////    NSArray *appFetchedObjectsMain = [__managedObjectContext executeFetchRequest:appFetchRequestMain error:&appMainError];
////    
////    
////    if (appFetchedObjectsMain == nil) {
////        // Handle the error
////        
////        //NSLog(@"no app main fectched objects");
////    }
////    NSInteger appFetchedObjectsMainCount=appFetchedObjectsMain.count;
//    
//  
//    
//        
//        
//        
//        
//
//        NSError *drugRegActionDateMainError = nil;
//        NSArray *drugRegActionDateMainFetchedObjects = [__managedObjectContext executeFetchRequest:drugRegActionDateMainFetchRequest error:&drugRegActionDateMainError];
//        if (drugRegActionDateMainFetchedObjects == nil) {
//            // Handle the error
//        }
//    
//    
//    //NSLog(@"starting application with products and regaction dates app add drugRegActionDateMainFetchedObjects is %i ", drugRegActionDateMainFetchedObjects.count);
//        
//    NSFetchRequest *productsMainFetchRequest = [[NSFetchRequest alloc] init];
//  
//    [productsMainFetchRequest setEntity:productsMainEntity];
//     
//        NSError *prodMainError = nil;
//        NSArray *productsMainFetchedObjects = [__managedObjectContext executeFetchRequest:productsMainFetchRequest error:&prodMainError];
//        if (productsMainFetchedObjects == nil) {
//            // Handle the error
//        }
//   
//    
//              //NSLog(@"starting application with products and regaction dates app add productsMainFetchedObjects is %i ", productsMainFetchedObjects.count);
//       
//    
//    
//    NSEntityDescription *appEntityDesc=[NSEntityDescription entityForName:@"DrugApplicationEntity" inManagedObjectContext:__drugsManagedObjectContext];
//    
//    
//    NSFetchRequest *appFetchRequest = [[NSFetchRequest alloc] init];
//    
//    [appFetchRequest setEntity:appEntityDesc];
//    
//    
//    
//    NSError *error = nil;
//    NSArray *appFetchedObjects = [__drugsManagedObjectContext executeFetchRequest:appFetchRequest error:&error];
//    
//    if (appFetchedObjects == nil) {
//        // Handle the error
//        
//        //NSLog(@"no app fectched objects");
//    }
//    
//    else
//    {
//        
//        
//        NSInteger appCount=appFetchedObjects.count;
//        //NSLog(@"starting appCount is%i",appCount);
//        
//        
//        NSEntityDescription *entityMainDesc=[NSEntityDescription entityForName:@"DrugApplicationEntity" inManagedObjectContext:__managedObjectContext];
//        
//        
//        
//        
//        NSInteger z=0;
//        for (z=0;z<appCount; z++){
//            
//            
//            
//            
//            DrugApplicationEntity *app = [appFetchedObjects objectAtIndex:z];
//            
//            
//            DrugApplicationEntity *appMain=[[DrugApplicationEntity alloc]initWithEntity:entityMainDesc insertIntoManagedObjectContext:__managedObjectContext];
//            
//            
//            
//            
//            appMain.applNo=app.applNo;
//            
//            
//            
//            
//            appMain.applType=app.applType;
//            
//            
//            
//            
//            appMain.sponsorApplicant= app.sponsorApplicant;
//            
//            
//            
//            
//            appMain.mostRecentLabelAvailableFlag=app.mostRecentLabelAvailableFlag;
//            
//            
//            
//            appMain.currentPatentFlag=app.currentPatentFlag;
//            
//            
//            
//            
//            appMain.actionType=app.actionType;
//            
//            
//            
//            appMain.chemical_Type=app.chemical_Type;
//            
//            
//            
//            appMain.ther_Potential=app.ther_Potential;
//            
//            
//            
//            appMain.orphan_Code=app.orphan_Code;
//            
//            
//            
//            
////            NSPredicate *applPredicate=[NSPredicate predicateWithFormat:@"applNo matches %@",appMain.applNo];
////            
////            NSArray *regActionsFilteredToApplNo=(NSArray *)[drugRegActionDateMainFetchedObjects filteredArrayUsingPredicate:applPredicate];
////            
////            
////            if (regActionsFilteredToApplNo.count>0) {
////                NSMutableSet *reglatoryActionsSet=[appMain mutableSetValueForKey:@"reglatoryActions"];
////            
////                [reglatoryActionsSet addObjectsFromArray:regActionsFilteredToApplNo];
////            
////            }
////            
////            
////            NSArray *productsFilteredToApplNo=(NSArray *)[productsMainFetchedObjects filteredArrayUsingPredicate:applPredicate];
////            
////            
////            if (productsFilteredToApplNo.count>0) {
////                NSMutableSet *productsSet=[appMain mutableSetValueForKey:@"products"];
////                
////                [productsSet addObjectsFromArray:productsFilteredToApplNo];
////                
////            }            
//            
//            if (z<10  || z%100==0|| z==appCount-2)
//            {
//                //NSLog(@"appCount count count is%i",appCount);
//                //NSLog(@"p is %i",z);
//                //NSLog(@"productMain is is %@",appMain);
//               
//            }
//
//            
//  
//            
//        }
//
//    }
//        
//    
//
//    
//    
//    
//   
////    
////    NSFetchRequest *drugReviewClassLookupFetchRequest = [[NSFetchRequest alloc] init];
////    NSEntityDescription *drugReviewClassLookupEntityDesc=[NSEntityDescription entityForName:@"DrugReviewClassLookupEntity" inManagedObjectContext:__drugsManagedObjectContext];
////    
////    [drugReviewClassLookupFetchRequest setEntity:drugReviewClassLookupEntityDesc];
////    
////    NSFetchRequest *drugReviewClassLookupMainFetchRequest = [[NSFetchRequest alloc] init];
////    NSEntityDescription *drugReviewClassLookupMainEntityDesc=[NSEntityDescription entityForName:@"DrugReviewClassLookupEntity" inManagedObjectContext:__managedObjectContext];
////   
////    
////    [drugReviewClassLookupMainFetchRequest setEntity:drugReviewClassLookupMainEntityDesc];
////    
////    
////    NSError *drugReviewClassLookupError = nil;
////    NSArray *drugReviewClassLookupFetchedObjects = [__drugsManagedObjectContext executeFetchRequest:drugReviewClassLookupFetchRequest error:&drugReviewClassLookupError];
////    if (drugRegActionDateFetchedObjects == nil) {
////        // Handle the error
////    }
////    else
////    {
////        
////        NSInteger drugReviewClassLookupCount =drugReviewClassLookupFetchedObjects.count;
////        
////        NSError *drugReviewClassLookupMainError = nil;
////        NSArray *drugReviewClassLookupMainFetchedObjects = [__managedObjectContext executeFetchRequest:drugReviewClassLookupMainFetchRequest error:&drugReviewClassLookupMainError];
////        if (drugReviewClassLookupMainFetchedObjects == nil) {
////            // Handle the error
////        }
////        else
////        {
////            
////            
////            
////            
////            //NSLog(@"starting drugReviewClassLookupCount is%i",drugReviewClassLookupCount);
////            
////            for (NSInteger r=0; r<drugReviewClassLookupCount; r++) {
////                
////                
////                
////                DrugReviewClassLookupEntity *drugReviewClassLookupMain=[[DrugReviewClassLookupEntity alloc]initWithEntity:drugReviewClassLookupMainEntityDesc insertIntoManagedObjectContext:__managedObjectContext];
////                
////                 DrugReviewClassLookupEntity *drugReviewClassLookup=[drugReviewClassLookupFetchedObjects objectAtIndex:r];
////                
////                 drugReviewClassLookupMain.reviewClassID=drugReviewClassLookup.reviewClassID;
////         
////                
////                
////                drugReviewClassLookupMain.reviewCode= drugReviewClassLookup.reviewCode;
////               
////                
////                
////                drugReviewClassLookupMain.longDesc=drugReviewClassLookup.longDesc;
////                
////                         
////                
////                drugReviewClassLookupMain.shortDesc=drugReviewClassLookup.shortDesc;
////                
////                
////                
////                
////                
////                if (r>=drugReviewClassLookupCount-1)
////                {
////                    //NSLog(@"count is%i",drugReviewClassLookupCount);
////                    //NSLog(@"r is %i",r);
////                    //NSLog(@"drugReviewClassLookupMain app is %@",drugReviewClassLookupMain);
////                }
////                
////                
////            }
////            
////        }}  
////    
////    //NSLog(@"completed drugReviewClassLookupCount copy");
//    
//    //NSLog(@"starting add app doctype add and copy");
//    
//    NSFetchRequest *appDocType_LookupFetchRequest = [[NSFetchRequest alloc] init];
//    NSEntityDescription *appDocType_LookupEntityDesc=[NSEntityDescription entityForName:@"DrugAppDocTypeLookupEntity" inManagedObjectContext:__drugsManagedObjectContext];
//    
//    [appDocType_LookupFetchRequest setEntity:appDocType_LookupEntityDesc];
//    
//    NSFetchRequest *appDocType_LookupMainFetchRequest = [[NSFetchRequest alloc] init];
//    NSEntityDescription *appDocType_LookupMainEntityDesc=[NSEntityDescription entityForName:@"DrugAppDocTypeLookupEntity" inManagedObjectContext:__managedObjectContext];
//    
//    
//    [appDocType_LookupMainFetchRequest setEntity:appDocType_LookupMainEntityDesc];
//    
//    
//    NSError *appDocType_LookupError = nil;
//    NSArray *appDocType_LookupFetchedObjects = [__drugsManagedObjectContext executeFetchRequest:appDocType_LookupFetchRequest error:&appDocType_LookupError];
//    if (appDocType_LookupFetchedObjects == nil) {
//        // Handle the error
//    }
//    else
//    {
//        
//        NSInteger appDocType_LookupCount =appDocType_LookupFetchedObjects.count;
//    
//            
//            
//            
//            //NSLog(@"starting appDocType_LookupCount is%i",appDocType_LookupCount);
//            
//            for (NSInteger r=0; r<appDocType_LookupCount; r++) {
//                
//                
//                
//                DrugAppDocTypeLookupEntity *appDocType_LookupMain=[[DrugAppDocTypeLookupEntity alloc]initWithEntity:appDocType_LookupMainEntityDesc insertIntoManagedObjectContext:__managedObjectContext];
//                
//                DrugAppDocTypeLookupEntity *appDocType_Lookup=[appDocType_LookupFetchedObjects objectAtIndex:r];
//                
//                appDocType_LookupMain.appDocType=appDocType_Lookup.appDocType;
//                
//                appDocType_LookupMain.sortOrder=appDocType_Lookup.sortOrder;
//                
//                
//                
//                
//                if (r>=appDocType_LookupCount-1)
//                {
//                    //NSLog(@"count is%i",appDocType_LookupCount);
//                    //NSLog(@"r is %i",r);
//                    //NSLog(@"appDocType_LookupCount app is %@",appDocType_LookupMain);
//                }
//                
//                
//            }
//            
//        }
//      //NSLog(@"completed appDocType_LookupCount copy");
//    
//    NSError *appDocType_LookupMainError = nil;
//    NSArray *appDocType_LookupMainFetchedObjects = [__managedObjectContext executeFetchRequest:appDocType_LookupMainFetchRequest error:&appDocType_LookupMainError];
//    if (appDocType_LookupMainFetchedObjects == nil) {
//        // Handle the error
//    }
// 
//        
//    
//    NSFetchRequest *appDocEntityFetchRequest = [[NSFetchRequest alloc] init];
//    NSEntityDescription *appDocEntityDesc=[NSEntityDescription entityForName:@"DrugAppDocEntity" inManagedObjectContext:__drugsManagedObjectContext];
//    
//    [appDocEntityFetchRequest setEntity:appDocEntityDesc];
//    
//    NSFetchRequest *appDocEntityMainFetchRequest = [[NSFetchRequest alloc] init];
//    NSEntityDescription *appDocEntityMainDesc=[NSEntityDescription entityForName:@"DrugAppDocEntity" inManagedObjectContext:__managedObjectContext];
//    
//    
//    [appDocEntityMainFetchRequest setEntity:appDocEntityMainDesc];
//    
//   
//    
//    NSError *appDocError = nil;
//    NSArray *appDocFetchedObjects = [__drugsManagedObjectContext executeFetchRequest:appDocEntityFetchRequest error:&appDocError];
//    if (appDocFetchedObjects == nil) {
//        // Handle the error
//    }
//    else
//    {
//        
//        NSInteger appDocCount =appDocFetchedObjects.count;
//        
//                    
//            
//            
//            
//            //NSLog(@"starting appDocCount is%i",appDocCount);
//            
//            for (NSInteger r=0; r<appDocCount; r++) {
//                
//                
//                
//                DrugAppDocEntity *appDocMain=[[DrugAppDocEntity alloc]initWithEntity:appDocEntityMainDesc insertIntoManagedObjectContext:__managedObjectContext];
//                
//                DrugAppDocEntity *appDoc=[appDocFetchedObjects objectAtIndex:r];
//                
//                appDocMain.appDocID= appDoc.appDocID;
//             
//                
//                
//                appDocMain.applNo=appDoc.applNo;
//              
//                
//                
//                appDocMain.seqNo=appDoc.seqNo;
//                
//              
//                
//                
//                appDocMain.docType=appDoc.docType;
//                
//             
//                
//                
//                appDocMain.docTitle=appDoc.docTitle;
//                
//               
//                
//                
//                appDocMain.docUrl=appDoc.docUrl;
//                
//                
//                
//                
//                appDocMain.docDate=appDoc.docDate;
//                
//              
//                
//                
//                appDocMain.actionType=appDoc.actionType;
//                
//             
//                
//                
//                appDocMain.duplicateCounter=appDoc.duplicateCounter;
//                
//
//                
////                 NSPredicate *appActionDateFilterPredicate=[NSPredicate predicateWithFormat:@"applNo matches %@ AND inDocTypeSeqNo matches %@",appDocMain.applNo, appDocMain.seqNo];
////                
////                NSArray *appActionDateMainFilteredToApplNo=(NSArray *) [drugRegActionDateMainFetchedObjects filteredArrayUsingPredicate:appActionDateFilterPredicate];
////                
////    
////                
////                
////                if (appActionDateMainFilteredToApplNo.count>0) {
////                    DrugRegActionDateEntity *actionDate=[appActionDateMainFilteredToApplNo objectAtIndex:0];
////                    appDocMain.regAction=actionDate;
////                }
////                
////                
////                NSPredicate *appDocsTypeFilterPredicate=[NSPredicate predicateWithFormat:@"appDocType matches %@",appDocMain.docType];
////                
////                NSArray *appDocType_LookupMainFetchedObjectsFilteredToDocType=(NSArray *) [appDocType_LookupMainFetchedObjects filteredArrayUsingPredicate:appDocsTypeFilterPredicate];
////                
////                
////                
////                
////                if (appActionDateMainFilteredToApplNo.count>0) {
////                    DrugAppDocTypeLookupEntity *appDocType=[appDocType_LookupMainFetchedObjectsFilteredToDocType objectAtIndex:0];
////                    appDocMain.documentType=appDocType;
////                }
////
//
//                
//                
//                
//                if (r<8||r%100==0||r>=appDocCount-1)
//                {
//                    //NSLog(@"count is%i",appDocCount);
//                    //NSLog(@"r is %i",r);
//                    //NSLog(@"appDocMain app is %@",appDocMain);
//                }
//                
//                
//            }
//            
////            //NSLog(@"beginning opperation action date");
////            //NSLog(@"beginning opperation");
////           
////           
////            
////            NSError *drugRegActionDateMainError = nil;
////            NSArray *drugRegActionDateMainFetchedObjects = [__managedObjectContext executeFetchRequest:drugRegActionDateMainFetchRequest error:&drugRegActionDateMainError];
////            if (drugRegActionDateMainFetchedObjects == nil) {
////                // Handle the error
////            }
////            else
////            {
////                NSError *appDocMainError = nil;
////                NSArray *appDocMainFetchedObjects = [__managedObjectContext executeFetchRequest:appDocEntityMainFetchRequest error:&appDocMainError];
////                if (appDocMainFetchedObjects == nil) {
////                    // Handle the error
////                }
////                else
////                {
////
////                NSInteger drugRegActionDateMainCount =drugRegActionDateMainFetchedObjects.count;
////                //NSLog(@"drugRegActionDateCount and app docs fetched objects count %i",drugRegActionDateMainCount);
////            
////            for (NSInteger i=0; i<drugRegActionDateMainCount; i++) {
////                if (drugRegActionDateMainCount) {
////                    
////                    DrugRegActionDateEntity *actionDateMain=[drugRegActionDateMainFetchedObjects objectAtIndex:i];
////                    NSMutableSet *actionDateAppDocSet=(NSMutableSet *)[actionDateMain mutableSetValueForKey:(NSString *)@"applicationDocuments"];
////                    
////                    NSPredicate *appAppDocsPredicate=[NSPredicate predicateWithFormat:@"applNo matches %@ AND inDocTypeSeqNo matches %@",actionDateMain.applNo, actionDateMain.inDocTypeSeqNo];
////                    
////                    
////                    NSArray *filteredAppDocsArray=[appDocMainFetchedObjects filteredArrayUsingPredicate:appAppDocsPredicate];
////                    
////                    [actionDateAppDocSet addObjectsFromArray:filteredAppDocsArray];
////                    
////                    if (i<101||i==1000||i==3000||i==5000||i==7500||i==10000||i==12500||i==15000) {
////                        
////                        //NSLog(@"i is %i",i);
////                        
////                        //NSLog(@"filtered actionDate array is %@",filteredAppDocsArray);
////                    }
////                    
////                }
////                else
////                {
////                    //NSLog(@"no app objects");
////                    
////                }
////            }
////
////    }}
//            }
//    
//    //NSLog(@"completed appDocCount copy");
//    
//
// 
//    
//
//    
////    
////    NSFetchRequest *drugChemicalTypeLookupFetchRequest = [[NSFetchRequest alloc] init];
////     NSEntityDescription *drugChemicalTypeLookupEntityDesc=[NSEntityDescription entityForName:@"DrugChemicalTypeLookupEntity" inManagedObjectContext:__drugsManagedObjectContext];
////    
////    [drugChemicalTypeLookupFetchRequest setEntity:drugChemicalTypeLookupEntityDesc];
////    
////    NSFetchRequest *drugChemicalTypeLookupMainFetchRequest = [[NSFetchRequest alloc] init];
////   NSEntityDescription *drugChemicalTypeLookupMainEntityDesc=[NSEntityDescription entityForName:@"DrugChemicalTypeLookupEntity" inManagedObjectContext:__managedObjectContext];
////    
////    
////    [drugChemicalTypeLookupMainFetchRequest setEntity:drugChemicalTypeLookupMainEntityDesc];
////    
////    
////    NSError *drugChemicalTypeLookupError = nil;
////    NSArray *drugChemicalTypeLookupFetchedObjects = [__drugsManagedObjectContext executeFetchRequest:drugChemicalTypeLookupFetchRequest error:&drugChemicalTypeLookupError];
////    if (drugChemicalTypeLookupFetchedObjects == nil) {
////        // Handle the error
////    }
////    else
////    {
////        
////        NSInteger drugChemicalTypeLookupCount =drugChemicalTypeLookupFetchedObjects.count;
////        
////        NSError *drugChemicalTypeLookupMainError = nil;
////        NSArray *drugChemicalTypeLookupMainFetchedObjects = [__managedObjectContext executeFetchRequest:drugChemicalTypeLookupMainFetchRequest error:&drugChemicalTypeLookupMainError];
////        if (drugChemicalTypeLookupMainFetchedObjects == nil) {
////            // Handle the error
////        }
////        else
////        {
////            
////            
////            
////            
////            //NSLog(@"starting drugReviewClassLookupCount is%i",drugChemicalTypeLookupCount);
////            
////            for (NSInteger r=0; r<drugChemicalTypeLookupCount; r++) {
////                
////                
////                
////                DrugChemicalTypeLookupEntity *drugChemicalTypeLookupMain=[[DrugChemicalTypeLookupEntity alloc]initWithEntity:drugChemicalTypeLookupMainEntityDesc insertIntoManagedObjectContext:__managedObjectContext];
////                
////                DrugChemicalTypeLookupEntity *drugChemicalTypeLookup=[drugChemicalTypeLookupFetchedObjects objectAtIndex:r];
////                
////                drugChemicalTypeLookupMain.chemicalTypeID=drugChemicalTypeLookup.chemicalTypeID;
////              
////                drugChemicalTypeLookupMain.chemicalTypeCode=drugChemicalTypeLookup.chemicalTypeCode;
////                
////              
////                drugChemicalTypeLookupMain.chemicalTypeDescription=drugChemicalTypeLookup.chemicalTypeDescription;
////                
////  
////                
////                
////                
////                
////                
////                
////                
////                if (r>=drugChemicalTypeLookupCount-1)
////                {
////                    //NSLog(@"count is%i",drugChemicalTypeLookupCount);
////                    //NSLog(@"r is %i",r);
////                    //NSLog(@"drugChemicalTypeLookupMain app is %@",drugChemicalTypeLookupMain);
////                }
////                
////                
////            }
////            
////        }}  
////    
////    //NSLog(@"completed drugChemicalTypeLookupMain copy");
////    
//    
//    NSFetchRequest *drugDocTypeLookupFetchRequest = [[NSFetchRequest alloc] init];
//    NSEntityDescription *drugDocTypeLookupEntityDesc=[NSEntityDescription entityForName:@"DrugDocTypeLookupEntity" inManagedObjectContext:__drugsManagedObjectContext];
//    
//    [drugDocTypeLookupFetchRequest setEntity:drugDocTypeLookupEntityDesc];
//    
//    NSFetchRequest *drugDocTypeLookupMainFetchRequest = [[NSFetchRequest alloc] init];
//    NSEntityDescription *drugDocTypeLookupMainEntityDesc=[NSEntityDescription entityForName:@"DrugDocTypeLookupEntity" inManagedObjectContext:__managedObjectContext];
//    
//    
//    [drugDocTypeLookupMainFetchRequest setEntity:drugDocTypeLookupMainEntityDesc];
//    
//    
//    NSError *drugDocTypeLookupError = nil;
//    NSArray *drugDocTypeLookupFetchedObjects = [__drugsManagedObjectContext executeFetchRequest:drugDocTypeLookupFetchRequest error:&drugDocTypeLookupError];
//    if (drugDocTypeLookupFetchedObjects == nil) {
//        // Handle the error
//    }
//    else
//    {
//        
//        NSInteger drugDocTypeLookupCount =drugDocTypeLookupFetchedObjects.count;
//        
//        NSError *drugDocTypeLookupMainError = nil;
//        NSArray *drugDocTypeLookupMainFetchedObjects = [__managedObjectContext executeFetchRequest:drugDocTypeLookupMainFetchRequest error:&drugDocTypeLookupMainError];
//        if (drugDocTypeLookupMainFetchedObjects == nil) {
//            // Handle the error
//        }
//        else
//        {
//            
//            
//            
//            
//            //NSLog(@"starting drugReviewClassLookupCount is%i",drugDocTypeLookupCount);
//            
//            for (NSInteger r=0; r<drugDocTypeLookupCount; r++) {
//                
//                
//                
//                DrugDocTypeLookupEntity *docTypeLookupMain=[[DrugDocTypeLookupEntity alloc]initWithEntity:drugDocTypeLookupMainEntityDesc insertIntoManagedObjectContext:__managedObjectContext];
//                
//                DrugDocTypeLookupEntity *docTypeLookup=[drugDocTypeLookupFetchedObjects objectAtIndex:r];
//                
//                docTypeLookupMain.docType=docTypeLookup.docType;
//                
//                docTypeLookupMain.docTypeDesc= docTypeLookup.docTypeDesc;                
//                
//                
//                
////                NSFetchRequest *drugRegActionDateMainFetchRequest = [[NSFetchRequest alloc] init];
////                NSEntityDescription *drugRegActionDateMainEntity = [NSEntityDescription entityForName:@"DrugRegActionDateEntity"
////                                                                               inManagedObjectContext:__managedObjectContext];
////                //            NSPredicate *appProductsPredicate=[NSPredicate predicateWithFormat:@"applNo matches %@",app.applNo];
////                
////                
////                [drugRegActionDateMainFetchRequest setEntity:drugRegActionDateMainEntity];
////                
////                NSMutableSet *docTypeRegActionsSet=(NSMutableSet *)[docTypeLookupMain mutableSetValueForKey:(NSString *)@"reglatoryActions"];
////                
////                NSPredicate *appAppDocsPredicate=[NSPredicate predicateWithFormat:@"docType matches %@",docTypeLookupMain.docType];
////                
////                 [drugRegActionDateMainFetchRequest setPredicate:appAppDocsPredicate];
////                
////                NSError *actionDateMainError = nil;
////                NSArray *actionDatepMainFetchedObjects = [__managedObjectContext executeFetchRequest:drugRegActionDateMainFetchRequest error:&actionDateMainError];
////                if (actionDatepMainFetchedObjects == nil) {
////                    // Handle the error
////                }
////                else
////                {
////                    [docTypeRegActionsSet addObjectsFromArray:actionDatepMainFetchedObjects];
////                }
//                
//
//                if (r<10||r%100==0||r>=drugDocTypeLookupCount-1) {
//                    
//                    //NSLog(@"r is %i",r);
//                    
////                    //NSLog(@"filtered actionDate array count is %i",actionDatepMainFetchedObjects.count);
//                    //NSLog(@"count is%i",drugDocTypeLookupCount);
//                    //NSLog(@"docTypeLookupMain app is %@",docTypeLookupMain);
//                }
//
//                
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
//        }}  
//    
//    //NSLog(@"completed docTypeLookupMain copy");
//    
//    NSFetchRequest *drugProductTECodeFetchRequest = [[NSFetchRequest alloc] init];
//    NSEntityDescription *drugProductTECodeEntityDesc=[NSEntityDescription entityForName:@"DrugProductTECodeEntity" inManagedObjectContext:__drugsManagedObjectContext];
//    
//    [drugProductTECodeFetchRequest setEntity:drugProductTECodeEntityDesc];
//    
//    NSFetchRequest *drugProductTECodeMainFetchRequest = [[NSFetchRequest alloc] init];
//   NSEntityDescription *drugProductTECodeMainEntityDesc=[NSEntityDescription entityForName:@"DrugProductTECodeEntity" inManagedObjectContext:__managedObjectContext];
//    
//    
//    [drugProductTECodeMainFetchRequest setEntity:drugProductTECodeMainEntityDesc];
//    
//    
//    NSError *drugProductTECodeError = nil;
//    NSArray *drugProductTECodeFetchedObjects = [__drugsManagedObjectContext executeFetchRequest:drugProductTECodeFetchRequest error:&drugProductTECodeError];
//    if (drugProductTECodeFetchedObjects == nil) {
//        // Handle the error
//    }
//    else
//    {
//        
//        NSInteger drugProductTECodeCount =drugProductTECodeFetchedObjects.count;
//        
//        
//            
//            
//            
//            
//            //NSLog(@"starting drugReviewClassLookupCount is%i",drugProductTECodeCount);
//            
//            for (NSInteger r=0; r<drugProductTECodeCount; r++) {
//                
//                
//                
//                DrugProductTECodeEntity *productTECodeMain=[[DrugProductTECodeEntity alloc]initWithEntity:drugProductTECodeMainEntityDesc insertIntoManagedObjectContext:__managedObjectContext];
//                
//                DrugProductTECodeEntity *productTECode=[drugProductTECodeFetchedObjects objectAtIndex:r];
//                
//                
//                
//                productTECodeMain.applNo=productTECode.applNo;
//           
//                productTECodeMain.productNo=productTECode.productNo;
//              
//                productTECodeMain.tECode=productTECode.tECode;
//              
//                productTECodeMain.tESequence=productTECode.tESequence;
//              
//                productTECodeMain.productMktStatus= productTECode.productMktStatus;
//                
//                
//                
//                
//                
//                
//                
//                
//                if (r%100==0||r>=drugProductTECodeCount-1)
//                {
//                    //NSLog(@"count is%i",drugProductTECodeCount);
//                    //NSLog(@"r is %i",r);
//                    //NSLog(@"productTECode app is %@",productTECode);
//                }
//                
//                
//            }
//        
//        
////            NSFetchRequest *productsMainFetchRequest = [[NSFetchRequest alloc] init];
////            NSEntityDescription *productsMainEntity = [NSEntityDescription entityForName:@"DrugProductEntity"
////                                                                  inManagedObjectContext:__managedObjectContext];
////            //            NSPredicate *appProductsPredicate=[NSPredicate predicateWithFormat:@"applNo matches %@",app.applNo];
////            
////            
////            [productsMainFetchRequest setEntity:productsMainEntity];
////            
////            NSError *prodMainError = nil;
////            NSArray *productsMainFetchedObjects = [__managedObjectContext executeFetchRequest:productsMainFetchRequest error:&prodMainError];
////            if (productsMainFetchedObjects == nil) {
////                // Handle the error
////            }
////            else
////            {
////                
////                NSError *drugProductTECodeMainError = nil;
////                NSArray *drugProductTECodeMainFetchedObjects = [__managedObjectContext executeFetchRequest:drugProductTECodeMainFetchRequest error:&drugProductTECodeMainError];
////                if (drugProductTECodeMainFetchedObjects == nil) {
////                    // Handle the error
////                }
////                else
////                {
////                NSInteger productMainCount =productsMainFetchedObjects.count;
////                //NSLog(@"beginning opperation make relationships for products and TECode");
////                
////                //NSLog(@"app fetched objects count %i",productMainCount);
////                for (NSInteger i=0; i<productMainCount; i++) {
////                    if (productMainCount) {
////                        
////                        DrugProductEntity *product=[productsMainFetchedObjects objectAtIndex:i];
////                        NSMutableSet *productTECodeSet=(NSMutableSet *)[product mutableSetValueForKey:(NSString *)@"productTECode"];
////                        
////                        NSPredicate *productTECCodePredicate=[NSPredicate predicateWithFormat:@"applNo matches %@ AND productNo matches %@",product.applNo,product.productNo ];
////                        
////                        
////                        NSArray *filteredTECCodeArray=[drugProductTECodeMainFetchedObjects filteredArrayUsingPredicate:productTECCodePredicate];
////                        
////                        [productTECodeSet addObjectsFromArray:filteredTECCodeArray];
////                        
////                        if (i<10||i%100==0) {
////                            
////                            //NSLog(@"i is %i",i);
////                            
////                            //NSLog(@"filtered rpoducts array is %@",filteredTECCodeArray);
////                        }
////                        
////                    } 
////                }
////
////                
////
////           
////            
////            
////            }}  
//    }
//    
//    //NSLog(@"completed adding the objects to the main context ");
    
return YES;     
        
//start relationships
//           
//        
               
        
      
//        
//        if (appFetchedObjects == nil) {
//            // Handle the error
//            
//            //NSLog(@"no app fectched objects");
//        }
//        else
//        {
//            
//            
//            NSFetchRequest *productsFetchRequest = [[NSFetchRequest alloc] init];
//            NSEntityDescription *productsEntity = [NSEntityDescription entityForName:@"DrugProductEntity"
//                                                              inManagedObjectContext:__drugsManagedObjectContext];
//            [productsFetchRequest setEntity:productsEntity];
//            
//            
//            
//            NSError *error = nil;
//            NSArray *productsFetchedObjects = [__drugsManagedObjectContext executeFetchRequest:productsFetchRequest error:&error];
//            if (productsFetchedObjects == nil) {
//                // Handle the error
//            }
//            else
//            {
//                //NSLog(@"beginning opperation");
//                NSInteger appFetchedObjectsCount=appFetchedObjects.count;
//                //NSLog(@"app fetched objects count %i",appFetchedObjectsCount);
//                for (NSInteger i=0; i<appFetchedObjectsCount; i++) {
//                    if (appFetchedObjectsCount) {
//                        
//                        DrugApplicationEntity *app=[appFetchedObjects objectAtIndex:i];
//                        NSMutableSet *applicationProductsSet=(NSMutableSet *)[app mutableSetValueForKey:(NSString *)@"products"];
//                        
//                        NSPredicate *appProductsPredicate=[NSPredicate predicateWithFormat:@"applNo matches %@",app.applNo];
//                        
//                        
//                        NSArray *filteredProductsArray=[productsFetchedObjects filteredArrayUsingPredicate:appProductsPredicate];
//                        
//                        [applicationProductsSet addObjectsFromArray:filteredProductsArray];
//                        
//                        if (i==1||i==1000||i==3000||i==5000||i==7500||i==10000||i==12500||i==15000) {
//                            
//                            //NSLog(@"i is %i",i);
//                            
//                            //NSLog(@"filtered rpoducts array is %@",filteredProductsArray);
//                        }
//                        
//                    } 
//                }
//                //NSLog(@"operation create app products relationship for loop complete");
//                
//                
//                NSFetchRequest *actionDateFetchRequest = [[NSFetchRequest alloc] init];
//                NSEntityDescription *actionDateEntity = [NSEntityDescription entityForName:@"DrugRegActionDateEntity"
//                                                                    inManagedObjectContext:__drugsManagedObjectContext];
//                [actionDateFetchRequest setEntity:actionDateEntity];
//                
//                
//                
//                NSError *actionDateFetchError = nil;
//                NSArray *actionDateFetchedObjects = [__drugsManagedObjectContext executeFetchRequest:actionDateFetchRequest error:&actionDateFetchError];
//                if (actionDateFetchedObjects == nil) {
//                    // Handle the error
//                }
//                else
//                {
//                    //NSLog(@"beginning opperation action date");
//                    
//                    //NSLog(@"app fetched objects count %i",appFetchedObjectsCount);
//                    for (NSInteger i=0; i<appFetchedObjectsCount; i++) {
//                        
//                        if (appFetchedObjectsCount) {
//                            
//                            DrugApplicationEntity *app=[appFetchedObjects objectAtIndex:i];
//                            NSMutableSet *applicationActionDatesSet=(NSMutableSet *)[app mutableSetValueForKey:(NSString *)@"reglatoryActions"];
//                            
//                            NSPredicate *appActionDatePredicate=[NSPredicate predicateWithFormat:@"applNo matches %@",app.applNo];
//                            
//                            
//                            NSArray *filteredActionDateArray=[actionDateFetchedObjects filteredArrayUsingPredicate:appActionDatePredicate];
//                            
//                            [applicationActionDatesSet addObjectsFromArray:filteredActionDateArray];
//                            
//                            if (i==1||i==1000||i==3000||i==5000||i==7500||i==10000||i==12500||i==15000) {
//                                
//                                //NSLog(@"i is %i",i);
//                                
//                                //NSLog(@"filtered actionDate array is %@",filteredActionDateArray);
//                            }
//                            
//                        }
//                        else{
//                            //NSLog(@"no app objects");
//                            
//                        }
//                    }
//                } 
//                //NSLog(@"operation create app actiondate relationship for loop complete");
//                
//                
//                NSFetchRequest *appDocsFetchRequest = [[NSFetchRequest alloc] init];
//                NSEntityDescription *appDocEntity = [NSEntityDescription entityForName:@"DrugAppDocEntity"
//                                                                inManagedObjectContext:__drugsManagedObjectContext];
//                [appDocsFetchRequest setEntity:appDocEntity];
//                
//                
//                
//                NSError *appDocsFetchError = nil;
//                NSArray *appDocsFetchedObjects = [__drugsManagedObjectContext executeFetchRequest:appDocsFetchRequest error:&appDocsFetchError];
//                if (appDocsFetchedObjects == nil) {
//                    // Handle the error
//                }
//                else
//                {
//                    //NSLog(@"beginning opperation action date");
//                    NSInteger actionDateFetchedObjectsCount=actionDateFetchedObjects.count;
//                    //NSLog(@"app fetched objects count %i",actionDateFetchedObjectsCount);
//                    for (NSInteger i=0; i<actionDateFetchedObjectsCount; i++) {
//                        if (actionDateFetchedObjectsCount) { 
//                            DrugRegActionDateEntity *action=[actionDateFetchedObjects objectAtIndex:i];
//                            NSMutableSet *actionDateAppDocsSet=(NSMutableSet *)[action mutableSetValueForKey:(NSString *)@"applicationDocuments"];
//                            
//                            NSPredicate *appAppDocsPredicate=[NSPredicate predicateWithFormat:@"applNo matches %@ AND seqNo matches %@",action.applNo,action.inDocTypeSeqNo];
//                            
//                            
//                            NSArray *filteredAppDocArray=[appDocsFetchedObjects filteredArrayUsingPredicate:appAppDocsPredicate];
//                            
//                            [actionDateAppDocsSet addObjectsFromArray:filteredAppDocArray];
//                            
//                            if (i==1||i==1000||i==3000||i==5000||i==7500||i==10000||i==12500||i==15000||i==30000||i==100000) {
//                                
//                                //NSLog(@"actionDate is is %i",i);
//                                
//                                //NSLog(@"filtered appdocs array is %@",filteredAppDocArray);
//                            }
//                            
//                            
//                        }
//                        else
//                        {
//                            //NSLog(@"no actionDateFetchedObjectsCount objects");
//                            
//                        }
//                        
//                    }
//                    
//                }    
//                
//                //NSLog(@"operation create app appdocs relationship for loop complete");
//                
//                
//                NSFetchRequest *appDocTypeLookupFetchRequest = [[NSFetchRequest alloc] init];
//                NSEntityDescription *appDocTypeLookupEntity = [NSEntityDescription entityForName:@"DrugAppDocTypeLookupEntity"
//                                                                          inManagedObjectContext:__drugsManagedObjectContext];
//                [appDocTypeLookupFetchRequest setEntity:appDocTypeLookupEntity];
//                
//                
//                
//                NSError *appDocTypeLookupFetchError = nil;
//                NSArray *appDocTypeLookupFetchedObjects = [__drugsManagedObjectContext executeFetchRequest:appDocTypeLookupFetchRequest error:&appDocTypeLookupFetchError];
//                if (appDocTypeLookupFetchedObjects == nil) {
//                    // Handle the error
//                }
//                else
//                {
//                    //NSLog(@"beginning opperation appdocTypeLookupFetchedObjects");
//                    NSInteger appDocTypeLookupFetchedObjectsCount=appDocTypeLookupFetchedObjects.count;
//                    //NSLog(@"docTypeLookupFetchedObjects count %i",appDocTypeLookupFetchedObjectsCount);
//                    for (NSInteger i=0; i<appDocTypeLookupFetchedObjectsCount; i++) {
//                        //                                    //NSLog(@"appDocTypeLookupFetchedObjects %@",appDocTypeLookupFetchedObjects);
//                        if (appDocTypeLookupFetchedObjectsCount) { 
//                            
//                            
//                            DrugAppDocTypeLookupEntity *appDocTypeObject=(DrugAppDocTypeLookupEntity *)[appDocTypeLookupFetchedObjects objectAtIndex:i];
//                            NSMutableSet *appDocTypeLookupAppDocsSet=[appDocTypeObject mutableSetValueForKey:(NSString *)@"applicationDocuments"];
//                            
//                            NSPredicate *appAppDocsPredicate=[NSPredicate predicateWithFormat:@"docType matches %@",appDocTypeObject.appDocType];
//                            
//                            
//                            NSArray *filteredAppDocArray=[appDocsFetchedObjects filteredArrayUsingPredicate:appAppDocsPredicate];
//                            
//                            [appDocTypeLookupAppDocsSet addObjectsFromArray:filteredAppDocArray];
//                            
//                            if (i==1||i==1000||i==3000||i==5000||i==7500||i==10000||i==12500||i==15000||i==30000) {
//                                
//                                //NSLog(@"i is %i",i);
//                                
//                                //NSLog(@"filtered rpoducts array is %@",filteredAppDocArray);
//                            }
//                            
//                        }
//                        else
//                        {
//                            //NSLog(@"no appDocTypeLookupFetchedObjectsCount objects");
//                            
//                        }
//                        
//                        
//                    }
//                }    
//                
//                
//                
//            }  
//            
//        } 
//        //                        NSMutableSet *appDocSet=[[NSMutableSet alloc]init];
//        //                        NSMutableSet *appDocType_LookupSet=[[NSMutableSet alloc]init];
//        //                        NSMutableSet *chemTypeLookupSet=[[NSMutableSet alloc]init];
//        //                        NSMutableSet *docTypeLookupSet=[[NSMutableSet alloc]init];
//        //                        NSMutableSet *productTcodeSet=[[NSMutableSet alloc]init];
//        //                        
//        //                        NSMutableSet *regActionDateSet=[[NSMutableSet alloc]init];
//        //                        NSMutableSet *reviewClassLookupSet=[[NSMutableSet alloc]init];
//        
//        
//        
//        
//        
//        
//        // 
//        
//        
//        
//        
//    return TRUE;
//    
//
//
//





}


#pragma mark - Application's Directories

/**
 Returns the URL to the application's Documents directory.
 */
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSURL *)applicationDrugsDirectory
{
    NSFileManager *fileManager=[[NSFileManager alloc]init];
    NSString *dirToCreate = [NSString stringWithFormat:@"%@/drugDatabase",[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject]];
    BOOL isDir=YES;
    NSError *error=[[NSError alloc]init];
    if(![fileManager fileExistsAtPath:dirToCreate isDirectory:&isDir])
        [fileManager createDirectoryAtPath:dirToCreate withIntermediateDirectories:YES attributes:nil error:&error];
            //NSLog(@"Error: Create folder failed");

    
    
    NSURL *drugUrl=[NSURL fileURLWithPath:dirToCreate isDirectory:YES];
    
    //NSLog(@"drug url is %@",drugUrl.path);
    
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
            //NSLog(@"Error: Create folder failed");
    
    
    
    NSURL *disorderUrl=[NSURL fileURLWithPath:dirToCreate isDirectory:YES];
    
    //NSLog(@"disorder url is %@",disorderUrl.path);
    
    return disorderUrl;
}


- (NSURL *)applicationPTTDirectory
{
    NSFileManager *fileManager=[[NSFileManager alloc]init];
    NSString *dirToCreate = [NSString stringWithFormat:@"%@/pttDatabase",[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject]];
    BOOL isDir=YES;
    NSError *error=[[NSError alloc]init];
    if(![fileManager fileExistsAtPath:dirToCreate isDirectory:&isDir])
        [fileManager createDirectoryAtPath:dirToCreate withIntermediateDirectories:YES attributes:nil error:&error];
            //NSLog(@"Error: Create folder failed");
    
    
    
    NSURL *pttDatabaseUrl=[NSURL fileURLWithPath:dirToCreate isDirectory:YES];
    
    //NSLog(@"drug url is %@",pttDatabaseUrl.path);
    
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
    
    NSNotification* refreshNotification = [NSNotification notificationWithName:@"RefreshAllViews" object:self  userInfo:[note userInfo]];
    
    [[NSNotificationCenter defaultCenter] postNotification:refreshNotification];
}

/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *)managedObjectContext {
	
    if (managedObjectContext__ != nil) {
        return managedObjectContext__;
    }
	
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    
    if (coordinator != nil) {
        // Make life easier by adopting the new NSManagedObjectContext concurrency API
        // the NSMainQueueConcurrencyType is good for interacting with views and controllers since
        // they are all bound to the main thread anyway
        NSManagedObjectContext* moc = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        
        [moc performBlockAndWait:^{
            // even the post initialization needs to be done within the Block
            [moc setPersistentStoreCoordinator: coordinator];
            [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(mergeChangesFrom_iCloud:) name:NSPersistentStoreDidImportUbiquitousContentChangesNotification object:coordinator];
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


/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
//- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
//	
//    if (persistentStoreCoordinator__ != nil) {
//        return persistentStoreCoordinator__;
//    }
//    
//    // assign the PSC to our app delegate ivar before adding the persistent store in the background
//    // this leverages a behavior in Core Data where you can create NSManagedObjectContext and fetch requests
//    // even if the PSC has no stores.  Fetch requests return empty arrays until the persistent store is added
//    // so it's possible to bring up the UI and then fill in the results later
//    persistentStoreCoordinator__ = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel: [self managedObjectModel]];
//    
//    
//    // prep the store path and bundle stuff here since NSBundle isn't totally thread safe
//    NSPersistentStoreCoordinator* psc = persistentStoreCoordinator__;
//	NSString *storePath = [[self applicationDocumentsDirectoryString] stringByAppendingPathComponent:@"psyTrack.sqlite"];
//    
//    // do this asynchronously since if this is the first time this particular device is syncing with preexisting
//    // iCloud content it may take a long long time to download
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        
//        NSURL *ubiq = [[NSFileManager defaultManager] 
//                       URLForUbiquityContainerIdentifier:nil];
//        if (ubiq) {
//            //NSLog(@"iCloud access at %@", ubiq);
//            // TODO: Load document... 
//        
//        
//        NSFileManager *fileManager = [NSFileManager defaultManager];
//        
//        NSURL *storeUrl = [NSURL fileURLWithPath:storePath];
//        // this needs to match the entitlements and provisioning profile
//        NSURL *cloudURL = [fileManager URLForUbiquityContainerIdentifier:nil];
//        NSString* coreDataCloudContent = [[cloudURL path] stringByAppendingPathComponent:@"recipes_v3"];
//        cloudURL = [NSURL fileURLWithPath:coreDataCloudContent];
//        
//        //  The API to turn on Core Data iCloud support here.
//        NSDictionary* options = [NSDictionary dictionaryWithObjectsAndKeys:@"com.apple.coredata.examples.recipes.3", NSPersistentStoreUbiquitousContentNameKey, cloudURL, NSPersistentStoreUbiquitousContentURLKey, [NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption,nil];
//        
//        NSError *error = nil;
//        
//        [psc lock];
//        if (![psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeUrl options:options error:&error]) {
//            /*
//             Replace this implementation with code to handle the error appropriately.
//             
//             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
//             
//             Typical reasons for an error here include:
//             * The persistent store is not accessible
//             * The schema for the persistent store is incompatible with current managed object model
//             Check the error message to determine what the actual problem was.
//             */
//            //NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
//            abort();
//        }    
//        [psc unlock];
//        
//        // tell the UI on the main thread we finally added the store and then
//        // post a custom notification to make your views do whatever they need to such as tell their
//        // NSFetchedResultsController to -performFetch again now there is a real store
//        dispatch_async(dispatch_get_main_queue(), ^{
//            //NSLog(@"asynchronously added persistent store!");
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"RefetchAllDatabaseData" object:self userInfo:nil];
//        });
//            
//            
//        } 
//        else 
//        
//        {
//            //NSLog(@"No iCloud access setting up local store");
//            
//            
//            NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"psyTrack.sqlite"];
//            
//            NSError *error = nil;
//            
//           
//            
//            
//            
//
//
//            
//           
//            if (![persistentStoreCoordinator__ addPersistentStoreWithType:NSSQLiteStoreType configuration:@"main" URL:storeURL options:nil error:&error])
//            {
//                /*
//                 Replace this implementation with code to handle the error appropriately.
//                 
//                 abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
//                 
//                 Typical reasons for an error here include:
//                 * The persistent store is not accessible;
//                 * The schema for the persistent store is incompatible with current managed object model.
//                 Check the error message to determine what the actual problem was.
//                 
//                 
//                 If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
//                 
//                 If you encounter schema incompatibility errors during development, you can reduce their frequency by:
//                 * Simply deleting the existing store:
//                 [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
//                 
//                 * Performing automatic lightweight migration by passing the following dictionary as the options parameter: 
//                 [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
//                 
//                 Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
//                 
//                 */
//                //NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
//                abort();
//            }   
//
//        }
//    });
//    
//    return persistentStoreCoordinator__;
//}


- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (persistentStoreCoordinator__ != nil)
    {
        return persistentStoreCoordinator__;
    }
//    NSString *uniqueIdentifier = [[UIDevice currentDevice] uniqueIdentifier];
    
    
 


    NSURL *storeURL = [[self applicationPTTDirectory] URLByAppendingPathComponent:[NSString stringWithFormat:@"psyTrack.sqlite"]];
    
    persistentStoreCoordinator__ = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];

    
    NSPersistentStoreCoordinator* psc = persistentStoreCoordinator__;
    
   
     //NSLog(@"user default preference for icloud is %i",[[NSUserDefaults standardUserDefaults] boolForKey:@"icloud_preference"]);
    
    NSLog(@"icloud user info %@",[[NSUbiquitousKeyValueStore defaultStore].dictionaryRepresentation allKeys]);
    //BOOL useriCloudPref=[[NSUserDefaults standardUserDefaults] boolForKey:@"icloud_preference"];
    
    NSURL *ubiq = [[NSFileManager defaultManager] 
                   URLForUbiquityContainerIdentifier:nil];
    if ( ubiq ) {
        NSLog(@"iCloud access at %@", ubiq);
        // TODO: Load document... 
        
        NSLog(@"user default preference for icloud is %i",[[NSUserDefaults standardUserDefaults] boolForKey:@"icloud_preference"]);
        
        
    } else {
        NSLog(@"No iCloud access");
    }
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSFileManager *fileManager = [NSFileManager defaultManager];
            
            // Migrate datamodel
            NSDictionary *options = nil;
            
                      
            // this needs to match the entitlements and provisioning profile
            NSURL *cloudURL = [fileManager URLForUbiquityContainerIdentifier:nil];
            NSString* coreDataCloudContent = [[cloudURL path] stringByAppendingPathComponent:@"psyTrack"];
            if ([coreDataCloudContent length] != 0 ) {
                // iCloud is available
                cloudURL = [NSURL fileURLWithPath:coreDataCloudContent];
                
                options = [NSDictionary dictionaryWithObjectsAndKeys:
                           [NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption,
                           [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption,
                           @"4R8ZH75936.com.psycheweb.psyTrack", NSPersistentStoreUbiquitousContentNameKey,
                           cloudURL, NSPersistentStoreUbiquitousContentURLKey,
                           nil];
                
                
            } else {
                // iCloud is not available
                options = [NSDictionary dictionaryWithObjectsAndKeys:
                           [NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption,
                           [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption,
                           nil];
                NSLog(@"icloud is not available");
                
            }
            
            NSError *error = nil;
            [psc lock];
            if (![psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:options error:&error])
            {
                NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
                abort();
            }
            [psc unlock];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                NSError *setProtectionAttribsError = nil;
                NSDictionary *fileAttributes = [NSDictionary dictionaryWithObject:NSFileProtectionComplete forKey:NSFileProtectionKey];
                if (![[NSFileManager defaultManager] setAttributes:fileAttributes ofItemAtPath:[storeURL path] error:&setProtectionAttribsError]) {
                    // Handle error
                }
                else {
                     [self saveContext];
                }
                
                NSLog(@"store url path %@",[storeURL path]);
                NSLog(@"persisitant store %@",persistentStoreCoordinator__.persistentStores);
                NSLog(@"asynchronously added persistent store!");
                [[NSNotificationCenter defaultCenter] postNotificationName:@"RefetchAllDatabaseData" object:self userInfo:nil];
               
                addedPersistentStoreSuccess=YES;
               
               
            });
            
        });
        
    
    return persistentStoreCoordinator__;
}

#pragma mark -
#pragma mark Application's documents directory

/**
 Returns the path to the application's documents directory.
 */
//- (NSString *)applicationDocumentsDirectory {
//	return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//}

//end icloud paste


-(void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(shake) name:@"shake" object:nil];
    
    if(event.type == UIEventTypeMotion && event.subtype == UIEventSubtypeMotionShake)
    { //NSLog(@"motion Began");
        
        
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
          //NSLog(@"tab bar tag is %i",self.tabBarController.selectedViewController.tabBarItem.tag);
           
                
            
            if (clinicianViewController.totalCliniciansLabel.alpha) {
           
            clinicianViewController.totalCliniciansLabel.alpha=0;
            }
            if (clientsViewController_iPhone) {
                
            clientsViewController_iPhone.totalClientsLabel.alpha=0;
            }
            self.trainTrackViewController.tableView.alpha=0;
            
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
        //NSLog(@"totoal clinicians label%f", clinicianViewController.totalCliniciansLabel.alpha);
        
        clientsViewController_iPhone.totalClientsLabel.alpha=1;
        //NSLog(@"totoal clinicians label%@", [clientsViewController_iPhone class]);
        
        self.trainTrackViewController.tableView.alpha=1;
       
        
    }

    
    [UIView commitAnimations];

}



#pragma mark -
#pragma mark LockScreenAppDelegate implementation

- (void) lockScreen: (LCYLockScreenViewController *) lockScreen unlockedApp: (BOOL) unlocked;
{
	if (unlocked)
	{
		[lockScreenVC_.view removeFromSuperview];
		self.lockScreenVC = nil;
         tabBar.userInteractionEnabled=TRUE; 
        
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
    return (BOOL)[(NSNumber *)[lockValuesDictionary_ valueForKey:K_LOCK_SCREEN_PASSCODE_IS_ON]boolValue];

}
- (BOOL) isLockedAtStartup
{	
//	LCYAppSettings *appSettings = [self appSettings];	
	return (BOOL)[(NSNumber *)[lockValuesDictionary_ valueForKey:K_LOCK_SCREEN_LOCK_AT_STARTUP]boolValue];
}

- (void) setLockedAtStartup:(BOOL)value
{	
    
    if ([lockValuesDictionary_ objectForKey:K_LOCK_SCREEN_LOCK_AT_STARTUP]) {
        [lockValuesDictionary_ setValue:[NSNumber numberWithBool:value] forKey:K_LOCK_SCREEN_LOCK_AT_STARTUP];
        
    }
      
}

-(BOOL)isAppLocked{

    if (lockValuesDictionary_ &&[lockValuesDictionary_ objectForKey:K_LOCK_SCREEN_LOCKED]) {
        return (BOOL)[(NSNumber *)[lockValuesDictionary_ valueForKey:K_LOCK_SCREEN_LOCKED]boolValue];
    }  	
    else
        return YES;
	

}
-(BOOL)isLockedTimerOn{
    
  	
	return (BOOL)[[lockValuesDictionary_ valueForKey:K_LOCK_SCREEN_TIMER_ON]boolValue];
    
}
- (NSString *) appLockPasscode
{
    if (lockValuesDictionary_ &&[lockValuesDictionary_ objectForKey:K_LOCK_SCREEN_PASSCODE]) {
        return (NSString *)[lockValuesDictionary_ valueForKey:K_LOCK_SCREEN_PASSCODE];
    }
    else {
        return [NSString string];
    }
	
}

-(void)displayWrongPassword{

    [lockScreenVC_ showBanner:lockScreenVC_.wrongPassCodeBanner];
    [lockScreenVC_.enterPassCodeBanner removeFromSuperview];	

}
- (void) lockApplication
{
    BOOL passcodeON=[self isPasscodeOn];
	if (! lockScreenVC_ && passcodeON)
	{
        NSString *lockScreenNibName;
        if ([[UIDevice currentDevice] userInterfaceIdiom] != UIUserInterfaceIdiomPad)
            lockScreenNibName=[NSString stringWithString:@"LCYLockScreen_iPhone"];
        else 
            lockScreenNibName=[NSString stringWithString:@"LCYLockScreen_iPad"];
        
        
		self.lockScreenVC = [[LCYLockScreenViewController alloc] initWithNibName:lockScreenNibName bundle:[NSBundle mainBundle]];
        
		self.lockScreenVC.passCode = [self appLockPasscode];
		self.lockScreenVC.delegate = self;
         tabBar.userInteractionEnabled=FALSE;
	}
	
    if (passcodeON) 
    {
//        [self.window addSubview:lockScreenVC_.window];
//        [self.lockScreenVC loadView];

        [self.window addSubview:self.lockScreenVC.view];
     
        if ([self isLockedTimerOn]) {
            [self displayWrongPassword];
        }
    }
    else {
        
       
        NSString *alertText=[NSString stringWithString:@"Need To Set Passcode in Lock Screen Settings" ];
    
        [self displayNotification:alertText forDuration:3.0 location:kPTTScreenLocationTop  inView:nil];
    }
   
} 

-(IBAction)resaveLockDictionarySettings:(id)sender{

    [self saveLockDictionarySettings];

}
-(BOOL)saveLockDictionarySettings{

    
    if (!encryption_) {
        self.encryption=[[PTTEncryption alloc]init];
    }
    BOOL success=FALSE;
    
    NSData *symetricData=[self getSymetricData];
    NSData * keyedArchiveData = [NSKeyedArchiver archivedDataWithRootObject:lockValuesDictionary_];
    
    NSData *encryptedArchivedLockData =(NSData *)[encryption_ doCipher:keyedArchiveData key:symetricData context:kCCEncrypt padding:(CCOptions *)kCCOptionPKCS7Padding];
    
    if ([encryptedArchivedLockData length]) {
        success= (BOOL)[encryptedArchivedLockData writeToFile:[self lockSettingsFilePath] atomically:YES];
        [self setLCYLockPlist];
        
        if (!managedObjectContext__) 
        {
            managedObjectContext__=[self managedObjectContext];
        }
        //3
        //3
        if (managedObjectContext__) 
        {
            
            NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
            NSEntityDescription *keyEntity = [NSEntityDescription entityForName:@"KeyEntity" inManagedObjectContext:managedObjectContext__];
            [fetchRequest setEntity:keyEntity];
            
            NSError *error = nil;
            NSArray *fetchedObjects = [managedObjectContext__ executeFetchRequest:fetchRequest error:&error];
            //4
            
            KeyEntity *keyObject;
            if (fetchedObjects == nil) 
            {
                                
            }
            //4
            //4
            if (!fetchedObjects.count) 
            {
                if (!addedPersistentStoreSuccess) 
                {
                    
                    
                    [[NSNotificationCenter defaultCenter]
                     addObserver:self
                     selector:@selector(resaveLockDictionarySettings:)
                     name:@"RefetchAllDatabaseData"
                     object:nil];
                }
                else {
                    NSString *status;
                    status=[self setupDefaultLockDictionaryResultStr];
                    
                    //NSLog(@"status %@", status);

                }
                

                
                
                
                
            }
            else {
                NSPredicate *keyDatePredicate=[NSPredicate predicateWithFormat:@"dateCreated= %@",[lockValuesDictionary_ valueForKey:K_LOCK_SCREEN_CREATE_DATE]];
                //NSLog(@"lock screen date is %@",[lockValuesDictionary_ valueForKey:K_LOCK_SCREEN_CREATE_DATE]);
                fetchedObjects=[fetchedObjects filteredArrayUsingPredicate:keyDatePredicate];
                
                if(fetchedObjects.count){
                    keyObject=[fetchedObjects objectAtIndex:0];
                    keyObject.dataF=encryptedArchivedLockData;
                    
                }
                else 
                {
                    
                    [self displayNotification:@"Error: Unable to save settings." forDuration:3.0 location:kPTTScreenLocationTop inView:nil];                  
                        
                }
            }
    
            //4
            
            [self saveContext];
            
        }
        //3
        
    
     

        
       
    }
    else 
    {
        success=NO;
        NSString *alertText=[NSString stringWithString:@"Unable to Save Lock Settings" ];
        
        [self displayNotification:alertText forDuration:3.0 location:kPTTScreenLocationTop  inView:nil];
       
       
    }
    
    return success;
    
}
-(NSString *)lockSettingsFilePath{

    NSString *encryptedFileName=@"ptdata.001";
    
    
    return [[self applicationSupportPath] stringByAppendingPathComponent:encryptedFileName];

}


@end



@implementation PTTAppDelegate (CasualAlerts)

#pragma mark -
#pragma notification controller implementation

-(void)displayNotification:(NSString *)alertText forDuration:(float)seconds location:(NSInteger )screenLocation inView:(UIView *)viewSuperview{

    //NSLog(@"alert text is  in app delegate is %@",alertText);
   
    
    if (casualAlertManager) {
        casualAlertManager.view=nil;
        casualAlertManager=nil;
    }
    self.casualAlertManager=[[CasualAlertViewController alloc] initWithNibName:@"CasualAlertViewController"  bundle:nil];
    
    [casualAlertManager loadView];
        [casualAlertManager displayRegularAlert:alertText forDuration:seconds location:screenLocation inView:viewSuperview];


}







@end


