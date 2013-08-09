//
//  EBPWebViewViewController.h
//  PsyTrack
//
//  Created by Daniel Boice on 7/3/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <SensibleTableView/SensibleTableView.h>

@interface EBPWebViewViewController : SCViewController
{

    __weak UIWebView *myWebView_;
    NSURL *url_;
    
}
@property (nonatomic, weak)IBOutlet UIWebView *myWebView;
@property (nonatomic, strong)NSURL *url;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil webURL:(NSString *)link;


@end
