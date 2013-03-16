/*
 *  ABGroupSelectionCell.hm
 *  psyTrack Clinician Tools
 *  Version: 1.05
 *
 *
 *	THIS SOURCE CODE AND ANY ACCOMPANYING DOCUMENTATION ARE PROTECTED BY UNITED STATES
 *	INTELLECTUAL PROPERTY LAW AND INTERNATIONAL TREATIES. UNAUTHORIZED REPRODUCTION OR
 *	DISTRIBUTION IS SUBJECT TO CIVIL AND CRIMINAL PENALTIES.
 *
 *  Created by Daniel Boice on 3/7/12.
 *  Copyright (c) 2011 PsycheWeb LLC. All rights reserved.
 *
 *
 *	This notice may not be removed from this file.
 *
 */
#import "ABGroupSelectionCell.h"
#import "PTTAppDelegate.h"
#import "PTABGroup.h"
@implementation ABGroupSelectionCell
@synthesize  clinician = clinician_;
@synthesize synchWithABBeforeLoadBool = synchWithABBeforeLoadBool_;
@synthesize objectSelectionCell = objectSelectionCell_;
@synthesize abGroupsArray = abGroupsArray_;
- (id) initWithClinician:(ClinicianEntity *)clinicianObject
{
    self.clinician = clinicianObject;

    [self syncryonizeWithAddressBookGroups];
    self.abGroupsArray = [NSArray arrayWithArray:[self addressBookGroupsArray]];

    self = [super initWithText:@"Address Book Groups"];

    return self;
}


- (void) performInitialization
{
//self.abGroupsArray=[NSArray arrayWithArray:[self addressBookGroupsArray]];

    [super performInitialization];

    self.customCell = YES;

    self.allowAddingItems = YES;
    self.allowDeletingItems = NO;
    self.allowEditDetailView = NO;
    self.allowMovingItems = NO;

    self.allowNoSelection = YES;
}


- (void) syncryonizeWithAddressBookGroups
{
    NSArray *groupItems = (NSArray *)self.items;

    int groupCount = groupItems.count;

    for (int i = 0; i < groupCount; i++)
    {
        PTABGroup *ptGroup = [groupItems objectAtIndex:i];

        if ([self personContainedInGroupWithID:ptGroup.recordID])
        {
            if (![objectSelectionCell_.selectedItemsIndexes containsObject:[NSNumber numberWithInt:i]])
            {
                [objectSelectionCell_.selectedItemsIndexes addObject:[NSNumber numberWithInt:i]];
            }
        }
    }

    synchWithABBeforeLoadBool_ = NO;
}


- (NSArray *) items
{
    return self.abGroupsArray;
}


- (void) addPersonToSelectedGroups
{
    if (objectSelectionCell_.selectedItemsIndexes.count > 0 && ![clinician_.aBRecordIdentifier isEqualToNumber:[NSNumber numberWithInt:-1]])
    {
        for (NSNumber *selectedItemAtIndex in objectSelectionCell_.selectedItemsIndexes)
        {
            PTABGroup *ptABGroup = [self.items objectAtIndex:[selectedItemAtIndex intValue]];

            if (![self personContainedInGroupWithID:(int)ptABGroup])
            {
                [self addPersonToGroupWithID:(int)ptABGroup.recordID];
            }
        }
    }
}


