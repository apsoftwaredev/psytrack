/*
 *  CliniciansDetailViewController_iPad.m
 *  psyTrack Clinician Tools
 *  Version: 1.5.4
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
 *  Created by Daniel Boice on 9/9/11.
 *  Copyright (c) 2011 PsycheWeb LLC. All rights reserved.
 *
 *
 *	This notice may not be removed from this file.
 *
 */
#import "CliniciansDetailViewController_iPad.h"
#import "PTTAppDelegate.h"

#import "CliniciansRootViewController_iPad.h"

@implementation CliniciansDetailViewController_iPad

@synthesize popoverController;

#pragma mark -
#pragma mark View lifecycle

- (void) viewDidLoad
{
    [super viewDidLoad];

    // Set the view controller's theme
    if ([SCUtilities systemVersion]<7) {
          self.tableViewModel.theme = [SCTheme themeWithPath:@"mapper-ipad-detail.ptt"];
    }
    else{

        [self.navigationController.navigationBar setTranslucent: YES];
        [self.navigationController.navigationBar setTintColor:[UIColor blueColor]];

        [self.navigationController.navigationBar setBarStyle:UIBarStyleDefault];
        [self.navigationController.navigationBar setBackgroundColor:[UIColor colorWithRed:0.317586 green:0.623853 blue:0.77796 alpha:1.0]];

    }


}


- (void) viewDidUnload
{
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.popoverController = nil;
}


#pragma mark -
#pragma mark Split view support

- (void) splitViewController:(UISplitViewController *)svc willHideViewController:(UIViewController *)aViewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)pc
{
    barButtonItem.title = @"Clinicians";
    self.navigationItem.leftBarButtonItem = barButtonItem;

    self.popoverController = pc;
}


// Called when the view is shown again in the split view, invalidating the button and popover controller.
- (void) splitViewController:(UISplitViewController *)svc willShowViewController:(UIViewController *)aViewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    self.navigationItem.leftBarButtonItem = nil;

    self.popoverController = nil;
}


#pragma mark -
#pragma mark Rotation support

// Ensure that the view controller supports rotation and that the split view can therefore show in both portrait and landscape.
- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}


- (void) willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval)duration
{
}


- (void) tableViewModel:(SCTableViewModel *)tableModel detailModelConfiguredForRowAtIndexPath:(NSIndexPath *)indexPath detailTableViewModel:(SCTableViewModel *)detailTableViewModel
{
    PTTAppDelegate *appDelegate = (PTTAppDelegate *)[UIApplication sharedApplication].delegate;

    CliniciansRootViewController_iPad *clinicianRootViewController_iPad = (CliniciansRootViewController_iPad *)appDelegate.clinicianViewController;

    if (clinicianRootViewController_iPad.searchBar.selectedScopeButtonIndex != 0)
    {
        [clinicianRootViewController_iPad.searchBar setSelectedScopeButtonIndex:0];
        SCArrayOfObjectsModel *arrayOfObjectsModel = (SCArrayOfObjectsModel *)clinicianRootViewController_iPad.tableViewModel;

        [arrayOfObjectsModel.dataFetchOptions setFilterPredicate:nil];

        [arrayOfObjectsModel.tableView reloadData];
    }

    self.delegate = clinicianRootViewController_iPad;
}


@end
