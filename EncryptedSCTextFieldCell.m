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
#import "SCTableViewModel.h"


@implementation EncryptedSCTextFieldCell

-(void)performInitialization{

    [super performInitialization];


    self.textField.tag=1;
    appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
    self.autoValidateValue=NO;
}




-(void)loadBoundValueIntoControl{

    [super loadBoundValueIntoControl];

    
    
 
    NSData *encryptedData=[self.boundObject valueForKey:[self.objectBindings valueForKey:@"1"]]; 
    
    NSData *decryptedData=[appDelegate decryptDataToPlainData:encryptedData];
    self.textField.text=[appDelegate convertDataToString:decryptedData];
    

    self.textLabel.text=@"Client ID Code";

//    self.boundObject=self.testString;
    
    NSLog(@"bound object is %@",self.boundObject);
    
    SCTableViewModel *owTableViewModel=(SCTableViewModel *)self.ownerTableViewModel;
  
    
    UINavigationItem *navigationItem=(UINavigationItem *)owTableViewModel.viewController.navigationItem;
    
    navigationItem.title=self.textField.text;
    
    NSLog(@"navigation bar all keys title attributes %@", owTableViewModel.viewController.navigationItem.title
);     
    

}



-(void)loadBindingsIntoCustomControls{

//    [self.boundObject setValue:@"test" forKey:@"clientIDCode"];
    [super loadBindingsIntoCustomControls];
    


}



// overrides superclass
- (void)commitChanges
{
	if(!self.needsCommit)
		return;
    
    
    
    
    
//    NSString *plaintext=self.textField.text;
//    
//    NSData *encryptedData=[appDelegate encryptStringToEncryptedData:plaintext];
//    
//    //even though it says client ID code, some users may put in a name..
//    
//    [self.boundObject setValue:encryptedData forKey:@"clientIDCode"];
//        
    
    
//    //    NSData *encryptedData=(NSData *)[self convertStringToEncryptedData:clientIDCode];
//    //    NSString* newStr = [[NSString alloc] initWithData:encryptedData encoding:NSASCIIStringEncoding];
//    
//    NSData *encryptedData=[appDelegate encryptStringToEncryptedData:(NSString *)clientIDCode];
//    [self setPrimitiveValue:encryptedData forKey:@"clientIDCode"];   
   
//    self.boundObject setValue: forKey:<#(NSString *)#>
    
    [super commitChanges];
    
    needsCommit=FALSE;
    
}

-(void)willChangeValueForKey:(NSString *)key
{

NSLog(@"will change value for key%@", key);

}

@end
