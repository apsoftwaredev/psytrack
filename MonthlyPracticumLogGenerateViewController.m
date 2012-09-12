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
#import "TimeTrackEntity.h"
#import "ExistingHoursEntity.h"
#import "ClinicianSelectionCell.h"

@interface MonthlyPracticumLogGenerateViewController ()
-(NSString *)sanitizeFileName:(NSString *)fileName;
@end

@implementation MonthlyPracticumLogGenerateViewController
@synthesize pdfFileNameTextField,pdfPasswordTextField,amendedLogSwitch,generateButton,trainingProgramTableView=trainingProgramTableView_;
@synthesize containerView,monthTextField,myPickerView,pickerContainerView, monthYearFieldOverMonthYearField,doneButtonOnPickerViewContainer;
@synthesize refreshButton,monthToDisplay;

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
    
   
    
       
    //begin
    SCEntityDefinition *trainingProgramDef=[SCEntityDefinition definitionWithEntityName:@"TrainingProgramEntity" managedObjectContext:appDelegate.managedObjectContext propertyNames:[NSArray arrayWithObjects:@"school",@"trainingProgram",@"course",@"doctorateLevel",@"startDate",@"endDate",@"selectedByDefault", @"notes", nil]];
    
    
    trainingProgramDef.titlePropertyName=@"trainingProgram;course";
    
    trainingProgramDef.titlePropertyNameDelimiter=@" - ";
    

    
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"EEE, M/d/yyyy"];
    
    
    
    
    trainingProgramDef.orderAttributeName=@"order";
    
    
    
    
    
   
           
    SCPropertyDefinition *trainingProgramPropertyDef=[trainingProgramDef propertyDefinitionWithName:@"trainingProgram"];
    trainingProgramPropertyDef.type=SCPropertyTypeTextView;
    SCPropertyDefinition *trainingProgramNotesPropertyDef=[trainingProgramDef propertyDefinitionWithName:@"notes"];
    trainingProgramNotesPropertyDef.type=SCPropertyTypeTextView;
    
    
    
    //create the dictionary with the data bindings
    NSDictionary *instructorDataBindings = [NSDictionary 
                                            dictionaryWithObjects:[NSArray arrayWithObjects:@"seminarInstructor",@"Seminar Instructor",[NSNumber numberWithBool:NO],@"seminarInstructor",[NSNumber numberWithBool:NO],nil] 
                                            forKeys:[NSArray arrayWithObjects:@"1",@"90",@"91",@"92",@"93",nil ]]; // 1 are the control tags
	
    //create the custom property definition
    SCCustomPropertyDefinition *instructorDataProperty = [SCCustomPropertyDefinition definitionWithName:@"InstructorData"
                                                                                         uiElementClass:[ClinicianSelectionCell class] objectBindings:instructorDataBindings];
	
    
    //set the autovalidate to false to catch the validation event with a custom validation, which is needed for custom cells
    instructorDataProperty.autoValidate=FALSE;
    
    
    [trainingProgramDef insertPropertyDefinition:instructorDataProperty atIndex:1];
    
    SCPropertyDefinition *trainingProgramStartDatePropertyDef = [trainingProgramDef propertyDefinitionWithName:@"startDate"];
	trainingProgramStartDatePropertyDef.attributes = [SCDateAttributes attributesWithDateFormatter:dateFormatter 
                                                                                    datePickerMode:UIDatePickerModeDate 
                                                                     displayDatePickerInDetailView:NO];
    
    
    SCPropertyDefinition *trainingProgramEndDatePropertyDef = [trainingProgramDef propertyDefinitionWithName:@"endDate"];
	trainingProgramEndDatePropertyDef.attributes = [SCDateAttributes attributesWithDateFormatter:dateFormatter 
                                                                                  datePickerMode:UIDatePickerModeDate 
                                                                   displayDatePickerInDetailView:NO];
    
    
    SCEntityDefinition *schoolDef=[SCEntityDefinition definitionWithEntityName:@"SchoolEntity" managedObjectContext:appDelegate.managedObjectContext propertyNames:[NSArray arrayWithObjects:@"schoolName",@"notes", nil]];
    
    
    schoolDef.orderAttributeName=@"order";
    SCPropertyDefinition *trainingProgramSchoolPropertyDef=[trainingProgramDef propertyDefinitionWithName:@"school"];
    trainingProgramSchoolPropertyDef.type =SCPropertyTypeObjectSelection;
    
    
    
    
    SCObjectSelectionAttributes *trainingProgramSchoolSelectionAttribs = [SCObjectSelectionAttributes attributesWithObjectsEntityDefinition:schoolDef usingPredicate:nil allowMultipleSelection:NO allowNoSelection:NO];
    trainingProgramSchoolSelectionAttribs.allowAddingItems = YES;
    trainingProgramSchoolSelectionAttribs.allowDeletingItems = YES;
    trainingProgramSchoolSelectionAttribs.allowMovingItems = YES;
    trainingProgramSchoolSelectionAttribs.allowEditingItems = YES;
    trainingProgramSchoolSelectionAttribs.placeholderuiElement = [SCTableViewCell cellWithText:@"(Tap Edit to add schools)"];
    trainingProgramSchoolSelectionAttribs.addNewObjectuiElement = [SCTableViewCell cellWithText:@"Add New School"];
    trainingProgramSchoolPropertyDef.attributes = trainingProgramSchoolSelectionAttribs;
    
    SCPropertyDefinition *trainingProgramSchoolNamePropertyDef=[schoolDef propertyDefinitionWithName:@"schoolName"];
    trainingProgramSchoolNamePropertyDef.type=SCPropertyTypeTextView;
    SCPropertyDefinition *trainingPrograSchoolmNotesPropertyDef=[schoolDef propertyDefinitionWithName:@"notes"];
    trainingPrograSchoolmNotesPropertyDef.type=SCPropertyTypeTextView;
    
    
    
    //training type end
    //end
    
    
    
    
    
    
    
    
    objectsModel=[[SCArrayOfObjectsModel_UseSelectionSection alloc]initWithTableView:self.trainingProgramTableView entityDefinition:trainingProgramDef];
    

    objectsModel.tag=0;
    objectsModel.delegate=self;
    objectsModel.allowMovingItems=YES;
    objectsModel.allowRowSelection=YES;
    objectsModel.allowAddingItems=YES;
    objectsModel.allowDeletingItems=YES;
    [self setNavigationBarType: SCNavigationBarTypeAddEditRight];
    
    
    objectsModel.editButtonItem = self.editButton;;
    
    objectsModel.addButtonItem = self.addButton;
    
    objectsModel.autoAssignDelegateForDetailModels=YES;
    
    
