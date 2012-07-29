/*
 *  SCEntityDefinition.h
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

#import <UIKit/UIKit.h>


#import <SensibleTableView/SCDataDefinition.h> 


/****************************************************************************************/
/*	class SCEntityDefinition	*/
/****************************************************************************************/ 
/**	
 This class functions as a means to further extend the definition of user-defined Core Data entities.
 Using entity definitions, classes like SCObjectCell and SCObjectSection 
 will be able to better generate user interface elements that truly represent the 
 properties of their bound objects. 
 
 'SCEntityDefinition' mainly consists of one or more property definitions of type SCPropertyDefinition.
 Upon creation, 'SCEntityDefinition' will (optionally) automatically generate all the
 property definitions for the given entity. From there, the user will be able to customize
 the generated property definitions, add new definitions, or remove generated definitions.
 
 @see SCPropertyDefinition.
 */
@interface SCEntityDefinition : SCDataDefinition


//////////////////////////////////////////////////////////////////////////////////////////
/// @name Creation and Initialization
//////////////////////////////////////////////////////////////////////////////////////////

/** Allocates and returns an initialized 'SCEntityDefinition' given a Core Data entity name and the option to auto generate property definitions for the given entity's properties.
 
 The method will also generate user friendly property titles from the names of 
 the generated properties. These titles can be modified by the user later as part of
 the property definition customization.
 
 *	@param entityName The name of the entity for which the definition will be extended.
 *	@param context The managed object context of the entity.
 *	@param autoGenerate If TRUE, 'SCClassDefinition' will automatically generate all the property definitions for the given entity's attributes. 
 *	@warning Note: This method is used when creating an extended class definition for Core Data's managed object.
 */
+ (id)definitionWithEntityName:(NSString *)entityName managedObjectContext:(NSManagedObjectContext *)context autoGeneratePropertyDefinitions:(BOOL)autoGenerate;

/** Allocates and returns an initialized 'SCEntityDefinition' given a Core Data entity name and a string of the property names to generate property definitions for.
 
 The method will also generate user friendly property titles from the names of 
 the given properties. These titles can be modified by the user later as part of
 the property definition customization.
 
 *	@param entityName The name of the entity for which the definition will be extended.
 *	@param context The managed object context of the entity.
 *	@param propertyNamesString A string with the property names separated by semi-colons. Example string: @"firstName;lastName". Property groups can also be defined in the string using the following format: @"Personal Details:(firstName, lastName); Address:(street, state, country)". The group title can also be ommitted to create a group with no title. For example: @":(firstName, lastName)".
 *
 */
+ (id)definitionWithEntityName:(NSString *)entityName managedObjectContext:(NSManagedObjectContext *)context propertyNamesString:(NSString *)propertyNamesString;

/** Allocates and returns an initialized 'SCEntityDefinition' given a Core Data entity name and an array of the property names to generate property definitions for.
 
 The method will also generate user friendly property titles from the names of 
 the given properties. These titles can be modified by the user later as part of
 the property definition customization.
 
 *	@param entityName The name of the entity for which the definition will be extended.
 *	@param context The managed object context of the entity.
 *	@param propertyNames An array of the names of properties to be generated. All array elements must be of type NSString.
 *
 */
+ (id)definitionWithEntityName:(NSString *)entityName managedObjectContext:(NSManagedObjectContext *)context propertyNames:(NSArray *)propertyNames;

/** Allocates and returns an initialized 'SCEntityDefinition' given a Core Data entity name, an array of
 the property names to generate property definitions for, and array of titles
 for these properties.
 
 *	@param entityName The name of the entity for which the definition will be extended.
 *	@param context The managed object context of the entity.
 *	@param propertyNames An array of the names of properties to be generated. All array elements must be of type NSString.
 *	@param propertyTitles An array of titles to the properties in propertyNames. All array elements must be of type NSString.
 *
 */
+ (id)definitionWithEntityName:(NSString *)entityName managedObjectContext:(NSManagedObjectContext *)context propertyNames:(NSArray *)propertyNames propertyTitles:(NSArray *)propertyTitles;

/** Allocates and returns an initialized 'SCEntityDefinition' given a Core Data entity name and an SCPropertyGroupArray.
 * 
 *	@param entityName The name of the entity for which the definition will be extended.
 *	@param context The managed object context of the entity.
 *	@param groups A collection of property groups. 
 */
