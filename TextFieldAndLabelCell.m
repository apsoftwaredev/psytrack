//
//  TextFieldAndLabelCell.m
//  PsyTrack
//
//  Created by Daniel Boice on 10/20/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import "TextFieldAndLabelCell.h"

@implementation TextFieldAndLabelCell
@synthesize textField = textField_,label = label_;
-(void)performInitialization{


    if ([SCUtilities systemVersion]>=7) {
        self.backgroundView.backgroundColor=[UIColor colorWithRed:0.217586 green:0.523853 blue:0.67796 alpha:1.0];;
    }

}


- (void) loadBindingsIntoCustomControls
{
    [super loadBindingsIntoCustomControls];
    
    
    if ([label_.text isEqualToString:@"First Name:"]) {
        self.textField.text =[self.boundObject valueForKey:@"firstName"];
    }
    if ([label_.text isEqualToString:@"Middle Name:"]) {
        self.textField.text =[self.boundObject valueForKey:@"middleName"];
    }
    if ([label_.text isEqualToString:@"Last Name:"]) {
        self.textField.text =[self.boundObject valueForKey:@"lastName"];
    }
    if ([label_.text isEqualToString:@"Suffix:"]) {
        self.textField.text =[self.boundObject valueForKey:@"suffix"];
    }
}

- (void) commitChanges
{
    if (!needsCommit)
    {
        return;
    }
    
    [super commitChanges];
    
    if ([label_.text isEqualToString:@"First Name:"]) {
         [self.boundObject setValue:self.textField.text forKey:@"firstName"];
    }
    if ([label_.text isEqualToString:@"Middle Name:"]) {
        [self.boundObject setValue:self.textField.text forKey:@"middleName"];
    }
    if ([label_.text isEqualToString:@"Last Name:"]) {
        [self.boundObject setValue:self.textField.text forKey:@"lastName"];
    }
    if ([label_.text isEqualToString:@"Suffix:"]) {
        [self.boundObject setValue:self.textField.text forKey:@"suffix"];
    }
    
    
    
    needsCommit = FALSE;
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
