//
//  ClinicianSelectionCell.m
//  PsyTrack Clinician Tools
//  Version: 1.5.3
//
//  Created by Daniel Boice on 3/27/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import "ClinicianSelectionCell.h"
#import "ClinicianViewController.h"
#import "PTTAppDelegate.h"

@implementation ClinicianSelectionCell
@synthesize clinicianObject = clinicianObject_;
@synthesize hasChangedClinicians = hasChangedClinicians_;
@synthesize cliniciansArray = cliniciansArray_;

- (void) performInitialization
{
    [super performInitialization];

    self.textLabel.font = [UIFont boldSystemFontOfSize:18];
}


- (void) willDisplay
{
    NSString *textLabelStr = [self.objectBindings valueForKey:@"90"];

    self.textLabel.text = textLabelStr;

    if (!multiSelect && clinicianObject_)
    {
        self.label.text = (NSString *)self.clinicianObject.combinedName;
    }
    else if (multiSelect)
    {
        int i = 0;
        NSString *labelStr = [NSString string];
        for (ClinicianEntity *clinician in cliniciansArray_)
        {
            if (i == 0)
            {
                labelStr = clinician.combinedName;
            }
            else
            {
                labelStr = [labelStr stringByAppendingFormat:@", %@",clinician.combinedName];
            }

            i++;
        }

        self.label.text = labelStr;
    }

    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}


- (void) didSelectCell
{
    NSString *clinicianViewControllerNibName = @"ClinicianViewController";

    NSPredicate *predicate = nil;

    if ( usePrescriber )
    {
//
        if ( (BOOL)[clinicianObject_.isPrescriber boolValue] )
        {
            predicate = [NSPredicate predicateWithFormat:@"isPrescriber ==%@",[NSNumber numberWithBool:YES]];
        }
    }
    else if (clinicianObject_ && !usePrescriber)
    {
        BOOL startWithMySupervisorFilter = YES;

        if ([clinicianObject_.myCurrentSupervisor isEqualToNumber:[NSNumber numberWithBool:YES]] && [clinicianObject_.myPastSupervisor isEqualToNumber:[NSNumber numberWithBool:YES]] && [clinicianObject_.myInformation isEqualToNumber:[NSNumber numberWithBool:YES]])
        {
            startWithMySupervisorFilter = NO;
        }

        if (startWithMySupervisorFilter)
        {
            predicate = [NSPredicate predicateWithFormat:@"myCurrentSupervisor == %i OR myPastSupervisor==%i", TRUE, TRUE];
        }
    }
    else if (cliniciansArray_ && cliniciansArray_.count)
    {
        BOOL startWithSupervisorFilter = NO;
        //
        for (int i = 0; i < cliniciansArray_.count; i++)
        {
            ClinicianEntity *clinicianInArray = (ClinicianEntity *)[cliniciansArray_ objectAtIndex:i];
            if ( ([clinicianInArray.myCurrentSupervisor isEqualToNumber:(NSNumber *)[NSNumber numberWithBool:YES]] || [clinicianInArray.myPastSupervisor isEqualToNumber:(NSNumber *)[NSNumber numberWithBool:YES]]) )
            {
                startWithSupervisorFilter = YES;
            }
            else
            {
                startWithSupervisorFilter = NO;
                break;
            }
        }

        if (startWithSupervisorFilter)
        {
            predicate = [NSPredicate predicateWithFormat:@"myCurrentSupervisor == %i OR myPastSupervisor==%i", TRUE, TRUE];
        }
    }

    ClinicianViewController *clinicianViewController = nil;

    clinicianViewController = [[ClinicianViewController alloc]initWithNibName:clinicianViewControllerNibName bundle:nil isInDetailSubView:YES objectSelectionCell:self sendingViewController:self.ownerTableViewModel.viewController withPredicate:(NSPredicate *)predicate usePrescriber:(BOOL)usePrescriber allowMultipleSelection:(BOOL)multiSelect];
    if (cliniciansArray_.count)
    {
    }

    [self.ownerTableViewModel.viewController.navigationController pushViewController:clinicianViewController animated:YES];

    if ([clinicianViewController.tableViewModel sectionCount] > 0)
    {
        for (int i = 0; i < clinicianViewController.tableViewModel.sectionCount; i++)
        {
            SCTableViewSection *section = (SCTableViewSection *)[clinicianViewController.tableViewModel sectionAtIndex:i];
            if ([section isKindOfClass:[SCObjectSelectionSection class]])
            {
                SCObjectSelectionSection *objectSelectionSection = (SCObjectSelectionSection *)section;

                if (multiSelect)
                {
                    NSMutableSet *selectedIndexesSet = objectSelectionSection.selectedItemsIndexes;
                    objectSelectionSection.allowMultipleSelection = YES;
                    for (int p = 0; p < self.cliniciansArray.count; p++)
                    {
                        int clinicianInSectionIndex;
                        ClinicianEntity *clinicianInArray = [self.cliniciansArray objectAtIndex:p];
                        if ([objectSelectionSection.items containsObject:clinicianInArray])
                        {
                            clinicianInSectionIndex = (int)[objectSelectionSection.items indexOfObject:clinicianInArray];
                            if (![objectSelectionSection.selectedItemsIndexes containsObject:[NSNumber numberWithInt:clinicianInSectionIndex]])
                            {
                                [selectedIndexesSet addObject:[NSNumber numberWithInt:clinicianInSectionIndex]];
                            }
                        }
                    }
                }
                else if (clinicianObject_)
                {
                    objectSelectionSection.allowMultipleSelection = NO;

                    [objectSelectionSection setSelectedItemIndex:(NSNumber *)[NSNumber numberWithInteger:[objectSelectionSection.items indexOfObject:clinicianObject_]]];
                }
                else
                {
                    objectSelectionSection.allowMultipleSelection = NO;
                }
            }
        }
    }
}