//    objectsModel.al
    objectsModel.enablePullToRefresh = TRUE;
    objectsModel.pullToRefreshView.arrowImageView.image = [UIImage imageNamed:@"blueArrow.png"];
    objectsModel.autoAssignDelegateForDetailModels=YES;

   
    [self setDatesAndYears];

  
    changedDefaultFileName=NO;
    
    objectsModel.modelActions.didRefresh = ^(SCTableViewModel *tableModel)
    {
        changedDefaultFileName=NO;
        [self setDatesAndYears];
        [self.myPickerView reloadAllComponents];
    };

    
    self.tableViewModel=objectsModel;
    
    
     prog = [[BigProgressViewWithBlockedView alloc] initWithFrame:CGRectMake(0, 64, 320, 367) blockedView:self.view];
    
    [self.tableViewModel reloadBoundValues];
    [self.tableViewModel.modeledTableView reloadData]; 
//    scrollView.contentSize=containerView.frame.size;
//    scrollView.pagingEnabled = NO;
//    CGRect pikerViewFrame=CGRectMake(0, self.view.frame.size.height-self.pickerView.frame.size.height, self.view.frame.size.width, self.pickerView.frame.size.height);
//    self.pickerView.frame=pikerViewFrame;
       self.monthTextField.inputView=self.pickerContainerView;
    
    self.monthTextField.delegate=self;
   
    
    
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

