//
//  EBPWebsitesTableViewController.m
//  PsyTrack
//
//  Created by Daniel Boice on 7/3/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import "EBPWebsitesTableViewController.h"
#import "EBPWebViewViewController.h"

@interface EBPWebsitesTableViewController ()

@end

@implementation EBPWebsitesTableViewController

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
    
    
    SCTableViewCell *apaCell=[SCTableViewCell cellWithText:@"APA Division 12 Website"];
    
    SCTableViewCell *nreppCell=[SCTableViewCell cellWithText:@"SAMHSA NREPP Website"];
    
    apaCell.cellActions.didSelect = ^(SCTableViewCell *cell, NSIndexPath *indexPath)
    {
        EBPWebViewViewController *ebpWebViewViewController=[[EBPWebViewViewController alloc]initWithNibName:@"EBPWebViewViewController" bundle:[NSBundle mainBundle] webURL:@"http://google.com"];
        
        [self.navigationController presentModalViewController:ebpWebViewViewController animated:YES];
    };
    
    nreppCell.cellActions.didSelect = ^(SCTableViewCell *cell, NSIndexPath *indexPath)
    {
        EBPWebViewViewController *ebpWebViewViewController=[[EBPWebViewViewController alloc]initWithNibName:@"EBPWebViewViewController" bundle:[NSBundle mainBundle] webURL:@"http://google.com"];
        
        [self.navigationController presentModalViewController:ebpWebViewViewController animated:YES];
    };

    
    
    SCTableViewSection *section=[SCTableViewSection sectionWithHeaderTitle:@"Evidence Based Practice Websites"];
    
    [section addCell:apaCell];
    [section addCell:nreppCell];
    
    [self.tableViewModel addSection:section];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
