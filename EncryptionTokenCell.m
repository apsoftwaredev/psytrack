//
//  EncryptionTokenCell.m
//  PsyTrack
//
//  Created by Daniel Boice on 6/16/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import "EncryptionTokenCell.h"

@implementation EncryptionTokenCell
@synthesize setKeyButton,tokenField=tokenField_,viewTokenButton,generateNewButton,
validateCurrentPasswordButton,validateEncryptionTokenButton,
validateNewPasswordButton,validateReenterNewPasswordButton;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}




-(void)performInitialization{


    
    [tokenField_ setFont:[UIFont fontWithName:@"Monaco" size:24]];

}





/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
