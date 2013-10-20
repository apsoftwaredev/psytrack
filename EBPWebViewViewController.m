//
//  EBPWebViewViewController.m
//  PsyTrack
//
//  Created by Daniel Boice on 7/3/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import "EBPWebViewViewController.h"
#import "BigProgressViewWithBlockedView.h"


@interface EBPWebViewViewController ()

@end

@implementation EBPWebViewViewController

@synthesize myWebView=myWebView_, url=url_, scrollView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil webURL:(NSString *)link
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.url=[NSURL URLWithString:link];
           prog = [[BigProgressViewWithBlockedView alloc] initWithFrame:CGRectMake(0, 64, 320, 367) blockedView:self.view];
        
        appDelegate = (PTTAppDelegate *)[UIApplication sharedApplication].delegate;
        [self.myWebView setDelegate:self];
        
           }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    myWebView_.contentMode = UIViewContentModeScaleAspectFit;
    myWebView_.backgroundColor = [UIColor blackColor];

    NSURLRequest *request = [NSURLRequest requestWithURL:url_];
    [myWebView_ loadRequest:request];
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
       
    [prog stopAnimating];
    [myWebView_ stopLoading];
}


#pragma mark webView delegate

- (void) webViewDidStartLoad:(UIWebView *)webView
{
    [prog startAnimatingOverView:self.myWebView];
}


- (void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [prog stopAnimating];
    
    if (error.code == -999)    // cancelled request
    {
        return;
    }
    else
    {
        [appDelegate displayNotification:@"Unable to Load Document" forDuration:3.0 location:kPTTScreenLocationTop inView:nil];
    }
}


- (void) webViewDidFinishLoad:(UIWebView *)webView
{
    [prog stopAnimating];
    
}

@end
