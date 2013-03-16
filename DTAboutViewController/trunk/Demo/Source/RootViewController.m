//
//  RootViewController.m
//  About
//
//  Created by Oliver Drobnik on 2/13/10.
//  Copyright Drobnik.com 2010. All rights reserved.
//

#import "RootViewController.h"
#import "DTAboutViewController.h"

#import "NSString+Helpers.h"

@implementation RootViewController

- (void) viewDidLoad
{
    [super viewDidLoad];

    self.title = @"Settings";
}


#pragma mark Table view methods

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}


- (NSString *) tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    return [@"© 2010 Drobnik.com. $CFBundleDisplayName $CFBundleVersion" stringBySubstitutingInfoTokens];
}


// Customize the appearance of table view cells.
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }

    // Configure the cell.

    switch (indexPath.row)
    {
        case 0:
            cell.textLabel.text = @"Support";
            break;
        case 1:
            cell.textLabel.text = @"About";
            break;
    }

    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}


// Override to support row selection in the table view.
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row)
    {
        case 0:
        {
            DTLayoutDefinition *supportLayout = [DTLayoutDefinition layoutNamed:@"support"];
            DTAboutViewController *support = [[DTAboutViewController alloc] initWithLayout:supportLayout];
            support.title = @"Support";
            [self.navigationController pushViewController:support animated:YES];
            [support release];

            break;
        }
        case 1:
        {
            DTAboutViewController *about = [[DTAboutViewController alloc] initWithLayout:nil];             // default is @"about"
            about.title = @"About";
            about.delegate = self;
            [self.navigationController pushViewController:about animated:YES];
            [about release];

            break;
        }
    } /* switch */
}


- (void) dealloc
{
    [super dealloc];
}


#pragma mark DTAboutViewController Delegate
- (void) aboutViewController:(DTAboutViewController *)aboutViewController performCustomAction:(NSString *)action withObject:(id)object
{
    // demonstrate responding to an action that the controller does not know how to perform
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.youtube.com/watch?v=xnq-_tJtaBU"]];
}


- (UIView *) aboutViewController:(DTAboutViewController *)aboutViewController customViewForDictionary:(NSDictionary *)dictionary
{
    return nil;
}


- (void) aboutViewController:(DTAboutViewController *)aboutViewController didSetupLabel:(UILabel *)label forTextStyle:(NSUInteger)style
{
    // demonstrate different text color on labels
    label.textColor = [UIColor darkGrayColor];
}


@end
