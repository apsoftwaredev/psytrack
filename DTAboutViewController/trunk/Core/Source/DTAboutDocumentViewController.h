//
//  DTAboutDocumentViewController.h
//
//  Created by Oliver on 03.09.09.
//  Copyright 2009 Drobnik.com. All rights reserved.
//

#import "TouchyWebView.h"

@class BigProgressView, TouchyWebView;

@interface DTAboutDocumentViewController : UIViewController <TouchyDelegate>
{
    TouchyWebView *webView;

    BigProgressView *prog;

    NSURL *urlToLoadWhenAppearing;

    BOOL fullScreenViewing;
}

@property (nonatomic, retain) IBOutlet TouchyWebView *webView;
@property (nonatomic, assign) BOOL fullScreenViewing;

- (id) initWithDocumentURL:(NSURL *)url;

@end
