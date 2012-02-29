//
//  UICasualAlertLabel.h
//  UICasualAlert
//
//  Created by Nils Munch on 7/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CasualAlertViewController;

@interface UICasualAlertLabel : UIView {
    CasualAlertViewController *manager;
    int segmentHeight;
    UILabel *innerLabel_;
    BOOL fading;
 
 
}

@property (nonatomic, strong) CasualAlertViewController *manager;
@property (nonatomic, strong) IBOutlet UILabel *innerLabel;
-(void)setText:(NSString*)text;
-(void)startFadeout;
-(void)setDuration:(float)seconds;

@end