- (void) loadBindingsIntoCustomControls
{
    [super loadBindingsIntoCustomControls];

    self.label.text = nil;
    self.detailTextLabel.text = nil;
    usePrescriber = (BOOL)[(NSNumber *)[self.objectBindings valueForKey:@"91"] boolValue];
    multiSelect = (BOOL)[(NSNumber *)[self.objectBindings valueForKey:@"93"] boolValue];

    self.allowMultipleSelection = multiSelect;

    if (!hasChangedClinicians_)
    {
        NSString *clinicianKeyStr = [self.objectBindings valueForKey:@"92"];
        if (!multiSelect)
        {
            self.clinicianObject = (ClinicianEntity *)[self.boundObject valueForKey:clinicianKeyStr];

            if (clinicianObject_)
            {
                NSNumber *selectedIndex = [NSNumber numberWithInt:[self.items indexOfObject:clinicianObject_]];

                self.selectedItemIndex = selectedIndex;
                self.label.text = (NSString *)clinicianObject_.combinedName;
            }
            else
            {
                self.label.text = [NSString string];
            }
        }
        else
        {
            NSString *clinicianKeyStr = [self.objectBindings valueForKey:@"92"];
            NSMutableSet *cliniciansMutableSet = (NSMutableSet *)[self.boundObject mutableSetValueForKey:clinicianKeyStr];
            self.cliniciansArray = [NSMutableArray arrayWithArray:[cliniciansMutableSet allObjects]];

            NSString *labelStr = [NSString string];
            for (int i = 0; i < cliniciansArray_.count; i++)
            {
                id objectInArray = [cliniciansArray_ objectAtIndex:i];
                if ([objectInArray isKindOfClass:[ClinicianEntity class]])
                {
                    ClinicianEntity *clinicianInArray = (ClinicianEntity *)objectInArray;
                    [clinicianInArray willAccessValueForKey:@"combinedName"];
                    if (i == 0)
                    {
                        labelStr = clinicianInArray.combinedName;
                    }
                    else
                    {
                        labelStr = [labelStr stringByAppendingFormat:@", %@",clinicianInArray.combinedName];
                    }

                    [self.selectedItemsIndexes addObject:[NSNumber numberWithInt:i]];
                }
            }

            self.label.text = labelStr;
        }
    }
}


- (void) doneButtonTappedInDetailView:(ClinicianEntity *)selectedObject selectedItems:(NSArray *)selectedItems withValue:(BOOL)hasValue
{
    needsCommit = TRUE;

    self.clinicianObject = nil;
    if (self.cliniciansArray.count)
    {
        [self.cliniciansArray removeAllObjects];
    }

    self.cliniciansArray = nil;

    self.clinicianObject = (ClinicianEntity *)selectedObject;
    self.cliniciansArray = [NSMutableArray arrayWithArray:selectedItems];

    if (hasValue)
    {
        self.hasChangedClinicians = hasValue;

        if (multiSelect)
        {
            NSString *labelTextStr = [NSString string];
            if (self.cliniciansArray.count)
            {
                for (int i = 0; i < self.cliniciansArray.count; i++)
                {
                    id obj = [self.cliniciansArray objectAtIndex:i];
                    if ([obj isKindOfClass:[ClinicianEntity class]])
                    {
                        ClinicianEntity *clinicianObjectInItems = (ClinicianEntity *)obj;

                        if (i == 0)
                        {
                            labelTextStr = clinicianObjectInItems.combinedName;
                        }
                        else
                        {
                            labelTextStr = [labelTextStr stringByAppendingFormat:@", %@",clinicianObjectInItems.combinedName];
                            [self.selectedItemsIndexes addObject:[NSNumber numberWithInt:i]];
                        }
                    }
                }
            }

            self.label.text = labelTextStr;
        }
        else if (self.clinicianObject)
        {
            self.label.text = clinicianObject_.combinedName;
            NSNumber *selectedIndex = [NSNumber numberWithInt:[self.items indexOfObject:clinicianObject_]];

            self.selectedItemIndex = selectedIndex;
            NSIndexPath *selfIndexPath = (NSIndexPath *)[self.ownerTableViewModel.modeledTableView indexPathForCell:self];
            [self.ownerTableViewModel valueChangedForRowAtIndexPath:selfIndexPath];
        }
        else
        {
            self.label.text = [NSString string];
        }
    }
}


// overrides superclass
- (void) commitChanges
{
    if (!self.needsCommit)
    {
        return;
    }

    NSString *clinicianKeyStr = [self.objectBindings valueForKey:@"92"];

    if (multiSelect)
    {
        NSMutableSet *cliniciansMutableSet = [NSMutableSet set];

        int itemsCount = self.cliniciansArray.count;
        for (int i = 0; i < itemsCount; i++)
        {
            id obj = [self.cliniciansArray objectAtIndex:i];
            if ([obj isKindOfClass:[ClinicianEntity class]])
            {
                ClinicianEntity *clinicianObjectInItems = (ClinicianEntity *)obj;

                [cliniciansMutableSet addObject:clinicianObjectInItems];
            }
        }

        [self.boundObject setValue:cliniciansMutableSet forKey:clinicianKeyStr];
    }
    else
    {
        if (clinicianObject_)
        {
            [self.boundObject setValue:clinicianObject_ forKey:clinicianKeyStr];
        }
        else
        {
            [self.boundObject setNilValueForKey:clinicianKeyStr];
            //        self.selectedItemIndex=[NSNumber numberWithInteger:-1];
        }

        [super commitChanges];
    }

    [self setAutoValidateValue:NO];

    self.hasChangedClinicians = FALSE;

    needsCommit = FALSE;
}


@end
