//
//  ClinicianSelectionCell.m
//  PsyTrack
//
//  Created by Daniel Boice on 3/27/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import "ClinicianSelectionCell.h"
#import "ClinicianViewController.h"
#import "PTTAppDelegate.h"

@implementation ClinicianSelectionCell
@synthesize clinicianObject=clinicianObject_;
@synthesize hasChangedClinicians=hasChangedClinicians_;
- (void)willDisplay
{
    
    self.textLabel.text=@"Prescriber";
    if (clinicianObject_) {
        self.label.text=(NSString *) clinicianObject_.combinedName;
        
    }
    
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}

- (void)didSelectCell
{
    
    NSLog(@"client %@",[self.boundObject valueForKey:@"prescriber"]);
    
    
    
    //    NSManagedObjectContext *managedObjectContext=[(PTTAppDelegate *)[UIApplication sharedApplication].delegate managedObjectContext];
    //Create a class definition for the client Entity
    
   
    
    
    NSString *clinicianViewControllerNibName;
    
    if ([SCHelper is_iPad]) 
        clinicianViewControllerNibName=[NSString stringWithString:@"ClinicianViewController"];
    else
        clinicianViewControllerNibName=[NSString stringWithString:@"ClinicianViewController"];
    
    
    ClinicianViewController *clinicianViewContoller=[[ClinicianViewController alloc]initWithNibName:clinicianViewControllerNibName bundle:nil isInDetailSubView:YES objectSelectionCell:self sendingViewController:self.ownerTableViewModel.viewController filterByPrescriber:(BOOL)YES];
    
    
    
    
    
    
    [self.ownerTableViewModel.viewController.navigationController pushViewController:clinicianViewContoller animated:YES];
    if ([clinicianViewContoller.tableModel sectionCount]>0) {
        SCTableViewSection *section=(SCTableViewSection *)[clinicianViewContoller.tableModel sectionAtIndex:0];
        if ([section isKindOfClass:[SCObjectSelectionSection class]]) {
            SCObjectSelectionSection *objectSelectionSection=(SCObjectSelectionSection *)section;
            
            if (clinicianObject_) {
                
                [objectSelectionSection setSelectedItemIndex:(NSNumber *)[NSNumber numberWithInteger:[objectSelectionSection.items indexOfObject:clinicianObject_]]];
                
                
            } 
        }
        
    }
    
  
    
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
    //        NSLog(@"no items");
    //    }
    //    NSMutableArray *arrayWithFetchedWithoutAlreadySelected=[NSMutableArray arrayWithArray:fetchedObjects];
    
    
    
    
    //    if (!hasChangedClients && [self.boundObject valueForKey:@"client"]) {
    //               
    //      NSLog(@"self itmes are %@",self.items);
    //    
    //      
    if (!hasChangedClinicians_) {
        self.clinicianObject=(ClinicianEntity *)[self.boundObject valueForKey:@"prescriber"];
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
    
    if (clinicianObject_){
        
        
        self.label.text =(NSString *) clinicianObject_.combinedName; 
        
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
//        NSLog(@"client id code %@",(NSString *)[clientObject valueForKey:@"clientIDCode"]);
//
//    }
// 
//
//    return clientIDCodeString;
//
//}

-(void)doneButtonTappedInDetailView:(NSManagedObject *)selectedObject withValue:(BOOL)hasValue{
    
    needsCommit=TRUE;
    
    self.clinicianObject=(ClinicianEntity *) selectedObject;
    //    [self.boundObject setValue:selectedObject forKey:@"client"];
    
    
    if (hasValue) {
        
        
        self.hasChangedClinicians=hasValue;
        
        
        
        NSIndexPath *myIndexPath=(NSIndexPath *)[self.ownerTableViewModel indexPathForCell:self];
        
        SCTableViewSection *clinicianSelectionCellOwnerSection=(SCTableViewSection *)[self.ownerTableViewModel sectionAtIndex:(NSInteger )myIndexPath.section ];
        
        
        
               
        if (clinicianObject_) {
            
            
            self.label.text=clinicianObject_.combinedName;
            
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
    
    if (![clinicianObject_ isDeleted]) {
        
        [self.boundObject setValue:clinicianObject_ forKey:@"prescriber"];
    }
    else
    {
        [self.boundObject setNilValueForKey:@"prescriber"];
        //        self.selectedItemIndex=[NSNumber numberWithInteger:-1];
    }
    [super commitChanges];
    self.hasChangedClinicians=FALSE ;
    
    needsCommit=FALSE;
    
}

@end
