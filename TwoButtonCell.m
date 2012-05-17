//
//  TwoButtonCell.m
//  PsyTrack
//
//  Created by Daniel Boice on 5/15/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import "TwoButtonCell.h"

@implementation TwoButtonCell
@synthesize buttonTwoText;
@synthesize buttonTwo=buttonTwo_;


// overrides superclass
- (void)performInitialization 
{
   
    [super performInitialization];
    
    // place any initialization code here
    
    buttonTwo_ = [UIButton buttonWithType:UIButtonTypeRoundedRect] ;
    buttonTwo_.tag = 301;  // any tag here
    //If the device is an iPad then move the button over
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) 
        buttonTwo_.frame = CGRectMake(29, 5, 290, 34);
    else
        buttonTwo_.frame = CGRectMake(20, 5, 290, 34);
    
   
    [buttonTwo_ setTitle:self.buttonTwoText forState:UIControlStateNormal];
    
	[self.contentView addSubview:buttonTwo_];
    buttonTwo_.autoresizingMask=UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/


-(void)toggleButtonsWithButtonOneHidden:(BOOL)buttonOneHidden{
    
    if (!buttonOneHidden) {
        
        button_.hidden=YES;
        buttonTwo_.hidden=NO;
        
        
    }
    else {
        button_.hidden=NO;
        buttonTwo_.hidden=YES;
    }

//    [self setNeedsDisplay];

  
}

- (void)initWithOneText:(NSString *)text twoText:(NSString *)twoText
{
  
    self.buttonText = text;
    self.buttonTwoText=twoText;
    [self performInitialization];

}
@end