-(void)generateAndViewReportPDFWithFileName:(NSString *)fileName{
   
    PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
    
    NSString *phrase = self.pdfPasswordTextField.text; // Document password (for unlocking most encrypted PDF files)
   
	NSString *pdfs = [appDelegate.applicationDocumentsDirectory.path stringByAppendingPathComponent:fileName];
    
    TrainingProgramEntity *trainingProgram=nil;
    if (objectsModel.sectionCount) {
        SCTableViewSection *section=(SCTableViewSection *)[objectsModel sectionAtIndex:0];
               if ([section isKindOfClass:[SCObjectSelectionSection class]]) {
            SCSelectionSection *selectionSection=(SCSelectionSection *)section;
            if (![selectionSection.selectedItemIndex isEqualToNumber:[NSNumber numberWithInt:-1]]) {
                id objectAtSelectedIndex=[selectionSection.items objectAtIndex:[selectionSection.selectedItemIndex intValue]];
                
                if ([objectAtSelectedIndex isKindOfClass:[TrainingProgramEntity class]]) {
                    trainingProgram=(TrainingProgramEntity *)objectAtSelectedIndex;
                    
                    
                    
                }
                
            }
            else {
                [appDelegate displayNotification:@"Please select training program & course"];
                return;
            }
            
            
            
        }
    }
    else {
        [appDelegate displayNotification:@"Add training programs under psyTrack interventions, assessments, existing hours, supervision, or existing hours tables"];
        return;
    }
   
    if (trainingProgram && self.monthToDisplay) {
        
        [NSThread detachNewThreadSelector:@selector(startAnimatingProgressInBackground) toTarget:prog withObject:prog];
        [self.view setNeedsDisplay];
        if (phrase&&phrase.length==0) {
           //otherwise the print button won't appear because we cannont print documents with passwords
            phrase=nil;
        }
        
        [PDFRenderer drawMonthlyPracticumLogPDF:fileName month:self.monthToDisplay trainingProgram:trainingProgram password:phrase amended:self.amendedLogSwitch.on ];
        
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
    
    else if (!self.monthToDisplay){
        if(!numberOfYearsSinceFirstDatePlusTen){
            [appDelegate displayNotification:@"No Assessments, Interventions, Support Activities, Or Supervision"];
            
        }
        else {
            [appDelegate displayNotification:@"Please select a month and year"];
        }
        
        
    }




}
-(IBAction)generateButtonTapped:(id)sender{

    PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
    
	
    NSString *fileName=[self sanitizeFileName:pdfFileNameTextField.text];
	NSString *pdfs = [appDelegate.applicationDocumentsDirectory.path stringByAppendingPathComponent:fileName];
    
    if ([self fileAlreadyExists:pdfs]) {
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:[NSString stringWithFormat:@"File %@.pdf Already Exists in the Documents Folder",fileName]  message:@"Would you like to overwrite the existing file?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Yes",@"No, incriment", nil];
        
        alertView.tag=50;
        
        [alertView show];
        
    }
    else {
        [self generateAndViewReportPDFWithFileName:[fileName stringByAppendingPathExtension:@"pdf"]];
    }
    
        
    
}

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    

    if (alertView.tag==50) {
        NSString *fileName=[self sanitizeFileName:pdfFileNameTextField.text];
            
        switch (buttonIndex) {
    
                   
                case 1: // overwrite
                {
                    // do the delete
                    
                   
                    
                   
                    [self generateAndViewReportPDFWithFileName:[fileName stringByAppendingPathExtension:@"pdf"]];
                    
                    
                    break;
                }
                    
                case 2: // increment
                {
                    // do the delete
                    
                    NSString *newFileName=[self incrementedFileName:fileName];
                    [self generateAndViewReportPDFWithFileName:newFileName];
                   
                }
                    break;
            }
                
           
    }      
            
        
    



}
-(IBAction)amendedLogSwitchChangedOn:(id)sender{
    
    if (!changedDefaultFileName) {
   
        NSString *fileNameText=self.pdfFileNameTextField.text;
        if (self.amendedLogSwitch.on) {
            self.pdfFileNameTextField.text=[NSString stringWithFormat:@"Amended%@",fileNameText];
        }
        else {
            self.pdfFileNameTextField.text=[fileNameText stringByReplacingOccurrencesOfString:@"Amended" withString:@""];
        }

    }

}
-(NSString *)sanitizeFileName:(NSString *)fileName{
    NSString *scrubbed =nil;
    
    if (fileName && [fileName isKindOfClass:[NSString class]]) {
        NSCharacterSet *invalidFsChars = [NSCharacterSet characterSetWithCharactersInString:@"/\\?%*|\"<>"];
        scrubbed = [fileName stringByTrimmingCharactersInSet:invalidFsChars];
        
        if (scrubbed.length>35) {
                
            scrubbed=[scrubbed substringToIndex:34];
        }
        
    }
   
    if (!scrubbed ||!scrubbed.length) {
       
        
        NSString *monthStr=[self titleForRow:[self.myPickerView selectedRowInComponent:0]]; 
        NSString *yearStr=[NSString stringWithFormat:@"%i",firstYear+[self.myPickerView selectedRowInComponent:1]];
        
        
        scrubbed=[NSString stringWithFormat:@"%@%@%@PracticumLog",self.amendedLogSwitch.on?@"Amended":@"",monthStr,yearStr];
        self.pdfFileNameTextField.text=scrubbed;

        
    }

    return scrubbed;

}

