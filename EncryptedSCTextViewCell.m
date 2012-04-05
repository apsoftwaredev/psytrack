//
//  EncryptedSCTextViewCell.m
//  PsyTrack Clinician Tools
//
//  Created by Daniel Boice on 3/12/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import "EncryptedSCTextViewCell.h"
#import "PTTAppDelegate.h"
@implementation EncryptedSCTextViewCell
@synthesize tempClientIDCode;

-(void)performInitialization{
    
    [super performInitialization];
    
    
    self.textView.tag=1;
    
    self.autoValidateValue=NO;
    self.textLabel.textColor=[UIColor colorWithRed:0.851 green:0.004 blue:0.157 alpha:1.0];
}

-(void)loadBoundValueIntoControl{
    
    [super loadBoundValueIntoControl];
    
    
//    PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
    

    self.textView.text=[self.boundObject valueForKey:[self.objectBindings valueForKey:@"34"]];
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
//            //NSLog(@"primitive daa is %@",primitiveData);
//            
//            
//            NSData *strData=[appDelegate decryptDataToPlainDataUsingKeyEntityWithDate:keyDate encryptedData:primitiveData];
//          
//            tempStr=[appDelegate convertDataToString:strData];
//            //NSLog(@"temp string is %@",tempStr);
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
    
    //NSLog(@"bound object is %@",self.boundObject);

       
    
    
    }
@end
