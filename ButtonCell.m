/*
 *  ButtonCell.m
 *  psyTrack Clinician Tools
 *  Version: 1.5.2
 *
 *
 *	THIS SOURCE CODE AND ANY ACCOMPANYING DOCUMENTATION ARE PROTECTED BY UNITED STATES
 *	INTELLECTUAL PROPERTY LAW AND INTERNATIONAL TREATIES. UNAUTHORIZED REPRODUCTION OR
 *	DISTRIBUTION IS SUBJECT TO CIVIL AND CRIMINAL PENALTIES.
 *
 *  Created by Daniel Boice on 9/5/11.
 *  Copyright (c) 2011 PsycheWeb LLC. All rights reserved.
 *
 *
 *	This notice may not be removed from this file.
 *
 */
#import "ButtonCell.h"

@implementation ButtonCell
@synthesize buttonText;
@synthesize button = button_;
// overrides superclass
- (void) performInitialization
{
    [super performInitialization];

    // place any initialization code here

    button_ = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button_.tag = 300;  // any tag here
    //If the device is an iPad then move the button over
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
    {
        button_.frame = CGRectMake(29, 5, 290, 34);
    }
    else
    {
        button_.frame = CGRectMake(20, 5, 290, 34);
    }

    [button_ setTitle:self.buttonText forState:UIControlStateNormal];

    [self.contentView addSubview:button_];
    button_.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;

    self.selectionStyle = UITableViewCellSelectionStyleNone;
}


// overrides superclass

- (id) initWithText:(NSString *)text
{
    self.buttonText = text;
    [self performInitialization];
    return self;
}


- (void) reloadBoundValue
{
    [super reloadBoundValue];

    [button_ setTitle:self.buttonText forState:UIControlStateNormal];
}


- (void) commitChanges
{
}


@end
