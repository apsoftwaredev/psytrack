//
//  UIView+Helpers.h
//  About
//
//  Created by Oliver Drobnik on 2/18/10.
//  Copyright 2010 Drobnik.com. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UIView (Helpers)

// adds a view as parent with the given margins
- (UIView *)viewByWrappingViewWithMargins:(UIEdgeInsets)margins;

// useful for debugging
- (void) logSubviews;

// set rounded corners
- (void) setRoundedCornersWithRadius:(CGFloat)radius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;


@end
