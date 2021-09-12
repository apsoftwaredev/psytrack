/*
 *  EncryptedSCTextFieldCell.m
 *  psyTrack Clinician Tools
 *  Version: 1.0
 *
 *
 The MIT License (MIT)
 Copyright © 2011- 2021 Daniel Boice
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
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
- (void) performInitialization
{
    [super performInitialization];

    self.textField.tag = 1;

    self.autoValidateValue = NO;
    self.textLabel.textColor = [UIColor colorWithRed:0.851 green:0.004 blue:0.157 alpha:1.0];
//    self.textLabel.text=[self.objectBindings valueForKey:@"33"];
}


- (void) loadBoundValueIntoControl
{
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
//
//
//        NSData *decryptedData=[appDelegate decryptDataToPlainDataUsingKeyEntityWithDate:keyString encryptedData:encryptedData];
//
//
//        self.clientIDCodeStr=[appDelegate convertDataToString:decryptedData];
//
////        [self.boundObject setValue:keyString forKey:@"keyString"];
//
//
//        //        textLabelStr=self.tempString;
//
//    }

    self.textField.text = [self.boundObject valueForKey:[self.objectBindings valueForKey:@"34"]];

    //    self.boundObject=self.testString;

    //    SCTableViewModel *owTableViewModel=(SCTableViewModel *)self.ownerTableViewModel;
    //
    //
    //    UINavigationItem *navigationItem=(UINavigationItem *)owTableViewModel.viewController.navigationItem;
    //
    //    navigationItem.title=self.textField.text;
    //
    //    //DLog(@"navigation bar all keys title attributes %@", owTableViewModel.viewController.navigationItem.title
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
////
//    self.clientIDCodeStr=self.textField.text;
//
//
//    NSDate *keyString=[self.boundObject valueForKey:[self.objectBindings valueForKey:@"32"]];
//
//
//
//    NSDictionary *encryptedDictionary=[appDelegate encryptStringToEncryptedData:self.clientIDCodeStr withkeyString:(NSDate*)keyString];
//
//    NSData *encryptedData=[encryptedDictionary valueForKey:@"encryptedData"];
//
//
//
//
//
//    //even though it says client ID code, some users may put in a name..
//
//    [self.boundObject setValue:encryptedData forKey:[self.objectBindings valueForKey:@"34"]];
//
//
//    keyString=[encryptedDictionary valueForKey:@"keyString"];
//
//
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
//
//    needsCommit=FALSE;
//
//}

@end
