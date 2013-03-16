//
//  EncryptedSCSelectionCell.m
//  PsyTrack Clinician Tools
//
//  Created by Daniel Boice on 3/20/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import "EncryptedSCSelectionCell.h"

@implementation EncryptedSCSelectionCell

- (void) performInitialization
{
    [super performInitialization];

    self.tag = 1;

    self.allowMultipleSelection = NO;
    self.allowNoSelection = NO;
    self.autoDismissDetailView = YES;
    self.hideDetailViewNavigationBar = NO;
    self.textLabel.text = @"Sex";

    self.autoValidateValue = NO;
    self.textLabel.textColor = [UIColor colorWithRed:0.851 green:0.004 blue:0.157 alpha:1.0];
}


- (void) loadBoundValueIntoControl
{
    [super loadBoundValueIntoControl];

    //    PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
//    NSArray *sexSelectionArray=[NSArray arrayWithObjects:@"Male", @"Female", @"Intersexual",@"F2M",@"M2F",@"Undisclosed", nil];
//    NSArray *itemsArray=(NSArray *)self.items;
//
//    itemsArray = sexSelectionArray;

    int selectedIndexInt = -1;
    if ([self.boundObject valueForKey:[self.objectBindings valueForKey:@"34"]])
    {
        [self setSelectedItemIndex:[NSNumber numberWithInt:(int)[self.items indexOfObject:[self.boundObject valueForKey:[self.objectBindings valueForKey:@"34"]]]]];
    }

    if (![self.selectedItemIndex isEqualToNumber:[NSNumber numberWithInt:-1]])
    {
        selectedIndexInt = [self.selectedItemIndex intValue];
    }

    if ([self.selectedItemIndex intValue] < self.items.count)
    {
        self.label.text = [self.items objectAtIndex:[self.selectedItemIndex intValue]];
    }

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
    //            NSDate *keyString=[self.boundObject valueForKey:@"keyString"];
    //            NSData *primitiveData=[self.boundObject valueForKey:@"clientIDCode"];
    //
    //
    //
    //            NSData *strData=[appDelegate decryptDataToPlainDataUsingKeyEntityWithDate:keyString encryptedData:primitiveData];
    //
    //            tempStr=[appDelegate convertDataToString:strData];
    //
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
}


- (void) commitChanges
{
    if (!needsCommit)
    {
        return;
    }

    if ([self.selectedItemIndex intValue] < self.items.count)
    {
        [self.boundObject setValue:[self.items objectAtIndex:[self.selectedItemIndex intValue]] forKey:[self.objectBindings valueForKey:@"34"]];
    }

    [super commitChanges];
}


@end
