//
//  DrugNameObjectSelectionCell.m
//  PsyTrack
//
//  Created by Daniel Boice on 3/25/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import "DrugNameObjectSelectionCell.h"
#import "PTTAppDelegate.h"
#import "DrugViewController_iPhone.h"
@implementation DrugNameObjectSelectionCell

@synthesize drugProduct;
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
    
    self.textLabel.text=@"Select Drug";
   
               
  
    
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}

- (void)didSelectCell
{
    
//    
    
    
    
    //    NSManagedObjectContext *managedObjectContext=[(PTTAppDelegate *)[UIApplication sharedApplication].delegate managedObjectContext];
    //Create a class definition for the client Entity
    
    
//    ClientsViewController_Shared *clientsViewController_Shared=[[ClientsViewController_Shared alloc]init];
//    
//    [clientsViewController_Shared setupTheClientsViewModelUsingSTV];
    
    
    
    //    NSMutableSet *mutableSet=[NSMutableSet setWithArray:self.items];
    
    
    
    //    
    
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
    
    NSString *drugViewControllerNibName=@"DrugViewController_iPhone";
    
  
    
    NSString *applicationNumber=[self.boundObject valueForKey:@"applNo"];
    NSString *productNumber=[self.boundObject valueForKey:@"productNo"];
    
    
    
    
   
       
    
    DrugViewController_iPhone *drugsViewContoller=[[DrugViewController_iPhone alloc]initWithNibName:drugViewControllerNibName bundle:[NSBundle mainBundle] isInDetailSubView:YES objectSelectionCell:self sendingViewController:self.ownerTableViewModel.viewController applNo:(NSString *)applicationNumber productNo:(NSString *)productNumber];
    
   [self.ownerTableViewModel.viewController.navigationController pushViewController:drugsViewContoller animated:YES];
    
    if (drugProduct.drugName &&drugProduct.drugName.length)
    [drugsViewContoller searchBar:drugsViewContoller.searchBar textDidChange:drugProduct.drugName];
   
      //    if ([drugsViewContoller.tableModel sectionCount]>0) {
//        SCTableViewSection *section=(SCTableViewSection *)[drugsViewContoller.tableModel sectionAtIndex:0];
//        if ([section isKindOfClass:[SCObjectSelectionSection class]]) {
//            SCObjectSelectionSection *objectSelectionSection=(SCObjectSelectionSection *)section;
//            
//            
//            NSString *drugName=[self.boundObject valueForKey:@"drugName"];
//            
//            
//            if (drugName.length) {
//                drugsViewContoller.searchBar.text=drugName;
//                
//            }
//            
//                        
//            if (drugProduct) 
//            {
//                
//                [objectSelectionSection setSelectedItemIndex:(NSNumber *)[NSNumber numberWithInteger:[objectSelectionSection.items indexOfObject:drugProduct]]];
//                
//                NSPredicate *predicate=[NSPredicate predicateWithFormat:@"applNo MATCHES %@",drugProduct.applNo];
//                
////                objectSelectionSection.itemsPredicate=predicate;
//                [objectSelectionSection reloadBoundValues];
//                [drugsViewContoller.tableView reloadData];
//                
//                if (drugProduct.drugName.length) {
//                    drugsViewContoller.searchBar.text=drugProduct.drugName;
//                }
//                
//                
//            }
//            else if (applicationNumber.length)
//            {
//            
//               
//                    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"applNo MATCHES %@",applicationNumber];
//                    
////                    objectSelectionSection.itemsPredicate=predicate;
//                    [objectSelectionSection reloadBoundValues];
//                    [drugsViewContoller.tableView reloadData];
//                
//
//            
//            }
//           
//            
//               
////                NSString *applNo=[self.boundObject valueForKey:@"applNo"];
//                
//                
//                                
//            
//            
//            
//            
//        }
//        
//    }
    
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
    
//    self.textLabel.text = nil;
//    self.detailTextLabel.text = nil;
//    
    
 
    drugProduct=(DrugProductEntity *) self.boundObject;
       self.label.text=(NSString *) drugProduct.drugName;
    
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
    //        
    //    }
    //    NSMutableArray *arrayWithFetchedWithoutAlreadySelected=[NSMutableArray arrayWithArray:fetchedObjects];
    
    
    
    
    //    if (!hasChangedClients && [self.boundObject valueForKey:@"client"]) {
    //               
    //      
    //    
    //      
//    if (!hasChangedClients) {
//        clientObject=(NSManagedObject *)[self.boundObject valueForKey:@"client"];
//    }
//    
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
    
//    if (clientObject){
//        
//        
//        self.label.text =(NSString *) [clientObject valueForKeyPath:@"clientIDCode" ]; 
//        
//    }
//    else {
//        self.textLabel.text=[NSString string];
//    }
//    
//    //    }
//    
//    
//}
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
//        
//
//    }
// 
//
//    return clientIDCodeString;
//
//}
}
-(void)doneButtonTappedInDetailView:(DrugProductEntity *)selectedObject withValue:(BOOL)hasValue{
    
    needsCommit=TRUE;
    
    drugProduct=selectedObject;
    //    [self.boundObject setValue:selectedObject forKey:@"client"];
    
    
//    if (hasValue) {
//        
//        
//        hasChangedDrug=hasValue;
        
        
        
//        NSIndexPath *myIndexPath=(NSIndexPath *)[self.ownerTableViewModel indexPathForCell:self];
        
//        SCTableViewSection *clientSelectionCellOwnerSection=(SCTableViewSection *)[self.ownerTableViewModel sectionAtIndex:(NSInteger )myIndexPath.section ];
        
        
        
       
        
        if (drugProduct) {
            [self.boundObject setValue:drugProduct.drugName forKey:@"drugName"];
            
            self.label.text=drugProduct.drugName;
            
            NSIndexPath *selfIndexPath=(NSIndexPath *) [self.ownerTableViewModel.modeledTableView indexPathForCell:self];
            [self.ownerTableViewModel valueChangedForRowAtIndexPath:selfIndexPath];
            
            
        }
        //         }
        //    }
        else
        {
            self.label.text=nil;
            //         self.selectedItemIndex=[NSNumber numberWithInteger:-1];
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
    
    if (drugProduct) {
        
        [self.boundObject setValue:drugProduct.drugName forKey:@"drugName"];
        [self.boundObject setValue:drugProduct.applNo forKey:@"applNo"];
         [self.boundObject setValue:drugProduct.productNo forKey:@"productNo"];
        
    }
    else
    {
        [self.boundObject setNilValueForKey:@"drugName"];
        //        self.selectedItemIndex=[NSNumber numberWithInteger:-1];
    }
    [super commitChanges];
//    hasChangedClients=FALSE ;
    
    needsCommit=FALSE;
    
}


@end
