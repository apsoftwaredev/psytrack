//
//  ABSourcesSCObjectSelectionCell.m
//  PsyTrack Clinician Tools
//
//  Created by Daniel Boice on 3/17/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import "ABSourcesSCObjectSelectionCell.h"
#import "MySource.h"
#import "PTTAppDelegate.h"
@implementation ABSourcesSCObjectSelectionCell

-(void)performInitialization{


    [super performInitialization];
    
    self.allowAddingItems=NO;
    self.allowDeletingItems=NO;
    self.allowEditDetailView=NO;
    self.allowMovingItems=NO;
    self.allowMultipleSelection=NO;
    self.allowNoSelection=NO;




}

-(void)loadBoundValueIntoControl{
    
    
        NSString *selectedName=[NSString string];
    
    for (int i=0;i<self.items.count; i++) {
        
        NSNumber *p=(NSNumber *)[NSNumber numberWithInt:i];
        MySource *mySource=[self.items objectAtIndex:i];
        
        if ([self.selectedItemIndex isEqualToNumber:p]) {
            
            NSMutableSet *selectedItemsIndexesSet=(NSMutableSet *)self.selectedItemsIndexes;
            
            [selectedItemsIndexesSet addObject:p];
            
            selectedName=[NSString stringWithFormat:@"%@",mySource.name];
            
            [[NSUserDefaults standardUserDefaults] setValue:p forKey:kPTTAddressBookSourceIdentifier];
            break;
        }
        
    }

        
 
    
    NSLog(@"selected item indexes %@",self.selectedItemsIndexes);  
    
   
   
        
       
   
//    if (self.items.count&&![self.selectedItemIndex isEqualToNumber:[NSNumber numberWithInt:-1]]) {
//        MySource *ptABSource=[self.items objectAtIndex:[self.selectedItemIndex intValue]];
//        selectedName=[NSString stringWithFormat:@"%@",ptABSource.name];
//        
//    }
  

        
  
    
    self.label.text=selectedName;
    
    
    
  
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end