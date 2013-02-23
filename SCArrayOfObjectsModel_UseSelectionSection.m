/*
 *  SCArrayOfObjectsModel+CoreData+SelectionSection.m
 *  psyTrack Clinician Tools
 *  Version: 1.05
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


#import "SCArrayOfObjectsModel_UseSelectionSection.h"
#import <STV+CoreData/SCCoreDataStore.h> 



@implementation SCArrayOfObjectsModel_UseSelectionSection





// override superclass method
- (SCArrayOfItemsSection *)createSectionWithHeaderTitle:(NSString *)title
{
    if (self.tag==0) {
    
        SCObjectSelectionSection *section = [SCObjectSelectionSection sectionWithHeaderTitle:title dataStore:self.dataStore];
        section.autoFetchItems = FALSE;
        [section setMutableItems:[NSMutableArray array]];
        return section;
        
    }
    else {
        SCArrayOfObjectsSection *section = [SCArrayOfObjectsSection sectionWithHeaderTitle:title dataStore:self.dataStore];
        section.autoFetchItems = FALSE;
        [section setMutableItems:[NSMutableArray array]];
        return section;

    }
    
}



@end
