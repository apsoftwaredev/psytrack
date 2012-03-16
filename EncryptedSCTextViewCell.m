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
    
    
//    PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
    

    self.textView.text=[self.boundObject valueForKey:[self.objectBindings valueForKey:@"34"]];
    NSString *textLabelStr=[NSString string];
    if ([objectBindings objectForKey:@"33"]) {
        textLabelStr=[self.objectBindings valueForKey:@"33"];
    }
    
    self.textLabel.text=textLabelStr;
    
    //    self.boundObject=self.testString;
    
    NSLog(@"bound object is %@",self.boundObject);

       
    
    
    }
@end
