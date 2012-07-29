/*
 *  SCArrayOfObjectsModel+CoreData.h
 *  Sensible TableView
 *  Version: 3.0.6
 *
 *
 *	THIS SOURCE CODE AND ANY ACCOMPANYING DOCUMENTATION ARE PROTECTED BY UNITED STATES 
 *	INTELLECTUAL PROPERTY LAW AND INTERNATIONAL TREATIES. UNAUTHORIZED REPRODUCTION OR 
 *	DISTRIBUTION IS SUBJECT TO CIVIL AND CRIMINAL PENALTIES. YOU SHALL NOT DEVELOP NOR
 *	MAKE AVAILABLE ANY WORK THAT COMPETES WITH A SENSIBLE COCOA PRODUCT DERIVED FROM THIS 
 *	SOURCE CODE. THIS SOURCE CODE MAY NOT BE RESOLD OR REDISTRIBUTED ON A STAND ALONE BASIS.
 *
 *	USAGE OF THIS SOURCE CODE IS BOUND BY THE LICENSE AGREEMENT PROVIDED WITH THE 
 *	DOWNLOADED PRODUCT.
 *
 *  Copyright 2012 Sensible Cocoa. All rights reserved.
 *
 *
 *	This notice may not be removed from this file.
 *
 */



#import <SensibleTableView/SCTableViewModel.h>

#import "SCEntityDefinition.h"


@interface SCArrayOfObjectsModel (CoreData)

/** 
 Allocates and returns an initialized 'SCArrayOfObjectsModel' given a UITableView 
 and an entity definition. Note: This method creates a model with all the objects that
 exist in the definition's managedObjectContext. 
 *
 *	@param modeledTableView The UITableView to be bound to the model. 
 *	@param definition The entity definition of the objects.
 */
+ (id)tableViewModelWithTableView:(UITableView *)modeledTableView entityDefinition:(SCEntityDefinition *)definition;

/** 
 Allocates and returns an initialized 'SCArrayOfObjectsModel' given a UITableView 
 and an entity definition. Note: This method creates a model with all the objects that
 exist in the definition's managedObjectContext. 
 *
 *	@param modeledTableView The UITableView to be bound to the model. 
 *	@param definition The entity definition of the objects.
 *	@param perdicate The predicate that will be used to filter the fetched objects.
 */
+ (id)tableViewModelWithTableView:(UITableView *)modeledTableView entityDefinition:(SCEntityDefinition *)definition filterPredicate:(NSPredicate *)predicate;


/** 
 Returns an initialized 'SCArrayOfObjectsModel' given a UITableView 
 and an entity definition. Note: This method creates a model with all the objects that
 exist in the definition's managedObjectContext. 
 *
 *	@param modeledTableView The UITableView to be bound to the model. 
 *	@param definition The entity definition of the objects.
 */
- (id)initWithTableView:(UITableView *)modeledTableView entityDefinition:(SCEntityDefinition *)definition;



/** 
 Returns an initialized 'SCArrayOfObjectsModel' given a UITableView 
 and an entity definition. Note: This method creates a model with all the objects that
 exist in the definition's managedObjectContext. 
 *
 *	@param modeledTableView The UITableView to be bound to the model. 
 *	@param definition The entity definition of the objects.
 *	@param perdicate The predicate that will be used to filter the fetched objects.
 */
- (id)initWithTableView:(UITableView *)modeledTableView entityDefinition:(SCEntityDefinition *)definition filterPredicate:(NSPredicate *)predicate;

@end
