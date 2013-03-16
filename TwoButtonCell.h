//
//  TwoButtonCell.h
//  PsyTrack Clinician Tools
//  Version: 1.05
//
//  Created by Daniel Boice on 5/15/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import "ButtonCell.h"
#import <UIKit/UIKit.h>

@interface TwoButtonCell : ButtonCell  {
    UIButton *buttonTwo_;
    NSString *buttonTwoText;
}

@property (nonatomic,strong) NSString *buttonTwoText;
@property (nonatomic,strong) IBOutlet UIButton *buttonTwo;

- (void) initWithOneText:(NSString *)text twoText:(NSString *)twoText;

- (void) toggleButtonsWithButtonOneHidden:(BOOL)buttonOneHidden;

@end
