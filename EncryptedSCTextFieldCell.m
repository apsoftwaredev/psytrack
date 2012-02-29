//
//  EncryptedSCTextFieldCell.m
//  PsyTrack Clinician Tools
//
//  Created by Daniel Boice on 2/23/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

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
