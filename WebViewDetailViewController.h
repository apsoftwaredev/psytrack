//
//  WebViewDetailViewController.h
//  psyTrainTrack
//
//  Created by Daniel Boice on 1/5/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "PTTAppDelegate.h"

@class BigProgressView;
@interface WebViewDetailViewController : UIViewController <UIPrintInteractionControllerDelegate ,/*UIAlertViewDelegate,		// for UIAlertView*/
UIActionSheetDelegate, UIScrollViewDelegate, UIPopoverControllerDelegate, MFMailComposeViewControllerDelegate,UIWebViewDelegate> {
    UIToolbar	  *toolbar;
    UIBarButtonItem *printButton;
//    UIBarButtonItem *pickerButton;
  
    UIPopoverController *popover;
    
    UIWebView *webView;
   BigProgressView *prog;
   
    UIView *view;

    IBOutlet UILabel *message;
    NSString *fileName;
    
    NSString *documentWebURLString;
    NSURL *documentWebURL;
 
    NSString *tmpPDF;
//    NSURL * PDFDocumentOnDeviceURL;
    UIPrintInteractionController *pic;
    UIActionSheet *pdfActionSheet;
    PTTAppDelegate *appDelegate;

}



@property (strong, readwrite) UIToolbar	      *toolbar;
@property (strong, readwrite) UIBarButtonItem *printButton;

@property (retain, strong) IBOutlet UIScrollView *scrollView;
@property (retain, readwrite) UIPopoverController *popover;
 @property (nonatomic, strong) IBOutlet UILabel *message;
- (void)printContent ;



@property (nonatomic, strong) IBOutlet UIWebView *webView;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil urlString:(NSString *)documentURLString;

//-(IBAction)showPicker:(id)sender;
-(void)displayComposerSheet;
//-(void)launchMailAppOnDevice;

@end
