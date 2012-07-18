//
//  MonthlyPracticumLogGenerateViewController.h
//  PsyTrack
//
//  Created by Daniel Boice on 7/17/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import "ReaderViewController.h"
#import "BigProgressView.h"
#import "SCArrayOfObjectsModel+CoreData+SelectionSection.h"
@interface MonthlyPracticumLogGenerateViewController : SCViewController <ReaderViewControllerDelegate,UITextFieldDelegate>{


    SCArrayOfObjectsModel_UseSelectionSection *objectsModel;
BigProgressView *prog;
   
} 

@property (nonatomic, weak)IBOutlet UITableView *trainingProgramTableView;
@property (nonatomic, weak)IBOutlet UITextField *pdfFileNameTextField;
@property (nonatomic, weak)IBOutlet UITextField *pdfPasswordTextField;
@property (nonatomic, weak)IBOutlet UISwitch *amendedLogSwitch;
@property (nonatomic, weak)IBOutlet UIScrollView *scrollView;
@property (nonatomic, weak)IBOutlet UIView *containerView;
@property (nonatomic, weak) IBOutlet UIButton *generateButton;
@property (nonatomic, weak)IBOutlet UITextField *monthTextField;
@property (nonatomic, weak)IBOutlet UIPickerView *pickerView;
-(IBAction)generateButtonTapped:(id)sender;



@end