+ (id)definitionWithEntityName:(NSString *)entityName managedObjectContext:(NSManagedObjectContext *)context propertyGroups:(SCPropertyGroupArray *)groups;


/** Returns an initialized 'SCEntityDefinition' given a Core Data entity name and the option to auto generate property definitions for the given entity's properties.
 
 The method will also generate user friendly property titles from the names of 
 the generated properties. These titles can be modified by the user later as part of
 the property definition customization.
 
 *	@param entityName The name of the entity for which the definition will be extended.
 *	@param context The managed object context of the entity.
 *	@param autoGenerate If TRUE, 'SCClassDefinition' will automatically generate all the property definitions for the given entity's attributes. 
 *
 */
- (id)initWithEntityName:(NSString *)entityName managedObjectContext:(NSManagedObjectContext *)context  autoGeneratePropertyDefinitions:(BOOL)autoGenerate;

/** Returns an initialized 'SCEntityDefinition' given a Core Data entity name and a string of the property names to generate property definitions for.
 
 The method will also generate user friendly property titles from the names of 
 the given properties. These titles can be modified by the user later as part of
 the property definition customization.
 
 *	@param entityName The name of the entity for which the definition will be extended.
 *	@param context The managed object context of the entity.
 *	@param propertyNamesString A string with the property names separated by semi-colons. Example string: @"firstName;lastName". Property groups can also be defined in the string using the following format: @"Personal Details:(firstName, lastName); Address:(street, state, country)". The group title can also be ommitted to create a group with no title. For example: @":(firstName, lastName)".
 *
 */
- (id)initWithEntityName:(NSString *)entityName managedObjectContext:(NSManagedObjectContext *)context propertyNamesString:(NSString *)propertyNamesString;

/** Returns an initialized 'SCEntityDefinition' given a Core Data entity name and an array of the property names to generate property definitions for.
 
 The method will also generate user friendly property titles from the names of 
 the given properties. These titles can be modified by the user later as part of
 the property definition customization.
 
 *	@param entityName The name of the entity for which the definition will be extended.
 *	@param context The managed object context of the entity.
 *	@param propertyNames An array of the names of properties to be generated. All array elements must be of type NSString.
 *
 */
- (id)initWithEntityName:(NSString *)entityName managedObjectContext:(NSManagedObjectContext *)context propertyNames:(NSArray *)propertyNames;

/** Returns an initialized 'SCEntityDefinition' given a Core Data entity name, an array of
 the property names to generate property definitions for, and array of titles
 for these properties.
 
 *	@param entityName The name of the entity for which the definition will be extended.
 *	@param context The managed object context of the entity.
 *	@param propertyNames An array of the names of properties to be generated. All array elements must be of type NSString.
 *	@param propertyTitles An array of titles to the properties in propertyNames. All array elements must be of type NSString.
 *
 */
- (id)initWithEntityName:(NSString *)entityName managedObjectContext:(NSManagedObjectContext *)context propertyNames:(NSArray *)propertyNames propertyTitles:(NSArray *)propertyTitles;

/** Returns an initialized 'SCEntityDefinition' given a Core Data entity name and an SCPropertyGroupArray.
 * 
 *	@param entityName The name of the entity for which the definition will be extended.
 *	@param context The managed object context of the entity.
 *	@param groups A collection of property groups. 
 */
- (id)initWithEntityName:(NSString *)entityName managedObjectContext:(NSManagedObjectContext *)context propertyGroups:(SCPropertyGroupArray *)groups;

//////////////////////////////////////////////////////////////////////////////////////////
/// @name Configuration
//////////////////////////////////////////////////////////////////////////////////////////

/** The entity associated with the definition. */
@property (nonatomic, readonly, strong) NSEntityDescription *entity;

/** The managed object context of the entity associated with the definition. */
@property (nonatomic, readonly, strong) NSManagedObjectContext *managedObjectContext;

/**	The name of the entity attribute that will be used to store the display order of its objects. 
 
 Setting this property to a valid attribute name allows for custom re-ordering of the generated
 user interface elements representing the Core Data objects (e.g. custom re-ordering of cells).
 Setting this property overrides the value set for the keyPropertyName property.
 @warning Important: This Core Data attribute must be of integer type. */
@property (nonatomic, copy) NSString *orderAttributeName;


@end