-(BOOL)fileAlreadyExists:(NSString *)fileName{

        
    NSFileManager *fileManager=[[NSFileManager alloc]init];
    
       
    return [fileManager fileExistsAtPath:[fileName stringByAppendingPathExtension:@"pdf"]];    
    




}
-(NSString *)incrementedFileName:(NSString *)fileNameGiven{

    
    
    NSFileManager *fileManager=[[NSFileManager alloc]init];
    
    PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
    
    NSString *documentsPath=[appDelegate applicationDocumentsDirectory].path;
    
    NSString *newFileName=nil;
    
    NSString *documentsPathWithNewFileName=nil;
    


    NSInteger i=0;
    do {
        i++;
        
        newFileName=[fileNameGiven stringByAppendingFormat:@"%i.pdf",i];
        documentsPathWithNewFileName=[documentsPath stringByAppendingPathComponent:newFileName];
        
        
        
    } while ( [fileManager fileExistsAtPath:documentsPathWithNewFileName]);
    


    return newFileName;

}

#pragma mark -
#pragma mark SCTableViewModelDelegate methods

-(void)tableViewModel:(SCTableViewModel *)tableModel willConfigureCell:(SCTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{

    NSManagedObject *cellManagedObject=(NSManagedObject *)cell.boundObject;
    
    if (cellManagedObject&&[cellManagedObject respondsToSelector:@selector(entity)]&&[cellManagedObject isKindOfClass:[TrainingProgramEntity class]]) {
        TrainingProgramEntity *trainingProgram=(TrainingProgramEntity *)cellManagedObject;
        
        if ([trainingProgram.selectedByDefault isEqualToNumber:[NSNumber numberWithBool:YES]]) {
            SCTableViewSection *section=(SCTableViewSection *)[tableModel sectionAtIndex:indexPath.section];
            
            if ([section isKindOfClass:[SCObjectSelectionSection class]]) {
                SCObjectSelectionSection *objectsSelectionSection=(SCObjectSelectionSection *)section;
                
                [objectsSelectionSection setSelectedItemIndex:[NSNumber numberWithInt:indexPath.row]];
                
                
                
            }
            
            
        }
        
        
    }
    



}
-(void)tableViewModel:(SCTableViewModel *)tableModel detailViewWillPresentForRowAtIndexPath:(NSIndexPath *)indexPath withDetailTableViewModel:(SCTableViewModel *)detailTableViewModel{
    
 
    if ([SCUtilities is_iPad]) {
        PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
        
        
        UIColor *backgroundColor=nil;
        
        if(indexPath.row==NSNotFound|| tableModel.tag>0)
        {
            
            backgroundColor=(UIColor *)appDelegate.window.backgroundColor;
            
        }
        else {
            
            
            
            backgroundColor=[UIColor clearColor];
            
            
        }
        
        if (detailTableViewModel.modeledTableView.backgroundColor!=backgroundColor) {
            
            [detailTableViewModel.modeledTableView setBackgroundView:nil];
            UIView *view=[[UIView alloc]init];
            [detailTableViewModel.modeledTableView setBackgroundView:view];
            [detailTableViewModel.modeledTableView setBackgroundColor:backgroundColor];
            
            
            
            
        }
        
        
    }
}
-(void)tableViewModel:(SCTableViewModel *)tableModel valueChangedForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (tableModel.tag==1) {
        
        SCTableViewCell *cell=(SCTableViewCell *)[tableModel cellAtIndexPath:indexPath];
        NSManagedObject *cellManagedObject=(NSManagedObject *)cell.boundObject;
                
        
        if (cellManagedObject &&[cellManagedObject respondsToSelector:@selector(entity)]) {
            if ([cellManagedObject.entity.name isEqualToString:@"TrainingProgramEntity"]) {
        
                if (cell.tag==7) {
                    PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
                    
                    
                    NSFetchRequest *trainingProgramFetchRequest = [[NSFetchRequest alloc] init];
                    NSEntityDescription *trainingProgramEntity = [NSEntityDescription entityForName:@"TrainingProgramEntity" inManagedObjectContext:appDelegate.managedObjectContext];
                    [trainingProgramFetchRequest setEntity:trainingProgramEntity];
                    
                    NSPredicate *defaultTrainingPredicate = [NSPredicate predicateWithFormat:@"selectedByDefault == %@ ", [NSNumber numberWithBool:YES],[NSNumber numberWithBool:YES]];
                    [trainingProgramFetchRequest setPredicate:defaultTrainingPredicate];
                    
                    NSError *trainingProgramError = nil;
                    NSArray *trainingProgramFetchedObjects = [appDelegate.managedObjectContext executeFetchRequest:trainingProgramFetchRequest error:&trainingProgramError];
                    
                    
                    if (trainingProgramFetchedObjects&&trainingProgramFetchedObjects.count) {
                        
                        for (TrainingProgramEntity *trainingProgram in trainingProgramFetchedObjects) {
                            [trainingProgram willChangeValueForKey:@"selectedByDefault"];
                            trainingProgram.selectedByDefault=[NSNumber numberWithBool:NO];
                            [trainingProgram didChangeValueForKey:@"selectedByDefault"];
                        }
                        
                        
                        if (tableModel.masterModel.sectionCount) {
                            SCSelectionSection *masterModelSection=(SCSelectionSection *)[tableModel.masterModel sectionAtIndex:0];
                            
                            [masterModelSection setSelectedItemIndex:[NSNumber numberWithInt:-1]];
                            [tableModel.masterModel.tableView reloadData];
                            
                        }

                    }
                                               
                        
                    }
                }
            }

        }
    
}

