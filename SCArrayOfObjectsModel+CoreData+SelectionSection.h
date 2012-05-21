//
//  SCArrayOfObjectsModel+CoreData+SelectionSection.h
//  PsyTrack
//
//  Created by Daniel Boice on 5/21/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//


#import <SensibleTableView/SCTableViewModel.h>

#import <STV+CoreData/SCEntityDefinition.h> 


@interface SCArrayOfObjectsModel_UseSelectionSection: SCArrayOfObjectsModel {


    BOOL useSelectionSection_;


}

/** 
 Allocates and returns an initialized 'SCArrayOfObjectsModel' given a UITableView 
 and an entity definition. Note: This method creates a model with all the objects that
 exist in the definition's managedObjectContext. 
 *
 *	@param modeledTableView The UITableView to be bound to the model. 
 *	@param definition The entity definition of the objects.
 */
+ (id)tableViewModelWithTableView:(UITableView *)modeledTableView entityDefinition:(SCEntityDefinition *)definition useSelectionSection:(BOOL)useSelectionSection;

/** 
 Allocates and returns an initialized 'SCArrayOfObjectsModel' given a UITableView 
 and an entity definition. Note: This method creates a model with all the objects that
 exist in the definition's managedObjectContext. 
 *
 *	@param modeledTableView The UITableView to be bound to the model. 
 *	@param definition The entity definition of the objects.
 *	@param perdicate The predicate that will be used to filter the fetched objects.
 */
+ (id)tableViewModelWithTableView:(UITableView *)modeledTableView entityDefinition:(SCEntityDefinition *)definition filterPredicate:(NSPredicate *)predicate  useSelectionSection:(BOOL)useSelectionSection;


/** 
 Returns an initialized 'SCArrayOfObjectsModel' given a UITableView 
 and an entity definition. Note: This method creates a model with all the objects that
 exist in the definition's managedObjectContext. 
 *
 *	@param modeledTableView The UITableView to be bound to the model. 
 *	@param definition The entity definition of the objects.
 */
- (id)initWithTableView:(UITableView *)modeledTableView entityDefinition:(SCEntityDefinition *)definition  useSelectionSection:(BOOL)useSelectionSection;



/** 
 Returns an initialized 'SCArrayOfObjectsModel' given a UITableView 
 and an entity definition. Note: This method creates a model with all the objects that
 exist in the definition's managedObjectContext. 
 *
 *	@param modeledTableView The UITableView to be bound to the model. 
 *	@param definition The entity definition of the objects.
 *	@param perdicate The predicate that will be used to filter the fetched objects.
 */
- (id)initWithTableView:(UITableView *)modeledTableView entityDefinition:(SCEntityDefinition *)definition filterPredicate:(NSPredicate *)predicate  useSelectionSection:(BOOL)useSelectionSection;
@end
