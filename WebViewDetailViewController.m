/*
 *  WebViewDetailViewController.m
 *  psyTrack Clinician Tools
 *  Version: 1.0
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

#import "DrugWebViewActionsViewController.h"

//#import "UICasualAlert.h"

#import "BigProgressView.h"

@implementation WebViewDetailViewController

@synthesize  popover;

@synthesize webView,toolbar, scrollView, printButton;

@synthesize message;
//
//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        // Custom initialization
//        
//        
//               
//        //Add buttons
//   
//        
//    }
//    return self;
//}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil urlString:(NSString *)documentURLString
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
      
        prog = [[BigProgressView alloc] initWithFrame:CGRectMake(0, 64, 320, 367)];


     
        // Custom initialization
        documentWebURLString=documentURLString;
//               //NSLog(@"document url top string%@",documentWebURLString);

    }
    return self;
}
-(void)dealloc{


//    pickerButton=nil;
//    
//   popover=nil;
    
    
    view=nil;
    
    fileName=nil;
    
   documentWebURLString=nil;
    documentWebURL=nil;
    
//     //NSLog(@"path to file%@", PDFDocumentOnDeviceURL.path);
    NSFileManager *fileManager=[[NSFileManager alloc]init];
    if([fileManager fileExistsAtPath:tmpPDF]) {
        
//        //NSLog(@"path to file%@", PDFDocumentOnDeviceURL.absoluteString);
        
        NSError *error=nil;
        
        if (![fileManager removeItemAtPath:tmpPDF error:&error]) {
            //NSLog(@"erroro occured %@",error);
        }
        
        
    }
   

//    PDFDocumentOnDeviceURL=nil;



}


- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	
	[prog stopAnimating];
	[webView stopLoading];
	//self.navigationItem.rightBarButtonItem.enabled = YES; // for reloading when we return
}
-(void)willMoveToParentViewController:(UIViewController *)parent{

    if (pic) {
        [pic dismissAnimated:NO];
        
    }
    if (pdfActionSheet) {
        [pdfActionSheet dismissWithClickedButtonIndex:3 animated:NO];
    }

}

//// Implement loadView to create a view hierarchy programmatically, without using a nib.
//- (void)loadView {
//	[super loadView];
//	
//	// Create our PDFScrollView and add it to the view controller.
//	
//
//}


// Comment out to draw at print time rather than hand the image off to UIKit.
// When printing single images on a page, using "direct submission" is the preferred 
// approach unless you need custom placement and scaling of the image. 
#define DIRECT_SUBMISSION 1   

// Leave this line intact to use an ALAsset object to obtain a screen-size image and use 
// that instead of the original image. Doing this allows viewing of images of a very
// large size that would otherwise be prohibitively large on most
// iOS devices.
#define USE_SCREEN_IMAGE 1

#define kToolbarHeight 48
#define kPDFViewerHeight  200
#pragma mark memory management methods

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
    //NSLog(@"didReceiveMemoryWarning message sent to PrintPhotoViewController"); 
}






#pragma mark view controller override methods

- (void)setupToolbarItems {
    
    // Only add an icon for selecting printing if printing is available on this device.
    
   
        
    
    
     UIBarButtonItem * actionButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(displayActionSheet:)];
   
    NSArray *toolbarItemsArray;
        if (UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPad) {
            UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
         
            toolbarItemsArray=[NSArray arrayWithObjects:  spaceItem, actionButton, nil];
         self.toolbar.items = toolbarItemsArray;
        }
        else {
            
            self.navigationItem.rightBarButtonItem = actionButton;
          
//           toolbarItemsArray= [NSArray arrayWithObjects:  actionButton, nil];
        }
    
   
       
   
    
   
    
    
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    CGRect toolbarFrame;
  
    [super viewDidLoad];
    
    CGRect bounds = [[UIScreen mainScreen] applicationFrame];
    
    appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate ;
    
    
    fileName=documentWebURLString.lastPathComponent;
    
    
    
    NSString *tempDirectory= NSTemporaryDirectory();
    
   tmpPDF=[tempDirectory stringByAppendingPathComponent:fileName];
    
    
     NSString *formattedComma=[NSString stringWithFormat:@"%@",@"%2C"];
    documentWebURL = [NSURL URLWithString:(NSString *)[[(NSString*)[documentWebURLString stringByAddingPercentEscapesUsingEncoding:
                                                                    NSASCIIStringEncoding] stringByReplacingOccurrencesOfString:@"," withString:formattedComma]stringByReplacingOccurrencesOfString:@"\%22" withString:@""] ];

    
    webView.contentMode = UIViewContentModeScaleAspectFit;
    webView.backgroundColor = [UIColor blackColor];
   
   
//    //NSLog(@"formatted comma is %@",[documentWebURLString stringByReplacingOccurrencesOfString:@"," withString:[NSString stringWithFormat:@"%C",0x002C ]]);
    
//    //NSLog(@"new formateted %@",[documentWebURLString stringByAddingPercentEscapesUsingEncoding:
//           NSASCIIStringEncoding]);
    
//    NSURL *targetURL = [NSURL URLWithString:(NSString *)[[(NSString*)[documentWebURLString stringByAddingPercentEscapesUsingEncoding:
//                                                         NSASCIIStringEncoding] stringByReplacingOccurrencesOfString:@"," withString:formattedComma]stringByReplacingOccurrencesOfString:@"\%22" withString:@""] ];
//    //NSLog(@"target URL string is %@",[(NSString*)[documentWebURLString stringByAddingPercentEscapesUsingEncoding:
//                                                  NSASCIIStringEncoding] stringByReplacingOccurrencesOfString:@"," withString:formattedComma]);
//    //NSLog(@"target url is %@",documentWebURL);
    
   
   

//   CGRect pdfViewerFrame = CGRectMake(10.0, 400.0, 300.0, kToolbarHeight);
//    PDFScrollView *sv = [[PDFScrollView alloc] initWithFrame:pdfViewerFrame];
//    
//	
//    [[self view] addSubview:sv];
    
    if (UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPad){
    
 
        toolbarFrame = CGRectMake(0, bounds.size.height - kToolbarHeight, bounds.size.width, kToolbarHeight);
        UIToolbar *aToolbar = [[UIToolbar alloc] initWithFrame:toolbarFrame];
        aToolbar.barStyle = UIBarStyleBlack;
         self.toolbar=aToolbar;
        [self setupToolbarItems];
        // Allow the image view to size as the orientation changes.
        aToolbar.autoresizingMask =  UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
        
        [self.view addSubview:aToolbar];

    }
    else {
         [self setupToolbarItems];
    }
    
   
    
    
    NSURLRequest *request = [NSURLRequest requestWithURL:documentWebURL];
    [webView loadRequest:request];
   
   
    
               
   
    
}



// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations; we support all.
    return YES;
}

#pragma mark target-action methods

// Invoked when the user chooses the action icon for printing.
- (void)printContent {
    
    pic = [UIPrintInteractionController sharedPrintController];
    
           
   
          NSData *myData = [NSData dataWithContentsOfFile:tmpPDF];
    if  (pic && [UIPrintInteractionController canPrintData:myData] ) {
        
         
        
        pic.delegate = self;
        
    
        
        UIPrintInfo *printInfo = [UIPrintInfo printInfo];
        
        printInfo.outputType = UIPrintInfoOutputGeneral;
        
        printInfo.jobName = [NSString stringWithString:@"Your Print Job"];
        
        printInfo.duplex = UIPrintInfoDuplexLongEdge;
        
        pic.printInfo = printInfo;
        
        pic.showsPageRange = YES;
        
       

        
        pic.printingItem =  myData;
        
        
        
        void (^completionHandler)(UIPrintInteractionController *, BOOL, NSError *) =
        
        ^(UIPrintInteractionController *pic, BOOL completed, NSError *error) {
            
           
            
//            if (!completed && error)
//                
//                //NSLog(@"FAILED! due to error in domain %@ with error code %u",
//                      
//                      error.domain, error.code);
            
        };
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            [pic presentFromBarButtonItem: self.navigationItem.rightBarButtonItem  animated:YES
             
                        completionHandler:completionHandler];
            
        } else {
            
            [pic presentAnimated:YES completionHandler:completionHandler];
            
        }
        
    }
}
- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController {
    self.popover = nil;
}

- (IBAction)displayActionSheet:(id)sender{
    
    
    if([UIPrintInteractionController isPrintingAvailable]){
        
        pdfActionSheet = [[UIActionSheet alloc] initWithTitle:@"Actions"
                                                                 delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil
                                                        otherButtonTitles:@"Email", @"Print", nil];
       
        pdfActionSheet.actionSheetStyle = UIActionSheetStyleDefault;
        pdfActionSheet.cancelButtonIndex=2;
         
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
         
            if (pic) {
                [pic dismissAnimated:YES];
            }
            [pdfActionSheet showFromBarButtonItem:self.navigationItem.rightBarButtonItem animated:YES]; 
            
        } else {
        [pdfActionSheet showFromToolbar:self.toolbar];
        }
        pdfActionSheet.tag=1;
    
    }  
    else
    {
    
       pdfActionSheet = [[UIActionSheet alloc] initWithTitle:@"Actions"
                                                                 delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil
                                                        otherButtonTitles:@"Email", nil];
       
        pdfActionSheet.actionSheetStyle = UIActionSheetStyleDefault;
        pdfActionSheet.cancelButtonIndex=1;
         [pdfActionSheet showFromToolbar:self.toolbar];
        pdfActionSheet.tag=1;
    }
    



 // show from our table view (pops up in the middle of the table)
}


#pragma mark -
#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	// the user clicked one of the OK/Cancel buttons
	
    if (pdfActionSheet.tag==1) {
 
        if (buttonIndex==0||buttonIndex==1) {
            
                   
            
            NSData *fileData=[[NSData alloc]initWithContentsOfURL:documentWebURL];
            
            
                        
            //NSLog(@"temp file name is %@",tmpPDF);
            if (![fileData writeToFile:tmpPDF atomically:YES]) {
                //NSLog(@"writeToFile error");
                
            }
            else {
                
                //NSLog(@"Written!");
            }
            

        }
        
        switch (buttonIndex) {
            
            case 1:
                [self printContent];
                break;
            case 0:
                [self displayComposerSheet];
                
                break;
            default:
                //NSLog(@"cancel actionsheet tapped");
                break;
                
        }
       
      
    }   
    
    
    if (pdfActionSheet.tag==2) {
        
    }
    
}


-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{

return self.scrollView;
}


#pragma mark -
#pragma mark Compose Mail

// Displays an email composition interface inside the application. Populates all the Mail fields. 
-(void)displayComposerSheet 
{
	MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
	picker.mailComposeDelegate = self;
	
	[picker setSubject:[NSString stringWithFormat:@"USFDA document %@",fileName]];
	
    
	// Set up recipients
//	NSArray *toRecipients = [NSArray arrayWithObject:@"dbboice@stu.argosy.edu"]; 
//		
//	[picker setToRecipients:toRecipients];
	
	// Attach an image to the email
	    NSData *myData = [NSData dataWithContentsOfFile:tmpPDF];
	
    if (myData) {
         [picker addAttachmentData:myData mimeType:@"application/pdf" fileName:fileName];
    }
   
	
	// Fill out the email body text
	
    NSString *emailBody;
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
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
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error 
{	
	message.hidden = NO;
	// Notifies users about errors associated with the interface
	

   
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
	}
	
    [self dismissModalViewControllerAnimated:YES];
    
    
//    self.message.text=resultString;
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
//    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
//    [UIView setAnimationDuration:3];
//    
//    
//    
//   
//        self.message.alpha=1;
//        
//      
//   
//    [UIView commitAnimations];
//    
//    [UIView beginAnimations:nil context:NULL];
//    [UIView setAnimationDuration:6];
//	self.message.alpha=0;
//       
//    [UIView commitAnimations];
    
//    UICasualAlert *customAlert=[[UICasualAlert alloc]init];
//     [customAlert displayRegularAlert:resultString forDuration:2.0 inView:nil];
    
    [appDelegate displayNotification:resultString forDuration:2.0 location:kPTTScreenLocationTop inView:nil];
    
}

#pragma mark webView delegate

-(void)webViewDidStartLoad:(UIWebView *)webView
{
	
		[prog startAnimatingOverView:self.webView];
	
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
	[prog stopAnimating];
	
	if (error.code==-999)  // cancelled request
	{
		return;
	}
	
	else
	{
		[appDelegate displayNotification:@"Unable to Load Document" forDuration:3.0 location:kPTTScreenLocationTop inView:nil];
	}
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
	[prog stopAnimating]; 
	
	
	
	NSString *title = [self.webView stringByEvaluatingJavaScriptFromString: @"document.title"];
	self.title = title;
}




@end
