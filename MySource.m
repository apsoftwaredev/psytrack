/*
     File: MySource.m
 Abstract: Encapsulates the name and all associated groups 
 of an ABSource object.
  Version: 1.0
 
 Disclaimer: IMPORTANT:  This Apple software is supplied to you by Apple
 Inc. ("Apple") in consideration of your agreement to the following
 terms, and your use, installation, modification or redistribution of
 this Apple software constitutes acceptance of these terms.  If you do
 not agree with these terms, please do not use, install, modify or
 redistribute this Apple software.
 
 In consideration of your agreement to abide by the following terms, and
 subject to these terms, Apple grants you a personal, non-exclusive
 license, under Apple's copyrights in this original Apple software (the
 "Apple Software"), to use, reproduce, modify and redistribute the Apple
 Software, with or without modifications, in source and/or binary forms;
 provided that if you redistribute the Apple Software in its entirety and
 without modifications, you must retain this notice and the following
 text and disclaimers in all such redistributions of the Apple Software.
 Neither the name, trademarks, service marks or logos of Apple Inc. may
 be used to endorse or promote products derived from the Apple Software
 without specific prior written permission from Apple.  Except as
 expressly stated in this notice, no other rights or licenses, express or
 implied, are granted by Apple herein, including but not limited to any
 patent rights that may be infringed by your derivative works or by other
 works in which the Apple Software may be incorporated.
 
 The Apple Software is provided by Apple on an "AS IS" basis.  APPLE
 MAKES NO WARRANTIES, EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION
 THE IMPLIED WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY AND FITNESS
 FOR A PARTICULAR PURPOSE, REGARDING THE APPLE SOFTWARE OR ITS USE AND
 OPERATION ALONE OR IN COMBINATION WITH YOUR PRODUCTS.
 
 IN NO EVENT SHALL APPLE BE LIABLE FOR ANY SPECIAL, INDIRECT, INCIDENTAL
 OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 INTERRUPTION) ARISING IN ANY WAY OUT OF THE USE, REPRODUCTION,
 MODIFICATION AND/OR DISTRIBUTION OF THE APPLE SOFTWARE, HOWEVER CAUSED
 AND WHETHER UNDER THEORY OF CONTRACT, TORT (INCLUDING NEGLIGENCE),
 STRICT LIABILITY OR OTHERWISE, EVEN IF APPLE HAS BEEN ADVISED OF THE
 POSSIBILITY OF SUCH DAMAGE.
 
 Copyright (C) 2011 Apple Inc. All Rights Reserved.
 
*/

#import "MySource.h"
#import "PTTAppDelegate.h"
#import "PTABGroup.h"

@implementation MySource
@synthesize /*name, groups,*/abGroupsMutArray;

//- (id)initWithAllGroups:(NSMutableArray *)allGroups name:(NSString*)sourceName
//{
//	self = [super init];
//	if(self != nil) 
//    {
//		self.groups = allGroups;
//		self.name = sourceName;
//    }
//	return self;
//}


- (id)init
{
	self = [super init];
	if(self != nil) 
    {
        
    }
	return self;
}




