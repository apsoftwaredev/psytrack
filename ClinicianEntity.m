//
//  ClinicianEntity.m
//  PsyTrack
//
//  Created by Daniel Boice on 7/22/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import "ClinicianEntity.h"
#import "ClinicianGroupEntity.h"
#import "DemographicProfileEntity.h"
#import "ExistingHoursEntity.h"
#import "LogEntity.h"
#import "MedicationReviewEntity.h"
#import "ReferralEntity.h"
#import "SiteEntity.h"
#import "SupervisionParentEntity.h"
#import "TimeTrackEntity.h"
#import "TrainingProgramEntity.h"
#import "PTTAppDelegate.h"

@implementation ClinicianEntity

@dynamic lastName;
@dynamic aBRecordIdentifier;
@dynamic practiceName;
@dynamic middleName;
@dynamic firstName;
@dynamic myPastSupervisor;
@dynamic website;
@dynamic suffix;
@dynamic myCurrentSupervisor;
@dynamic prefix;
@dynamic order;
@dynamic keyString;
@dynamic bio;
@dynamic myInformation;
@dynamic startedPracticing;
@dynamic notes;
@dynamic atMyCurrentSite;
@dynamic isPrescriber;
@dynamic logs;
@dynamic supervisedTime;
@dynamic awards;
@dynamic clinicianType;
@dynamic specialties;
@dynamic publications;
@dynamic groups;
@dynamic medicationPrescribed;
@dynamic supervisionSessionsPresent;
@dynamic influences;
@dynamic existingSupervisionGiven;
@dynamic diagnoser;
@dynamic site;
@dynamic consultationReferral;
@dynamic grants;
@dynamic orientationHistory;
@dynamic degrees;
@dynamic demographicInfo;
@dynamic referrals;
@dynamic employments;
@dynamic certifications;
@dynamic licenseNumbers;
@dynamic memberships;
@dynamic advisingReceived;
@dynamic currentJobTitles;
@dynamic existingHours;
@dynamic teachingExperience;
@dynamic practicumCoursesInstructed;
@synthesize combinedName;

@synthesize tempNotes;