- (void) addPersonToGroupWithID:(int)groupID
{
    int clinicianABRecordIdentifier = [clinician_.aBRecordIdentifier intValue];
    if (clinicianABRecordIdentifier == -1)
    {
        return;
    }

    ABAddressBookRef addressBook = nil;
    addressBook = ABAddressBookCreate();

    ABRecordRef person = ABAddressBookGetPersonWithRecordID(addressBook, clinicianABRecordIdentifier);

    if (person)
    {
        if (groupID > -1)
        {
            ABRecordRef group = ABAddressBookGetGroupWithRecordID( (ABAddressBookRef)addressBook, (ABRecordID)groupID );

            CFErrorRef *error = nil;
            if (group)
            {
                bool didSave = (bool)ABGroupAddMember(group, person,error);

                if (error != noErr)
                {
                    PTTAppDelegate *appDelegate = (PTTAppDelegate *)[UIApplication sharedApplication].delegate;

                    [ appDelegate displayNotification:[NSString stringWithFormat:@"Error adding to group occured: %@", (__bridge NSString *)CFErrorCopyDescription(*error) ] forDuration:3.0 location:kPTTScreenLocationTop inView:nil];
                }

                if ( (didSave == YES) && ( ABAddressBookHasUnsavedChanges(addressBook) ) == YES )
                {
                    BOOL wantToSaveChanges = YES;
                    if (wantToSaveChanges)
                    {
                        didSave = ABAddressBookSave(addressBook, nil);

                        if (!didSave)
                        {
                            /* Handle error here. */
                        }
                    }
                    else
                    {
                        ABAddressBookRevert(addressBook);
                    }
                }
            }

            if (error)
            {
                CFRelease(error);
            }
        }
    }

    CFRelease(addressBook);
}


- (void) removePersonFromGroupWithID:(int)groupID
{
    int clinicianABRecordIdentifier = [clinician_.aBRecordIdentifier intValue];
    if (clinicianABRecordIdentifier == -1)
    {
        return;
    }

    ABAddressBookRef addressBook = nil;
    addressBook = ABAddressBookCreate();
    ABRecordRef person = nil;
    person = ABAddressBookGetPersonWithRecordID(addressBook, clinicianABRecordIdentifier);

    if (person)
    {
        if (groupID > -1)
        {
            ABRecordRef group = nil;
            group = ABAddressBookGetGroupWithRecordID( (ABAddressBookRef)addressBook, (ABRecordID)groupID );

            CFErrorRef *error = nil;

            if (group)
            {
                bool didRemove = (bool)ABGroupRemoveMember(group, person,error);

                if (error != noErr)
                {
                    PTTAppDelegate *appDelegate = (PTTAppDelegate *)[UIApplication sharedApplication].delegate;

                    [ appDelegate displayNotification:[NSString stringWithFormat:@"Error adding to group occured: %@", (__bridge NSString *)CFErrorCopyDescription(*error) ] forDuration:3.0 location:kPTTScreenLocationTop inView:nil];
                }
                else if ( (didRemove == YES) && ( ABAddressBookHasUnsavedChanges( (ABAddressBookRef)addressBook ) ) == YES )
                {
                    BOOL wantToSaveChanges = YES;

                    if (wantToSaveChanges)
                    {
                        bool didSave = NO;

                        didSave = ABAddressBookSave(addressBook, nil);

                        if (!didSave)
                        {
                            /* Handle error here. */
                        }
                    }
                    else
                    {
                        ABAddressBookRevert(addressBook);
                    }
                }
            }
        }
    }

    CFRelease(addressBook);
}


- (BOOL) personContainedInGroupWithID:(int)groupID
{
    int clinicianABRecordIdentifier = [clinician_.aBRecordIdentifier intValue];
    if (clinicianABRecordIdentifier == -1)
    {
        return NO;
    }

    BOOL personExistsInGroup = NO;
    ABAddressBookRef addressBook = nil;
    addressBook = ABAddressBookCreate();

    ABRecordRef group = nil;

    group = ABAddressBookGetGroupWithRecordID(addressBook, groupID);

    if (group)
    {
        ABRecordRef person = nil;
        CFArrayRef arrayOfGroupMembers = nil;

        arrayOfGroupMembers = (CFArrayRef)ABGroupCopyArrayOfAllMembers(group);
        if (arrayOfGroupMembers)
        {
            int countOfMembers = 0;
            countOfMembers = CFArrayGetCount(arrayOfGroupMembers);

            for (int i = 0; i < countOfMembers; i++)
            {
                person = nil;
                person = CFArrayGetValueAtIndex(arrayOfGroupMembers, i);

                int memberInArrayID = ABRecordGetRecordID(person);
                if (memberInArrayID == clinicianABRecordIdentifier)
                {
                    personExistsInGroup = YES;
                    break;
                }
            }
        }

        if (arrayOfGroupMembers)
        {
            CFRelease(arrayOfGroupMembers);
        }
    }

    CFRelease(addressBook);

    return personExistsInGroup;
}


