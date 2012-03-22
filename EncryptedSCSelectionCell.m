//
//  EncryptedSCSelectionCell.m
//  PsyTrack Clinician Tools
//
//  Created by Daniel Boice on 3/20/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import "EncryptedSCSelectionCell.h"

@implementation EncryptedSCSelectionCell

-(void)performInitialization{
    
    [super performInitialization];
    
    
    self.tag=1;
    
    self.allowMultipleSelection=NO;
    self.allowNoSelection=NO;
    self.autoDismissDetailView=YES;
    self.hideDetailViewNavigationBar=NO;
    self.textLabel.text= @"Sex";
    
    self.autoValidateValue=NO;
}

-(void)loadBoundValueIntoControl{
    
    [super loadBoundValueIntoControl];
    
    
    //    PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
    NSArray *sexSelectionArray=[NSArray arrayWithObjects:@"Male", @"Female", @"Intersexual",@"F2M",@"M2F",@"Undisclosed", nil];
    self.items=sexSelectionArray;
    
    NSLog(@"value for cell is %@",[self.boundObject valueForKey:@"sex"]);
    int selectedIndexInt=-1;
    if ([self.boundObject valueForKey:[self.objectBindings valueForKey:@"34"]]) {
        [self setSelectedItemIndex:[NSNumber numberWithInt:(int)[self.items indexOfObject:[self.boundObject valueForKey:[self.objectBindings valueForKey:@"34"]]]]];
    }
    
    
    if (![self.selectedItemIndex isEqualToNumber:[NSNumber numberWithInt:-1]]) {
        selectedIndexInt=[self.selectedItemIndex intValue];
    }
    if ([self.selectedItemIndex intValue]<self.items.count) {
        self.label.text=[self.items objectAtIndex:[self.selectedItemIndex intValue]];
    }
    
    //    NSString *textLabelStr=[NSString string];
    //    if ([objectBindings objectForKey:@"33"]) {
    ////        textLabelStr=[self.objectBindings valueForKey:@"33"];
    //        
    //        NSString *tempStr;
    //                
    //        
    //        if (!self.tempClientIDCode ||!self.tempClientIDCode.length) {
    //            
    //           
    //            
    //            
    //            
    //            
    //           
    //            PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
    //            
    //            
    //          
    //            NSDate *keyDate=[self.boundObject valueForKey:@"keyDate"];
    //            NSData *primitiveData=[self.boundObject valueForKey:@"clientIDCode"];
    //            NSLog(@"primitive daa is %@",primitiveData);
    //            
    //            
    //            NSData *strData=[appDelegate decryptDataToPlainDataUsingKeyEntityWithDate:keyDate encryptedData:primitiveData];
    //          
    //            tempStr=[appDelegate convertDataToString:strData];
    //            NSLog(@"temp string is %@",tempStr);
    //                       
    //            self.tempClientIDCode=tempStr;
    //        
    //            textLabelStr=tempStr;
    //            
    //        }
    //        else 
    //        {
    //            textLabelStr=self.tempClientIDCode;
    //            
    //        }
    //
    //        
    //        
    //        
    //        
    //        
    //    }
    
    //    self.textLabel.text=[se;
    
    //    self.boundObject=self.testString;
    
    NSLog(@"bound object is %@",self.boundObject);
    
    
    
    
}
-(void)commitChanges{

    if (!needsCommit) {
        return;
    }
    
     if ([self.selectedItemIndex intValue]<self.items.count) {
    [self.boundObject setValue:[self.items objectAtIndex:[self.selectedItemIndex intValue]] forKey:[self.objectBindings valueForKey:@"34"]];
    
     }
    
    [super commitChanges];


}

@end
