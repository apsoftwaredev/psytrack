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
    __weak TouchyWebView *webView;

    BigProgressView *prog;

    NSURL *urlToLoadWhenAppearing;

    BOOL fullScreenViewing;
}

@property (nonatomic, weak) IBOutlet TouchyWebView *webView;
@property (nonatomic, assign) BOOL fullScreenViewing;

- (id) initWithDocumentURL:(NSURL *)url;

@end
