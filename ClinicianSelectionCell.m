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
@synthesize cliniciansArray=cliniciansArray_;


- (void)willDisplay
{
    
    NSString *textLabelStr=[self.objectBindings valueForKey:@"90"];
    
    
    self.textLabel.text=textLabelStr;
    if (!multiSelect && clinicianObject_) {
        self.label.text=(NSString *) self.clinicianObject.combinedName;
        
    }else if (multiSelect)
    {
        int i=0;
        NSString *labelStr=[NSString string];
        for (ClinicianEntity *clinician in cliniciansArray_) {
            
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
    
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}

- (void)didSelectCell
{
    
//    NSString *clinicianKeyStr=[self.objectBindings valueForKey:@"92"];
    //NSLog(@"client %@",[self.boundObject valueForKey:clinicianKeyStr]);
    
    
    
    //    NSManagedObjectContext *managedObjectContext=[(PTTAppDelegate *)[UIApplication sharedApplication].delegate managedObjectContext];
    //Create a class definition for the client Entity
    
   
    
    
    NSString *clinicianViewControllerNibName;
    
    if ([SCUtilities is_iPad]) 
        clinicianViewControllerNibName=[NSString stringWithString:@"ClinicianViewController"];
    else
        clinicianViewControllerNibName=[NSString stringWithString:@"ClinicianViewController"];
    
    
    NSPredicate *predicate=nil;
    
    
    if ( usePrescriber ) {
        
//        
        if ((BOOL)[clinicianObject_.isPrescriber boolValue]) {
             predicate=[NSPredicate predicateWithFormat:@"isPrescriber ==%@",[NSNumber numberWithBool: YES]];
            
            
        }
        
       
        
                
      
    }else if (clinicianObject_ &&!usePrescriber){
        BOOL startWithMySupervisorFilter=YES;
        
             
        if ([clinicianObject_.myCurrentSupervisor isEqualToNumber:[NSNumber numberWithBool:YES]]&&[clinicianObject_.myPastSupervisor isEqualToNumber:[NSNumber numberWithBool:YES]]&&[clinicianObject_.myInformation  isEqualToNumber:[NSNumber numberWithBool:YES]]) {
            startWithMySupervisorFilter=NO;
            
            
        }
        if (startWithMySupervisorFilter) {
             predicate=[NSPredicate predicateWithFormat:@"myCurrentSupervisor == %i OR myPastSupervisor==%i", TRUE, TRUE];
        }
       
    }
    
else if (cliniciansArray_ &&cliniciansArray_.count){
    BOOL startWithSupervisorFilter=NO;
    //        
        for (int i=0; i<cliniciansArray_.count; i++) {
            ClinicianEntity *clinicianInArray=(ClinicianEntity *)[cliniciansArray_ objectAtIndex:i];
            if (([clinicianInArray.myCurrentSupervisor isEqualToNumber:(NSNumber *)[NSNumber numberWithBool: YES]]||  [clinicianInArray.myPastSupervisor isEqualToNumber:(NSNumber *)[NSNumber numberWithBool: YES]])) {
                startWithSupervisorFilter=YES;
               
                
            }else {
                startWithSupervisorFilter=NO;
                break;
            }
        }
    
    if (startWithSupervisorFilter) {
        predicate=[NSPredicate predicateWithFormat:@"myCurrentSupervisor == %i OR myPastSupervisor==%i", TRUE, TRUE];
    }
}
    //NSLog(@"use prescriberis %i",usePrescriber);
    ClinicianViewController *clinicianViewController=nil;
   
    
    clinicianViewController=[[ClinicianViewController alloc]initWithNibName:clinicianViewControllerNibName bundle:nil isInDetailSubView:YES objectSelectionCell:self sendingViewController:self.ownerTableViewModel.viewController  withPredicate:(NSPredicate *)predicate usePrescriber:(BOOL)usePrescriber allowMultipleSelection:(BOOL)multiSelect];
    
    
    //NSLog(@"view controllers is %@",self.ownerTableViewModel.viewController.navigationController.viewControllers);

//    for ( int i=0;i< self.ownerTableViewModel.viewController.navigationController.viewControllers.count;i++) {
//        id objectInArray=(id)[self.ownerTableViewModel.viewController.navigationController.viewControllers objectAtIndex:i];
//        
//               if ([objectInArray isKindOfClass:[ClinicianViewController class]]) {
//            
//            clinicianViewController=objectInArray;
//            break;
//        }
//        
//    }    
    
   
   
    
    
    
    
    
    
    [self.ownerTableViewModel.viewController.navigationController pushViewController:clinicianViewController animated:YES];

    if ([clinicianViewController.tableViewModel sectionCount]>0) {
        
        for (int i=0; i<clinicianViewController.tableViewModel.sectionCount; i++) {
        
            SCTableViewSection *section=(SCTableViewSection *)[clinicianViewController.tableViewModel sectionAtIndex:i];
        if ([section isKindOfClass:[SCObjectSelectionSection class]]) {
            SCObjectSelectionSection *objectSelectionSection=(SCObjectSelectionSection *)section;
            
            
            
           
            if (multiSelect) {
            
                NSMutableSet *selectedIndexesSet=objectSelectionSection.selectedItemsIndexes;
                objectSelectionSection.allowMultipleSelection=YES;
                for (int p=0; p<self.cliniciansArray.count; p++) {
                    int clinicianInSectionIndex;
                    ClinicianEntity *clinicianInArray=[self.cliniciansArray objectAtIndex:p];
                    if ([objectSelectionSection.items containsObject:clinicianInArray]) {
                        clinicianInSectionIndex=(int )[objectSelectionSection.items indexOfObject:clinicianInArray];
                        if (![objectSelectionSection.selectedItemsIndexes containsObject:[NSNumber numberWithInt:clinicianInSectionIndex]]) {
                             [selectedIndexesSet addObject:[NSNumber numberWithInt:clinicianInSectionIndex]];
                        }
                       
                    }
                    
                }
            
             
                
            }
            else if (clinicianObject_) 
            {
           
                objectSelectionSection.allowMultipleSelection=NO;
    
               
                [objectSelectionSection setSelectedItemIndex:(NSNumber *)[NSNumber numberWithInteger:[objectSelectionSection.items indexOfObject:clinicianObject_]]];
                
                
            } 
            else {
                objectSelectionSection.allowMultipleSelection=NO;
            }
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
    //        //NSLog(@"no items");
    //    }
    //    NSMutableArray *arrayWithFetchedWithoutAlreadySelected=[NSMutableArray arrayWithArray:fetchedObjects];
    
    
    
    
    //    if (!hasChangedClients && [self.boundObject valueForKey:@"client"]) {
    //               
    //      //NSLog(@"self itmes are %@",self.items);
    //    
    //      
    
    //NSLog(@"cell bound object is %@", self.boundObject);
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
                self.label.text=[NSString string];
            } 
        
        }
        else 
        {
         
       
            NSString *clinicianKeyStr=[self.objectBindings valueForKey:@"92"];
            NSMutableSet *cliniciansMutableSet=(NSMutableSet *)[self.boundObject mutableSetValueForKey:clinicianKeyStr];
            self.cliniciansArray=[NSMutableArray arrayWithArray:[cliniciansMutableSet allObjects]];
            //NSLog(@"clinician array is %@",cliniciansArray_);
            
            NSString *labelStr=[NSString string];
            for (int i=0; i<cliniciansArray_.count; i++) {
               
                id objectInArray=[cliniciansArray_ objectAtIndex:i];
                if ([objectInArray isKindOfClass:[ClinicianEntity class]]) {
                    ClinicianEntity *clinicianInArray=(ClinicianEntity *)objectInArray;
                    [clinicianInArray willAccessValueForKey:@"combinedName"];
                    if (i==0) {
                      
                        labelStr=clinicianInArray.combinedName;
                    } 
                    else {
                        labelStr=[labelStr stringByAppendingFormat:@", %@",clinicianInArray.combinedName];
                    }

                }
                                   
              
                  
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
//        //NSLog(@"client id code %@",(NSString *)[clientObject valueForKey:@"clientIDCode"]);
//
//    }
// 
//
//    return clientIDCodeString;
//
//}

-(void)doneButtonTappedInDetailView:(ClinicianEntity *)selectedObject selectedItems:(NSArray *)selectedItems withValue:(BOOL)hasValue{
    
    needsCommit=TRUE;
    
    self.clinicianObject=nil;
    if (self.cliniciansArray.count) {
        [self.cliniciansArray removeAllObjects];
    }
    self.cliniciansArray=nil;
   
    self.clinicianObject=(ClinicianEntity *) selectedObject;
    self.cliniciansArray=[NSMutableArray arrayWithArray:selectedItems];
 
    //    [self.boundObject setValue:selectedObject forKey:@"client"];
    
    
    if (hasValue) {
        
        
        self.hasChangedClinicians=hasValue;
        
        
        
//        NSIndexPath *myIndexPath=(NSIndexPath *)[self.ownerTableViewModel indexPathForCell:self];
//        
//        SCTableViewSection *clinicianSelectionCellOwnerSection=(SCTableViewSection *)[self.ownerTableViewModel sectionAtIndex:(NSInteger )myIndexPath.section ];
        
        
        if (multiSelect) 
        {
            
             NSString *labelTextStr=[NSString string];
            if (self.cliniciansArray.count) 
            {
               
                for (int i=0; i<self.cliniciansArray.count; i++) 
                {
               
                    id obj=[self.cliniciansArray objectAtIndex:i];
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
            
        
            
 
        else if (self.clinicianObject)
        {
            
                 //NSLog(@"combined name is %@",clinicianObject_.combinedName);
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
      
        int itemsCount=self.cliniciansArray.count;
        for (int i=0; i<itemsCount; i++) {
            id obj=[self.cliniciansArray objectAtIndex:i];
            if ([obj isKindOfClass:[ClinicianEntity class]]) {
                ClinicianEntity *clinicianObjectInItems=(ClinicianEntity *)obj;
                
                [cliniciansMutableSet addObject:clinicianObjectInItems];
                
            }  
        }
        [self.boundObject setValue:cliniciansMutableSet forKey:clinicianKeyStr];
        
    }else 
    {
      //NSLog(@"combined name is %@",clinicianObject_.combinedName);
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
