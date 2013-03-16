//
//  TouchyWebView.m
//  ELO
//
//  Created by Oliver on 06.09.09.
//  Copyright 2009 Drobnik.com. All rights reserved.
//

#import "TouchyWebView.h"

@implementation TouchyWebView

- (UIView *) hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(touchAtPoint:)])
    {
        [(id < TouchyDelegate >)self.delegate touchAtPoint : point];
    }

    return [super hitTest:point withEvent:event];
}


@end
