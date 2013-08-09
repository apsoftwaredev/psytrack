//
//  EBPWebViewViewController.m
//  PsyTrack
//
//  Created by Daniel Boice on 7/3/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import "EBPWebViewViewController.h"

@interface EBPWebViewViewController ()

@end

@implementation EBPWebViewViewController

@synthesize myWebView=myWebView_, url=url_;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil webURL:(NSString *)link
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.url=[NSURL URLWithString:link];
        
           }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.myWebView loadHTMLString:nil baseURL:url_];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
