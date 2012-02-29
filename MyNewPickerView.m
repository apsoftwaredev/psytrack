//
//  MyNewPickerView.m
//  psyTrainTrack
//
//  Created by Daniel Boice on 11/13/11.
//  Copyright (c) 2011 PsycheWeb LLC. All rights reserved.
//

#import "MyNewPickerView.h"

@implementation MyNewPickerView
@synthesize view;
@synthesize picker;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super init];
    if (self) {
        // Custom initialization
        
        
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
