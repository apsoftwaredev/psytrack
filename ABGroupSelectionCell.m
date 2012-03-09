//
//  ABGroupSelectionCell.m
//  PsyTrack Clinician Tools
//
//  Created by Daniel Boice on 3/7/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import "ABGroupSelectionCell.h"
#import "PTTAppDelegate.h"
#import "PTABGroup.h"
@implementation ABGroupSelectionCell
@synthesize  clinician=clinician_;

-(id)initWithClinician:(ClinicianEntity *)clinicianObject
{


    self=[super init];
    
    
    self.clinician=clinicianObject;
    return self;


}

-(void)performInitialization{


    [super performInitialization];


    
    self.allowAddingItems=NO;
    self.allowDeletingItems=NO;
    self.allowEditDetailView=NO;
    self.allowMovingItems=NO;
    self.allowMultipleSelection=YES;
    self.allowNoSelection=YES;
    
    self.textLabel.text=@"Address Book Groups";
    
    
    self.items=[self addressBookGroupsArray];
    
}



-(void)loadBindingsIntoCustomControls{


    NSLog(@" test");
   
    
    



}
-(void)loadBoundValueIntoControl{
    
    int groupCount=self.items.count;
    NSArray *groupItems=(NSArray *)self.items;
NSLog(@"selected item indexes %@",self.selectedItemsIndexes);
    
    NSLog(@"items are %@",self.items);
    
    for (int i=0; i<groupCount; i++) {
    
        PTABGroup *ptGroup=[groupItems objectAtIndex:i];
        if ([self personContainedInGroupWithID:ptGroup.recordID]) {
            if (![self.selectedItemsIndexes containsObject:[NSNumber numberWithInt:i]]) {
                [self.selectedItemsIndexes addObject:[NSNumber numberWithInt:i]];
            }
          
            
        }
        else 
        {
            if ([self.selectedItemsIndexes containsObject:[NSNumber numberWithInt:i]]) {
                [self.selectedItemsIndexes removeObject:[NSNumber numberWithInt:i]];
            }
        }
    
    
    }
    
  NSLog(@"selected item indexes %@",self.selectedItemsIndexes);  
    
    NSString *groupsList=[NSString string];
    for (NSInteger i=0;i<self.selectedItemsIndexes.count; i++) {
        
        NSInteger p=(int)[(NSNumber *)[(NSArray *)[self.selectedItemsIndexes allObjects] objectAtIndex:i]intValue];
        PTABGroup *ptABGroup=[self.items objectAtIndex:p];
        
        if (!groupsList.length) {
            groupsList=[NSString stringWithFormat:@"%@",ptABGroup.groupName];
        }
        else {
            groupsList=[groupsList stringByAppendingFormat:@", %@",ptABGroup.groupName];
        }
        
    }

    self.label.text=groupsList;
    
    
   
    
    NSLog(@"clinician is %@", self.clinician);
    
}

-(void)addPersonToGroupWithID:(int)groupID
{
    int clinicianABRecordIdentifier=[clinician_.aBRecordIdentifier intValue];
    if (clinicianABRecordIdentifier==-1) {
        return;
    }



}


-(BOOL)personContainedInGroupWithID:(int)groupID{

    int clinicianABRecordIdentifier=[clinician_.aBRecordIdentifier intValue];
    if (clinicianABRecordIdentifier==-1) {
        
       
        
        return NO;
    }
    
    
    BOOL personExistsInGroup=NO;
    ABAddressBookRef addressBook=nil;
    addressBook=ABAddressBookCreate();

    ABRecordRef group=nil;
    
    group=ABAddressBookGetGroupWithRecordID(addressBook, groupID);
    
    
    
    if (group) {
    
        ABRecordRef person=nil;
        CFArrayRef arrayOfGroupMembers=nil;
        
       arrayOfGroupMembers =(CFArrayRef )ABGroupCopyArrayOfAllMembers(group);
        if (arrayOfGroupMembers) {
       
        int countOfMembers= 0;
        countOfMembers=    CFArrayGetCount(arrayOfGroupMembers);
      
        
        for (int i=0; i<countOfMembers; i++)
        {
            person=nil;
            person=CFArrayGetValueAtIndex(arrayOfGroupMembers, i);
            
           int memberInArrayID=ABRecordGetRecordID(person);
            if (memberInArrayID==clinicianABRecordIdentifier) {
                personExistsInGroup=YES;
                break;
                
                
            }
            
           
            
        
            
            
            
        }
            
        }
        if (person) {
            CFRelease(person);
        }
        if (arrayOfGroupMembers) {
            CFRelease(arrayOfGroupMembers);
            
        } 
        
}

    if (group){

        CFRelease(group);
    }



    return personExistsInGroup;

}


