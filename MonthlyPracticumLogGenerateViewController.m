//
//  MonthlyPracticumLogGenerateViewController.m
//  PsyTrack
//
//  Created by Daniel Boice on 7/17/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import "MonthlyPracticumLogGenerateViewController.h"
#import "PTTAppDelegate.h"
#import "ReaderDocument.h"
#import "PDFRenderer.h"

@interface MonthlyPracticumLogGenerateViewController ()
-(NSString *)sanitizeFileName:(NSString *)fileName;
@end

@implementation MonthlyPracticumLogGenerateViewController
@synthesize pdfFileNameTextField,pdfPasswordTextField,amendedLogSwitch,generateButton,trainingProgramTableView=trainingProgramTableView_;
@synthesize scrollView,containerView,monthTextField,pickerView;


- (void)viewDidLoad
{
    [super viewDidLoad];
//    // Do any additional setup after loading the view from its nib.
    PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
//    
//
     UIViewController *navtitle=self.navigationController.topViewController;
    if ([SCUtilities is_iPad]) {
        
        
        [self.trainingProgramTableView setBackgroundView:nil];
        UIView *view=[[UIView alloc]init];
        [self.trainingProgramTableView setBackgroundView:view];
    }
    
    [self.tableView setBackgroundColor:[UIColor clearColor]];
    self.containerView.backgroundColor=[UIColor clearColor];
    self.view.backgroundColor=[UIColor clearColor];
    navtitle.title=@"Monthly Practicum Log Generator";
    
    SCEntityDefinition *programDef=[SCEntityDefinition definitionWithEntityName:@"TrainingProgramEntity" managedObjectContext:appDelegate.managedObjectContext autoGeneratePropertyDefinitions:YES];
    
    programDef.titlePropertyName=@"trainingProgram";
    objectsModel=[[SCArrayOfObjectsModel_UseSelectionSection alloc]initWithTableView:self.trainingProgramTableView entityDefinition:programDef];
    
    
    
    objectsModel.enablePullToRefresh = TRUE;
    objectsModel.pullToRefreshView.arrowImageView.image = [UIImage imageNamed:@"blueArrow.png"];
    
    

    
    
    self.tableViewModel=objectsModel;
    
    
     prog = [[BigProgressView alloc] initWithFrame:CGRectMake(0, 64, 320, 367)];
    
    
//    scrollView.contentSize=containerView.frame.size;
//    scrollView.pagingEnabled = NO;
//    CGRect pikerViewFrame=CGRectMake(0, self.view.frame.size.height-self.pickerView.frame.size.height, self.view.frame.size.width, self.pickerView.frame.size.height);
//    self.pickerView.frame=pikerViewFrame;
    self.monthTextField.inputView=self.pickerView;
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}


-(IBAction)generateButtonTapped:(id)sender{

    PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
    
    [prog startAnimatingOverView:self.view];
	NSString *phrase = nil; // Document password (for unlocking most encrypted PDF files)
    NSString *fileName=[[self sanitizeFileName:pdfFileNameTextField.text] stringByAppendingPathExtension:@"pdf"];
	NSString *pdfs = [appDelegate.applicationDocumentsDirectory.path stringByAppendingPathComponent:fileName];
    NSLog(@"pdfs %@",pdfs);
    [PDFRenderer drawPDF:fileName];
    
	NSString *filePath = pdfs  ;// Path to last PDF file
    
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
-(void)textFieldDidBeginEditing:(UITextField *)textField{

   

}

-(NSString *)sanitizeFileName:(NSString *)fileName{
    NSString *scrubbed =nil;
    
    if (fileName && [fileName isKindOfClass:[NSString class]]) {
        NSCharacterSet *invalidFsChars = [NSCharacterSet characterSetWithCharactersInString:@"/\\?%*|\"<>"];
        scrubbed = [fileName stringByTrimmingCharactersInSet:invalidFsChars];
        
        if (scrubbed.length>20) {
                
            scrubbed=[scrubbed substringToIndex:19];
        }
        
    }
   
    if (!scrubbed ||!scrubbed.length) {
        int practicumLogNumber=[[[NSUserDefaults standardUserDefaults]valueForKey:kPTMonthlyPracticumLogNumber]intValue];
        scrubbed=[NSString stringWithFormat:@"monthlyPracticumLog%i",practicumLogNumber];
    }

    return scrubbed;

}

#pragma mark -
#pragma mark ReaderViewController Delegate Methods

-(void)readerViewDidAppear:(ReaderViewController *)viewController{


    [prog stopAnimating];

}

- (void)dismissReaderViewController:(ReaderViewController *)viewController
{
#ifdef DEBUGX
	NSLog(@"%s", __FUNCTION__);
#endif
    
#if (DEMO_VIEW_CONTROLLER_PUSH == TRUE)
    
	[self.navigationController popViewControllerAnimated:YES];
    
#else // dismiss the modal view controller
    
	[self dismissModalViewControllerAnimated:YES];
    
#endif // DEMO_VIEW_CONTROLLER_PUSH
}

#pragma mark -
#pragma mark UITextFieldDelegate Methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
@end
