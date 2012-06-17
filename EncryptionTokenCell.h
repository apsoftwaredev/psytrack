//
//  EncryptionTokenCell.h
//  PsyTrack
//
//  Created by Daniel Boice on 6/16/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//



@interface EncryptionTokenCell : SCCustomCell{


    UITextField *tokenField_;
    UIButton *setKeyButton_;
    UISwitch *viewTokenSwitch_;
     UIButton *generateNewButton_;
    UILabel *validateCurrentPasswordLabel_;
    UILabel *validateNewPasswordLabel_;
    UILabel *validateReenterNewPasswordLabel_;
    UILabel *validateEncryptionTokenLabel_;
}

@property (nonatomic, weak) IBOutlet UITextField *tokenField;
@property (nonatomic, weak) IBOutlet UIButton *setKeyButton;
@property (nonatomic, weak) IBOutlet UISwitch *viewTokenSwitch;
@property (nonatomic, weak) IBOutlet UIButton *generateNewButton;
@property (nonatomic, weak) IBOutlet UILabel *validateCurrentPasswordLabel;
@property (nonatomic, weak) IBOutlet UILabel *validateNewPasswordLabel;
@property (nonatomic, weak) IBOutlet UILabel *validateReenterNewPasswordLabel;
@property (nonatomic, weak) IBOutlet UILabel *validateEncryptionTokenLabel;;



@end
