//
//  ViewControllerTest.m
//  psyTrainTrack
//
//  Created by Daniel Boice on 2/2/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import "ViewControllerTest.h"

@interface ViewControllerTest ()

@end

@implementation ViewControllerTest

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

@end
