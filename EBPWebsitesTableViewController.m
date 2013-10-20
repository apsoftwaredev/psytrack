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
    
    
    NSString *nibName=nil;
    if ([SCUtilities is_iPad]) {
        nibName=@"EBPWebViewViewController";
    }
    else
    {
        nibName=@"EBPWebViewViewController_iPhone";

    }
    apaCell.cellActions.didSelect = ^(SCTableViewCell *cell, NSIndexPath *indexPath)
    {
        EBPWebViewViewController *ebpWebViewViewController=[[EBPWebViewViewController alloc]initWithNibName:nibName bundle:[NSBundle mainBundle] webURL:@"http://www.psychologicaltreatments.org"];
        
        [self.navigationController pushViewController:ebpWebViewViewController animated:YES ];
    };
    
    nreppCell.cellActions.didSelect = ^(SCTableViewCell *cell, NSIndexPath *indexPath)
    {
        EBPWebViewViewController *ebpWebViewViewController=[[EBPWebViewViewController alloc]initWithNibName:nibName bundle:[NSBundle mainBundle] webURL:@"http://www.nrepp.samhsa.gov/ViewAll.aspx"];
        
        
        [self.navigationController pushViewController:ebpWebViewViewController animated:YES ];
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
