//
//  AboutAppDelegate.m
//  About
//
//  Created by Oliver Drobnik on 2/13/10.
//  Copyright Drobnik.com 2010. All rights reserved.
//

#import "AboutAppDelegate.h"
#import "RootViewController.h"


@implementation AboutAppDelegate

@synthesize window;
@synthesize navigationController;


#pragma mark -
#pragma mark Application lifecycle

- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
    // Override point for customization after app launch    
	
	[window addSubview:[navigationController view]];
    [window makeKeyAndVisible];
	
	navigationController.navigationBar.barStyle = UIBarStyleBlack;
}


- (void)applicationWillTerminate:(UIApplication *)application {
	// Save data if appropriate
}


#pragma mark -
#pragma mark Memory management

- (void)dealloc {
	[navigationController release];
	[window release];
	[super dealloc];
}


@end

