//
//  ClientsDetailViewController_iPad.m
//  psyTrainTrack
//
//  Created by Daniel Boice on 9/24/11.
//  Copyright (c) 2011 PsycheWeb LLC. All rights reserved.
//

#import "ClientsRootViewController_iPad.h"
#import "ClientsDetailViewController_iPad.h"

#import "PTTAppDelegate.h"


@interface ClientsDetailViewController_iPad ()

@property (nonatomic, strong) UIPopoverController *popoverController;

- (void)addButtonTapped;

@end



@implementation ClientsDetailViewController_iPad

@synthesize addButtonItem;

@synthesize popoverController;
@synthesize clientsRootViewController_iPad=__clientsRootViewController_iPad;

#pragma mark -
#pragma mark Private Methods

- (void)addButtonTapped
{
	[self.clientsRootViewController_iPad addButtonTapped];
}

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    
    //create an add button
    UIBarButtonItem *_addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addButtonTapped)];
	
    //set the add button outlet defined in the header to item to the created add button
    self.addButtonItem = _addButton;
    
    //set the right navigation bar button item to the defined add button
    self.navigationItem.rightBarButtonItem=self.addButtonItem;
    
    
    [self.tableView setBackgroundView:nil];
    [self.tableView setBackgroundView:[[UIView alloc] init]];
    [self.tableView setBackgroundColor:UIColor.clearColor]; // Make the table view transparent
    
}

- (void)viewDidUnload {
	
    [super viewDidUnload];
    // Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
	self.popoverController = nil;
}




#pragma mark -
#pragma mark Split view support

- (void)splitViewController: (UISplitViewController*)svc willHideViewController:(UIViewController *)aViewController withBarButtonItem:(UIBarButtonItem*)barButtonItem forPopoverController: (UIPopoverController*)pc {
    
    barButtonItem.title = @"Clients";
    self.navigationItem.leftBarButtonItem = barButtonItem;
	
    self.popoverController = pc;
    
}


// Called when the view is shown again in the split view, invalidating the button and popover controller.
- (void)splitViewController: (UISplitViewController*)svc willShowViewController:(UIViewController *)aViewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem {
    
	self.navigationItem.leftBarButtonItem = nil;
	
	self.popoverController = nil;
}


#pragma mark -
#pragma mark Rotation support

// Ensure that the view controller supports rotation and that the split view can therefore show in both portrait and landscape.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}


- (void) didReceiveMemoryWarning 
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
    PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
    
    
    
    
    [appDelegate displayMemoryWarning];
 
    
    
}


@end

