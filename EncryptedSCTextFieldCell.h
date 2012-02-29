//
//  EncryptedSCTextFieldCell.h
//  PsyTrack Clinician Tools
//
//  Created by Daniel Boice on 2/23/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import "SCTableViewCell.h"
#import "PTTAppDelegate.h"
@interface EncryptedSCTextFieldCell : SCTextFieldCell {


    PTTAppDelegate *appDelegate;


}


@property (nonatomic,strong)NSString *testString;

@end
