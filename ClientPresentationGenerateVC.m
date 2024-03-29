//
//  ClientPresentationGenerateVC.m
//  PsyTrack Clinician Tools
//  Version: 1.5.4
//
//  Created by Daniel Boice on 11/13/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import "ClientPresentationGenerateVC.h"
#import "PTTAppDelegate.h"
#import "ReaderDocument.h"
#import "PDFGenerator.h"
#import "ClinicianEntity.h"
#import "AssessmentTypeEntity.h"
#import "ServiceCodeEntity.h"
#import "InterventionTypeEntity.h"
#import "InterventionTypeSubtypeEntity.h"
#import "SupportActivityTypeEntity.h"

@interface ClientPresentationGenerateVC ()
- (NSString *) sanitizeFileName;
@end

@implementation ClientPresentationGenerateVC

@synthesize pdfFileNameTextField,pdfPasswordTextField,generateButton;
@synthesize containerView;
@synthesize presentationTableModel;
@synthesize serviceDate;
@synthesize totalTime, timeInDate,timeOutDate;
@synthesize serviceDateTimeString;
- (void) viewDidLoad
{
    [super viewDidLoad];

    UIViewController *navtitle = self.navigationController.topViewController;

    self.containerView.backgroundColor = [UIColor clearColor];
    self.view.backgroundColor = [UIColor clearColor];
    navtitle.title = @"Client Interaction Report Generator";

    fileName = nil;
    fileName = [self sanitizeFileName];

    self.pdfFileNameTextField.text = fileName;

    changedDefaultFileName = NO;

    self.view.backgroundColor = [UIColor clearColor];

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

    PDFGenerator *pdfGenerator = [[PDFGenerator alloc]init];

    NSString *trackText = nil;
    NSString *reportTitle = nil;
    BOOL isSupportActivity = NO;

    switch (self.timeTrackControllerSetup)
    {
        case kTimeTrackAssessmentSetup:
        {
            reportTitle = @"Client Interaction Process Notes\n";
            if (self.firstDetailTableModel && self.firstDetailTableModel.sectionCount > 2)
            {
                SCTableViewSection *sectionThree = (SCTableViewSection *)[self.firstDetailTableModel sectionAtIndex:2];
                SCTableViewCell *cellOne = (SCTableViewCell *)[sectionThree cellAtIndex:0];

                if ([cellOne isKindOfClass:[SCObjectSelectionCell class]])
                {
                    SCObjectSelectionCell *objectSelectionCell = (SCObjectSelectionCell *)cellOne;

                    if (![objectSelectionCell.selectedItemIndex isEqualToNumber:[NSNumber numberWithInteger:-1]])
                    {
                        NSManagedObject *selectedObject = (NSManagedObject *)[objectSelectionCell.items objectAtIndex:[objectSelectionCell.selectedItemIndex integerValue]];

                        if ([selectedObject isKindOfClass:[AssessmentTypeEntity class]])
                        {
                            AssessmentTypeEntity *assessmentTypeObject = (AssessmentTypeEntity *)selectedObject;

                            [assessmentTypeObject willAccessValueForKey:@"assessmentType"];
                            if (assessmentTypeObject.assessmentType && assessmentTypeObject.assessmentType.length)
                            {
                                trackText = [NSString stringWithFormat:@"Assessment Type: %@ \n",assessmentTypeObject.assessmentType];
                            }
                        }
                    }
                }

                SCTableViewCell *cellFour = (SCTableViewCell *)[sectionThree cellAtIndex:3];

                if ([cellFour isKindOfClass:[SCObjectSelectionCell class]])
                {
                    SCObjectSelectionCell *objectSelectionCell = (SCObjectSelectionCell *)cellFour;

                    if (![objectSelectionCell.selectedItemIndex isEqualToNumber:[NSNumber numberWithInteger:-1]])
                    {
                        NSManagedObject *selectedObject = (NSManagedObject *)[objectSelectionCell.items objectAtIndex:[objectSelectionCell.selectedItemIndex integerValue]];

                        if ([selectedObject isKindOfClass:[ServiceCodeEntity class]])
                        {
                            ServiceCodeEntity *serviceCodeObject = (ServiceCodeEntity *)selectedObject;

                            [serviceCodeObject willAccessValueForKey:@"code"];
                            if (serviceCodeObject.code && serviceCodeObject.code.length)
                            {
                                if (!trackText)
                                {
                                    trackText = [NSString stringWithFormat:@"Service Code: %@",serviceCodeObject.code];
                                }
                                else
                                {
                                    trackText = [trackText stringByAppendingFormat:@"Service Code: %@",serviceCodeObject.code];
                                }
                            }

                            [serviceCodeObject willAccessValueForKey:@"name"];
                            if (serviceCodeObject.name && serviceCodeObject.name.length)
                            {
                                trackText = [trackText stringByAppendingFormat:@" - %@",serviceCodeObject.name];
                            }
                        }
                    }
                }
            }
        }
        break;
        case kTimeTrackInterventionSetup:

        {
            reportTitle = @"Client Interaction Process Notes\n";
            if (self.firstDetailTableModel && self.firstDetailTableModel.sectionCount > 2)
            {
                SCTableViewSection *sectionThree = (SCTableViewSection *)[self.firstDetailTableModel sectionAtIndex:2];
                SCTableViewCell *cellThree = (SCTableViewCell *)[sectionThree cellAtIndex:3];
                if ([cellThree isKindOfClass:[SCObjectSelectionCell class]])
                {
                    SCObjectSelectionCell *objectSelectionCell = (SCObjectSelectionCell *)cellThree;

                    if (![objectSelectionCell.selectedItemIndex isEqualToNumber:[NSNumber numberWithInteger:-1]])
                    {
                        NSManagedObject *selectedObject = (NSManagedObject *)[objectSelectionCell.items objectAtIndex:[objectSelectionCell.selectedItemIndex integerValue]];

                        if ([selectedObject isKindOfClass:[InterventionTypeEntity class]])
                        {
                            InterventionTypeEntity *interventionTypeObject = (InterventionTypeEntity *)selectedObject;

                            [interventionTypeObject willAccessValueForKey:@"interventionType"];
                            if (interventionTypeObject.interventionType && interventionTypeObject.interventionType.length)
                            {
                                trackText = [NSString stringWithFormat:@"Intervention Type: %@ ; ",interventionTypeObject.interventionType];
                            }
                        }
                    }
                }

                SCTableViewCell *cellFour = (SCTableViewCell *)[sectionThree cellAtIndex:4];
                if ([cellFour isKindOfClass:[SCObjectSelectionCell class]])
                {
                    SCObjectSelectionCell *objectSelectionCell = (SCObjectSelectionCell *)cellFour;

                    if (![objectSelectionCell.selectedItemIndex isEqualToNumber:[NSNumber numberWithInteger:-1]])
                    {
                        NSManagedObject *selectedObject = (NSManagedObject *)[objectSelectionCell.items objectAtIndex:[objectSelectionCell.selectedItemIndex integerValue]];

                        if ([selectedObject isKindOfClass:[InterventionTypeSubtypeEntity class]])
                        {
                            InterventionTypeSubtypeEntity *interventionTypeSubtypeObject = (InterventionTypeSubtypeEntity *)selectedObject;

                            [interventionTypeSubtypeObject willAccessValueForKey:@"interventionSubType"];

                            if (interventionTypeSubtypeObject.interventionSubType && interventionTypeSubtypeObject.interventionSubType.length)
                            {
                                if (!trackText)
                                {
                                    trackText = [NSString stringWithFormat:@"Subtype: %@ \n",interventionTypeSubtypeObject.interventionSubType];
                                }
                                else
                                {
                                    trackText = [trackText stringByAppendingFormat:@"Subtype: %@ \n",interventionTypeSubtypeObject.interventionSubType];
                                }
                            }
                        }
                    }
                }

                SCTableViewCell *cellFive = (SCTableViewCell *)[sectionThree cellAtIndex:5];

                if ([cellFive isKindOfClass:[SCObjectSelectionCell class]])
                {
                    SCObjectSelectionCell *objectSelectionCell = (SCObjectSelectionCell *)cellFive;

                    if (![objectSelectionCell.selectedItemIndex isEqualToNumber:[NSNumber numberWithInteger:-1]])
                    {
                        NSManagedObject *selectedObject = (NSManagedObject *)[objectSelectionCell.items objectAtIndex:[objectSelectionCell.selectedItemIndex integerValue]];

                        if ([selectedObject isKindOfClass:[ServiceCodeEntity class]])
                        {
                            ServiceCodeEntity *serviceCodeObject = (ServiceCodeEntity *)selectedObject;

                            [serviceCodeObject willAccessValueForKey:@"code"];
                            if (serviceCodeObject.code && serviceCodeObject.code.length)
                            {
                                if (!trackText)
                                {
                                    trackText = [NSString stringWithFormat:@"Service Code: %@",serviceCodeObject.code];
                                }
                                else
                                {
                                    trackText = [trackText stringByAppendingFormat:@"Service Code: %@",serviceCodeObject.code];
                                }
                            }

                            [serviceCodeObject willAccessValueForKey:@"name"];
                            if (serviceCodeObject.name && serviceCodeObject.name.length)
                            {
                                trackText = [trackText stringByAppendingFormat:@" - %@",serviceCodeObject.name];
                            }
                        }
                    }
                }
            }
        }

        break;
        case kTimeTrackSupportSetup:

        {
            reportTitle = @"Client Support Activity Process Notes\n";
            isSupportActivity = YES;
            if (self.firstDetailTableModel && self.firstDetailTableModel.sectionCount > 2)
            {
                SCTableViewSection *sectionThree = (SCTableViewSection *)[self.firstDetailTableModel sectionAtIndex:2];
                SCTableViewCell *cellOne = (SCTableViewCell *)[sectionThree cellAtIndex:0];

                if ([cellOne isKindOfClass:[SCObjectSelectionCell class]])
                {
                    SCObjectSelectionCell *objectSelectionCell = (SCObjectSelectionCell *)cellOne;

                    if (![objectSelectionCell.selectedItemIndex isEqualToNumber:[NSNumber numberWithInteger:-1]])
                    {
                        NSManagedObject *selectedObject = (NSManagedObject *)[objectSelectionCell.items objectAtIndex:[objectSelectionCell.selectedItemIndex integerValue]];

                        if ([selectedObject isKindOfClass:[SupportActivityTypeEntity class]])
                        {
                            SupportActivityTypeEntity *supportActivityTypeObject = (SupportActivityTypeEntity *)selectedObject;

                            [supportActivityTypeObject willAccessValueForKey:@"supportActivityType"];
                            if (supportActivityTypeObject.supportActivityType && supportActivityTypeObject.supportActivityType.length)
                            {
                                trackText = [NSString stringWithFormat:@"Indirect Support Type: %@ \n",supportActivityTypeObject.supportActivityType];
                            }
                        }
                    }
                }

                SCTableViewCell *cellFour = (SCTableViewCell *)[sectionThree cellAtIndex:3];

                if ([cellFour isKindOfClass:[SCObjectSelectionCell class]])
                {
                    SCObjectSelectionCell *objectSelectionCell = (SCObjectSelectionCell *)cellFour;

                    if (![objectSelectionCell.selectedItemIndex isEqualToNumber:[NSNumber numberWithInteger:-1]])
                    {
                        NSManagedObject *selectedObject = (NSManagedObject *)[objectSelectionCell.items objectAtIndex:[objectSelectionCell.selectedItemIndex integerValue]];

                        if ([selectedObject isKindOfClass:[ServiceCodeEntity class]])
                        {
                            ServiceCodeEntity *serviceCodeObject = (ServiceCodeEntity *)selectedObject;

                            [serviceCodeObject willAccessValueForKey:@"code"];
                            if (serviceCodeObject.code && serviceCodeObject.code.length)
                            {
                                if (!trackText)
                                {
                                    trackText = [NSString stringWithFormat:@"Service Code: %@",serviceCodeObject.code];
                                }
                                else
                                {
                                    trackText = [trackText stringByAppendingFormat:@"Service Code: %@",serviceCodeObject.code];
                                }
                            }

                            [serviceCodeObject willAccessValueForKey:@"name"];
                            if (serviceCodeObject.name && serviceCodeObject.name.length)
                            {
                                trackText = [trackText stringByAppendingFormat:@" - %@",serviceCodeObject.name];
                            }
                        }
                    }
                }
            }
        }

        break;

        default:
            break;
    } /* switch */

    [pdfGenerator createPDF:(NSString *)fileName presentationTableModel:(SCArrayOfObjectsModel *)self.presentationTableModel trackText:(NSString *)trackText serviceDateTimeStr:(NSString *)self.serviceDateTimeString clinician:(ClinicianEntity *)[self getClinicianName] forSize:12 andFont:@"Georgia" andColor:[UIColor blackColor] allowCopy:YES allowPrint:YES password:([pdfPasswordTextField.text length] > 0) ? pdfPasswordTextField.text:nil reportTitle:(NSString *)reportTitle isSupportActivity:(BOOL)isSupportActivity];

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

        [self presentViewController:readerViewController animated:YES completion:nil];
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
            case 1 : // overwrite
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
        scrubbed = @"ClientInteractionReport";
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
    [self dismissViewControllerAnimated:YES completion:nil];
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


- (ClinicianEntity *) getClinicianName
{
    ClinicianEntity *clinician = nil;

    NSArray *cliniciansArrayWithMyInfo = [self fetchObjectsFromEntity:@"ClinicianEntity" filterPredicate:[NSPredicate predicateWithFormat:@"myInformation== %@",[NSNumber numberWithBool:YES]]];

    if (cliniciansArrayWithMyInfo && cliniciansArrayWithMyInfo.count)
    {
        int clinicianCount = cliniciansArrayWithMyInfo.count;

        if (clinicianCount > 1)
        {
            //there should only be one

            for (ClinicianEntity *clinicianInArray in cliniciansArrayWithMyInfo)
            {
                //try to find the right one
                if ([clinicianInArray.firstName isEqualToString:@"Enter Your"])
                {
                    clinician = clinicianInArray;
                    break;
                }
            }

            if (!clinician)
            {
                ClinicianEntity *clinicianInArray = [cliniciansArrayWithMyInfo objectAtIndex:0];
                clinician = clinicianInArray;
            }
        }
        else if (cliniciansArrayWithMyInfo && cliniciansArrayWithMyInfo.count)
        {
            ClinicianEntity *clinicianInArray = [cliniciansArrayWithMyInfo objectAtIndex:0];
            clinician = clinicianInArray;
        }
    }

    return clinician;
}


- (NSArray *) fetchObjectsFromEntity:(NSString *)entityStr filterPredicate:(NSPredicate *)filterPredicate
{
    PTTAppDelegate *appDelegate = (PTTAppDelegate *)[UIApplication sharedApplication].delegate;

    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];

    NSEntityDescription *entity = [NSEntityDescription entityForName:entityStr inManagedObjectContext:appDelegate.managedObjectContext];

    [fetchRequest setEntity:entity];

    [fetchRequest setRelationshipKeyPathsForPrefetching:
     (NSArray *)[NSArray arrayWithObjects:@"clinicianType",nil] ];

    if (filterPredicate)
    {
        [fetchRequest setPredicate:filterPredicate];
    }

    NSError *error = nil;
    NSArray *fetchedObjects = [appDelegate.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    fetchRequest = nil;
    return fetchedObjects;
}


@end
