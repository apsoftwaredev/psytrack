//
//  ClientPresentationGenerateVC.h
//  PsyTrack Clinician Tools
//  Version: 1.5.1
//
//  Created by Daniel Boice on 11/13/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import "ReaderViewController.h"
#import "BigProgressViewWithBlockedView.h"

typedef enum {
    kTimeTrackAssessmentSetup,
    kTimeTrackInterventionSetup,
    kTimeTrackSupportSetup,
    kTimeTrackSupervisionReceivedSetup,
    kTimeTrackSupervisionGivenSetup,
} PTimeTrackControllerSetup;

@interface ClientPresentationGenerateVC : SCViewController <ReaderViewControllerDelegate,UITextFieldDelegate, UIAlertViewDelegate>{
    BigProgressViewWithBlockedView *prog;
    NSString *fileName;
    BOOL changedDefaultFileName;
}
@property (nonatomic, weak) IBOutlet UITextField *pdfFileNameTextField;
@property (nonatomic, weak) IBOutlet UITextField *pdfPasswordTextField;

@property (nonatomic, weak) IBOutlet UIView *containerView;
@property (nonatomic, weak) IBOutlet UIButton *generateButton;
@property (nonatomic,strong) SCArrayOfObjectsModel *presentationTableModel;
@property (nonatomic, strong) SCArrayOfObjectsModel *firstDetailTableModel;
@property (nonatomic, strong) NSDate *serviceDate;

@property (strong, nonatomic) NSDate *timeInDate;
@property (nonatomic, strong)   NSDate *timeOutDate;
@property (nonatomic, strong) NSDate *totalTime;
@property (nonatomic, strong) NSString *serviceDateTimeString;
@property (nonatomic, assign) PTimeTrackControllerSetup timeTrackControllerSetup;

- (IBAction) generateButtonTapped:(id)sender;

@end
