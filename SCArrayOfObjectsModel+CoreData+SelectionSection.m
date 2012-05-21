/*
 *  SCArrayOfObjectsModel+CoreData+SelectionSection.m
 *  psyTrack Clinician Tools
 *  Version: 1.0
 *
 *
 *	THIS SOURCE CODE AND ANY ACCOMPANYING DOCUMENTATION ARE PROTECTED BY UNITED STATES 
 *	INTELLECTUAL PROPERTY LAW AND INTERNATIONAL TREATIES. UNAUTHORIZED REPRODUCTION OR 
 *	DISTRIBUTION IS SUBJECT TO CIVIL AND CRIMINAL PENALTIES. 
 *
 *  Created by Daniel Boice on 6/19/11.
 *  Copyright (c) 2011 PsycheWeb LLC. All rights reserved.
 *
 *
 *	This notice may not be removed from this file.
 *
 */


#import "SCArrayOfObjectsModel+CoreData+SelectionSection.h"
#import <STV+CoreData/SCCoreDataStore.h> 



@implementation SCArrayOfObjectsModel_UseSelectionSection






+ (id)tableViewModelWithTableView:(UITableView *)tableView entityDefinition:(SCEntityDefinition *)definition useSelectionSection:(BOOL)useSelectionSection
{
    return [[[self class] alloc] initWithTableView:tableView entityDefinition:definition useSelectionSection:(BOOL)useSelectionSection];
}

+ (id)tableViewModelWithTableView:(UITableView *)tableView entityDefinition:(SCEntityDefinition *)definition filterPredicate:(NSPredicate *)predicate useSelectionSection:(BOOL)useSelectionSection
{
    return [[[self class] alloc] initWithTableView:tableView entityDefinition:definition filterPredicate:predicate  useSelectionSection:(BOOL)useSelectionSection];
}


- (id)initWithTableView:(UITableView *)tableView entityDefinition:(SCEntityDefinition *)definition useSelectionSection:(BOOL)useSelectionSection
{
    return [self initWithTableView:tableView entityDefinition:definition filterPredicate:nil  useSelectionSection:(BOOL)useSelectionSection];
}

- (id)initWithTableView:(UITableView *)tableView entityDefinition:(SCEntityDefinition *)definition filterPredicate:(NSPredicate *)predicate useSelectionSection:(BOOL)useSelectionSection
{
    SCCoreDataStore *store = [SCCoreDataStore storeWithManagedObjectContext:definition.managedObjectContext defaultEntityDefinition:definition];
    
    self = [self initWithTableView:tableView dataStore:store];
    if(self)
    {
        self.dataFetchOptions = [SCCoreDataFetchOptions options];
        if(predicate)
        {
            self.dataFetchOptions.filter = TRUE;
            self.dataFetchOptions.filterPredicate = predicate;
            useSelectionSection_=useSelectionSection;
        }
    }
    
    return self;
}

// override superclass method
- (SCArrayOfItemsSection *)createSectionWithHeaderTitle:(NSString *)title
{
    if (self.tag==0 && useSelectionSection_){
        SCObjectSelectionSection *section = [SCObjectSelectionSection sectionWithHeaderTitle:title dataStore:self.dataStore];
        section.autoFetchItems = FALSE;
        [section setMutableItems:[NSMutableArray array]];
        return section;
    }else
    {
        SCArrayOfObjectsSection *section = [SCArrayOfObjectsSection sectionWithHeaderTitle:title dataStore:self.dataStore];
        section.autoFetchItems = FALSE;
        [section setMutableItems:[NSMutableArray array]];

        return section;
    }

}



@end
