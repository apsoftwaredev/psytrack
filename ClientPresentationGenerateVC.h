//
//  ClientPresentationGenerateVC.h
//  PsyTrack
//
//  Created by Daniel Boice on 11/13/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import "ReaderViewController.h"
#import "BigProgressViewWithBlockedView.h"


@interface ClientPresentationGenerateVC : SCViewController <ReaderViewControllerDelegate,UITextFieldDelegate, UIAlertViewDelegate>{
    
    
    
    BigProgressViewWithBlockedView *prog;
    NSString *fileName;
    BOOL changedDefaultFileName;
}
@property (nonatomic, weak)IBOutlet UITextField *pdfFileNameTextField;
@property (nonatomic, weak)IBOutlet UITextField *pdfPasswordTextField;


@property (nonatomic, weak)IBOutlet UIView *containerView;
@property (nonatomic, weak) IBOutlet UIButton *generateButton;
@property (nonatomic,strong) SCArrayOfObjectsModel *presentationTableModel;

-(IBAction)generateButtonTapped:(id)sender;
-(IBAction)myCancelButtonTapped:(id)sender;


@end
