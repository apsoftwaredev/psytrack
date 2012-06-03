 /*
 *  EncryptedSCTextFieldCell.m
 *  psyTrack Clinician Tools
 *  Version: 1.0
 *
 *
 *	THIS SOURCE CODE AND ANY ACCOMPANYING DOCUMENTATION ARE PROTECTED BY UNITED STATES 
 *	INTELLECTUAL PROPERTY LAW AND INTERNATIONAL TREATIES. UNAUTHORIZED REPRODUCTION OR 
 *	DISTRIBUTION IS SUBJECT TO CIVIL AND CRIMINAL PENALTIES. 
 *
 *  Created by Daniel Boice on 2/23/12.
 *  Copyright (c) 2011 PsycheWeb LLC. All rights reserved.
 *
 *
 *	This notice may not be removed from this file.
 *
 */
#import "EncryptedSCTextFieldCell.h"

#import "PTTAppDelegate.h"

@implementation EncryptedSCTextFieldCell
@synthesize clientIDCodeStr;
-(void)performInitialization{

    [super performInitialization];


    self.textField.tag=1;
    
    self.autoValidateValue=NO;
    self.textLabel.textColor=[UIColor colorWithRed:0.851 green:0.004 blue:0.157 alpha:1.0];
//    self.textLabel.text=[self.objectBindings valueForKey:@"33"];
}


-(void)loadBoundValueIntoControl{
    
    [super loadBoundValueIntoControl];
//    if (!self.clientIDCodeStr ||!self.clientIDCodeStr.length) {
//        
//        
//        
//        
//        
//        
//        
//        PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
//        
//        
//        
//        NSData *encryptedData=[self.boundObject valueForKey:[self.objectBindings valueForKey:@"34"]]; 
//        NSDate *keyString=[self.boundObject valueForKey:[self.objectBindings valueForKey:@"32"]];
//        //NSLog(@"encrypted data is %@",encryptedData);
//        //NSLog(@"key date is %@",keyString);
//        NSData *decryptedData=[appDelegate decryptDataToPlainDataUsingKeyEntityWithDate:keyString encryptedData:encryptedData];
//        
//        //NSLog(@"decyrpted data %@",decryptedData);
//        self.clientIDCodeStr=[appDelegate convertDataToString:decryptedData];
//        //NSLog(@"temp string is %@",self.clientIDCodeStr);
////        [self.boundObject setValue:keyString forKey:@"keyString"];
//        
//        
//        //        textLabelStr=self.tempString;
//        
//    }
    
    
    
    
    
    
    
    
    
    self.textField.text=[self.boundObject valueForKey:[self.objectBindings valueForKey:@"34"]];
    
    //    self.boundObject=self.testString;
    
    //NSLog(@"bound object is %@",self.boundObject);
    
    //    SCTableViewModel *owTableViewModel=(SCTableViewModel *)self.ownerTableViewModel;
    //  
    //    
    //    UINavigationItem *navigationItem=(UINavigationItem *)owTableViewModel.viewController.navigationItem;
    //    
    //    navigationItem.title=self.textField.text;
    //    
    //    //NSLog(@"navigation bar all keys title attributes %@", owTableViewModel.viewController.navigationItem.title
    //);     
    


}



//
//-(void)loadBindingsIntoCustomControls{
//
////    [self.boundObject setValue:@"test" forKey:@"clientIDCode"];
//    [super loadBindingsIntoCustomControls];
//    
//
//
//}



// overrides superclass
//- (void)commitChanges
//{
//	if(!self.needsCommit)
//		return;
//    
//   
//    
//    
//    PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
//    
//
////    NSString *plaintext=self.textField.text;
////    //NSLog(@"key bindings are %@",[self.ownerTableViewModel. allKeys]);
//    self.clientIDCodeStr=self.textField.text;
//    //NSLog(@"textfield text is %@",self.clientIDCodeStr);
//    
//    NSDate *keyString=[self.boundObject valueForKey:[self.objectBindings valueForKey:@"32"]];
//    
//    //NSLog(@"key date is %@",keyString);
//    
//    NSDictionary *encryptedDictionary=[appDelegate encryptStringToEncryptedData:self.clientIDCodeStr withkeyString:(NSDate*)keyString];
//    
//    NSData *encryptedData=[encryptedDictionary valueForKey:@"encryptedData"];
//   
//    //NSLog(@"encrypted data is %@",encryptedDictionary);
//    
//    //NSLog(@"encrypete data is %@",encryptedData);
//    
//    //even though it says client ID code, some users may put in a name..
//    
//    [self.boundObject setValue:encryptedData forKey:[self.objectBindings valueForKey:@"34"]];
//        //NSLog(@"encrypted data is %@",[self.objectBindings valueForKey:@"34"]);
//    
//    keyString=[encryptedDictionary valueForKey:@"keyString"];
//    
//    //NSLog(@"keyString is %@",keyString);
//    [self.boundObject setValue:keyString forKey:@"keyString"];
//    
////    //    NSData *encryptedData=(NSData *)[self convertStringToEncryptedData:clientIDCode];
////    //    NSString* newStr = [[NSString alloc] initWithData:encryptedData encoding:NSASCIIStringEncoding];
////    
////    NSData *encryptedData=[appDelegate encryptStringToEncryptedData:(NSString *)clientIDCode];
////    [self setPrimitiveValue:encryptedData forKey:@"clientIDCode"];   
//   
////    self.boundObject setValue: forKey:<#(NSString *)#>
//    
//     [super commitChanges];
//    //NSLog(@"self bound object %@",self.boundObject);
//    needsCommit=FALSE;
//    
//}



@end