-(NSArray * )addressBookGroupsArray{
    
    ABAddressBookRef addressBook;
    @try {
        
        addressBook=ABAddressBookCreate();        
        
    }
    @catch (NSException *exception) {
        PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
        
        
        [appDelegate displayNotification:@"Not able to access Address Book" forDuration:3.0 location:kPTTScreenLocationTop inView:appDelegate.window];
        return nil ;
    }
    @finally 
    {
        BOOL autoAddClinicianToGroup=[[NSUserDefaults standardUserDefaults]boolForKey:kPTAutoAddClinicianToGroup];
        ABRecordRef group=nil;
        
        int groupIdentifier=-1;
        if ([[NSUserDefaults standardUserDefaults] objectForKey:kPTTAddressBookGroupName])
        {
            
            groupIdentifier=(NSInteger )[[NSUserDefaults standardUserDefaults] integerForKey:kPTTAddressBookGroupIdentifier];
        }
        
        if (groupIdentifier>0) {
            
            
            group=  ABAddressBookGetGroupWithRecordID((ABAddressBookRef) addressBook, groupIdentifier);
            
        }
        
        
        
        
        
        CFStringRef CFGroupName;
        
        if ([[NSUserDefaults standardUserDefaults] objectForKey:kPTTAddressBookGroupName]) {
            
            CFGroupName=(__bridge CFStringRef)[[NSUserDefaults standardUserDefaults] valueForKey:kPTTAddressBookGroupName];  
            
        }
        else {
            @try {
                NSString *userDefaultName=[PTTAppDelegate retrieveFromUserDefaults:@"abgroup_name"];
                
                
                CFGroupName=(__bridge_retained  CFStringRef)userDefaultName;
                
            }
            @catch (NSException *exception) {
                PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
                
                
                [appDelegate displayNotification:@"Unable to access addressbook settings" forDuration:3.0 location:kPTTScreenLocationTop inView:appDelegate.window];
            }
            @finally {
                
            }
            
            
        }
        
        
        
        
        if (!CFStringGetLength(CFGroupName) && autoAddClinicianToGroup) {
            NSString *clinicians=@"Clinicians";
            CFGroupName=(__bridge CFStringRef)clinicians;
            [[NSUserDefaults standardUserDefaults] setValue:(__bridge NSString*)CFGroupName forKeyPath:kPTTAddressBookGroupName];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
        }
        
        NSLog(@"group name is %@",CFGroupName);   
        //check to see if the group name exists already
        int groupCount=ABAddressBookGetGroupCount((ABAddressBookRef) addressBook);
        CFArrayRef CFGroupsCheckNameArray=nil;
        CFStringRef CFGroupNameCheck =nil;
        ABRecordRef groupInCheckNameArray=nil;
        if (groupCount&&!group ) {
            
            CFGroupsCheckNameArray= (CFArrayRef )ABAddressBookCopyArrayOfAllGroups((ABAddressBookRef) addressBook);
            NSLog(@"cggroups array %@",CFGroupsCheckNameArray);
            
            
            for (CFIndex i = 0; i < groupCount; i++) {
                groupInCheckNameArray = CFArrayGetValueAtIndex(CFGroupsCheckNameArray, i);
                CFGroupNameCheck  = ABRecordCopyValue(groupInCheckNameArray, kABGroupNameProperty);
                
                
                CFComparisonResult result=  (CFComparisonResult) CFStringCompare (
                                                                                  ( CFStringRef)CFGroupName,
                                                                                  (CFStringRef) CFGroupNameCheck,
                                                                                  1
                                                                                  );
                
                NSLog(@"result is %ld and %d",result,kCFCompareEqualTo);
                if (result==0) {
                    group=groupInCheckNameArray;
                    break;
                }
                //                    CFRelease(CFGroupsCheckNameArray); 
                //                    CFRelease(CFGroupNameCheck);
                
                NSLog(@"group is %@",group);
                
            }
        }
        
        
   
        
        
        
        
        
        
        NSMutableArray *allGroups;
        
        
       
        
        if (!group) {
            
            
            
            [self changeABGroupNameTo:(__bridge NSString*) CFGroupName addNew:YES];
            groupIdentifier=(NSInteger )[(NSNumber *)[[NSUserDefaults standardUserDefaults]valueForKey:kPTTAddressBookGroupIdentifier]intValue];
            group=ABAddressBookGetGroupWithRecordID((ABAddressBookRef) addressBook, groupIdentifier);
            
            //        //        ABRecordRef CFAddressBookGroupRecord =  ABGroupCreate ();
            //        
            //        group=ABGroupCreate();
            //        
            //        //        ABRecord *groupRecord=(ABRecord *)[group getRecordRef];
            //        
            //        //        NSLog(@"group composite name is %@",groupRecord.compositeName);
            //        
            //        bool didSetGroupName=FALSE;
            //        didSetGroupName= (bool) ABRecordSetValue (
            //                                                  group,
            //                                                  (ABPropertyID) kABGroupNameProperty,
            //                                                  (__bridge CFStringRef)groupName  ,
            //                                                  nil
            //                                                  );  
            //        //        NSLog(@"group record identifier is %i",groupRecord.recordID);
            //        
            //        BOOL wantToSaveChanges=TRUE;
            //        if (ABAddressBookHasUnsavedChanges(addressBook)) {
            //            
            //            if (wantToSaveChanges) {
            //                bool didSave=FALSE;
            //                didSave = ABAddressBookSave(addressBook, nil);
            //                
            //                if (!didSave) {/* Handle error here. */}
            //                
            //            } 
            //            else {
            //                
            //                ABAddressBookRevert(addressBook);
            //                
            //            }
            //            
            //        }
            //        
            //        //        ABRecord *groupRecord=[[ABRecord alloc]initWithABRef:(CFTypeRef)kABGroupType ];
            //        
            //        NSLog(@"group idenitifer is%i",ABRecordGetRecordID(group));
            //
            //        NSLog(@"group name is %@", (__bridge NSString *)ABRecordCopyValue(group, kABGroupNameProperty));
            //        groupIdentifier=ABRecordGetRecordID(group);
            //        
            //        
            //        [[NSUserDefaults standardUserDefaults] setInteger:(int )groupIdentifier forKey:kPTTAddressBookGroupIdentifier];
            //        
            //        [[NSUserDefaults standardUserDefaults]synchronize];
            //            
            //            
            
        } 
        // Get the ABSource object that contains this new group
        
        
        
        NSNumber *groupIdentifierNumber=(NSNumber *)[[NSUserDefaults standardUserDefaults] valueForKey:kPTTAddressBookGroupIdentifier];
        
        if ([groupIdentifierNumber isEqualToNumber:[NSNumber numberWithInt:(int)-1]]||[groupIdentifierNumber isEqualToNumber:[NSNumber numberWithInt:(int)0]]||!groupCount) {
            
            [ self changeABGroupNameTo:nil addNew:YES];
            
            
        }
        
        
        
        groupCount=ABAddressBookGetGroupCount((ABAddressBookRef) addressBook);
        if (groupCount) {
            
            CFArrayRef CFGroupsArray= (CFArrayRef )ABAddressBookCopyArrayOfAllGroups((ABAddressBookRef) addressBook);
            NSLog(@"cggroups array %@",(__bridge NSArray *) CFGroupsArray);
            
            if (CFGroupsArray) {
                
                
                
               allGroups = [[NSMutableArray alloc] init];
                
                
                //            CFStringRef CFGroupName ;
                for (CFIndex i = 0; i < groupCount; i++) {
                    
                    
                    
                    ABRecordRef groupInCFArray = CFArrayGetValueAtIndex(CFGroupsArray, i);
                    CFGroupName  = ABRecordCopyValue(groupInCFArray, kABGroupNameProperty);
                    int CFGroupID=ABRecordGetRecordID((ABRecordRef) groupInCFArray);
                    
                    PTABGroup *ptGroup=[[PTABGroup alloc]initWithName:(__bridge_transfer  NSString*)CFGroupName recordID:CFGroupID];
                    
                    [allGroups addObject:ptGroup];
                    
                    CFRelease(groupInCFArray);
                }     
                
                
                
                CFRelease(CFGroupsArray);
                
                NSLog(@"array of group names %@",allGroups);
                abGroupsArray=allGroups;
            }
            
        }
        
        //        if (addressBook) {
        //            CFRelease(addressBook);
        //        }
        
        return allGroups;
}
}    