#pragma mark -
#pragma mark ReaderViewController Delegate Methods

-(void)readerViewDidAppear:(ReaderViewController *)viewController{


    [prog stopAnimating];

}

- (void)dismissReaderViewController:(ReaderViewController *)viewController
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

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}



-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{

    
    if (textField.tag==23) {
        if (![SCUtilities is_iPad]) {
           [ self.tableView setContentOffset:CGPointMake(0, self.monthYearFieldOverMonthYearField.frame.origin.y+self.monthYearFieldOverMonthYearField.frame.size.height)  animated:YES ];
        }
        [self setMyPickerViewToCurrentMonthAndYear];
        if (self.monthToDisplay) {
            NSString *monthStr=[self titleForRow:currentMonth-1]; 
            self.monthYearFieldOverMonthYearField.text=[NSString stringWithFormat:@"%@ %i",monthStr,currentYear];
           
            if (!changedDefaultFileName) {
                self.pdfFileNameTextField.text=[NSString stringWithFormat:@"%@%@%iPracticumLog",self.amendedLogSwitch.on?@"Amended":@"",monthStr,currentYear];
            }
            
        }
        else {
            self.monthYearFieldOverMonthYearField.text=@"No records to display";
        }
        
    }
    else if (textField.tag==24) {
        [textField resignFirstResponder];
        [monthTextField becomeFirstResponder];
        return NO;
    }
    else {
        return YES;
    }
    return YES;
}


-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{

    changedDefaultFileName=YES;
    return YES;


}
-(IBAction)doneButtonOnPickerConatainerTapped:(id)sender{


    [self.monthTextField resignFirstResponder];


}
#pragma mark -
#pragma mark UIPickerViewDataSource methods



- (NSString *)titleForRow:(NSInteger)row
{
    NSString *title = nil;
    switch (row) 
    {
        case 0: title = @"January";     break;
        case 1: title = @"February";    break;
        case 2: title = @"March";     break;
        case 3: title = @"April";    break;
        case 4: title = @"May";     break;
        case 5: title = @"June";    break;
        case 6: title = @"July";     break;
        case 7: title = @"August";    break;
        case 8: title = @"September";     break;
        case 9: title = @"October";    break;
        case 10: title = @"November";     break;
        case 11: title = @"December";    break;
                    
            
    }
    return title;
}

- (NSInteger)rowForTitle:(NSString *)title
{
    
    
    NSInteger row = 0;
    
    for(NSInteger i=0; i<3; i++)
    {
        if([title isEqualToString:[self titleForRow:i]])
        {
            row = i;
            break;
        }
    }
    
    return row;
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
     NSInteger returnInteger=2;
    switch (component) {
        case 0:
            returnInteger=12;
            break;
        case 1:
            
        {            
            returnInteger =numberOfYearsSinceFirstDatePlusTen;

            break;
        }
        default:
            break;
    }
   
    
    
    
    
    
    return returnInteger;
}

