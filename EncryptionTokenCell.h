//
//  EncryptionTokenCell.h
//  PsyTrack
//
//  Created by Daniel Boice on 6/16/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//



@interface EncryptionTokenCell : SCCustomCell{


   __weak UITextField *tokenField_;
    __weak UITextField *passwordFieldCurrent_;
    __weak UITextField *passwordFieldNew_;
    __weak UITextField *passwordFieldReenter_;
    UIButton *setKeyButton_;
    UIButton *viewTokenButton_;
     UIButton *generateNewButton_;
    UIButton *validateCurrentPasswordButton_;
    UIButton *validateNewPasswordButton_;
    UIButton *validateReenterNewPasswordButton_;
    UIButton *validateEncryptionTokenButton_;
}

@property (nonatomic, weak) IBOutlet UITextField *tokenField;
@property (nonatomic, weak) IBOutlet UIButton *setKeyButton;
@property (nonatomic, weak) IBOutlet UIButton *viewTokenButton;
@property (nonatomic, weak) IBOutlet UIButton *generateNewButton;
@property (nonatomic, weak) IBOutlet UIButton *validateCurrentPasswordButton;
@property (nonatomic, weak) IBOutlet UIButton *validateNewPasswordButton;
@property (nonatomic, weak) IBOutlet UIButton *validateReenterNewPasswordButton;
@property (nonatomic, weak) IBOutlet UIButton *validateEncryptionTokenButton;
@property (nonatomic, weak) IBOutlet UITextField *passwordFieldCurrent;
@property (nonatomic, weak) IBOutlet UITextField *passwordFieldNew;
@property (nonatomic, weak) IBOutlet UITextField *passowrdFieldReenter;



@end