- (NSArray *) addressBookGroupsArray
{
    ABAddressBookRef addressBook = nil;
    @try
    {
        addressBook = ABAddressBookCreate();
    }
    @catch (NSException *exception)
    {
        PTTAppDelegate *appDelegate = (PTTAppDelegate *)[UIApplication sharedApplication].delegate;

        [appDelegate displayNotification:@"Not able to access Address Book" forDuration:3.0 location:kPTTScreenLocationTop inView:appDelegate.window];
        return nil;
    }

    @finally
    {
        BOOL autoAddClinicianToGroup = [[NSUserDefaults standardUserDefaults]boolForKey:kPTAutoAddClinicianToGroup];
        ABRecordRef group = nil;

        int groupIdentifier = -1;
        if ([[NSUserDefaults standardUserDefaults] objectForKey:kPTTAddressBookGroupName])
        {
            groupIdentifier = (NSInteger)[[NSUserDefaults standardUserDefaults] integerForKey : kPTTAddressBookGroupIdentifier];
        }

        if (groupIdentifier > 0)
        {
            group = ABAddressBookGetGroupWithRecordID( (ABAddressBookRef)addressBook, groupIdentifier );
        }

        CFStringRef CFGroupName;

        if ([[NSUserDefaults standardUserDefaults] objectForKey:kPTTAddressBookGroupName])
        {
            CFGroupName = (__bridge CFStringRef)[[NSUserDefaults standardUserDefaults] valueForKey:kPTTAddressBookGroupName];
        }
        else
        {
            @try
            {
                NSString *userDefaultName = [PTTAppDelegate retrieveFromUserDefaults:@"abgroup_name"];

                CFGroupName = (__bridge_retained CFStringRef)userDefaultName;
            }
            @catch (NSException *exception)
            {
                PTTAppDelegate *appDelegate = (PTTAppDelegate *)[UIApplication sharedApplication].delegate;

                [appDelegate displayNotification:@"Unable to access addressbook settings" forDuration:3.0 location:kPTTScreenLocationTop inView:appDelegate.window];
            }

            @finally
            {
            }
        }

        if ( ( !CFGroupName || !CFStringGetLength(CFGroupName) ) && autoAddClinicianToGroup )
        {
            NSString *clinicians = @"Clinicians";
            CFGroupName = (__bridge CFStringRef)clinicians;
            [[NSUserDefaults standardUserDefaults] setValue:(__bridge NSString *)CFGroupName forKeyPath:kPTTAddressBookGroupName];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }

        //check to see if the group name exists already

        ABRecordRef source = nil;

        int sourceID = [self defaultABSourceID];

        source = ABAddressBookGetSourceWithRecordID(addressBook, sourceID);

        CFArrayRef allGroupsInSource = ABAddressBookCopyArrayOfAllGroupsInSource(addressBook, source);
        int groupCount = CFArrayGetCount(allGroupsInSource);

        CFStringRef CFGroupNameCheck;
        ABRecordRef groupInCheckNameArray;
        if (groupCount && !group )
        {
            for (CFIndex i = 0; i < groupCount; i++)
            {
                groupInCheckNameArray = CFArrayGetValueAtIndex(allGroupsInSource, i);
                CFGroupNameCheck = ABRecordCopyValue(groupInCheckNameArray, kABGroupNameProperty);

                CFComparisonResult result = (CFComparisonResult)CFStringCompare(
                    (CFStringRef)CFGroupName,
                    (CFStringRef)CFGroupNameCheck,
                    1
                    );

                if (result == 0)
                {
                    group = groupInCheckNameArray;
                    break;
                }
            }
        }

        NSMutableArray *allGroups;

        if (!group)
        {
            [self changeABGroupNameTo:(__bridge NSString *)CFGroupName addNew:YES checkExisting:YES];

            groupIdentifier = (NSInteger)[(NSNumber *)[[NSUserDefaults standardUserDefaults]valueForKey:kPTTAddressBookGroupIdentifier] intValue];
            group = ABAddressBookGetGroupWithRecordID( (ABAddressBookRef)addressBook, groupIdentifier );
        }

        if (group != NULL)
        {
            CFRelease(group);
        }

        // Get the ABSource object that contains this new group

        NSNumber *groupIdentifierNumber = (NSNumber *)[[NSUserDefaults standardUserDefaults] valueForKey:kPTTAddressBookGroupIdentifier];

        if ([groupIdentifierNumber isEqualToNumber:[NSNumber numberWithInt:(int)-1]] || [groupIdentifierNumber isEqualToNumber:[NSNumber numberWithInt:(int)0]] || !groupCount)
        {
            [ self changeABGroupNameTo:nil addNew:NO checkExisting:YES];
        }

        allGroupsInSource = ABAddressBookCopyArrayOfAllGroupsInSource(addressBook, source);
        groupCount = CFArrayGetCount(allGroupsInSource);

        if (groupCount)
        {
            allGroupsInSource = ABAddressBookCopyArrayOfAllGroupsInSource(addressBook, source);

            if (allGroupsInSource)
            {
                allGroups = [[NSMutableArray alloc] init];

                //            CFStringRef CFGroupName ;
                for (CFIndex i = 0; i < groupCount; i++)
                {
                    ABRecordRef groupInCFArray = CFArrayGetValueAtIndex(allGroupsInSource, i);
                    CFGroupName = ABRecordCopyValue(groupInCFArray, kABGroupNameProperty);
                    int CFGroupID = ABRecordGetRecordID( (ABRecordRef)groupInCFArray );

                    PTABGroup *ptGroup = [[PTABGroup alloc]initWithName:(__bridge_transfer NSString *)CFGroupName recordID:CFGroupID];

                    [allGroups addObject:ptGroup];

                    CFRelease(groupInCFArray);
                }

                CFRelease(allGroupsInSource);

                abGroupsArray = allGroups;
            }
        }

        return allGroups;
    }
}


