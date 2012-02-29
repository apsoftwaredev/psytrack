//
//  ReportsRootViewController_iPad.m
//  psyTrainTrack
//
//  Created by Daniel Boice on 11/24/11.
//  Copyright (c) 2011 PsycheWeb LLC. All rights reserved.
//

#import "ReportsRootViewController_iPad.h"
#import "PTTAppDelegate.h"
@implementation ReportsRootViewController_iPad
@synthesize reportsDetailViewController_iPad;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}



#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
     // Make the table view transparent

    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

@end
