/*
 *  WebViewDetailViewController.m
 *  psyTrack Clinician Tools
 *  Version: 1.0.6
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
#import "WebViewDetailViewController.h"

//#import "UICasualAlert.h"

#import "BigProgressView.h"

@implementation WebViewDetailViewController

@synthesize  popover = popover_;

@synthesize webView,toolbar, scrollView, printButton;

@synthesize message;

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil urlString:(NSString *)documentURLString
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        prog = [[BigProgressView alloc] initWithFrame:CGRectMake(0, 64, 320, 367)];

        // Custom initialization
        documentWebURLString = documentURLString;
//
    }

    return self;
}


- (void) dealloc
{
    view = nil;

    fileName = nil;

    documentWebURLString = nil;
    documentWebURL = nil;

    NSFileManager *fileManager = [[NSFileManager alloc]init];
    if ([fileManager fileExistsAtPath:tmpPDF])
    {
        NSError *error = nil;

        if (![fileManager removeItemAtPath:tmpPDF error:&error])
        {
        }
    }
}


- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if (documentController)
    {
        [documentController dismissMenuAnimated:NO];
    }

    if (pdfActionSheet)
    {
        [pdfActionSheet dismissWithClickedButtonIndex:5 animated:NO];
    }

    [prog stopAnimating];
    [webView stopLoading];
}


- (void) willMoveToParentViewController:(UIViewController *)parent
{
    if (pic)
    {
        [pic dismissAnimated:NO];
    }

    if (pdfActionSheet)
    {
        [pdfActionSheet dismissWithClickedButtonIndex:3 animated:NO];
    }
}


#define DIRECT_SUBMISSION 1

// Leave this line intact to use an ALAsset object to obtain a screen-size image and use
// that instead of the original image. Doing this allows viewing of images of a very
// large size that would otherwise be prohibitively large on most
// iOS devices.
#define USE_SCREEN_IMAGE 1

#define kToolbarHeight 48
#define kPDFViewerHeight  200
#pragma mark memory management methods

#pragma mark view controller override methods

- (void) setupToolbarItems
{
    // Only add an icon for selecting printing if printing is available on this device.

    UIBarButtonItem *actionButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(displayActionSheet:)];

    NSArray *toolbarItemsArray;
    if (UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPad)
    {
        UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];

        toolbarItemsArray = [NSArray arrayWithObjects:spaceItem, actionButton, nil];
        self.toolbar.items = toolbarItemsArray;
    }
    else
    {
        self.navigationItem.rightBarButtonItem = actionButton;
    }
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void) viewDidLoad
{
    CGRect toolbarFrame;

    [super viewDidLoad];

    CGRect bounds = [[UIScreen mainScreen] applicationFrame];

    appDelegate = (PTTAppDelegate *)[UIApplication sharedApplication].delegate;

    fileName = documentWebURLString.lastPathComponent;

    NSString *tempDirectory = NSTemporaryDirectory();

    tmpPDF = [tempDirectory stringByAppendingPathComponent:fileName];

    NSString *formattedComma = [NSString stringWithFormat:@"%@",@"%2C"];
    documentWebURL = [NSURL URLWithString:(NSString *)[[(NSString *)[documentWebURLString stringByAddingPercentEscapesUsingEncoding:
                                                                     NSASCIIStringEncoding] stringByReplacingOccurrencesOfString : @"," withString : formattedComma]stringByReplacingOccurrencesOfString:@"\%22" withString:@""] ];

    webView.contentMode = UIViewContentModeScaleAspectFit;
    webView.backgroundColor = [UIColor blackColor];

    if (UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPad)
    {
        toolbarFrame = CGRectMake(0, bounds.size.height - kToolbarHeight, bounds.size.width, kToolbarHeight);
        UIToolbar *aToolbar = [[UIToolbar alloc] initWithFrame:toolbarFrame];
        aToolbar.barStyle = UIBarStyleBlack;
        self.toolbar = aToolbar;
        [self setupToolbarItems];
        // Allow the image view to size as the orientation changes.
        aToolbar.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;

        [self.view addSubview:aToolbar];
    }
    else
    {
        [self setupToolbarItems];
    }

    NSURLRequest *request = [NSURLRequest requestWithURL:documentWebURL];
    [webView loadRequest:request];
}


// Override to allow orientations other than the default portrait orientation.
- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations; we support all.
    return YES;
}


#pragma mark target-action methods

// Invoked when the user chooses the action icon for printing.
- (void) printContent
{
    pic = [UIPrintInteractionController sharedPrintController];

    NSData *myData = [NSData dataWithContentsOfFile:tmpPDF];
    if (pic && [UIPrintInteractionController canPrintData:myData] )
    {
        pic.delegate = self;

        UIPrintInfo *printInfo = [UIPrintInfo printInfo];

        printInfo.outputType = UIPrintInfoOutputGeneral;

        printInfo.jobName = @"Your Print Job";

        printInfo.duplex = UIPrintInfoDuplexLongEdge;

        pic.printInfo = printInfo;

        pic.showsPageRange = YES;

        pic.printingItem = myData;

        void (^completionHandler)(UIPrintInteractionController *, BOOL, NSError *) =

            ^(UIPrintInteractionController *pic, BOOL completed, NSError *error) {
        };

        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            [pic presentFromBarButtonItem:self.navigationItem.rightBarButtonItem animated:YES

                        completionHandler:completionHandler];
        }
        else
        {
            [pic presentAnimated:YES completionHandler:completionHandler];
        }
    }
}


- (IBAction) displayActionSheet:(id)sender
{
    if (documentController)
    {
        [documentController dismissMenuAnimated:NO];
        documentController = nil;
    }

    if (pdfActionSheet)
    {
        [pdfActionSheet dismissWithClickedButtonIndex:5 animated:YES];
        pdfActionSheet = nil;
    }

    if ([UIPrintInteractionController isPrintingAvailable])
    {
        if (!pdfActionSheet)
        {
            pdfActionSheet = [[UIActionSheet alloc] initWithTitle:@"Actions"
                                                         delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil
                                                otherButtonTitles:@"Email", @"Print",@"Open In", nil];
        }

        pdfActionSheet.actionSheetStyle = UIActionSheetStyleDefault;
        pdfActionSheet.cancelButtonIndex = 2;

        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            if (pic)
            {
                [pic dismissAnimated:YES];
            }

            [pdfActionSheet showFromBarButtonItem:self.navigationItem.rightBarButtonItem animated:YES];
        }
        else
        {
            [pdfActionSheet showFromToolbar:self.toolbar];
        }

        pdfActionSheet.tag = 1;
    }
    else
    {
        if (!pdfActionSheet)
        {
            pdfActionSheet = [[UIActionSheet alloc] initWithTitle:@"Actions"
                                                         delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil
                                                otherButtonTitles:@"Email",@"Open In", nil];
        }

        pdfActionSheet.actionSheetStyle = UIActionSheetStyleDefault;
        pdfActionSheet.cancelButtonIndex = 1;

        [pdfActionSheet showFromToolbar:self.toolbar];
        pdfActionSheet.tag = 1;
    }

    // show from our table view (pops up in the middle of the table)
}


#pragma mark -
#pragma mark - UIActionSheetDelegate

- (void) actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    // the user clicked one of the OK/Cancel buttons
    if (actionSheet.tag == 1 && buttonIndex == 5)
    {
        pdfActionSheet = nil;
        return;
    }

    if (pdfActionSheet.tag == 1)
    {
        NSData *fileData = [[NSData alloc]initWithContentsOfURL:documentWebURL];

        if (![fileData writeToFile:tmpPDF atomically:YES])
        {
            [appDelegate displayNotification:@"Error occured opening menu"];
            return;
        }
        else
        {
            switch (buttonIndex)
            {
                case 0:
                    [self displayComposerSheet];

                    break;
                case 1:
                    [self printContent];
                    break;

                case 2:
                {
                    [self openDocumentIn];
                }

                default:

                    break;
            } /* switch */
        }
    }

    pdfActionSheet = nil;
}


