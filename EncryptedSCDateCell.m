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
    
    self.displayDatePickerInDetailView=NO;
    self.datePicker.tag=1;
    
    self.autoValidateValue=NO;
    NSDateFormatter *dateFormatterShort = [[NSDateFormatter alloc] init];
	[dateFormatterShort setDateFormat:@"MMM dd, yyyy"];
    
    self.dateFormatter=dateFormatterShort;
    
    self.datePicker.datePickerMode=UIDatePickerModeDate;
    self.textLabel.textColor=[UIColor redColor];
}

-(void)loadBoundValueIntoControl{
    
    [super loadBoundValueIntoControl];
    
   
//    PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
    
    
    
//    NSData *encryptedData=[self.boundObject valueForKey:[self.objectBindings valueForKey:@"1"]]; 
//    NSDate *keyDate=[self.boundObject valueForKey:[self.objectBindings valueForKey:@"32"]];
//    
//
//    NSLog(@"key date is %@",keyDate);
//    NSData *decryptedData=[appDelegate decryptDataToPlainDataUsingKeyEntityWithDate:keyDate encryptedData:encryptedData];
//    
//    if (decryptedData.length) {
        NSDate * restoredDate = [self.boundObject valueForKey:[self.objectBindings valueForKey:@"34"]];
    if (restoredDate) {
            NSLog(@"restored date is %@",restoredDate);
        self.datePicker.date=restoredDate;
        self.label.text =[dateFormatter stringFromDate:restoredDate];
} 

//    }
       NSString *textLabelStr=[NSString string];
    if ([self.objectBindings objectForKey:@"33"]) {
        textLabelStr=[self.objectBindings valueForKey:@"33"];
    }
    
    self.textLabel.text=textLabelStr;
    
    //    self.boundObject=self.testString;
    
    NSLog(@"bound object is %@",self.boundObject);
    
    
    
}
-(void)commitChanges{

    if (!needsCommit) {
        return;
    }

    
    [self.boundObject setValue:self.datePicker.date forKey:[objectBindings valueForKey:@"34"]];
    
    
    needsCommit=false;
}


@end
