//
//  BigProgressViewWithBlockedView.h
//  PsyTrack Clinician Tools
//  Version: 1.5.4
//
//  Created by Daniel Boice on 7/19/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import "BigProgressView.h"

@interface BigProgressViewWithBlockedView : BigProgressView {
    UIView *sendingViewToBlock;
}

- (id) initWithFrame:(CGRect)frame blockedView:(UIView *)blockedView;
- (void) startAnimatingProgressInBackground;
@end