-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    
    
    if ([SCUtilities is_iPad]) 
        return  180.0;
    else if(component==0){
        return 180.0;
    }
    else {
        return 80.0;
    }
        
        
    
    
    
    
}


#pragma mark -
#pragma mark UIPickerViewDelegate methods



-(void)viewDidLayoutSubviews{



}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *returnStr = @"";
	
	// note: custom picker doesn't care about titles, it uses custom views
	
    
    
	
   
    if (component==0) {
        returnStr = [self titleForRow:row];
    }
    
	
	return returnStr;
}

-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{

    CGFloat viewWidth=180.0;
    if (component==1) {
        viewWidth=80.0;
    }
    
      UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(20, 0, viewWidth, 30.0)];
    
    
    
    
    if (component==0) {
        label.text=[self titleForRow:row];
        
        if (row+1<firstMonth && ![pickerView selectedRowInComponent:1]) {
            label.enabled=NO;
        }
        
    }
    else {
        label.text=[self yearForRow:row];
    }
       

    label.font=[UIFont boldSystemFontOfSize:21];
    label.backgroundColor=[UIColor clearColor];
    label.textAlignment=UITextAlignmentCenter;
 
    return label;
}
-(NSString *)yearForRow:(NSInteger )row{

    return [NSString stringWithFormat:@"%i",row+firstYear];    
    



}

-(void)setMyPickerViewToCurrentMonthAndYear{

    if (currentMonth &&currentYear) {
   

        [ self.myPickerView selectRow:currentMonth-1 inComponent:0 animated:YES];
    
        [self.myPickerView reloadComponent:0];
        
        
        NSInteger rowForCurrentYear=currentYear-firstYear;
        [self.myPickerView selectRow:rowForCurrentYear inComponent:1 animated:YES];
        
        [self setMonthtoDisplayToPickerSelection];
    }


}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{


    if (component==1) {
        [pickerView reloadComponent:0];
    }
    
   
        UIView *viewForRow=[pickerView viewForRow:row forComponent:0] ;
        if ([viewForRow isKindOfClass:[UILabel class]]) {
            UILabel *label=(UILabel*)viewForRow;
            
            if (!label.enabled) {
                if (firstMonth-1<=[pickerView numberOfRowsInComponent:0]) {
                     [ pickerView selectRow:firstMonth-1 inComponent:0 animated:YES];
                    [pickerView reloadComponent:0];
                }
                          
            }
        
            
            
        }
    NSString *monthYearStr=nil;

    UIView *monthLabelView=(UIView *)[pickerView viewForRow:[pickerView selectedRowInComponent:0] forComponent:0];

    if([monthLabelView isKindOfClass:[UILabel class]]){
    
        UILabel *rowLabel=(UILabel *)monthLabelView;
        
        monthYearStr=rowLabel.text;
    
    }
    
UIView *yearLabelView=(UIView *)[pickerView viewForRow:[pickerView selectedRowInComponent:1] forComponent:1];

if([yearLabelView isKindOfClass:[UILabel class]]){
    
    UILabel *rowLabel=(UILabel *)yearLabelView;
    if(monthYearStr &&monthYearStr.length){
        monthYearStr=[monthYearStr stringByAppendingFormat:@" %@", rowLabel.text];
        
        self.monthYearFieldOverMonthYearField.text=monthYearStr;
        
        NSString *monthYearStrWithoutSpace=[monthYearStr stringByReplacingOccurrencesOfString:@" " withString:@""]; 
        
        if (!changedDefaultFileName) {
            self.pdfFileNameTextField.text=[NSString stringWithFormat:@"%@%@PracticumLog",self.amendedLogSwitch.on?@"Amended":@"",monthYearStrWithoutSpace];
        }

    }
    
}
    [self setMonthtoDisplayToPickerSelection];


}
#pragma mark -
#pragma mark Custom Methods for PickerView

-(IBAction)refreshButtonTapped:(id)sender{

    [self setDatesAndYears];
    [self.myPickerView reloadAllComponents];

    [self setMyPickerViewToCurrentMonthAndYear];



}

