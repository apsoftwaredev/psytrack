//
//  TimePickerView.m
//  psyTrainTrack
//
//  Created by Daniel Boice on 10/23/11.
//  Copyright (c) 2011 PsycheWeb LLC. All rights reserved.
//

#import "TimePickerView.h"

@implementation TimePickerView
@synthesize picker;
@synthesize hourLabel, minLabel;
@synthesize view;



- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
        
       
        
//        [self.view setBackgroundColor:[UIColor viewFlipsideBackgroundColor]];
//        [self.view addSubview:hourLabel];
//        [self.view addSubview:minLabel];
//        [self.view addSubview:picker];

    }
    return self;
}



#pragma mark - View lifecycle

/*
 // Implement loadView to create a view hierarchy programmatically, without using a nib.
 - (void)loadView
 {
 }
 */

/*
 // Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
 - (void)viewDidLoad
 {
 [super viewDidLoad];
 }
 */



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}


@end