-(void)changeABGroupNameTo:(NSString *)groupName  addNew:(BOOL)addNew{
    
    ABAddressBookRef addressBook;
    @try 
    {
        addressBook=nil;
        addressBook=ABAddressBookCreate();
        
        
    }
    
    @catch (NSException *exception) 
    {
        PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
        
        
        [appDelegate displayNotification:@"Not able to access address book" forDuration:3.0 location:kPTTScreenLocationTop inView:appDelegate.window];
        return;
    }
    @finally 
    {
        
        ABRecordRef group;
        int groupIdentifier;
        int groupCount=ABAddressBookGetGroupCount((ABAddressBookRef) addressBook);
        if (!groupName ||!groupName.length) {
            
            if ([[NSUserDefaults standardUserDefaults] objectForKey:kPTTAddressBookGroupName]) {
                
                groupName=(NSString *)[[NSUserDefaults standardUserDefaults] valueForKey:kPTTAddressBookGroupName];  
                
                //        }
                if (!groupName ||!groupName.length) {
                    groupName=@"Clinicians";
                    if ([[NSUserDefaults standardUserDefaults]objectForKey:kPTTAddressBookGroupName]) {
                        
                        [[NSUserDefaults standardUserDefaults] setValue:groupName forKeyPath:kPTTAddressBookGroupName];
                        [[NSUserDefaults standardUserDefaults] synchronize];
                        
                    }
                }
                
            }  
            
            
            
            if (!addNew) 
            {
                
                if ([[NSUserDefaults standardUserDefaults]objectForKey:kPTTAddressBookGroupIdentifier]) 
                {
                    groupIdentifier=(NSInteger )[[NSUserDefaults standardUserDefaults] integerForKey:kPTTAddressBookGroupIdentifier];
                    
                }
                
                if (!addNew&&groupIdentifier>-1)
                {
                    group=ABAddressBookGetGroupWithRecordID((ABAddressBookRef) addressBook, groupIdentifier);
                    
                }
                
                
                
                
                
                
                
                
                //should not ad new
                CFArrayRef CFGroupsCheckNameArray;
                CFStringRef CFGroupNameCheck ;
                ABRecordRef groupInCheckNameArray;
                if (groupCount) 
                {
                    
                    CFGroupsCheckNameArray= (CFArrayRef )ABAddressBookCopyArrayOfAllGroups((ABAddressBookRef) addressBook);
                    NSLog(@"cggroups array %@",CFGroupsCheckNameArray);
                    
                    
                    for (CFIndex i = 0; i < groupCount; i++) {
                        groupInCheckNameArray = CFArrayGetValueAtIndex(CFGroupsCheckNameArray, i);
                        CFGroupNameCheck  = ABRecordCopyValue(groupInCheckNameArray, kABGroupNameProperty);
                        
                        
                        //            CFComparisonResult result=  (CFComparisonResult) CFStringCompare (
                        //                                                                              (__bridge CFStringRef)groupName,
                        //                                                                              (CFStringRef) CFGroupNameCheck,
                        //                                                                              1
                        //                                                                              );
                        
                        
                        
                        NSString *checkNameStr=[NSString stringWithFormat:@"%@",(__bridge NSString*) CFGroupNameCheck];
                        
                        NSLog(@"cfgroupname is %@",checkNameStr);
                        NSLog(@"groupname Str is %@",groupName);
                        if ([checkNameStr isEqualToString:groupName]) {
                            group=groupInCheckNameArray;
                            groupIdentifier=ABRecordGetRecordID(group);
                            
                            if ([[NSUserDefaults standardUserDefaults] objectForKey:kPTTAddressBookGroupIdentifier]) {
                                [[NSUserDefaults standardUserDefaults] setInteger:groupIdentifier forKey:kPTTAddressBookGroupIdentifier];
                                [[NSUserDefaults standardUserDefaults]synchronize];
                                
                            }
                            
                            if (group) {
                                NSLog(@"group is %@",group);
                            }
                            
                            else {
                                NSLog(@"no group");
                            } 
                            break;
                        }
                        //            CFRelease(CFGroupsCheckNameArray); 
                        //            CFRelease(CFGroupNameCheck);
                        
                    }
                    if (CFGroupsCheckNameArray) {
                        CFRelease(CFGroupsCheckNameArray); 
                    }
                    
                    if (CFGroupNameCheck) {
                        CFRelease(CFGroupNameCheck);
                    }
                }
                
                
            }
            
        }
        
        
        
        
        NSNumber *groupIdentifierNumber=(NSNumber *)[[NSUserDefaults standardUserDefaults] valueForKey:kPTTAddressBookGroupIdentifier];
        
        if (!addNew && !group && groupIdentifier>0 && groupCount>0 && ![groupIdentifierNumber isEqualToNumber:[NSNumber numberWithInt:(int)-1]]  && ![groupIdentifierNumber isEqualToNumber:[NSNumber numberWithInt:(int)0]]) {
            
            group=ABAddressBookGetGroupWithRecordID((ABAddressBookRef) addressBook, groupIdentifier);
            
        }
        
        if (!group ||addNew) {
            
            
            if (!addressBook) {
                
                return;
            }
            //        ABRecordRef CFAddressBookGroupRecord =  ABGroupCreate ();
            
            group=ABGroupCreate();
            
            //        ABRecord *groupRecord=(ABRecord *)[group getRecordRef];
            
            //        NSLog(@"group composite name is %@",groupRecord.compositeName);
            
            
            //        NSLog(@"group record identifier is %i",groupRecord.recordID);
            
            bool didSetGroupName=FALSE;
            didSetGroupName= (bool) ABRecordSetValue (
                                                      group,
                                                      (ABPropertyID) kABGroupNameProperty,
                                                      (__bridge CFStringRef)groupName  ,
                                                      nil
                                                      );  
            
            ABAddressBookAddRecord((ABAddressBookRef) addressBook, (ABRecordRef) group, nil);
            
            BOOL wantToSaveChanges=TRUE;
            if (ABAddressBookHasUnsavedChanges(addressBook)) {
                
                if (wantToSaveChanges) {
                    bool didSave=FALSE;
                    didSave = ABAddressBookSave(addressBook, nil);
                    
                    if (!didSave) {/* Handle error here. */  NSLog(@"addressbook did not save");}
                    else NSLog(@"addresss book saved new group.");
                    
                } 
                else {
                    
                    ABAddressBookRevert(addressBook);
                    
                }
                
            }
            
            //        ABRecord *groupRecord=[[ABRecord alloc]initWithABRef:(CFTypeRef)kABGroupType ];
            
            NSLog(@"group idenitifer is%i",ABRecordGetRecordID(group));
            
            NSLog(@"group name is %@", (__bridge NSString *)ABRecordCopyValue(group, kABGroupNameProperty));
            
            
            
            
            
            groupIdentifier=ABRecordGetRecordID(group);
            
            [[NSUserDefaults standardUserDefaults] setInteger:(int )groupIdentifier forKey:kPTTAddressBookGroupIdentifier];
            
            [[NSUserDefaults standardUserDefaults] setValue:groupName forKey:kPTTAddressBookGroupName];  
            
            [[NSUserDefaults standardUserDefaults]synchronize];
            
            if (group) {
                CFRelease(group);
            }
            
        } 
        else
            
        {
            
            BOOL wantToSaveChanges=TRUE;
            groupIdentifier=ABRecordGetRecordID(group);
            
            if (groupIdentifier>0) {
                
                [[NSUserDefaults standardUserDefaults] setInteger:(int )groupIdentifier forKey:kPTTAddressBookGroupIdentifier];
                
                [[NSUserDefaults standardUserDefaults]synchronize];
                
            }
            if (ABAddressBookHasUnsavedChanges(addressBook)) {
                
                if (wantToSaveChanges) {
                    bool didSave=FALSE;
                    didSave = ABAddressBookSave(addressBook, nil);
                    
                    if (!didSave) {/* Handle error here. */}
                    
                } 
                else {
                    
                    ABAddressBookRevert(addressBook);
                    
                }
                
                
                
            }
            
        }
        
        
        
        
    }
    //    [[NSUserDefaults standardUserDefaults]  setValue:(NSString *)groupName forKey:kPTTAddressBookGroupName];
    
    
    
    
    
}



@end
