//
//  DemographicReportGenerateVC.m
//  PsyTrack Clinician Tools
//  Version: 1.5.2
//
//  Created by Daniel Boice on 9/16/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import "DemographicReportGenerateVC.h"
#import "PTTAppDelegate.h"
#import "ReaderDocument.h"
#import "PDFRenderer.h"

@interface DemographicReportGenerateVC ()
- (NSString *) sanitizeFileName;
@end

@implementation DemographicReportGenerateVC

@synthesize pdfFileNameTextField,pdfPasswordTextField,generateButton;
@synthesize containerView;

- (void) viewDidLoad
{
    [super viewDidLoad];
    //    // Do any additional setup after loading the view from its nib.

    //
    //
    UIViewController *navtitle = self.navigationController.topViewController;

    self.containerView.backgroundColor = [UIColor clearColor];
    self.view.backgroundColor = [UIColor clearColor];
    navtitle.title = @"Client Demographics Report Generator";

    fileName = nil;
    fileName = [self sanitizeFileName];

    self.pdfFileNameTextField.text = fileName;

    changedDefaultFileName = NO;

    prog = [[BigProgressViewWithBlockedView alloc] initWithFrame:CGRectMake(0, 64, 320, 367) blockedView:self.view];
}


- (void) viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}


- (void) generateAndViewReportPDF
{
    PTTAppDelegate *appDelegate = (PTTAppDelegate *)[UIApplication sharedApplication].delegate;

    NSString *phrase = self.pdfPasswordTextField.text; // Document password (for unlocking most encrypted PDF files)
    fileName = [fileName stringByAppendingPathExtension:@"pdf"];
    NSString *pdfs = [appDelegate.applicationDocumentsDirectory.path stringByAppendingPathComponent:fileName];

    [NSThread detachNewThreadSelector:@selector(startAnimatingProgressInBackground) toTarget:prog withObject:prog];
    [self.view setNeedsDisplay];
    if (phrase && phrase.length == 0)
    {
        //otherwise the print button won't appear because we cannont print documents with passwords
        phrase = nil;
    }

    [PDFRenderer drawDemographicReportPDF:fileName password:phrase];

    NSString *filePath = pdfs;  // Path to last PDF file

    ReaderDocument *document = [ReaderDocument withDocumentFilePath:filePath password:phrase checkArchive:(BOOL)NO];

    if (document != nil) // Must have a valid ReaderDocument object in order to proceed with things
    {
        ReaderViewController *readerViewController = [[ReaderViewController alloc] initWithReaderDocument:document];

        readerViewController.delegate = self; // Set the ReaderViewController delegate to self

#if (DEMO_VIEW_CONTROLLER_PUSH == TRUE)
        [self.navigationController pushViewController:readerViewController animated:YES];

#else // present in a modal view controller
        readerViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        readerViewController.modalPresentationStyle = UIModalPresentationFullScreen;

        [self presentModalViewController:readerViewController animated:YES];
#endif // DEMO_VIEW_CONTROLLER_PUSH

        // Release the ReaderViewController
    }
}


- (IBAction) generateButtonTapped:(id)sender
{
    PTTAppDelegate *appDelegate = (PTTAppDelegate *)[UIApplication sharedApplication].delegate;

    fileName = pdfFileNameTextField.text;
    fileName = [self sanitizeFileName];
    NSString *pdfs = [appDelegate.applicationDocumentsDirectory.path stringByAppendingPathComponent:fileName];

    if ([self fileAlreadyExists:pdfs])
    {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:[NSString stringWithFormat:@"File %@.pdf Already Exists in the Documents Folder",fileName]  message:@"Would you like to overwrite the existing file?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Yes",@"No, incriment", nil];

        alertView.tag = 50;

        [alertView show];
    }
    else
    {
        [self generateAndViewReportPDF];
    }
}


- (void) alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 50)
    {
        switch (buttonIndex)
        {
            case 1: // overwrite
            {
                // do the delete

                [self generateAndViewReportPDF];

                break;
            }

            case 2: // increment
            {
                // do the delete

                fileName = [self incrementedFileName:fileName];
                [self generateAndViewReportPDF];
            }
            break;
        } /* switch */
    }
}


- (NSString *) sanitizeFileName
{
    NSString *scrubbed = nil;

    if (fileName && fileName.length > 3 && [[fileName substringFromIndex:fileName.length - 4]isEqualToString:@".pdf"])
    {
        fileName = [fileName substringToIndex:fileName.length - 4];
    }

    if (fileName && [fileName isKindOfClass:[NSString class]])
    {
        NSCharacterSet *invalidFsChars = [NSCharacterSet characterSetWithCharactersInString:@"/\\?%*|\"<>"];
        scrubbed = [fileName stringByTrimmingCharactersInSet:invalidFsChars];

        if (scrubbed.length > 35)
        {
            scrubbed = [scrubbed substringToIndex:34];
        }
    }

    if (!scrubbed || !scrubbed.length)
    {
        scrubbed = @"ClientDemographicReport";
        self.pdfFileNameTextField.text = scrubbed;
    }

    return scrubbed;
}


- (BOOL) fileAlreadyExists:(NSString *)fileNameGiven
{
    NSFileManager *fileManager = [[NSFileManager alloc]init];
    BOOL fileExists = [fileManager fileExistsAtPath:[fileNameGiven stringByAppendingPathExtension:@"pdf"]];

    fileManager = nil;
    return fileExists;
}


- (NSString *) incrementedFileName:(NSString *)fileNameGiven
{
    NSFileManager *fileManager = [[NSFileManager alloc]init];

    PTTAppDelegate *appDelegate = (PTTAppDelegate *)[UIApplication sharedApplication].delegate;

    NSString *documentsPath = [appDelegate applicationDocumentsDirectory].path;

    NSString *newFileName = nil;

    NSString *documentsPathWithNewFileName = nil;

    NSInteger i = 0;
    BOOL fileHasPDFExtention = NO;

    if (fileNameGiven && fileNameGiven.length > 3 && [[fileNameGiven substringFromIndex:fileNameGiven.length - 4]isEqualToString:@".pdf"])
    {
        fileHasPDFExtention = YES;
    }

    do
    {
        i++;
        if (fileNameGiven && fileHasPDFExtention)
        {
            newFileName = [[fileNameGiven substringToIndex:fileNameGiven.length - 4 ] stringByAppendingFormat:@"%i",i];
        }
        else
        {
            newFileName = [fileNameGiven stringByAppendingFormat:@"%i",i];
        }

        documentsPathWithNewFileName = [documentsPath stringByAppendingPathComponent:newFileName];
    }
    while ( [fileManager fileExistsAtPath:[documentsPathWithNewFileName stringByAppendingString:@".pdf"]]);

    fileManager = nil;

    return newFileName;
}


#pragma mark -
#pragma mark ReaderViewController Delegate Methods

- (void) readerViewDidAppear:(ReaderViewController *)viewController
{
    [prog stopAnimating];
}


- (void) dismissReaderViewController:(ReaderViewController *)viewController
{
#ifdef DEBUGX
#endif

#if (DEMO_VIEW_CONTROLLER_PUSH == TRUE)
    [self.navigationController popViewControllerAnimated:YES];

#else // dismiss the modal view controller
    [self dismissModalViewControllerAnimated:YES];
#endif // DEMO_VIEW_CONTROLLER_PUSH
}


#pragma mark -
#pragma mark UITextFieldDelegate Methods

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


- (BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    changedDefaultFileName = YES;
    return YES;
}


@end
