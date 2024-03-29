//
//  DemographicReportGenerateVC.h
//  PsyTrack Clinician Tools
//  Version: 1.5.4
//
//  Created by Daniel Boice on 9/16/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import "ReaderViewController.h"
#import "SCArrayOfObjectsModel_UseSelectionSection.h"
#import "BigProgressViewWithBlockedView.h"

@interface DemographicReportGenerateVC : SCViewController  <ReaderViewControllerDelegate,UITextFieldDelegate, UIAlertViewDelegate>{
    BigProgressViewWithBlockedView *prog;
    NSString *fileName;
    BOOL changedDefaultFileName;
}
@property (nonatomic, weak) IBOutlet UITextField *pdfFileNameTextField;
@property (nonatomic, weak) IBOutlet UITextField *pdfPasswordTextField;

@property (nonatomic, weak) IBOutlet UIView *containerView;
@property (nonatomic, weak) IBOutlet UIButton *generateButton;

- (IBAction) generateButtonTapped:(id)sender;

@end