#pragma mark -
#pragma mark additonal Methods for working with address book
//-(NSArray *)addressBookGroupsArray{
//    
//    ABAddressBookRef addressBook;
//    @try {
//        
//        addressBook=ABAddressBookCreate();        
//        
//    }
//    @catch (NSException *exception) {
//        PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
//        
//        
//        [appDelegate displayNotification:@"Not able to access Address Book" forDuration:3.0 location:kPTTScreenLocationTop inView:appDelegate.window];
//        return nil;
//    }
//    @finally 
//    {
//        BOOL autoAddClinicianToGroup=[[NSUserDefaults standardUserDefaults]boolForKey:kPTAutoAddClinicianToGroup];
//        ABRecordRef group=nil;
//        
//        int groupIdentifier=-1;
//        if ([[NSUserDefaults standardUserDefaults] objectForKey:kPTTAddressBookGroupName])
//        {
//            
//            groupIdentifier=(NSInteger )[[NSUserDefaults standardUserDefaults] integerForKey:kPTTAddressBookGroupIdentifier];
//        }
//        
//        if (groupIdentifier>0) {
//            
//            
//            group=  ABAddressBookGetGroupWithRecordID((ABAddressBookRef) addressBook, groupIdentifier);
//            
//        }
//        
//        
//        
//        
//        
//        CFStringRef CFGroupName;
//        
//        if ([[NSUserDefaults standardUserDefaults] objectForKey:kPTTAddressBookGroupName]) {
//            
//            CFGroupName=(__bridge CFStringRef)[[NSUserDefaults standardUserDefaults] valueForKey:kPTTAddressBookGroupName];  
//            
//        }
//        else {
//            @try {
//                NSString *userDefaultName=[PTTAppDelegate retrieveFromUserDefaults:@"abgroup_name"];
//                
//                
//                CFGroupName=(__bridge_retained  CFStringRef)userDefaultName;
//                
//            }
//            @catch (NSException *exception) {
//                PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
//                
//                
//                [appDelegate displayNotification:@"Unable to access addressbook settings" forDuration:3.0 location:kPTTScreenLocationTop inView:appDelegate.window];
//            }
//            @finally {
//                
//            }
//            
//            
//        }
//        
//        
//        
//        
//        if (!CFStringGetLength(CFGroupName) && autoAddClinicianToGroup) {
//            NSString *clinicians=@"Clinicians";
//            CFGroupName=(__bridge CFStringRef)clinicians;
//            [[NSUserDefaults standardUserDefaults] setValue:(__bridge NSString*)CFGroupName forKeyPath:kPTTAddressBookGroupName];
//            [[NSUserDefaults standardUserDefaults] synchronize];
//            
//        }
//        
//        NSLog(@"group name is %@",CFGroupName);   
//        //check to see if the group name exists already
//        int groupCount=ABAddressBookGetGroupCount((ABAddressBookRef) addressBook);
//        CFArrayRef CFGroupsCheckNameArray=nil;
//        CFStringRef CFGroupNameCheck =nil;
//        ABRecordRef groupInCheckNameArray=nil;
//        if (groupCount&&!group ) {
//            
//            CFGroupsCheckNameArray= (CFArrayRef )ABAddressBookCopyArrayOfAllGroups((ABAddressBookRef) addressBook);
//            NSLog(@"cggroups array %@",CFGroupsCheckNameArray);
//            
//            
//            for (CFIndex i = 0; i < groupCount; i++) {
//                groupInCheckNameArray = CFArrayGetValueAtIndex(CFGroupsCheckNameArray, i);
//                CFGroupNameCheck  = ABRecordCopyValue(groupInCheckNameArray, kABGroupNameProperty);
//                
//                
//                CFComparisonResult result=  (CFComparisonResult) CFStringCompare (
//                                                                                  ( CFStringRef)CFGroupName,
//                                                                                  (CFStringRef) CFGroupNameCheck,
//                                                                                  1
//                                                                                  );
//                
//                NSLog(@"result is %ld and %d",result,kCFCompareEqualTo);
//                if (result==0) {
//                    group=groupInCheckNameArray;
//                    break;
//                }
//                //                    CFRelease(CFGroupsCheckNameArray); 
//                //                    CFRelease(CFGroupNameCheck);
//                
//                NSLog(@"group is %@",group);
//                
//            }
//        }
//        
//        
//        
//        
//        
//        
//        
//        
//        
//        NSMutableArray *allGroups;
//        
//        
//        
//        
//        if (!group) {
//            
//            
//            
//            [self changeABGroupNameTo:(__bridge NSString*) CFGroupName addNew:YES checkExisting:NO];
//            groupIdentifier=(NSInteger )[(NSNumber *)[[NSUserDefaults standardUserDefaults]valueForKey:kPTTAddressBookGroupIdentifier]intValue];
//            group=ABAddressBookGetGroupWithRecordID((ABAddressBookRef) addressBook, groupIdentifier);
//            
//            //        //        ABRecordRef CFAddressBookGroupRecord =  ABGroupCreate ();
//            //        
//            //        group=ABGroupCreate();
//            //        
//            //        //        ABRecord *groupRecord=(ABRecord *)[group getRecordRef];
//            //        
//            //        //        NSLog(@"group composite name is %@",groupRecord.compositeName);
//            //        
//            //        bool didSetGroupName=FALSE;
//            //        didSetGroupName= (bool) ABRecordSetValue (
//            //                                                  group,
//            //                                                  (ABPropertyID) kABGroupNameProperty,
//            //                                                  (__bridge CFStringRef)groupName  ,
//            //                                                  nil
//            //                                                  );  
//            //        //        NSLog(@"group record identifier is %i",groupRecord.recordID);
//            //        
//            //        BOOL wantToSaveChanges=TRUE;
//            //        if (ABAddressBookHasUnsavedChanges(addressBook)) {
//            //            
//            //            if (wantToSaveChanges) {
//            //                bool didSave=FALSE;
//            //                didSave = ABAddressBookSave(addressBook, nil);
//            //                
//            //                if (!didSave) {/* Handle error here. */}
//            //                
//            //            } 
//            //            else {
//            //                
//            //                ABAddressBookRevert(addressBook);
//            //                
//            //            }
//            //            
//            //        }
//            //        
//            //        //        ABRecord *groupRecord=[[ABRecord alloc]initWithABRef:(CFTypeRef)kABGroupType ];
//            //        
//            //        NSLog(@"group idenitifer is%i",ABRecordGetRecordID(group));
//            //
//            //        NSLog(@"group name is %@", (__bridge NSString *)ABRecordCopyValue(group, kABGroupNameProperty));
//            //        groupIdentifier=ABRecordGetRecordID(group);
//            //        
//            //        
//            //        [[NSUserDefaults standardUserDefaults] setInteger:(int )groupIdentifier forKey:kPTTAddressBookGroupIdentifier];
//            //        
//            //        [[NSUserDefaults standardUserDefaults]synchronize];
//            //            
//            //            
//            
//        } 
//        // Get the ABSource object that contains this new group
//        
//        
//        
//        NSNumber *groupIdentifierNumber=(NSNumber *)[[NSUserDefaults standardUserDefaults] valueForKey:kPTTAddressBookGroupIdentifier];
//        
//        if ([groupIdentifierNumber isEqualToNumber:[NSNumber numberWithInt:(int)-1]]||[groupIdentifierNumber isEqualToNumber:[NSNumber numberWithInt:(int)0]]||!groupCount) {
//            
//            [ self changeABGroupNameTo:nil addNew:YES checkExisting:NO];
//            
//            
//        }
//        
//        
//        
//        groupCount=ABAddressBookGetGroupCount((ABAddressBookRef) addressBook);
//        if (groupCount) {
//            
//            CFArrayRef CFGroupsArray= (CFArrayRef )ABAddressBookCopyArrayOfAllGroups((ABAddressBookRef) addressBook);
//            NSLog(@"cggroups array %@",(__bridge NSArray *) CFGroupsArray);
//            
//            if (CFGroupsArray) {
//                
//                
//                
//                NSMutableArray *allGroups = [[NSMutableArray alloc] init];
//                
//                
//                //            CFStringRef CFGroupName ;
//                for (CFIndex i = 0; i < groupCount; i++) {
//                    
//                    
//                    
//                    ABRecordRef groupInCFArray = CFArrayGetValueAtIndex(CFGroupsArray, i);
//                    CFGroupName  = ABRecordCopyValue(groupInCFArray, kABGroupNameProperty);
//                    int CFGroupID=ABRecordGetRecordID((ABRecordRef) groupInCFArray);
//                    
//                    PTABGroup *ptGroup=[[PTABGroup alloc]initWithName:(__bridge_transfer NSString*)CFGroupName recordID:CFGroupID];
//                    
//                    [allGroups addObject:ptGroup];
//                    
//                    CFRelease(groupInCFArray);
//                }     
//                
//                
//                NSLog(@"array of group names %@",allGroups);
//                CFRelease(CFGroupsArray);
//                
//                
//            }
//            
//        }
//        
//        //        if (addressBook) {
//        //            CFRelease(addressBook);
//        //        }
//        return allGroups;
//    }
//}
//
//-(void)changeABGroupNameTo:(NSString *)groupName  addNew:(BOOL)addNew checkExisting:(BOOL)checkExisting{
//    
//    ABAddressBookRef addressBook;
//    @try 
//    {
//        
//        addressBook=ABAddressBookCreate();
//        
//        
//    }
//    
//    @catch (NSException *exception) 
//    {
//        PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
//        
//        
//        [appDelegate displayNotification:@"Not able to access address book" forDuration:3.0 location:kPTTScreenLocationTop inView:appDelegate.window];
//        return;
//    }
//    @finally 
//    {
//        
//        ABRecordRef group=nil;
//        int groupIdentifier;
//        int groupCount=ABAddressBookGetGroupCount((ABAddressBookRef) addressBook);
//        BOOL autoAddClinicianToGroup=[[NSUserDefaults standardUserDefaults]boolForKey:kPTAutoAddClinicianToGroup];
//        if ((!groupName ||!groupName.length||checkExisting)&&autoAddClinicianToGroup) {
//            
//            if ([[NSUserDefaults standardUserDefaults] objectForKey:kPTTAddressBookGroupName]) {
//                
//                if (!checkExisting) {
//                    
//                    groupName=(NSString *)[[NSUserDefaults standardUserDefaults] valueForKey:kPTTAddressBookGroupName];  
//                    
//                }
//                //        }
//                if (!groupName ||!groupName.length) {
//                    groupName=@"Clinicians";
//                    if ([[NSUserDefaults standardUserDefaults]objectForKey:kPTTAddressBookGroupName]) {
//                        
//                        [[NSUserDefaults standardUserDefaults] setValue:groupName forKeyPath:kPTTAddressBookGroupName];
//                        [[NSUserDefaults standardUserDefaults] synchronize];
//                        
//                    }
//                }
//                
//            }  
//            
//            
//            
//            if (!addNew) 
//            {
//                
//                if ([[NSUserDefaults standardUserDefaults]objectForKey:kPTTAddressBookGroupIdentifier]) 
//                {
//                    groupIdentifier=(NSInteger )[[NSUserDefaults standardUserDefaults] integerForKey:kPTTAddressBookGroupIdentifier];
//                    
//                }
//                
//                if (!addNew&&groupIdentifier>-1)
//                {
//                    group=ABAddressBookGetGroupWithRecordID((ABAddressBookRef) addressBook, groupIdentifier);
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
//                //should not ad new
//                CFArrayRef CFGroupsCheckNameArray=nil;
//                CFStringRef CFGroupNameCheck =nil;
//                ABRecordRef groupInCheckNameArray=nil;
//                if (groupCount) 
//                {
//                    
//                    CFGroupsCheckNameArray= (CFArrayRef )ABAddressBookCopyArrayOfAllGroups((ABAddressBookRef) addressBook);
//                    NSLog(@"cggroups array %@",CFGroupsCheckNameArray);
//                    
//                    
//                    for (CFIndex i = 0; i < groupCount; i++) {
//                        groupInCheckNameArray = CFArrayGetValueAtIndex(CFGroupsCheckNameArray, i);
//                        CFGroupNameCheck  = ABRecordCopyValue(groupInCheckNameArray, kABGroupNameProperty);
//                        
//                        
//                        //            CFComparisonResult result=  (CFComparisonResult) CFStringCompare (
//                        //                                                                              (__bridge CFStringRef)groupName,
//                        //                                                                              (CFStringRef) CFGroupNameCheck,
//                        //                                                                              1
//                        //                                                                              );
//                        
//                        
//                        
//                        NSString *checkNameStr=[NSString stringWithFormat:@"%@",(__bridge NSString*) CFGroupNameCheck];
//                        
//                        NSLog(@"cfgroupname is %@",checkNameStr);
//                        NSLog(@"groupname Str is %@",groupName);
//                        if ([checkNameStr isEqualToString:groupName]) {
//                            group=groupInCheckNameArray;
//                            groupIdentifier=ABRecordGetRecordID(group);
//                            
//                            if ([[NSUserDefaults standardUserDefaults] objectForKey:kPTTAddressBookGroupIdentifier]) {
//                                [[NSUserDefaults standardUserDefaults] setInteger:groupIdentifier forKey:kPTTAddressBookGroupIdentifier];
//                                [[NSUserDefaults standardUserDefaults]synchronize];
//                                
//                            }
//                            
//                            if (group) {
//                                NSLog(@"group is %@",group);
//                            }
//                            
//                            else {
//                                NSLog(@"no group");
//                            } 
//                            break;
//                        }
//                        //            CFRelease(CFGroupsCheckNameArray); 
//                        //            CFRelease(CFGroupNameCheck);
//                        
//                    }
//                    if (CFGroupsCheckNameArray) {
//                        CFRelease(CFGroupsCheckNameArray); 
//                    }
//                    
//                    if (CFGroupNameCheck) {
//                        CFRelease(CFGroupNameCheck);
//                    }  
//                }
//                
//                
//            }
//            
//        }
//        
//        
//        
//        
//        NSNumber *groupIdentifierNumber=(NSNumber *)[[NSUserDefaults standardUserDefaults] valueForKey:kPTTAddressBookGroupIdentifier];
//        
//        if (!addNew && !group && groupIdentifier>0 && groupCount>0 && ![groupIdentifierNumber isEqualToNumber:[NSNumber numberWithInt:(int)-1]]  && ![groupIdentifierNumber isEqualToNumber:[NSNumber numberWithInt:(int)0]]) {
//            
//            group=ABAddressBookGetGroupWithRecordID((ABAddressBookRef) addressBook, groupIdentifier);
//            
//        }
//        
//        if ((!group ||addNew) && autoAddClinicianToGroup) {
//            
//            
//            if (!addressBook) {
//                
//                return;
//            }
//            //        ABRecordRef CFAddressBookGroupRecord =  ABGroupCreate ();
//            
//            group=ABGroupCreate();
//            
//            //        ABRecord *groupRecord=(ABRecord *)[group getRecordRef];
//            
//            //        NSLog(@"group composite name is %@",groupRecord.compositeName);
//            
//            
//            //        NSLog(@"group record identifier is %i",groupRecord.recordID);
//            
//            bool didSetGroupName=FALSE;
//            didSetGroupName= (bool) ABRecordSetValue (
//                                                      group,
//                                                      (ABPropertyID) kABGroupNameProperty,
//                                                      (__bridge CFStringRef)groupName  ,
//                                                      nil
//                                                      );  
//            
//            ABAddressBookAddRecord((ABAddressBookRef) addressBook, (ABRecordRef) group, nil);
//            
//            BOOL wantToSaveChanges=TRUE;
//            if (ABAddressBookHasUnsavedChanges(addressBook)) {
//                
//                if (wantToSaveChanges) {
//                    bool didSave=FALSE;
//                    didSave = ABAddressBookSave(addressBook, nil);
//                    
//                    if (!didSave) {/* Handle error here. */  NSLog(@"addressbook did not save");}
//                    else NSLog(@"addresss book saved new group.");
//                    
//                } 
//                else {
//                    
//                    ABAddressBookRevert(addressBook);
//                    
//                }
//                
//            }
//            
//            //        ABRecord *groupRecord=[[ABRecord alloc]initWithABRef:(CFTypeRef)kABGroupType ];
//            
//            NSLog(@"group idenitifer is%i",ABRecordGetRecordID(group));
//            
//            NSLog(@"group name is %@", (__bridge NSString *)ABRecordCopyValue(group, kABGroupNameProperty));
//            
//            
//            
//            
//            
//            groupIdentifier=ABRecordGetRecordID(group);
//            
//            [[NSUserDefaults standardUserDefaults] setInteger:(int )groupIdentifier forKey:kPTTAddressBookGroupIdentifier];
//            
//            [[NSUserDefaults standardUserDefaults] setValue:groupName forKey:kPTTAddressBookGroupName];  
//            
//            [[NSUserDefaults standardUserDefaults]synchronize];
//            
//            //        CFRelease(group);
//        } 
//        else
//            
//        {
//            
//            BOOL wantToSaveChanges=TRUE;
//            
//            if (group) {
//                groupIdentifier=ABRecordGetRecordID(group);
//            }
//            
//            
//            if (groupIdentifier>-1) {
//                
//                [[NSUserDefaults standardUserDefaults] setInteger:(int )groupIdentifier forKey:kPTTAddressBookGroupIdentifier];
//                
//                [[NSUserDefaults standardUserDefaults]synchronize];
//                
//            }
//            if (ABAddressBookHasUnsavedChanges(addressBook)) {
//                
//                if (wantToSaveChanges) {
//                    bool didSave=FALSE;
//                    didSave = ABAddressBookSave(addressBook, nil);
//                    
//                    if (!didSave) {/* Handle error here. */}
//                    
//                } 
//                else {
//                    
//                    ABAddressBookRevert(addressBook);
//                    
//                }
//                
//                
//                
//            }
//            
//        }
//        
//        
//        
//        
//    }
//    //    [[NSUserDefaults standardUserDefaults]  setValue:(NSString *)groupName forKey:kPTTAddressBookGroupName];
//    
//    
//    
//    
//    
//}


@end