-(void)setMonthtoDisplayToPickerSelection{


    NSInteger pickerFirstComponentRow=[self.myPickerView selectedRowInComponent:0];
    NSInteger pickerSecondComponentRow=[self.myPickerView selectedRowInComponent:1];
    
    
    NSInteger month=pickerFirstComponentRow+1 ;
    
    NSInteger year =pickerSecondComponentRow+firstYear;
    
    
       
      //define a  calandar
      NSCalendar *calendar = [NSCalendar currentCalendar];
      
      //define the calandar unit flags
      NSUInteger unitFlags = NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit;
      
      //define the date components
      NSDateComponents *dateComponents = [calendar components:unitFlags fromDate:[NSDate date]];
    
    dateComponents.month=month;
    dateComponents.year=year;
    dateComponents.day=1;
    
    if (firstYear) {
         self.monthToDisplay=[calendar dateFromComponents:dateComponents];
    }
    else {
        self.monthToDisplay=nil;
    }
   
    

}
-(void)setDatesAndYears{


    
    earliestDate=[self firstDateInTrackOrExisting];
   
    if (earliestDate) {
   
    firstYear=[self yearIntegerFromDate:earliestDate];
    
    firstMonth=[self monthIntegerFromDate:earliestDate];
    currentYear=[self yearIntegerForCurrentDate];
    
    currentMonth=[self monthIntegerFromDate:[NSDate date]];
    
    if ([earliestDate compare:[NSDate date]]==NSOrderedDescending) {
        currentYear=firstYear;
        currentMonth=firstMonth;
    }
    
    if (newestYear<=currentYear) {
        newestYear=currentYear;
    }
    numberOfYearsSinceFirstDatePlusTen=newestYear-firstYear+10;
        
        [self setMyPickerViewToCurrentMonthAndYear];
       
    }
    else {
        firstYear=0;
        firstMonth=0;
        currentYear=0;
        currentMonth=0;
        numberOfYearsSinceFirstDatePlusTen=0;
        
    }

    
    
    NSString *monthString=[self titleForRow:currentMonth-1];
    NSString *monthYearString=[NSString stringWithFormat:@"%@ %i",monthString,currentYear];
   
    if (firstYear) {
        self.monthYearFieldOverMonthYearField.text=monthYearString;
        NSString *monthYearStrWithoutSpace=[monthYearString stringByReplacingOccurrencesOfString:@" " withString:@""]; 
        
        if (!changedDefaultFileName) {
            self.pdfFileNameTextField.text=[NSString stringWithFormat:@"%@%@PracticumLog",self.amendedLogSwitch.on?@"Amended":@"",monthYearStrWithoutSpace];
        }
        
    }
    else
    {
        self.monthYearFieldOverMonthYearField.text =@"No records to display";
        
    }


}


-(NSDate *)firstDateInTrackOrExisting{

    PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
    


NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
NSEntityDescription *entity = [NSEntityDescription entityForName:@"TimeTrackEntity"
inManagedObjectContext:appDelegate.managedObjectContext];
[fetchRequest setEntity:entity];

NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"dateOfService"
ascending:YES];
NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
[fetchRequest setSortDescriptors:sortDescriptors];

