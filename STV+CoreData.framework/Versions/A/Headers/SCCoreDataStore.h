/*
 *  SCCoreDataStore.h
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

#import "SCEntityDefinition.h"
#import "SCCoreDataFetchOptions.h"
#import <SensibleTableView/SCDataStore.h> 


@interface SCCoreDataStore : SCDataStore
{
    NSManagedObjectContext *_managedObjectContext;
    NSMutableSet *_boundSet;
    BOOL _boundSetOwnsStoreObjects;
}

+ (id)storeWithManagedObjectContext:(NSManagedObjectContext *)context defaultEntityDefinition:(SCEntityDefinition *)definition;
+ (id)storeWithManagedObjectContext:(NSManagedObjectContext *)context boundSet:(NSMutableSet *)set boundSetEntityDefinition:(SCEntityDefinition *)definition boundSetOwnsStoreObjects:(BOOL)ownsStoreObjects;

- (id)initWithManagedObjectContext:(NSManagedObjectContext *)context defaultEntityDefinition:(SCEntityDefinition *)definition;
- (id)initWithManagedObjectContext:(NSManagedObjectContext *)context boundSet:(NSMutableSet *)set boundSetEntityDefinition:(SCEntityDefinition *)definition boundSetOwnsStoreObjects:(BOOL)ownsStoreObjects;

- (void)commitData;

/** The managed object context associated with the store. */
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@property (nonatomic, strong, readonly) NSMutableSet *boundSet;
@property (nonatomic, readonly) BOOL boundSetOwnsStoreObjects;

@end
