/*
 *  SCArrayOfObjectsCell+CoreData.h
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

#import <SensibleTableView/SCTableViewCell.h> 

#import "SCEntityDefinition.h"

@interface SCArrayOfObjectsCell (CoreData)

//////////////////////////////////////////////////////////////////////////////////////////
/// @name Creation and Initialization
//////////////////////////////////////////////////////////////////////////////////////////

/** 
 Allocates and returns an initialized 'SCArrayOfObjectsCell' given a header title and an entity definition. Note: This method creates a cell with all the objects that exist in classDefinition's entity's managedObjectContext. To create a cell with only a subset of these objects, consider using the other cell initializers.
 *
 *	@param definition The entity definition of the objects in the objects set.
 */
+ (id)cellWithEntityDefinition:(SCEntityDefinition *)definition;

/** Allocates and returns an initialized 'SCArrayOfObjectsCell' given a mutable set of objects. This method should only be used to create a cell with the contents of a Core Data relationship.
 *
 *	@param cellItemsSet A mutable set of objects that the cell will use to generate its cells.
 *	@param definition The class definition of the entity of the objects in the objects set.
 */
+ (id)cellWithBoundItemsSet:(NSMutableSet *)cellItemsSet boundSetEntityDefinition:(SCEntityDefinition *)definition boundSetOwnsObjects:(BOOL)ownsObjects;


/** 
 Returns an initialized 'SCArrayOfObjectsCell' given a header title and an entity definition. Note: This method creates a cell with all the objects that exist in classDefinition's entity's managedObjectContext. To create a cell with only a subset of these objects, consider using the other cell initializers.
 *
 *	@param definition The entity definition of the objects in the objects set.
 */
- (id)initWithEntityDefinition:(SCEntityDefinition *)definition;

/** Returns an initialized 'SCArrayOfObjectsCell' given a mutable set of objects. This method should only be used to create a cell with the contents of a Core Data relationship.
 *
 *	@param cellItemsSet A mutable set of objects that the cell will use to generate its cells.
 *	@param classDefinition The class definition of the entity of the objects in the objects set.
 */
- (id)initWithBoundItemsSet:(NSMutableSet *)cellItemsSet boundSetEntityDefinition:(SCEntityDefinition *)definition boundSetOwnsObjects:(BOOL)ownsObjects;

@end


