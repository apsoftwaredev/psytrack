//
//  EBPWebViewViewController.h
//  PsyTrack
//
//  Created by Daniel Boice on 7/3/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//
#import "PTTAppDelegate.h"

@class BigProgressViewWithBlockedView;
@interface EBPWebViewViewController : SCViewController <UIWebViewDelegate>
{

    __weak UIWebView *myWebView_;
    NSURL *url_;
    BigProgressViewWithBlockedView *prog;
    PTTAppDelegate *appDelegate;

}
@property (nonatomic, weak)IBOutlet UIWebView *myWebView;
@property (nonatomic, strong)NSURL *url;
@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil webURL:(NSString *)link;


@end
