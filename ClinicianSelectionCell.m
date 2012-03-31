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
    
    NSString *textLabelStr=[self.objectBindings valueForKey:@"90"];
    
    
    self.textLabel.text=textLabelStr;
    if (clinicianObject_) {
        self.label.text=(NSString *) clinicianObject_.combinedName;
        
    }
    
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}

- (void)didSelectCell
{
    
    NSString *clinicianKeyStr=[self.objectBindings valueForKey:@"92"];
    NSLog(@"client %@",[self.boundObject valueForKey:clinicianKeyStr]);
    
    
    
    //    NSManagedObjectContext *managedObjectContext=[(PTTAppDelegate *)[UIApplication sharedApplication].delegate managedObjectContext];
    //Create a class definition for the client Entity
    
   
    
    
    NSString *clinicianViewControllerNibName;
    
    if ([SCHelper is_iPad]) 
        clinicianViewControllerNibName=[NSString stringWithString:@"ClinicianViewController"];
    else
        clinicianViewControllerNibName=[NSString stringWithString:@"ClinicianViewController"];
    
    
    ClinicianViewController *clinicianViewContoller=[[ClinicianViewController alloc]initWithNibName:clinicianViewControllerNibName bundle:nil isInDetailSubView:YES objectSelectionCell:self sendingViewController:self.ownerTableViewModel.viewController filterByPrescriber:(BOOL)usePrescriber];
    
    
    
    
    
    
    [self.ownerTableViewModel.viewController.navigationController pushViewController:clinicianViewContoller animated:YES];
    if ([clinicianViewContoller.tableModel sectionCount]>0) {
        SCTableViewSection *section=(SCTableViewSection *)[clinicianViewContoller.tableModel sectionAtIndex:0];
        if ([section isKindOfClass:[SCObjectSelectionSection class]]) {
            SCObjectSelectionSection *objectSelectionSection=(SCObjectSelectionSection *)section;
            
            
            objectSelectionSection.allowMultipleSelection=multiSelect;
            
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
    usePrescriber=(BOOL)[(NSNumber *)[self.objectBindings valueForKey:@"91"]boolValue];
    multiSelect=(BOOL)[(NSNumber *)[self.objectBindings valueForKey:@"93"]boolValue];
    
    self.allowMultipleSelection=multiSelect;
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
    
    NSLog(@"cell bound object is %@", self.boundObject);
    if (!hasChangedClinicians_) {
        NSString *clinicianKeyStr=[self.objectBindings valueForKey:@"92"];
        if (!multiSelect) 
        {
        
            self.clinicianObject=(ClinicianEntity *)[self.boundObject valueForKey:clinicianKeyStr];
            
            if (clinicianObject_)
            {
                
                self.label.text =(NSString *) clinicianObject_.combinedName; 
                
            }
            else 
            {
                self.textLabel.text=[NSString string];
            } 
        
        }
        else 
        {
         
       
            NSString *clinicianKeyStr=[self.objectBindings valueForKey:@"92"];
            NSMutableSet *cliniciansMutableSet=(NSMutableSet *)[self.boundObject mutableSetValueForKey:clinicianKeyStr];
            
            int i=0;
            NSString *labelStr=[NSString string];
            for (ClinicianEntity *clinician in [cliniciansMutableSet allObjects]) {
               
                if (i==0) {
                    labelStr=clinician.combinedName;
                } 
                else {
                    labelStr=[labelStr stringByAppendingFormat:@", %@",clinician.combinedName];
                }
                   
                i++;
                  
            }
            self.label.text=labelStr;
            
        }
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

-(void)doneButtonTappedInDetailView:(NSManagedObject *)selectedObject selectedItems:(NSArray *)selectedItems withValue:(BOOL)hasValue{
    
    needsCommit=TRUE;
    
    self.clinicianObject=(ClinicianEntity *) selectedObject;
    self.items=selectedItems;
    //    [self.boundObject setValue:selectedObject forKey:@"client"];
    
    
    if (hasValue) {
        
        
        self.hasChangedClinicians=hasValue;
        
        
        
//        NSIndexPath *myIndexPath=(NSIndexPath *)[self.ownerTableViewModel indexPathForCell:self];
//        
//        SCTableViewSection *clinicianSelectionCellOwnerSection=(SCTableViewSection *)[self.ownerTableViewModel sectionAtIndex:(NSInteger )myIndexPath.section ];
        
        
        if (multiSelect) 
        {
            
             NSString *labelTextStr=[NSString string];
            if (self.items.count) 
            {
               
                for (int i=0; i<self.items.count; i++) 
                {
               
                    id obj=[self.items objectAtIndex:i];
                    if ([obj isKindOfClass:[ClinicianEntity class]]) {
                        ClinicianEntity *clinicianObjectInItems=(ClinicianEntity *)obj;
                        
                        if (i==0) 
                        {
                            labelTextStr=clinicianObjectInItems.combinedName;
                        }
                        else 
                        {
                            labelTextStr=[labelTextStr stringByAppendingFormat:@", %@",clinicianObjectInItems.combinedName];
                        }

                    }  
                                           
                }
            }
            self.label.text=labelTextStr;
            
        }
            
        
            
 
        else if (clinicianObject_)
        {
            
                
                self.label.text=clinicianObject_.combinedName;
                
                NSIndexPath *selfIndexPath=(NSIndexPath *) [self.ownerTableViewModel.modeledTableView indexPathForCell:self];
                [self.ownerTableViewModel valueChangedForRowAtIndexPath:selfIndexPath];
        }
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
    
     NSString *clinicianKeyStr=[self.objectBindings valueForKey:@"92"];
    
    
    if (multiSelect) {
        NSMutableSet *cliniciansMutableSet=[NSMutableSet set];
      
        int itemsCount=self.items.count;
        for (int i=0; i<itemsCount; i++) {
            id obj=[self.items objectAtIndex:i];
            if ([obj isKindOfClass:[ClinicianEntity class]]) {
                ClinicianEntity *clinicianObjectInItems=(ClinicianEntity *)obj;
                
                [cliniciansMutableSet addObject:clinicianObjectInItems];
                
            }  
        }
        [self.boundObject setValue:cliniciansMutableSet forKey:clinicianKeyStr];
        
    }else 
    {
    
        if (![clinicianObject_ isDeleted]) {
            
            [self.boundObject setValue:clinicianObject_ forKey:clinicianKeyStr];
        }
        else
        {
            [self.boundObject setNilValueForKey:clinicianKeyStr];
            //        self.selectedItemIndex=[NSNumber numberWithInteger:-1];
        }
         
        [super commitChanges];
    }

    [self setAutoValidateValue:NO];
   
    self.hasChangedClinicians=FALSE ;
    
    needsCommit=FALSE;
    
}

@end
