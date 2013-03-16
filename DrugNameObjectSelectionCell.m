//
//  DrugNameObjectSelectionCell.m
//  PsyTrack Clinician Tools
//  Version: 1.05
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
    
    
    
   }
- (void)willDisplay
{
    
    self.textLabel.text=@"Select Drug";
   
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}

- (void)didSelectCell
{
    
    
    NSString *drugViewControllerNibName=@"DrugViewController_iPhone";
    
  
    
    NSString *applicationNumber=[self.boundObject valueForKey:@"applNo"];
    NSString *productNumber=[self.boundObject valueForKey:@"productNo"];
    
    
    
    
   
       
    
    DrugViewController_iPhone *drugsViewContoller=[[DrugViewController_iPhone alloc]initWithNibName:drugViewControllerNibName bundle:[NSBundle mainBundle] isInDetailSubView:YES objectSelectionCell:self sendingViewController:self.ownerTableViewModel.viewController applNo:(NSString *)applicationNumber productNo:(NSString *)productNumber];
    
   [self.ownerTableViewModel.viewController.navigationController pushViewController:drugsViewContoller animated:YES];
    
    if (drugProduct.drugName &&drugProduct.drugName.length)
    [drugsViewContoller searchBar:drugsViewContoller.searchBar textDidChange:drugProduct.drugName];
   
}


//override superclass
//override superclass
- (void)cellValueChanged
{	
  
	[super cellValueChanged];
}


- (void)loadBindingsIntoCustomControls
{
    [super loadBindingsIntoCustomControls];

    drugProduct=(DrugProductEntity *) self.boundObject;
       self.label.text=(NSString *) drugProduct.drugName;
    

}
-(void)doneButtonTappedInDetailView:(DrugProductEntity *)selectedObject withValue:(BOOL)hasValue{
    
    needsCommit=TRUE;
    
    drugProduct=selectedObject;
  
        
        if (drugProduct) {
            [self.boundObject setValue:drugProduct.drugName forKey:@"drugName"];
            
            self.label.text=drugProduct.drugName;
            
            NSIndexPath *selfIndexPath=(NSIndexPath *) [self.ownerTableViewModel.modeledTableView indexPathForCell:self];
            [self.ownerTableViewModel valueChangedForRowAtIndexPath:selfIndexPath];
            
            
        }

        else
        {
            self.label.text=nil;
  
        }
    }

// overrides superclass
- (void)commitChanges
{
	if(!self.needsCommit)
		return;
    

    if (drugProduct) {
        
        [self.boundObject setValue:drugProduct.drugName forKey:@"drugName"];
        [self.boundObject setValue:drugProduct.applNo forKey:@"applNo"];
         [self.boundObject setValue:drugProduct.productNo forKey:@"productNo"];
        
    }
    else
    {
        [self.boundObject setNilValueForKey:@"drugName"];
 
    }
    [super commitChanges];

    
    needsCommit=FALSE;
    
}


@end