- (void) changeABGroupNameTo:(NSString *)groupName addNew:(BOOL)addNew checkExisting:(BOOL)checkExisting
{
    ABAddressBookRef addressBook = nil;
    @try
    {
        addressBook = ABAddressBookCreate();
    }
    @catch (NSException *exception)
    {
        PTTAppDelegate *appDelegate = (PTTAppDelegate *)[UIApplication sharedApplication].delegate;

        [appDelegate displayNotification:@"Not able to access address book" forDuration:3.0 location:kPTTScreenLocationTop inView:appDelegate.window];
        return;
    }

    @finally
    {
        ABRecordRef source = nil;
        int sourceID = [self defaultABSourceID];
        source = ABAddressBookGetSourceWithRecordID(addressBook, sourceID);
        ABRecordRef group;
        int groupIdentifier;

        CFArrayRef allGroupsInSource = ABAddressBookCopyArrayOfAllGroupsInSource(addressBook, source);
        int groupCount = CFArrayGetCount(allGroupsInSource);

        BOOL autoAddClinicianToGroup = [[NSUserDefaults standardUserDefaults]boolForKey:kPTAutoAddClinicianToGroup];
        if ( (!groupName || !groupName.length || checkExisting) && autoAddClinicianToGroup )
        {
            if ([[NSUserDefaults standardUserDefaults] objectForKey:kPTTAddressBookGroupName])
            {
                if (!checkExisting)
                {
                    groupName = (NSString *)[[NSUserDefaults standardUserDefaults] valueForKey:kPTTAddressBookGroupName];
                }

                //        }
                if (!groupName || !groupName.length)
                {
                    groupName = @"Clinicians";
                    if ([[NSUserDefaults standardUserDefaults]objectForKey:kPTTAddressBookGroupName])
                    {
                        [[NSUserDefaults standardUserDefaults] setValue:groupName forKeyPath:kPTTAddressBookGroupName];
                        [[NSUserDefaults standardUserDefaults] synchronize];
                    }
                }
            }

            if (!addNew)
            {
                if ([[NSUserDefaults standardUserDefaults]objectForKey:kPTTAddressBookGroupIdentifier])
                {
                    groupIdentifier = (NSInteger)[[NSUserDefaults standardUserDefaults] integerForKey : kPTTAddressBookGroupIdentifier];
                }

                if (!addNew && groupIdentifier > -1)
                {
                    group = ABAddressBookGetGroupWithRecordID( (ABAddressBookRef)addressBook, groupIdentifier );
                }

                //should not ad new
                CFStringRef CFGroupNameCheck = nil;
                ABRecordRef groupInCheckNameArray = nil;
                if (groupCount)
                {
                    for (CFIndex i = 0; i < groupCount; i++)
                    {
                        groupInCheckNameArray = CFArrayGetValueAtIndex(allGroupsInSource, i);
                        CFGroupNameCheck = ABRecordCopyValue(groupInCheckNameArray, kABGroupNameProperty);

                        NSString *checkNameStr = [NSString stringWithFormat:@"%@",(__bridge NSString *)CFGroupNameCheck];

                        if ([checkNameStr isEqualToString:groupName])
                        {
                            group = groupInCheckNameArray;
                            groupIdentifier = ABRecordGetRecordID(group);

                            if ([[NSUserDefaults standardUserDefaults] objectForKey:kPTTAddressBookGroupIdentifier])
                            {
                                [[NSUserDefaults standardUserDefaults] setInteger:groupIdentifier forKey:kPTTAddressBookGroupIdentifier];
                                [[NSUserDefaults standardUserDefaults]synchronize];
                            }

                            if (group)
                            {
                            }
                            else
                            {
                            }

                            break;
                        }
                    }

                    if (allGroupsInSource)
                    {
                        CFRelease(allGroupsInSource);
                    }

                    if (CFGroupNameCheck)
                    {
                        CFRelease(CFGroupNameCheck);
                    }
                }
            }
        }

        NSNumber *groupIdentifierNumber = (NSNumber *)[[NSUserDefaults standardUserDefaults] valueForKey:kPTTAddressBookGroupIdentifier];

        if (!addNew && !group && groupIdentifier > 0 && groupCount > 0 && ![groupIdentifierNumber isEqualToNumber:[NSNumber numberWithInt:(int)-1]] && ![groupIdentifierNumber isEqualToNumber:[NSNumber numberWithInt:(int)0]])
        {
            group = ABAddressBookGetGroupWithRecordID( (ABAddressBookRef)addressBook, groupIdentifier );
        }

        if ( (!group || addNew) && autoAddClinicianToGroup )
        {
            if (!addressBook)
            {
                return;
            }

            group = ABGroupCreateInSource(source);

            bool didSetGroupName = FALSE;
            didSetGroupName = (bool)ABRecordSetValue(
                group,
                (ABPropertyID)kABGroupNameProperty,
                (__bridge CFStringRef)groupName,
                nil
                );

            ABAddressBookAddRecord( (ABAddressBookRef)addressBook, (ABRecordRef)group, nil );

            BOOL wantToSaveChanges = TRUE;
            if ( ABAddressBookHasUnsavedChanges(addressBook) )
            {
                if (wantToSaveChanges)
                {
                    bool didSave = FALSE;
                    didSave = ABAddressBookSave(addressBook, nil);
                }
                else
                {
                    ABAddressBookRevert(addressBook);
                }
            }

            groupIdentifier = ABRecordGetRecordID(group);

            [[NSUserDefaults standardUserDefaults] setInteger:(int)groupIdentifier forKey:kPTTAddressBookGroupIdentifier];

            [[NSUserDefaults standardUserDefaults] setValue:groupName forKey:kPTTAddressBookGroupName];

            [[NSUserDefaults standardUserDefaults]synchronize];
        }
        else
        {
            BOOL wantToSaveChanges = TRUE;

            if (group)
            {
                groupIdentifier = ABRecordGetRecordID(group);
            }

            if (groupIdentifier > -1)
            {
                [[NSUserDefaults standardUserDefaults] setInteger:(int)groupIdentifier forKey:kPTTAddressBookGroupIdentifier];

                [[NSUserDefaults standardUserDefaults]synchronize];
            }

            if ( ABAddressBookHasUnsavedChanges(addressBook) )
            {
                if (wantToSaveChanges)
                {
                    bool didSave = FALSE;
                    didSave = ABAddressBookSave(addressBook, nil);

                    if (!didSave)
                    {              /* Handle error here. */
                    }
                }
                else
                {
                    ABAddressBookRevert(addressBook);
                }
            }
        }

        if (addressBook)
        {
            CFRelease(addressBook);
        }
    }
}


