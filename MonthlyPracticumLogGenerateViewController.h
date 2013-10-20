//
//  MonthlyPracticumLogGenerateViewController.h
//  PsyTrack Clinician Tools
//  Version: 1.5.3
//
//  Created by Daniel Boice on 7/17/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import "ReaderViewController.h"
#import "SCArrayOfObjectsModel_UseSelectionSection.h"
#import "BigProgressViewWithBlockedView.h"

@interface MonthlyPracticumLogGenerateViewController : SCTableViewController <ReaderViewControllerDelegate,UITextFieldDelegate, SCTableViewModelDelegate, UIPickerViewDelegate,UIPickerViewDataSource,UIAlertViewDelegate>{
    SCArrayOfObjectsModel *objectsModel;
    BigProgressViewWithBlockedView *prog;
    NSDate *earliestDate;
    NSInteger firstMonth;
    NSInteger firstYear;
    NSInteger currentYear;
    NSInteger currentMonth;
    NSInteger newestYear;
    NSInteger numberOfYearsSinceFirstDatePlusTen;
    BOOL changedDefaultFileName;
}

@property (nonatomic, weak) IBOutlet UITableView *trainingProgramTableView;
@property (nonatomic, weak) IBOutlet UITextField *pdfFileNameTextField;
@property (nonatomic, weak) IBOutlet UITextField *pdfPasswordTextField;
@property (nonatomic, weak) IBOutlet UISwitch *amendedLogSwitch;

@property (nonatomic, weak) IBOutlet UIView *containerView;
@property (nonatomic, weak) IBOutlet UIButton *generateButton;
@property (nonatomic, weak) IBOutlet UITextField *monthTextField;
@property (nonatomic, weak) IBOutlet UIPickerView *myPickerView;
@property (nonatomic, weak) IBOutlet UIView *pickerContainerView;
@property (nonatomic, weak) IBOutlet UITextField *monthYearFieldOverMonthYearField;
@property (nonatomic, weak) IBOutlet UIButton *doneButtonOnPickerViewContainer;
@property (nonatomic, weak) IBOutlet UIButton *refreshButton;

@property (nonatomic, strong) NSDate *monthToDisplay;

- (IBAction) generateButtonTapped:(id)sender;

- (IBAction) amendedLogSwitchChangedOn:(id)sender;

@end
