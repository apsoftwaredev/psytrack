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


-(void)performInitialization{
    
    [super performInitialization];
    
    
    self.textView.tag=1;
    
    self.autoValidateValue=NO;
}

-(void)loadBoundValueIntoControl{
    
    [super loadBoundValueIntoControl];
    
    
    PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
    

    
    NSData *encryptedData=[self.boundObject valueForKey:[self.objectBindings valueForKey:@"1"]]; 
    NSDate *keyDate=[self.boundObject valueForKey:[self.objectBindings valueForKey:@"32"]];
    
    NSLog(@"key date is %@",keyDate);
    NSData *decryptedData=[appDelegate decryptDataToPlainDataUsingKeyEntityWithDate:keyDate encryptedData:encryptedData];
    
    self.textView.text=[appDelegate convertDataToString:decryptedData];
    
    NSMutableString *textLabelStr=[NSMutableString string];
    if ([self.objectBindings objectForKey:@"33"]) {
        textLabelStr=[self.objectBindings valueForKey:@"33"];
    }
    
    self.textLabel.text=textLabelStr;
    
    //    self.boundObject=self.testString;
    
    NSLog(@"bound object is %@",self.boundObject);
    
    
    
    }
@end
