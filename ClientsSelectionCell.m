/*
 *  ClientsSelectionCell.m
 *  psyTrack Clinician Tools
 *  Version: 1.5.5
 *
 *
 *	THIS SOURCE CODE AND ANY ACCOMPANYING DOCUMENTATION ARE PROTECTED BY UNITED STATES
 *	INTELLECTUAL PROPERTY LAW AND INTERNATIONAL TREATIES. UNAUTHORIZED REPRODUCTION OR
 *	DISTRIBUTION IS SUBJECT TO CIVIL AND CRIMINAL PENALTIES.
 *
 *  Created by Daniel Boice on 11/18/11.
 *  Copyright (c) 2011 PsycheWeb LLC. All rights reserved.
 *
 *
 *	This notice may not be removed from this file.
 *
 */
#import "ClientsSelectionCell.h"
#import "ClientsViewController_Shared.h"
#import "ClientsViewController_iPhone.h"
#import "ClientsRootViewController_iPad.h"
#import "PTTAppDelegate.h"
#import "ClientPresentations_Shared.h"

@implementation ClientsSelectionCell
@synthesize alreadySelectedClients;
@synthesize hasChangedClients;
@synthesize clientObject = clientObject;
@synthesize testDate;
@synthesize addAgeCells = addAgeCells_;
@synthesize clientsArray = clientsArray_;

- (void) performInitialization
{
    [super performInitialization];
}


- (void) willDisplay
{
    NSString *textLabelStr = [self.objectBindings valueForKey:@"90"];

    self.textLabel.text = textLabelStr;
    if (!multiSelect && clientObject)
    {
        self.label.text = (NSString *)self.clientObject.clientIDCode;
    }
    else if (multiSelect)
    {
        int i = 0;
        NSString *labelStr = [NSString string];
        for (ClientEntity *client in self.clientsArray)
        {
            if (i == 0)
            {
                labelStr = client.clientIDCode;
            }
            else
            {
                labelStr = [labelStr stringByAppendingFormat:@", %@",client.clientIDCode];
            }

            i++;
        }

        self.label.text = labelStr;
    }

    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}


- (void) didSelectCell
{
    ClientsViewController_Shared *clientsViewController_Shared = [[ClientsViewController_Shared alloc]init];

    [clientsViewController_Shared setupTheClientsViewModelUsingSTV];

    NSString *clientViewControllerNibName;

    if ([SCUtilities is_iPad])
    {
        clientViewControllerNibName = @"ClientsViewController_iPad";
    }
    else
    {
        clientViewControllerNibName = @"ClientsViewController_iPhone";
    }

    ClientsViewController_iPhone *clientsViewContoller = [[ClientsViewController_iPhone alloc]initWithNibName:clientViewControllerNibName bundle:nil isInDetailSubView:YES objectSelectionCell:self sendingViewController:self.ownerTableViewModel.viewController allowMultipleSelection:multiSelect];

    [self.ownerTableViewModel.viewController.navigationController pushViewController:clientsViewContoller animated:YES];
    if ([clientsViewContoller.tableViewModel sectionCount] > 0)
    {
        SCTableViewSection *section = (SCTableViewSection *)[clientsViewContoller.tableViewModel sectionAtIndex:0];
        if ([section isKindOfClass:[SCObjectSelectionSection class]])
        {
            SCObjectSelectionSection *objectSelectionSection = (SCObjectSelectionSection *)section;

            if (multiSelect)
            {
                NSMutableSet *selectedIndexesSet = objectSelectionSection.selectedItemsIndexes;
                objectSelectionSection.allowMultipleSelection = YES;
                for (int p = 0; p < self.clientsArray.count; p++)
                {
                    int clientInSectionIndex;
                    ClientEntity *clientInArray = [self.clientsArray objectAtIndex:p];
                    if ([objectSelectionSection.items containsObject:clientInArray])
                    {
                        clientInSectionIndex = (int)[objectSelectionSection.items indexOfObject:clientInArray];
                        if (![objectSelectionSection.selectedItemsIndexes containsObject:[NSNumber numberWithInt:clientInSectionIndex]])
                        {
                            [selectedIndexesSet addObject:[NSNumber numberWithInt:clientInSectionIndex]];
                        }
                    }
                }
            }
            else if (clientObject)
            {
                objectSelectionSection.allowMultipleSelection = NO;

                [objectSelectionSection setSelectedItemIndex:(NSNumber *)[NSNumber numberWithInteger:[objectSelectionSection.items indexOfObject:clientObject]]];
            }
            else
            {
                objectSelectionSection.allowMultipleSelection = NO;
            }
        }
    }
}