-(void)awakeFromInsert{
    
    
    
    NSManagedObjectContext * managedObjectContext = [(PTTAppDelegate *)[UIApplication sharedApplication].delegate managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"ClinicianGroupEntity" inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"addNewClinicians == %@", [NSNumber numberWithBool:YES]];
    [fetchRequest setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *fetchedObjects = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (fetchedObjects ) {
        [self willAccessValueForKey:@"groups"];
        NSMutableSet *groupsMutableSet=(NSMutableSet *)[self mutableSetValueForKey:@"groups"];
        [self didAccessValueForKey:@"groups"];
        
        for (ClinicianGroupEntity *clinicianGroup in fetchedObjects) {
            [self willChangeValueForKey:@"groups"];
            [groupsMutableSet addObject:clinicianGroup];
            [self didChangeValueForKey:@"groups"];
            
            
        }
        
        
        
    }
    
    
}

-(NSString *)combinedName{
    
    
    
    combinedName=[NSString string];
    
    
    //DLog(@"name values in entity are %@, %@, %@, %@, %@, %@", prefix, firstName, middleName, lastName,suffix, credentialInitials );
    
    
    [self willAccessValueForKey:@"prefix"];
    if (self.prefix.length) {
        combinedName=[self.prefix stringByAppendingString:@" "];
    } 
    [self didAccessValueForKey:@"prefix"];
    
    [self willAccessValueForKey:@"firstName"];
    if (self.firstName.length) {
        combinedName=[combinedName stringByAppendingString:self.firstName];
    }
    [self didAccessValueForKey:@"firstName"];
    
    [self willAccessValueForKey:@"middleName"];
    if (self.middleName.length ) 
    {
        
        NSString *middleInitial=[self.middleName substringToIndex:1];
        
        middleInitial=[middleInitial stringByAppendingString:@"."];
        
        
        
        combinedName=[combinedName stringByAppendingFormat:@" %@", middleInitial];
        
        
    }
    [self didAccessValueForKey:@"middleName"];
    [self willAccessValueForKey:@"lastName"];
    
    if (self.lastName.length  && combinedName.length ) 
    {
        
        
        combinedName=[combinedName stringByAppendingFormat:@" %@",self.lastName];
        
    }
    [self didAccessValueForKey:@"lastName"];
    [self willAccessValueForKey:@"suffix"];
    if (self.suffix.length  && combinedName.length) {
        
        combinedName=[combinedName stringByAppendingFormat:@", %@",self.suffix];
        
    }
    [self didAccessValueForKey:@"suffix"];
    
    //DLog(@"combined name values at end in entity are  %@",combinedName  );
    
    
    
    
    
    
    
    return combinedName;
    
}
-(void)rekeyEncryptedAttributes{

    if (self.notes) {
        [self rekeyString:(NSString *)self.notes forKey:@"notes"];
    }
    

}
- (void)rekeyString:(NSString *)strValue forKey:(NSString *)key
{
    
    PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
    
    if (strValue&& strValue.length ) {
        
        
        
        
        
        NSDictionary *encryptedDataDictionary=[appDelegate encryptStringToEncryptedData:(NSString *)strValue withKeyString:nil];
        //DLog(@"encrypted dictionary right after set %@",encryptedDataDictionary);
        NSData *encryptedData;
        NSString *encryptedKeyString;
        if ([encryptedDataDictionary.allKeys containsObject:@"encryptedData"]) {
            encryptedData=[encryptedDataDictionary valueForKey:@"encryptedData"];
            
            
            if ([encryptedDataDictionary.allKeys containsObject:@"keyString"]) {
                //DLog(@"all keys are %@",[encryptedDataDictionary allKeys]);
                
                encryptedKeyString=[encryptedDataDictionary valueForKey:@"keyString"];
                //DLog(@"key date is client entity %@",encryptedkeyString);
            }
        }
        
        
        if (encryptedData.length) {
            [self willChangeValueForKey:key];
            [self setPrimitiveValue:encryptedData forKey:key];
            [self didChangeValueForKey:key];
        }
        
        
        [self willAccessValueForKey:@"keyString"];
        if (![encryptedKeyString isEqualToString:self.keyString]) {
            [self didAccessValueForKey:@"keyString"];
            [self willChangeValueForKey:@"keyString"];
            [self setPrimitiveValue:encryptedKeyString forKey:@"keyString"];
            [self didChangeValueForKey:@"keyString"];
            
        }
        
        
        
        
        
        
    }
}

- (void)setStringToPrimitiveData:(NSString *)strValue forKey:(NSString *)key 
{
    
    PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
    
    if (strValue&& strValue.length ) {
        
        
        
        
        
        NSDictionary *encryptedDataDictionary=[appDelegate encryptStringToEncryptedData:(NSString *)strValue withKeyString:self.keyString];
        //DLog(@"encrypted dictionary right after set %@",encryptedDataDictionary);
        NSData *encryptedData;
        NSString *encryptedKeyString;
        if ([encryptedDataDictionary.allKeys containsObject:@"encryptedData"]) {
            encryptedData=[encryptedDataDictionary valueForKey:@"encryptedData"];
            
            
            if ([encryptedDataDictionary.allKeys containsObject:@"keyString"]) {
                //DLog(@"all keys are %@",[encryptedDataDictionary allKeys]);
                
                encryptedKeyString=[encryptedDataDictionary valueForKey:@"keyString"];
                //DLog(@"key date is client entity %@",encryptedkeyString);
            }
        }
        
        
        if (encryptedData.length) {
            [self willChangeValueForKey:key];
            [self setPrimitiveValue:encryptedData forKey:key];
            [self didChangeValueForKey:key];
        }
        
        
        [self willAccessValueForKey:@"keyString"];
        if (![encryptedKeyString isEqualToString:self.keyString]) {
            [self didAccessValueForKey:@"keyString"];
            [self willChangeValueForKey:@"keyString"];
            [self setPrimitiveValue:encryptedKeyString forKey:@"keyString"];
            [self didChangeValueForKey:@"keyString"];
            
        }
        
        
        
        
        
        
    }
}
-(NSString *)notes{
    
    NSString *tempStr;
    [self willAccessValueForKey:@"tempNotes"];
    
    
    if (!self.tempNotes ||!self.tempNotes.length) {
        
        [self didAccessValueForKey:@"tempNotes"];
        PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
        
        
        [self willAccessValueForKey:@"notes"];
        
        
        NSData *primitiveData=[self primitiveValueForKey:@"notes"];
        [self didAccessValueForKey:@"notes"];
        
        if (!primitiveData ||!primitiveData.length ) {
            return nil;
        }
        [self willAccessValueForKey:@"keyString"];
        NSString *tmpKeyString=self.keyString;
        [self didAccessValueForKey:@"keyString"];
        
        NSData *strData=[appDelegate decryptDataToPlainDataUsingKeyEntityWithString:tmpKeyString encryptedData:primitiveData];
        
        tempStr=[appDelegate convertDataToString:strData];
        
        [self willChangeValueForKey:@"tempNotes"];
        
        self.tempNotes=tempStr;
        [self didChangeValueForKey:@"tempNotes"];
        
        
    }
    else 
    {
        tempStr=self.tempNotes;
        [self didAccessValueForKey:@"tempNotes"];
    }
    
    
    
    
    return tempStr;
    
    
    
    
    
    
}
-(void)setNotes:(NSString *)notes{
    
    [self setStringToPrimitiveData:(NSString *)notes forKey:@"notes"];
    
    self.tempNotes=notes;
}

//    -(NSSet *)abGroupsold{
//        
//        if (tempABGroupSet) {
//            return tempABGroupSet;
//        }
//        ABAddressBookRef addressBook=nil;
//        @try {
//            
//            addressBook=ABAddressBookCreate();        
//            
//        }
//        @catch (NSException *exception) {
//            PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
//            
//            
//            [appDelegate displayNotification:@"Not able to access Address Book" forDuration:3.0 location:kPTTScreenLocationTop inView:appDelegate.window];
//            return nil;
//        }
//        @finally 
//        {
//            BOOL autoAddClinicianToGroup=[[NSUserDefaults standardUserDefaults]boolForKey:kPTAutoAddClinicianToGroup];
//            ABRecordRef group=nil;
//            
//            int groupIdentifier=-1;
//            if ([[NSUserDefaults standardUserDefaults] objectForKey:kPTTAddressBookGroupName])
//            {
//                
//                groupIdentifier=(NSInteger )[[NSUserDefaults standardUserDefaults] integerForKey:kPTTAddressBookGroupIdentifier];
//            }
//            
//            if (groupIdentifier>0) {
//                
//                
//                group=  ABAddressBookGetGroupWithRecordID((ABAddressBookRef) addressBook, groupIdentifier);
//                
//            }
//            
//            
//            
//            
//            
//            CFStringRef CFGroupName;
//            
//            if ([[NSUserDefaults standardUserDefaults] objectForKey:kPTTAddressBookGroupName]) {
//                
//                CFGroupName=(__bridge CFStringRef)[[NSUserDefaults standardUserDefaults] valueForKey:kPTTAddressBookGroupName];  
//                
//            }
//            else {
//                @try {
//                    NSString *userDefaultName=[PTTAppDelegate retrieveFromUserDefaults:@"abgroup_name"];
//                    
//                    
//                    CFGroupName=(__bridge_retained  CFStringRef)userDefaultName;
//                    
//                }
//                @catch (NSException *exception) {
//                    PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
//                    
//                    
//                    [appDelegate displayNotification:@"Unable to access addressbook settings" forDuration:3.0 location:kPTTScreenLocationTop inView:appDelegate.window];
//                }
//                @finally {
//                    
//                }
//                
//                
//            }
//            
//            
//            
//            
//            if ((!CFGroupName || !CFStringGetLength(CFGroupName) )&& autoAddClinicianToGroup) {
//                NSString *clinicians=@"Clinicians";
//                CFGroupName=(__bridge CFStringRef)clinicians;
//                [[NSUserDefaults standardUserDefaults] setValue:(__bridge NSString*)CFGroupName forKeyPath:kPTTAddressBookGroupName];
//                [[NSUserDefaults standardUserDefaults] synchronize];
//                
//            }
//            
//            //DLog(@"group name is %@",CFGroupName);   
//            //check to see if the group name exists already
//            
//            ABRecordRef source=nil;
//            
//            
//            int sourceID=[self defaultABSourceID];
//            
//            
//            
//            source=ABAddressBookGetSourceWithRecordID(addressBook, sourceID);
//            
//            
//            CFArrayRef allGroupsInSource=ABAddressBookCopyArrayOfAllGroupsInSource(addressBook, source);
//            int groupCount=CFArrayGetCount(allGroupsInSource);
//            
//            
//            
//            
//            
//            CFStringRef CFGroupNameCheck ;
//            ABRecordRef groupInCheckNameArray;
//            if (groupCount&&!group ) {
//                
//                
//                //DLog(@"cggroups array %@",allGroupsInSource);
//                
//                
//                for (CFIndex i = 0; i < groupCount; i++) {
//                    groupInCheckNameArray = CFArrayGetValueAtIndex(allGroupsInSource, i);
//                    CFGroupNameCheck  = ABRecordCopyValue(groupInCheckNameArray, kABGroupNameProperty);
//                    
//                    
//                    CFComparisonResult result=  (CFComparisonResult) CFStringCompare (
//                                                                                      ( CFStringRef)CFGroupName,
//                                                                                      (CFStringRef) CFGroupNameCheck,
//                                                                                      1
//                                                                                      );
//                    
//                    //DLog(@"result is %ld and %d",result,kCFCompareEqualTo);
//                    if (result==0) {
//                        group=groupInCheckNameArray;
//                        break;
//                    }
//                    //                    CFRelease(CFGroupsCheckNameArray); 
//                    //                    CFRelease(CFGroupNameCheck);
//                    
//                    //DLog(@"group is %@",group);
//                    
//                }
//            }
//            
//            
//            
//            
//            
//            
//            
//            
//            
//            NSMutableSet *allGroups;
//            
//            
//            
//            
//            if (!group) {
//                
//                [self changeABGroupNameTo:(__bridge NSString*) CFGroupName addNew:YES checkExisting:YES];
//                
//                
//                
//                
//                groupIdentifier=(NSInteger )[(NSNumber *)[[NSUserDefaults standardUserDefaults]valueForKey:kPTTAddressBookGroupIdentifier]intValue];
//                group=ABAddressBookGetGroupWithRecordID((ABAddressBookRef) addressBook, groupIdentifier);
//                
//                //        //        ABRecordRef CFAddressBookGroupRecord =  ABGroupCreate ();
//                //        
//                //        group=ABGroupCreate();
//                //        
//                //        //        ABRecord *groupRecord=(ABRecord *)[group getRecordRef];
//                //        
//                //        //        //DLog(@"group composite name is %@",groupRecord.compositeName);
//                //        
//                //        bool didSetGroupName=FALSE;
//                //        didSetGroupName= (bool) ABRecordSetValue (
//                //                                                  group,
//                //                                                  (ABPropertyID) kABGroupNameProperty,
//                //                                                  (__bridge CFStringRef)groupName  ,
//                //                                                  nil
//                //                                                  );  
//                //        //        //DLog(@"group record identifier is %i",groupRecord.recordID);
//                //        
//                //        BOOL wantToSaveChanges=TRUE;
//                //        if (ABAddressBookHasUnsavedChanges(addressBook)) {
//                //            
//                //            if (wantToSaveChanges) {
//                //                bool didSave=FALSE;
//                //                didSave = ABAddressBookSave(addressBook, nil);
//                //                
//                //                if (!didSave) {/* Handle error here. */}
//                //                
//                //            } 
//                //            else {
//                //                
//                //                ABAddressBookRevert(addressBook);
//                //                
//                //            }
//                //            
//                //        }
//                //        
//                //        //        ABRecord *groupRecord=[[ABRecord alloc]initWithABRef:(CFTypeRef)kABGroupType ];
//                //        
//                //        //DLog(@"group idenitifer is%i",ABRecordGetRecordID(group));
//                //
//                //        //DLog(@"group name is %@", (__bridge NSString *)ABRecordCopyValue(group, kABGroupNameProperty));
//                //        groupIdentifier=ABRecordGetRecordID(group);
//                //        
//                //        
//                //        [[NSUserDefaults standardUserDefaults] setInteger:(int )groupIdentifier forKey:kPTTAddressBookGroupIdentifier];
//                //        
//                //        [[NSUserDefaults standardUserDefaults]synchronize];
//                //            
//                //            
//                
//            } 
//            if (group!=NULL) {
//                CFRelease(group);
//            }
//            // Get the ABSource object that contains this new group
//            
//            
//            
//            NSNumber *groupIdentifierNumber=(NSNumber *)[[NSUserDefaults standardUserDefaults] valueForKey:kPTTAddressBookGroupIdentifier];
//            
//            if ([groupIdentifierNumber isEqualToNumber:[NSNumber numberWithInt:(int)-1]]||[groupIdentifierNumber isEqualToNumber:[NSNumber numberWithInt:(int)0]]||!groupCount) {
//                
//                [ self changeABGroupNameTo:nil addNew:NO checkExisting:YES];
//                
//                
//            }
//            
//            
//            
//            allGroupsInSource=ABAddressBookCopyArrayOfAllGroupsInSource(addressBook, source);
//            groupCount=CFArrayGetCount(allGroupsInSource);
//            
//            if (groupCount) {
//                
//                allGroupsInSource=ABAddressBookCopyArrayOfAllGroupsInSource(addressBook, source);
//                //DLog(@"cggroups array %@",(__bridge NSArray *) allGroupsInSource);
//                
//                if (allGroupsInSource) {
//                    
//                    
//                    
//                    allGroups = [[NSMutableSet alloc] init];
//                    
//                    
//                    //            CFStringRef CFGroupName ;
//                    for (CFIndex i = 0; i < groupCount; i++) {
//                        
//                        
//                        
//                        ABRecordRef groupInCFArray = CFArrayGetValueAtIndex(allGroupsInSource, i);
//                        CFGroupName  = ABRecordCopyValue(groupInCFArray, kABGroupNameProperty);
//                        int CFGroupID=ABRecordGetRecordID((ABRecordRef) groupInCFArray);
//                        
//                        PTABGroup *ptGroup=[[PTABGroup alloc]initWithName:(__bridge_transfer  NSString*)CFGroupName recordID:CFGroupID];
//                        
//                        [allGroups addObject:ptGroup];
//                        
//                        CFRelease(groupInCFArray);
//                    }     
//                    
//                    
//                    
//                    CFRelease(allGroupsInSource);
//                    
//                    
//                    
//                }
//                
//            }
//            
//            //        if (addressBook) {
//            //            CFRelease(addressBook);
//            //        }
//            DLog(@"all groups are %@",allGroups);
//            tempABGroupSet=allGroups;
//            return allGroups;
//        }
//        
//    }
//    -(void)changeABGroupNameTo:(NSString *)groupName  addNew:(BOOL)addNew checkExisting:(BOOL)checkExisting{
//        
//        ABAddressBookRef addressBook=nil;
//        @try 
//        {
//            
//            addressBook=ABAddressBookCreate();
//            
//            
//        }
//        
//        @catch (NSException *exception) 
//        {
//            PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
//            
//            
//            [appDelegate displayNotification:@"Not able to access address book" forDuration:3.0 location:kPTTScreenLocationTop inView:appDelegate.window];
//            return;
//        }
//        @finally 
//        {
//            ABRecordRef source=nil;
//            int sourceID=[self defaultABSourceID];
//            source=ABAddressBookGetSourceWithRecordID(addressBook, sourceID);
//            ABRecordRef group;
//            int groupIdentifier;
//            
//            CFArrayRef allGroupsInSource=ABAddressBookCopyArrayOfAllGroupsInSource(addressBook, source);
//            int groupCount=CFArrayGetCount(allGroupsInSource);
//            
//            
//            
//            
//            
//            BOOL autoAddClinicianToGroup=[[NSUserDefaults standardUserDefaults]boolForKey:kPTAutoAddClinicianToGroup];
//            if ((!groupName ||!groupName.length||checkExisting)&&autoAddClinicianToGroup) {
//                
//                if ([[NSUserDefaults standardUserDefaults] objectForKey:kPTTAddressBookGroupName]) {
//                    
//                    if (!checkExisting) {
//                        
//                        groupName=(NSString *)[[NSUserDefaults standardUserDefaults] valueForKey:kPTTAddressBookGroupName];  
//                        
//                    }
//                    //        }
//                    if (!groupName ||!groupName.length) {
//                        groupName=@"Clinicians";
//                        if ([[NSUserDefaults standardUserDefaults]objectForKey:kPTTAddressBookGroupName]) {
//                            
//                            [[NSUserDefaults standardUserDefaults] setValue:groupName forKeyPath:kPTTAddressBookGroupName];
//                            [[NSUserDefaults standardUserDefaults] synchronize];
//                            
//                        }
//                    }
//                    
//                }  
//                
//                
//                
//                if (!addNew) 
//                {
//                    
//                    if ([[NSUserDefaults standardUserDefaults]objectForKey:kPTTAddressBookGroupIdentifier]) 
//                    {
//                        groupIdentifier=(NSInteger )[[NSUserDefaults standardUserDefaults] integerForKey:kPTTAddressBookGroupIdentifier];
//                        
//                    }
//                    
//                    if (!addNew&&groupIdentifier>-1)
//                    {
//                        group=ABAddressBookGetGroupWithRecordID((ABAddressBookRef) addressBook, groupIdentifier);
//                        
//                    }
//                    
//                    
//                    
//                    
//                    
//                    
//                    
//                    
//                    //should not ad new
//                    ;
//                    CFStringRef CFGroupNameCheck =nil;
//                    ABRecordRef groupInCheckNameArray=nil;
//                    if (groupCount) 
//                    {
//                        
//                        
//                        //DLog(@"cggroups array %@",allGroupsInSource);
//                        
//                        
//                        for (CFIndex i = 0; i < groupCount; i++) {
//                            groupInCheckNameArray = CFArrayGetValueAtIndex(allGroupsInSource, i);
//                            CFGroupNameCheck  = ABRecordCopyValue(groupInCheckNameArray, kABGroupNameProperty);
//                            
//                            
//                            //            CFComparisonResult result=  (CFComparisonResult) CFStringCompare (
//                            //                                                                              (__bridge CFStringRef)groupName,
//                            //                                                                              (CFStringRef) CFGroupNameCheck,
//                            //                                                                              1
//                            //                                                                              );
//                            
//                            
//                            
//                            NSString *checkNameStr=[NSString stringWithFormat:@"%@",(__bridge NSString*) CFGroupNameCheck];
//                            
//                            //DLog(@"cfgroupname is %@",checkNameStr);
//                            //DLog(@"groupname Str is %@",groupName);
//                            if ([checkNameStr isEqualToString:groupName]) {
//                                group=groupInCheckNameArray;
//                                groupIdentifier=ABRecordGetRecordID(group);
//                                
//                                if ([[NSUserDefaults standardUserDefaults] objectForKey:kPTTAddressBookGroupIdentifier]) {
//                                    [[NSUserDefaults standardUserDefaults] setInteger:groupIdentifier forKey:kPTTAddressBookGroupIdentifier];
//                                    [[NSUserDefaults standardUserDefaults]synchronize];
//                                    
//                                }
//                                
//                                if (group) {
//                                    //DLog(@"group is %@",group);
//                                }
//                                
//                                else {
//                                    //DLog(@"no group");
//                                } 
//                                break;
//                            }
//                            //            CFRelease(CFGroupsCheckNameArray); 
//                            //            CFRelease(CFGroupNameCheck);
//                            
//                        }
//                        if (allGroupsInSource) {
//                            CFRelease(allGroupsInSource); 
//                        }
//                        
//                        if (CFGroupNameCheck) {
//                            CFRelease(CFGroupNameCheck);
//                        }  
//                    }
//                    
//                    
//                }
//                
//            }
//            
//            
//            
//            
//            NSNumber *groupIdentifierNumber=(NSNumber *)[[NSUserDefaults standardUserDefaults] valueForKey:kPTTAddressBookGroupIdentifier];
//            
//            if (!addNew && !group && groupIdentifier>0 && groupCount>0 && ![groupIdentifierNumber isEqualToNumber:[NSNumber numberWithInt:(int)-1]]  && ![groupIdentifierNumber isEqualToNumber:[NSNumber numberWithInt:(int)0]]) {
//                
//                group=ABAddressBookGetGroupWithRecordID((ABAddressBookRef) addressBook, groupIdentifier);
//                
//            }
//            
//            if ((!group ||addNew) && autoAddClinicianToGroup) {
//                
//                
//                if (!addressBook) {
//                    
//                    return;
//                }
//                //        ABRecordRef CFAddressBookGroupRecord =  ABGroupCreate ();
//                
//                group=ABGroupCreateInSource(source);
//                
//                //        ABRecord *groupRecord=(ABRecord *)[group getRecordRef];
//                
//                //        //DLog(@"group composite name is %@",groupRecord.compositeName);
//                
//                
//                //        //DLog(@"group record identifier is %i",groupRecord.recordID);
//                
//                bool didSetGroupName=FALSE;
//                didSetGroupName= (bool) ABRecordSetValue (
//                                                          group,
//                                                          (ABPropertyID) kABGroupNameProperty,
//                                                          (__bridge CFStringRef)groupName  ,
//                                                          nil
//                                                          );  
//                
//                ABAddressBookAddRecord((ABAddressBookRef) addressBook, (ABRecordRef) group, nil);
//                
//                BOOL wantToSaveChanges=TRUE;
//                if (ABAddressBookHasUnsavedChanges(addressBook)) {
//                    
//                    if (wantToSaveChanges) {
//                        bool didSave=FALSE;
//                        didSave = ABAddressBookSave(addressBook, nil);
//                        
//                        //                if (!didSave) {/* Handle error here. */  //DLog(@"addressbook did not save");}
//                        //                else //DLog(@"addresss book saved new group.");
//                        
//                    } 
//                    else {
//                        
//                        ABAddressBookRevert(addressBook);
//                        
//                    }
//                    
//                }
//                
//                //        ABRecord *groupRecord=[[ABRecord alloc]initWithABRef:(CFTypeRef)kABGroupType ];
//                
//                //DLog(@"group idenitifer is%i",ABRecordGetRecordID(group));
//                
//                //DLog(@"group name is %@", (__bridge NSString *)ABRecordCopyValue(group, kABGroupNameProperty));
//                
//                
//                
//                
//                
//                groupIdentifier=ABRecordGetRecordID(group);
//                
//                [[NSUserDefaults standardUserDefaults] setInteger:(int )groupIdentifier forKey:kPTTAddressBookGroupIdentifier];
//                
//                [[NSUserDefaults standardUserDefaults] setValue:groupName forKey:kPTTAddressBookGroupName];  
//                
//                [[NSUserDefaults standardUserDefaults]synchronize];
//                
//                //        CFRelease(group);
//            } 
//            else
//                
//            {
//                
//                BOOL wantToSaveChanges=TRUE;
//                
//                if (group) {
//                    groupIdentifier=ABRecordGetRecordID(group);
//                }
//                
//                
//                if (groupIdentifier>-1) {
//                    
//                    [[NSUserDefaults standardUserDefaults] setInteger:(int )groupIdentifier forKey:kPTTAddressBookGroupIdentifier];
//                    
//                    [[NSUserDefaults standardUserDefaults]synchronize];
//                    
//                }
//                if (ABAddressBookHasUnsavedChanges(addressBook)) {
//                    
//                    if (wantToSaveChanges) {
//                        bool didSave=FALSE;
//                        didSave = ABAddressBookSave(addressBook, nil);
//                        
//                        if (!didSave) {/* Handle error here. */}
//                        
//                    } 
//                    else {
//                        
//                        ABAddressBookRevert(addressBook);
//                        
//                    }
//                    
//                    
//                    
//                }
//                
//            }
//            if (addressBook) {
//                CFRelease(addressBook);
//            }
//            
//            
//            
//        }
//        //    [[NSUserDefaults standardUserDefaults]  setValue:(NSString *)groupName forKey:kPTTAddressBookGroupName];
//        
//        
//        
//        
//        
//    }
//
//    -(int )defaultABSourceID{
//        
//        BOOL iCloudEnabled=(BOOL)[[NSUserDefaults standardUserDefaults] valueForKey:@"icloud_preference"];
//        
//        int returnID=-1;
//        int sourceID=-1;
//        BOOL continueChecking=YES;
//        
//        ABAddressBookRef addressBook;
//        addressBook=nil;
//        
//        addressBook=ABAddressBookCreate();
//        
//        CFArrayRef allSourcesArray=ABAddressBookCopyArrayOfAllSources(addressBook);
//        ABRecordRef source=nil;
//        int sourcesCount=0;
//        
//        if (allSourcesArray ) {
//            sourcesCount= CFArrayGetCount(allSourcesArray);
//        } 
//        if (sourcesCount==0) {
//            
//            continueChecking=NO;
//            returnID=-1 ;
//        } 
//        if (continueChecking&& allSourcesArray && sourcesCount==1) {
//            
//            source=CFArrayGetValueAtIndex(allSourcesArray, 0);
//            ABRecordID sourceID=ABRecordGetRecordID(source);
//            
//            continueChecking=NO;
//            returnID=sourceID;
//            
//            
//        }
//        
//        
//        int recordID=(int)[(NSNumber*)[[NSUserDefaults standardUserDefaults] valueForKey:kPTTAddressBookSourceIdentifier]
//                           intValue];
//        
//        
//        
//        if (continueChecking && recordID!=-1) {
//            
//            source=ABAddressBookGetSourceWithRecordID(addressBook, recordID);
//            
//            
//            if (source) {
//                continueChecking=NO;
//                returnID=recordID;
//            }
//            
//            //        }
//            
//            
//        }
//        if (continueChecking&& allSourcesArray && CFArrayGetCount(allSourcesArray) >1 &&  iCloudEnabled) {
//            
//            
//            
//            for (int i=0; i<sourcesCount ; i++){
//                // Fetch the source type
//                
//                source=CFArrayGetValueAtIndex(allSourcesArray, i);
//                CFNumberRef sourceType = ABRecordCopyValue(source, kABSourceTypeProperty);
//                
//                
//                // Fetch the name associated with the source type
//                //            NSString *sourceName = [self nameForSourceWithIdentifier:[(__bridge NSNumber*)sourceType intValue]];
//                if (sourceType) {
//                    CFRelease(sourceType);
//                }
//                
//                
//                if ([(__bridge NSNumber *)sourceType isEqualToNumber:[NSNumber numberWithInt:kABSourceTypeCardDAV]]) 
//                    
//                {
//                    sourceID=ABRecordGetRecordID(source);
//                    
//                    
//                    
//                    //               
//                    
//                    returnID=sourceID;
//                    continueChecking=NO;
//                    break;
//                }
//                
//                
//            }
//            
//            
//        }
//        
//        if(continueChecking&& sourcesCount>1)
//        {
//            source= CFArrayGetValueAtIndex(allSourcesArray, 0);
//            sourceID=ABRecordGetRecordID(source);
//            returnID=sourceID;        
//            
//        }
//        if (addressBook) {
//            CFRelease(addressBook);
//        }
//        
//        
//        if (allSourcesArray) {
//            CFRelease(allSourcesArray);
//        }
//        
//        
//        return returnID;
//    }
//
//
//
//    // Return the name associated with the given identifier
//    - (NSString *)nameForSourceWithIdentifier:(int)identifier
//    {
//        switch (identifier)
//        {
//            case kABSourceTypeLocal:
//                return @"On My Device";
//                break;
//            case kABSourceTypeExchange:
//                return @"Exchange server";
//                break;
//            case kABSourceTypeExchangeGAL:
//                return @"Exchange Global Address List";
//                break;
//            case kABSourceTypeMobileMe:
//                return @"Moblile Me";
//                break;
//            case kABSourceTypeLDAP:
//                return @"LDAP server";
//                break;
//            case kABSourceTypeCardDAV:
//                return @"CardDAV server";
//                break;
//            case kABSourceTypeCardDAVSearch:
//                return @"Searchable CardDAV server";
//                break;
//            default:
//                break;
//        }
//        return nil;
//    }
//

@end
