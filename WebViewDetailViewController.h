/*
 *  WebViewDetailViewController.h
 *  psyTrack Clinician Tools
 *  Version: 1.5.3
 *
 *
 *	THIS SOURCE CODE AND ANY ACCOMPANYING DOCUMENTATION ARE PROTECTED BY UNITED STATES
 *	INTELLECTUAL PROPERTY LAW AND INTERNATIONAL TREATIES. UNAUTHORIZED REPRODUCTION OR
 *	DISTRIBUTION IS SUBJECT TO CIVIL AND CRIMINAL PENALTIES.
 *
 *  Created by Daniel Boice on   1/5/12.
 *  Copyright (c) 2011 PsycheWeb LLC. All rights reserved.
 *
 *
 *	This notice may not be removed from this file.
 *
 */
#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "PTTAppDelegate.h"

@class BigProgressView;
@interface WebViewDetailViewController : UIViewController <UIPrintInteractionControllerDelegate, /*UIAlertViewDelegate,		// for UIAlertView*/
                                                           UIActionSheetDelegate, UIScrollViewDelegate, UIPopoverControllerDelegate, MFMailComposeViewControllerDelegate,UIDocumentInteractionControllerDelegate, UIWebViewDelegate> {
    UIToolbar *toolbar;
    UIBarButtonItem *printButton;

    UIPopoverController *popover_;

    UIWebView *webView;
    BigProgressView *prog;

    UIView *view;

    IBOutlet UILabel *message;
    NSString *fileName;

    NSString *documentWebURLString;
    NSURL *documentWebURL;

    NSString *tmpPDF;

    UIPrintInteractionController *pic;
    UIActionSheet *pdfActionSheet;
    PTTAppDelegate *appDelegate;
    UIDocumentInteractionController *documentController;
}

@property (strong, nonatomic) UIToolbar *toolbar;
@property (strong, nonatomic) UIBarButtonItem *printButton;
@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) UIPopoverController *popover;
@property (nonatomic, strong) IBOutlet UILabel *message;
@property (nonatomic, strong) IBOutlet UIWebView *webView;

- (void) printContent;

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil urlString:(NSString *)documentURLString;

- (void) displayComposerSheet;

@end
