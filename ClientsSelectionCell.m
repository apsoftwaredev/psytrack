/*
 *  ClientsSelectionCell.m
 *  psyTrack Clinician Tools
 *  Version: 1.0
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
@synthesize clientObject=clientObject;
@synthesize testDate;

-(void) performInitialization{

    [super performInitialization];
    
    
     
    
//    self.allowAddingItems = YES;
//    self.allowDeletingItems = NO;
//    self.allowMovingItems = YES;
//    self.allowAddingItems = YES;
//
//    self.allowMultipleSelection=NO;
//    self.allowNoSelection=YES;
//    self.delegate=self;

  }
- (void)willDisplay
{
    
    self.textLabel.text=@"Client";
    if (clientObject) {
        self.label.text=(NSString *) [clientObject valueForKey:@"clientIDCode" ];
        
    }
    
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}

- (void)didSelectCell
{
    
    ////NSLog(@"client %@",[self.boundObject valueForKey:@"client"]);
   
   
    
//    NSManagedObjectContext *managedObjectContext=[(PTTAppDelegate *)[UIApplication sharedApplication].delegate managedObjectContext];
    //Create a class definition for the client Entity
    
    
    ClientsViewController_Shared *clientsViewController_Shared=[[ClientsViewController_Shared alloc]init];
    
    [clientsViewController_Shared setupTheClientsViewModelUsingSTV];
    
    
    
//    NSMutableSet *mutableSet=[NSMutableSet setWithArray:self.items];
    
    
    
//    ////NSLog(@"clientobject selection itemset %@",mutableSet);
    
//    SCObjectSelectionSection *objectSelectionSection=[SCObjectSelectionSection sectionWithHeaderTitle:nil withItemsSet:mutableSet withClassDefinition:clientsViewController_Shared.clientDef];
//    
    
//   NSMutableSet *mutableSet= [self.ownerTableViewModel mutableSetValueForKey:@"testSessionDelivered" ];

//    NSMutableSet *clientsInClientPresentationItems=(NSMutableSet *)[self.ownerTableViewModel mutableSetValueForKey:@"client"];
    
  
//    
//    
//    self.selectedItemIndex=[NSNumber numberWithInteger:(NSInteger)[self.items indexOfObject:clientObject]];
//    
//   
////    
//    
//    objectSelectionSection.selectedItemIndex=(NSNumber *)[NSNumber numberWithInteger:[objectSelectionSection.items indexOfObject:clientObject]];
//    
//    objectSelectionSection.allowMultipleSelection = NO;
//    objectSelectionSection.allowNoSelection = NO;
//    objectSelectionSection.maximumSelections = 1;
//    objectSelectionSection.allowAddingItems = YES;
//    objectSelectionSection.allowDeletingItems = NO;
//    objectSelectionSection.allowMovingItems = YES;
//    objectSelectionSection.allowEditDetailView = YES;
//
    
    NSString *clientViewControllerNibName;
    
    if ([SCUtilities is_iPad]) 
        clientViewControllerNibName=[NSString stringWithString:@"ClientsViewController_iPad"];
    else
        clientViewControllerNibName=[NSString stringWithString:@"ClientsViewController_iPhone"];

        
        ClientsViewController_iPhone *clientsViewContoller=[[ClientsViewController_iPhone alloc]initWithNibName:clientViewControllerNibName bundle:nil isInDetailSubView:YES objectSelectionCell:self sendingViewController:self.ownerTableViewModel.viewController];
        
   
    

        
        
        [self.ownerTableViewModel.viewController.navigationController pushViewController:clientsViewContoller animated:YES];
    if ([clientsViewContoller.tableModel sectionCount]>0) {
        SCTableViewSection *section=(SCTableViewSection *)[clientsViewContoller.tableModel sectionAtIndex:0];
        if ([section isKindOfClass:[SCObjectSelectionSection class]]) {
            SCObjectSelectionSection *objectSelectionSection=(SCObjectSelectionSection *)section;
            
            if (clientObject) {
           
            [objectSelectionSection setSelectedItemIndex:(NSNumber *)[NSNumber numberWithInteger:[objectSelectionSection.items indexOfObject:clientObject]]];
            
                
            } 
        }
        
    }
    
//    SCObjectSelectionSection *objectSelectionSection=(SCObjectSelectionAttributes
        
//        if (clientsViewContoller.tableModel.sectionCount) {
//            [clientsViewContoller.tableModel removeSectionAtIndex:0];
//        }
//    
//        [clientsViewContoller.tableModel addSection:objectSelectionSection];
//    [clientsViewContoller.tableModel setUseSCObjectsSelectionSection:TRUE];
//        clientsViewContoller.alreadySelectedClients=alreadySelectedClients;
//        clientsViewContoller.clientCurrentlySelectedInReferringDetailview=clientObject;
//        [clientsViewContoller updateClientsTotalLabel];
  

        
        
        ////NSLog(@"already selected Clients are%@",self.alreadySelectedClients);
        
        
           
    

//    UINavigationController *clientsNavigationController=(UINavigationController *)clientsViewContoller.navigationController;
//   clientsNavigationController=(UINavigationController *)self.ownerTableViewModel.viewController.navigationController;
//        
//        

}


//override superclass
//override superclass
- (void)cellValueChanged
{	
 
    
//	self.label.text = [self clientIDCodeStringUsingBoundObject:YES];
	
	[super cellValueChanged];
}


- (void)loadBindingsIntoCustomControls
{
    [super loadBindingsIntoCustomControls];
  
    self.textLabel.text = nil;
    self.detailTextLabel.text = nil;
//    NSManagedObjectContext *managedObjectContext=(NSManagedObjectContext *)[(PTTAppDelegate *)[UIApplication sharedApplication].delegate managedObjectContext];
//    
//    
//    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
//    
//    NSEntityDescription *entity = [NSEntityDescription entityForName:@"ClientEntity" inManagedObjectContext:managedObjectContext];
//    [fetchRequest setEntity:entity];
//    
//    NSError *error = nil;
//    NSArray *fetchedObjects = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
//    if (fetchedObjects == nil) {
//        ////NSLog(@"no items");
//    }
//    NSMutableArray *arrayWithFetchedWithoutAlreadySelected=[NSMutableArray arrayWithArray:fetchedObjects];
   
    
    
    
//    if (!hasChangedClients && [self.boundObject valueForKey:@"client"]) {
//               
//      ////NSLog(@"self itmes are %@",self.items);
//    
//      
    if (!hasChangedClients) {
         clientObject=(NSManagedObject *)[self.boundObject valueForKey:@"client"];
    }
       
//        
//    }
//           }
//   
//        if(!hasChangedClients){
//        for(id obj in alreadySelectedClients) { 
//            if(obj!=clientObject)
//                [arrayWithFetchedWithoutAlreadySelected removeObject:obj];
//            
//        }
//    }
//    self.items=arrayWithFetchedWithoutAlreadySelected;
//    if (!clientObject.isDeleted) {
//        self.selectedItemIndex=(NSNumber*)[NSNumber numberWithInteger:[self.items indexOfObject:clientObject]];
       
    if (clientObject){
        
        
        self.label.text =(NSString *) [clientObject valueForKeyPath:@"clientIDCode" ]; 
    
}
    else {
        self.textLabel.text=[NSString string];
    }
        
//    }
    

}
//-(NSString *)clientIDCodeString{
//
//    NSString *clientIDCodeString=[NSString string];
//    NSNumber *selectedIndex;
//  
//    
//    int itemsCount=self.items.count;
//    int selecteIndexIntValue=[selectedIndex intValue];
//    selecteIndexIntValue=selecteIndexIntValue+1;
//    if ((clientObject )&&(selecteIndexIntValue>-1 ) && (itemsCount>=1 )&& (selecteIndexIntValue <= itemsCount)) 
//    {
//       
//       
//        
//       clientIDCodeString = (NSString *)[clientObject valueForKey:@"clientIDCode"];
//        ////NSLog(@"client id code %@",(NSString *)[clientObject valueForKey:@"clientIDCode"]);
//
//    }
// 
//
//    return clientIDCodeString;
//
//}

-(void)doneButtonTappedInDetailView:(NSManagedObject *)selectedObject withValue:(BOOL)hasValue{

    needsCommit=TRUE;
    
    clientObject=selectedObject;
//    [self.boundObject setValue:selectedObject forKey:@"client"];
    
   
    if (hasValue) {
        
 
        hasChangedClients=hasValue;

    
    
    NSIndexPath *myIndexPath=(NSIndexPath *)[self.ownerTableViewModel indexPathForCell:self];
    
    SCTableViewSection *clientSelectionCellOwnerSection=(SCTableViewSection *)[self.ownerTableViewModel sectionAtIndex:(NSInteger )myIndexPath.section ];
    
    
    
    ClientPresentations_Shared *clientPresentationsShared=[[ClientPresentations_Shared alloc]init];
    
    clientPresentationsShared.serviceDatePickerDate=(NSDate *)testDate;
    
    [clientPresentationsShared addWechlerAgeCellToSection:clientSelectionCellOwnerSection];
    
    
    if (clientObject) {
    

             self.label.text=[clientObject valueForKeyPath:@"clientIDCode"];

            NSIndexPath *selfIndexPath=(NSIndexPath *) [self.ownerTableViewModel.modeledTableView indexPathForCell:self];
             [self.ownerTableViewModel valueChangedForRowAtIndexPath:selfIndexPath];
    }
//         }
//    }
    else
    {
         self.label.text=[NSString string];
//         self.selectedItemIndex=[NSNumber numberWithInteger:-1];
    }
    }
}
// overrides superclass
- (void)commitChanges
{
	if(!self.needsCommit)
		return;
   
    
//    NSObject *selectedObject = nil;
//    int indexInt = [self.selectedItemIndex intValue] ;
    
//    if((indexInt >= 0) &&(indexInt<=self.items.count+1)&&self.items.count>0){
//        selectedObject = [self.items objectAtIndex:indexInt];

    if (![clientObject isDeleted]) {
       
    [self.boundObject setValue:clientObject forKey:@"client"];
    }
    else
    {
        [self.boundObject setNilValueForKey:@"client"];
//        self.selectedItemIndex=[NSNumber numberWithInteger:-1];
    }
    [super commitChanges];
    hasChangedClients=FALSE ;

    needsCommit=FALSE;
   
}


-(void)didChange:(NSKeyValueChange)changeKind valuesAtIndexes:(NSIndexSet *)indexes forKey:(NSString *)key{

////NSLog(@"did change values for key");


}


@end