- (void) loadBindingsIntoCustomControls
{
    [super loadBindingsIntoCustomControls];

    self.label.text = nil;
    self.detailTextLabel.text = nil;

    multiSelect = (BOOL)[(NSNumber *)[self.objectBindings valueForKey:@"93"] boolValue];

    self.allowMultipleSelection = multiSelect;

    if (!hasChangedClients)
    {
        NSString *clientKeyStr = [self.objectBindings valueForKey:@"92"];
        if (!multiSelect)
        {
            self.clientObject = (ClientEntity *)[self.boundObject valueForKey:clientKeyStr];

            if (clientObject)
            {
                self.label.text = (NSString *)clientObject.clientIDCode;
            }
            else
            {
                self.label.text = [NSString string];
            }
        }
        else
        {
            NSMutableSet *clientsMutableSet = (NSMutableSet *)[self.boundObject mutableSetValueForKey:clientKeyStr];
            self.clientsArray = [NSMutableArray arrayWithArray:[clientsMutableSet allObjects]];

            NSString *labelStr = [NSString string];
            for (int i = 0; i < self.clientsArray.count; i++)
            {
                id objectInArray = [self.clientsArray objectAtIndex:i];
                if ([objectInArray isKindOfClass:[ClientEntity class]])
                {
                    ClientEntity *clientInArray = (ClientEntity *)objectInArray;
                    [clientInArray willAccessValueForKey:@"clientIDCode"];
                    if (i == 0)
                    {
                        labelStr = clientInArray.clientIDCode;
                    }
                    else
                    {
                        labelStr = [labelStr stringByAppendingFormat:@", %@",clientInArray.clientIDCode];
                    }
                }
            }

            self.label.text = labelStr;
        }
    }

//    }
}


- (void) doneButtonTappedInDetailView:(NSObject *)selectedObject selectedClients:(NSArray *)selectedClients withValue:(BOOL)hasValue
{
    needsCommit = TRUE;
    needsCommit = TRUE;

    self.clientObject = nil;
    if (self.clientsArray.count)
    {
        [self.clientsArray removeAllObjects];
    }

    self.clientsArray = nil;

    self.clientObject = (ClientEntity *)selectedObject;
    self.clientsArray = [NSMutableArray arrayWithArray:selectedClients];

    clientObject = (ClientEntity *)selectedObject;

    if (hasValue)
    {
        hasChangedClients = hasValue;

        if (multiSelect)
        {
            NSString *labelTextStr = [NSString string];
            if (self.clientsArray.count)
            {
                for (int i = 0; i < self.clientsArray.count; i++)
                {
                    id obj = [self.clientsArray objectAtIndex:i];
                    if ([obj isKindOfClass:[ClientEntity class]])
                    {
                        ClientEntity *clientObjectInItems = (ClientEntity *)obj;

                        if (i == 0)
                        {
                            labelTextStr = clientObjectInItems.clientIDCode;
                        }
                        else
                        {
                            labelTextStr = [labelTextStr stringByAppendingFormat:@", %@",clientObjectInItems.clientIDCode];
                        }
                    }
                }
            }

            self.label.text = labelTextStr;
        }
        else if (clientObject)
        {
            self.label.text = clientObject.clientIDCode;

            NSIndexPath *selfIndexPath = (NSIndexPath *)[self.ownerTableViewModel.modeledTableView indexPathForCell:self];
            [self.ownerTableViewModel valueChangedForRowAtIndexPath:selfIndexPath];
        }
        else
        {
            self.label.text = [NSString string];
            //         self.selectedItemIndex=[NSNumber numberWithInteger:-1];
        }

        if (addAgeCells_)
        {
            NSIndexPath *myIndexPath = (NSIndexPath *)[self.ownerTableViewModel indexPathForCell:self];

            SCTableViewSection *clientSelectionCellOwnerSection = (SCTableViewSection *)[self.ownerTableViewModel sectionAtIndex:(NSInteger)myIndexPath.section ];

            ClientPresentations_Shared *clientPresentationsShared = [[ClientPresentations_Shared alloc]init];

            clientPresentationsShared.serviceDatePickerDate = (NSDate *)testDate;

            [clientPresentationsShared addWechlerAgeCellToSection:clientSelectionCellOwnerSection];
        }

        //         }
//    }
    }
}


// overrides superclass
- (void) commitChanges
{
    if (!self.needsCommit)
    {
        return;
    }

    NSString *clientKeyStr = [self.objectBindings valueForKey:@"92"];

    if (multiSelect)
    {
        NSMutableSet *clientsMutableSet = [NSMutableSet set];

        int itemsCount = self.clientsArray.count;
        for (int i = 0; i < itemsCount; i++)
        {
            id obj = [self.clientsArray objectAtIndex:i];
            if ([obj isKindOfClass:[ClientEntity class]])
            {
                ClientEntity *clientObjectInItems = (ClientEntity *)obj;

                [clientsMutableSet addObject:clientObjectInItems];
            }
        }

        [self.boundObject setValue:clientsMutableSet forKey:clientKeyStr];
    }
    else
    {
        if (![clientObject isDeleted])
        {
            [self.boundObject setValue:clientObject forKey:clientKeyStr];
        }
        else
        {
            [self.boundObject setNilValueForKey:clientKeyStr];
            //        self.selectedItemIndex=[NSNumber numberWithInteger:-1];
        }

        [super commitChanges];
    }

    [self setAutoValidateValue:NO];

    self.hasChangedClients = FALSE;

    needsCommit = FALSE;
}


@end