- (int) defaultABSourceID
{
    BOOL iCloudEnabled = (BOOL)[[NSUserDefaults standardUserDefaults] valueForKey : @"icloud_preference"];

    int returnID = -1;
    int sourceID = -1;
    BOOL continueChecking = YES;

    ABAddressBookRef addressBook;
    addressBook = nil;

    addressBook = ABAddressBookCreate();

    CFArrayRef allSourcesArray = ABAddressBookCopyArrayOfAllSources(addressBook);
    ABRecordRef source = nil;
    int sourcesCount = 0;

    if (allSourcesArray )
    {
        sourcesCount = CFArrayGetCount(allSourcesArray);
    }

    if (sourcesCount == 0)
    {
        continueChecking = NO;
        returnID = -1;
    }

    if (continueChecking && allSourcesArray && sourcesCount == 1)
    {
        source = CFArrayGetValueAtIndex(allSourcesArray, 0);
        ABRecordID sourceID = ABRecordGetRecordID(source);

        continueChecking = NO;
        returnID = sourceID;
    }

    int recordID = (int)[(NSNumber *)[[NSUserDefaults standardUserDefaults] valueForKey:kPTTAddressBookSourceIdentifier]
                         intValue];

    if (continueChecking && recordID != -1)
    {
        source = ABAddressBookGetSourceWithRecordID(addressBook, recordID);

        if (source)
        {
            returnID = recordID;
        }

        //        }
    }
    else if (continueChecking && allSourcesArray && CFArrayGetCount(allSourcesArray) > 1 && iCloudEnabled)
    {
        for (int i = 0; i < sourcesCount; i++)
        {
            // Fetch the source type

            source = CFArrayGetValueAtIndex(allSourcesArray, i);
            CFNumberRef sourceType = ABRecordCopyValue(source, kABSourceTypeProperty);

            NSNumber *sourceTypeNumber = (__bridge_transfer NSNumber *)sourceType;

            if ([sourceTypeNumber isEqualToNumber:[NSNumber numberWithInt:kABSourceTypeCardDAV]])
            {
                sourceID = ABRecordGetRecordID(source);

                //

                returnID = sourceID;

                break;
            }
        }
    }
    else if (continueChecking && sourcesCount > 1)
    {
        source = CFArrayGetValueAtIndex(allSourcesArray, 0);
        sourceID = ABRecordGetRecordID(source);
        returnID = sourceID;
    }

    if (addressBook)
    {
        CFRelease(addressBook);
    }

    if (allSourcesArray)
    {
        CFRelease(allSourcesArray);
    }

    return returnID;
}


// Return the name associated with the given identifier
- (NSString *) nameForSourceWithIdentifier:(int)identifier
{
    switch (identifier)
    {
        case kABSourceTypeLocal:
            return @"On My Device";
            break;
        case kABSourceTypeExchange:
            return @"Exchange server";
            break;
        case kABSourceTypeExchangeGAL:
            return @"Exchange Global Address List";
            break;
        case kABSourceTypeMobileMe:
            return @"Moblile Me";
            break;
        case kABSourceTypeLDAP:
            return @"LDAP server";
            break;
        case kABSourceTypeCardDAV:
            return @"CardDAV server";
            break;
        case kABSourceTypeCardDAVSearch:
            return @"Searchable CardDAV server";
            break;
        default:
            break;
    } /* switch */

    return nil;
}


@end
