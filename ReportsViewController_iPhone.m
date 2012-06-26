/*
 *  ReportsViewController_iPhone.m
 *  psyTrack Clinician Tools
 *  Version: 1.0
 *
 *
 *	THIS SOURCE CODE AND ANY ACCOMPANYING DOCUMENTATION ARE PROTECTED BY UNITED STATES 
 *	INTELLECTUAL PROPERTY LAW AND INTERNATIONAL TREATIES. UNAUTHORIZED REPRODUCTION OR 
 *	DISTRIBUTION IS SUBJECT TO CIVIL AND CRIMINAL PENALTIES. 
 *
 *  Created by Daniel Boice on 11/24/11.
 *  Copyright (c) 2011 PsycheWeb LLC. All rights reserved.
 *
 *
 *	This notice may not be removed from this file.
 *
 */
#import "ReportsViewController_iPhone.h"
#import "PTTAppDelegate.h"
#import "CoreText/CoreText.h"
#import "PDFRenderer.h"

@implementation ReportsViewController_iPhone

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) didReceiveMemoryWarning 
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
    PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
    
    
   [appDelegate displayMemoryWarning];

    
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    NSString* fileName = [self getPDFFileName];
    
//    [PDFRenderer drawPDF:fileName];
    
    
    [self showPDFFile];
    
     
    
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

-(void)showPDFFile
{
    NSString* pdfFileName = [self getPDFFileName];
    CGRect frame;
    if ([SCUtilities is_iPad]) {
        frame=CGRectMake(0, 0, 640, 1004);
    }
    else {
        frame=CGRectMake(0, 0, 320, 480);
    }
    UIWebView* webView = [[UIWebView alloc] initWithFrame:frame];
    
    NSURL *url = [NSURL fileURLWithPath:pdfFileName];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView setScalesPageToFit:YES];
    [webView loadRequest:request];
    
    
    
    [self.view addSubview:webView];
    
}

-(NSString*)getPDFFileName
{
//    NSString* fileName = @"monthlyPracticumLog.pdf";
//    
//    NSArray *arrayPaths = 
//    NSSearchPathForDirectoriesInDomains(
//                                        NSDocumentDirectory,
//                                        NSUserDomainMask,
//                                        YES);
//    NSString *path = [arrayPaths objectAtIndex:0];
//    NSString* pdfFileName = [path stringByAppendingPathComponent:fileName];
//    
    
    NSString *resourceString=[[NSBundle mainBundle] pathForResource:@"may2012" ofType:@"htm"];
    
    return resourceString;
    
}


@end
