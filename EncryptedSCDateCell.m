//
//  EncryptedSCDateCell.m
//  PsyTrack Clinician Tools
//
//  Created by Daniel Boice on 3/12/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import "EncryptedSCDateCell.h"
#import "PTTAppDelegate.h"


@implementation EncryptedSCDateCell

-(void)performInitialization{
    
    [super performInitialization];
    
    
    self.datePicker.tag=1;
    
    self.autoValidateValue=NO;
}

-(void)loadBoundValueIntoControl{
    
    [super loadBoundValueIntoControl];
    
    
    PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
    
    
    
    NSData *encryptedData=[self.boundObject valueForKey:[self.objectBindings valueForKey:@"1"]]; 
    NSDate *keyDate=[self.boundObject valueForKey:[self.objectBindings valueForKey:@"32"]];
    
    NSLog(@"key date is %@",keyDate);
    NSData *decryptedData=[appDelegate decryptDataToPlainDataUsingKeyEntityWithDate:keyDate encryptedData:encryptedData];
    NSDate * restoredDate = [NSKeyedUnarchiver unarchiveObjectWithData:decryptedData];
    
    
    self.datePicker.date=restoredDate;
    
    NSMutableString *textLabelStr=[NSMutableString string];
    if ([self.objectBindings objectForKey:@"33"]) {
        textLabelStr=[self.objectBindings valueForKey:@"33"];
    }
    
    self.textLabel.text=textLabelStr;
    
    //    self.boundObject=self.testString;
    
    NSLog(@"bound object is %@",self.boundObject);
    
    
    
}


@end
