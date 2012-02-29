//
//  UICasualAlertLabel.m
//  UICasualAlert
//
//  Created by Nils Munch on 7/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UICasualAlertLabel.h"
#import "CasualAlertViewController.h"
#import "PTTAppDelegate.h"

@implementation UICasualAlertLabel

@synthesize manager;
@synthesize innerLabel=innerLabel_;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0.317586 green:0.623853 blue:0.77796 alpha:0.7];
        self.userInteractionEnabled = YES;
        self.innerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,self.frame.size.width, self.frame.size.height)];
        [self addSubview:innerLabel_];
        fading = NO;
        innerLabel_.textColor = [UIColor whiteColor];
        innerLabel_.backgroundColor = [UIColor clearColor];
        innerLabel_.font = [UIFont fontWithName:@"Helvetica-Bold" size:(14.0)];
        innerLabel_.textAlignment = UITextAlignmentCenter;
        innerLabel_.numberOfLines=3;
        innerLabel_.tag=456;
       innerLabel_.autoresizingMask=UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    }
    [UIView setAnimationDelegate:self];
    return self;
}


-(void)setText:(NSString*)text {
    innerLabel_.text = text;
}

-(void)setDuration:(float)seconds {
    [self performSelector:@selector(startFadeout) withObject:NULL afterDelay:seconds];
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self startFadeout];
}

-(void)startFadeout {
    if (fading != NO) {return;}
    fading = YES;
    [UIView transitionWithView:self duration:0.5 options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionAllowUserInteraction animations:^{self.alpha = 0.0;
	} completion:^(BOOL finished) {
		[self removeFromSuperview];
        fading = NO;
        [manager cleanAlertArea];
	}];
}

@end
