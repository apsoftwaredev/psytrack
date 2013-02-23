//
//  AllTrainingHoursGenerateVC.h
//  PsyTrack Clinician Tools
//  Version: 1.05
//
//  Created by Daniel Boice on 9/4/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//
#import "ReaderViewController.h"
#import "SCArrayOfObjectsModel_UseSelectionSection.h"
#import "BigProgressViewWithBlockedView.h"

@interface AllTrainingHoursGenerateVC : SCViewController <ReaderViewControllerDelegate,UITextFieldDelegate, UIAlertViewDelegate>{
    
    
    
    BigProgressViewWithBlockedView *prog;
    NSString *fileName;
    BOOL changedDefaultFileName;
}
@property (nonatomic, weak)IBOutlet UITextField *pdfFileNameTextField;
@property (nonatomic, weak)IBOutlet UITextField *pdfPasswordTextField;


@property (nonatomic, weak)IBOutlet UIView *containerView;
@property (nonatomic, weak) IBOutlet UIButton *generateButton;
@property (nonatomic, weak) IBOutlet UISegmentedControl *doctorateLevelSegCtrl;
-(IBAction)generateButtonTapped:(id)sender;



@end
