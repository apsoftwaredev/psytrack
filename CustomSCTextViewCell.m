/*
 *  CustomSCTextViewCell.m
 *  psyTrack Clinician Tools
 *  Version: 1.5.2
 *
 *
 *	THIS SOURCE CODE AND ANY ACCOMPANYING DOCUMENTATION ARE PROTECTED BY UNITED STATES
 *	INTELLECTUAL PROPERTY LAW AND INTERNATIONAL TREATIES. UNAUTHORIZED REPRODUCTION OR
 *	DISTRIBUTION IS SUBJECT TO CIVIL AND CRIMINAL PENALTIES.
 *
 *  Created by Daniel Boice on 1/6/12.
 *  Copyright (c) 2011 PsycheWeb LLC. All rights reserved.
 *
 *
 *	This notice may not be removed from this file.
 *
 */
#import "CustomSCTextViewCell.h"

@implementation CustomSCTextViewCell
@synthesize myLabel, myTextView;

- (void) performInitialization
{
    [super performInitialization];
}


- (void) loadBoundValueIntoControl
{
    [super loadBoundValueIntoControl];
    myLabel.text = [self.objectBindings valueForKey:@"label"];

    NSString *boundPropertyString = [self.objectBindings valueForKey:@"propertyNameString"];
    myTextView.text = [self.boundObject valueForKey:boundPropertyString];

    SCTextViewCell *textViewCell = [[SCTextViewCell alloc]init];

    myTextView.textColor = textViewCell.textView.textColor;
    myTextView.font = textViewCell.textView.font;

    myTextView.backgroundColor = textViewCell.backgroundColor;

    myTextView.editable = FALSE;
}


@end