NSError *error = nil;
NSArray *fetchedObjects = [appDelegate.managedObjectContext executeFetchRequest:fetchRequest error:&error];
if (fetchedObjects == nil) {
    // Handle the error
}

    NSDate *trackFirstDateOfService=nil;
   
    NSDate *trackNewestDate=nil;
    if (fetchedObjects && fetchedObjects.count) {
        TimeTrackEntity *timeTrackObject=(TimeTrackEntity*)[fetchedObjects objectAtIndex:0];
        
        trackFirstDateOfService=timeTrackObject.dateOfService;
        TimeTrackEntity *lastTimeTrackObject=(TimeTrackEntity *)[fetchedObjects lastObject];
        
        trackNewestDate=lastTimeTrackObject.dateOfService;
        
        
    }
    
      
    
    NSFetchRequest *existingHoursfetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *existingHoursEntity = [NSEntityDescription entityForName:@"ExistingHoursEntity"
                                              inManagedObjectContext:appDelegate.managedObjectContext];
    [existingHoursfetchRequest setEntity:existingHoursEntity];
    
    NSSortDescriptor *existingHoursSortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"startDate"
                                                                   ascending:YES];
    NSArray *existingHoursSortDescriptors = [[NSArray alloc] initWithObjects:existingHoursSortDescriptor, nil];
    [existingHoursfetchRequest setSortDescriptors:existingHoursSortDescriptors];
    
    NSError *existingHoursError = nil;
    NSArray *existingHoursFetchedObjects = [appDelegate.managedObjectContext executeFetchRequest:existingHoursfetchRequest error:&existingHoursError];
    if (fetchedObjects == nil) {
        // Handle the error
    }
   
    NSDate *existingHoursFirstDate=nil;
    NSDate *existingHoursNewestDate=nil;
    if (existingHoursFetchedObjects && existingHoursFetchedObjects.count) {
        ExistingHoursEntity *existingHoursObject=(ExistingHoursEntity*)[existingHoursFetchedObjects objectAtIndex:0];
        
        existingHoursFirstDate=existingHoursObject.startDate;
        NSSortDescriptor *existingHoursEndDateSortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"endDate"
                                                                                    ascending:YES];
        NSArray *existingHoursEndDateSortDescriptors = [[NSArray alloc] initWithObjects:existingHoursEndDateSortDescriptor, nil];
        
        NSArray *existingHoursSortedByEndDate=[existingHoursFetchedObjects sortedArrayUsingDescriptors:existingHoursEndDateSortDescriptors];
        
        ExistingHoursEntity *existingHoursLastObject=[existingHoursSortedByEndDate lastObject];
        
        existingHoursNewestDate=existingHoursLastObject.endDate;
        
    }
    
    NSDate *returnDate=nil;
    if (trackFirstDateOfService &&((trackFirstDateOfService && !existingHoursFirstDate)||([trackFirstDateOfService compare:existingHoursFirstDate]==NSOrderedSame)||([trackFirstDateOfService compare:existingHoursFirstDate]==NSOrderedAscending))) {
        
        returnDate=trackFirstDateOfService;
    }
    else {
        returnDate=existingHoursFirstDate;
    }
    
    NSDate *newestDate=nil;
    
    if (([trackNewestDate compare:existingHoursNewestDate]==NSOrderedSame)||([trackNewestDate compare:existingHoursNewestDate]==NSOrderedDescending)) {
        newestDate=trackNewestDate;
    }
    else {
        newestDate=existingHoursNewestDate;
    }
    
    newestYear=[self yearIntegerFromDate:newestDate];
    
    
    return returnDate;
}

    
    
-(NSInteger )yearIntegerFromDate:(NSDate *)givenDate{


    NSInteger yearToReturn=0;
    if (givenDate) {
   
                      //define a gregorian calandar
                      NSCalendar *calendar = [NSCalendar currentCalendar];
                      
                      //define the calandar unit flags
                      NSUInteger unitFlags = NSYearCalendarUnit;
                      
                      //define the date components
                      NSDateComponents *dateComponents = [calendar components:unitFlags fromDate:givenDate];
        
        [dateComponents setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
        yearToReturn=dateComponents.year;
    }
    return yearToReturn;
    





}
-(NSInteger )yearIntegerForCurrentDate{
    
    
    
    
    NSDate *currentDate=[NSDate date];
    NSInteger yearToReturn=0;
    if (currentDate) {
        
        //define a gregorian calandar
        NSCalendar *calendar = [NSCalendar currentCalendar];
        
        //define the calandar unit flags
        NSUInteger unitFlags =NSYearCalendarUnit;
        
        //define the date components
        NSDateComponents *dateComponents = [calendar components:unitFlags fromDate:currentDate];
        yearToReturn=dateComponents.year;
    }
    return yearToReturn;
    
    
    
    
    
    
}    
-(NSInteger )monthIntegerFromDate:(NSDate *)givenDate{
    
    
    NSInteger monthToReturn=1;
    if (givenDate) {
        
        //define a gregorian calandar
        NSCalendar *calendar = [NSCalendar currentCalendar];
        
        //define the calandar unit flags
        NSUInteger unitFlags = NSMonthCalendarUnit;
        
        //define the date components
        NSDateComponents *dateComponents = [calendar components:unitFlags fromDate:givenDate];
        monthToReturn=dateComponents.month;
    }
    return monthToReturn;
    
    
    
    
    
    
}


-(NSArray * )yearsArraySinceEarliestDate {


    NSMutableArray *yearsArray=nil;
    if (!earliestDate) {
        earliestDate=[self firstDateInTrackOrExisting];
    }
    
   
    
    
    
    for (NSInteger addYears=0; addYears < numberOfYearsSinceFirstDatePlusTen; addYears++) {
        
        NSInteger yearToAdd=firstYear+addYears;
        
        [yearsArray addObject:[NSNumber numberWithInteger:yearToAdd]];
        
        
    }
    
    
    return [NSArray arrayWithArray:yearsArray]; 


}

@end
