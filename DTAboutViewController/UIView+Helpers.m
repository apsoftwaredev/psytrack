//
//  UIView+Helpers.m
//  About
//
//  Created by Oliver Drobnik on 2/18/10.
//  Copyright 2010 Drobnik.com. All rights reserved.
//

#import "UIView+Helpers.h"
#import <QuartzCore/QuartzCore.h>


@implementation UIView (Helpers)


- (UIView *)viewByWrappingViewWithMargins:(UIEdgeInsets)margins
{
	UIView *newView = [[UIView alloc] init];
	newView.autoresizingMask = self.autoresizingMask;

	
	newView.frame = CGRectMake(0, 0, self.bounds.size.width + margins.left + margins.right, self.bounds.size.height + margins.top + margins.bottom);
	self.frame = CGRectMake(margins.left, margins.top, self.bounds.size.width, self.bounds.size.height);
	
	[newView addSubview:self];
	newView.opaque = NO;
	
	return newView ;
}


- (void) logSubviews
{
	NSEnumerator *enumerator = [self.subviews objectEnumerator];
	UIView *anObject;
	
	while ((anObject = [enumerator nextObject])) {
		if( [anObject isKindOfClass: [ UIView class] ] )
		{
			//NSLog(@"%@", anObject);
			
			[ anObject logSubviews];
		}
	}
}


- (void) setRoundedCornersWithRadius:(CGFloat)radius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor
{
	self.clipsToBounds = YES;
	self.layer.cornerRadius = radius;
	self.layer.borderWidth = borderWidth;
	
	if (borderColor)
	{
		self.layer.borderColor = borderColor.CGColor;
	}
}

@end