- (void) openDocumentIn
{
    if (!documentController)
    {
        documentController =
            [UIDocumentInteractionController interactionControllerWithURL:[NSURL fileURLWithPath:tmpPDF]];
    }

    documentController.delegate = self;

    documentController.UTI = @"com.adobe.pdf";
    if ([SCUtilities is_iPad])
    {
        [documentController presentOpenInMenuFromBarButtonItem:self.navigationItem.rightBarButtonItem animated:YES];
    }
    else
    {
        UIView *toolbarSubview = [self.toolbar.subviews objectAtIndex:0];
        [documentController presentOpenInMenuFromRect:toolbarSubview.frame inView:self.view animated:YES];
    }
}


- (void) documentInteractionControllerDidDismissOpenInMenu:(UIDocumentInteractionController *)controller
{
    documentController = nil;
}


- (UIView *) viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.scrollView;
}


#pragma mark -
#pragma mark Compose Mail

// Displays an email composition interface inside the application. Populates all the Mail fields.
- (void) displayComposerSheet
{
    MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
    picker.mailComposeDelegate = self;

    [picker setSubject:[NSString stringWithFormat:@"USFDA document %@",fileName]];

    // Attach an image to the email
    NSData *myData = [NSData dataWithContentsOfFile:tmpPDF];

    if (myData)
    {
        [picker addAttachmentData:myData mimeType:@"application/pdf" fileName:fileName];
    }

    // Fill out the email body text

    NSString *emailBody;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        emailBody = @"USFDA PDF Document sent from iPad from drug database";
    }
    else
    {
        emailBody = @"USFDA PDF Document sent from iPhone drug database";
    }

    [picker setMessageBody:emailBody isHTML:NO];

    [self presentModalViewController:picker animated:YES];
}


// Dismisses the email composition interface when users tap Cancel or Send. Proceeds to update the message field with the result of the operation.
- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    message.hidden = NO;

    NSString *resultString;
    switch (result)
    {
        case MFMailComposeResultCancelled:
            resultString = @"Email canceled";
            break;
        case MFMailComposeResultSaved:
            resultString = @"Email saved";
            break;
        case MFMailComposeResultSent:
            resultString = @"Sending Email";
            break;
        case MFMailComposeResultFailed:
            resultString = @"Email Message failed";
            break;
        default:
            resultString = @"Email Message not sent";
            break;
    } /* switch */

    [self dismissModalViewControllerAnimated:YES];

    [appDelegate displayNotification:resultString forDuration:2.0 location:kPTTScreenLocationTop inView:nil];
}


#pragma mark webView delegate

- (void) webViewDidStartLoad:(UIWebView *)webView
{
    [prog startAnimatingOverView:self.webView];
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

    NSString *title = [self.webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    self.title = title;
}


@end
