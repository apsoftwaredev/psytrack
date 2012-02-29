/*
 *  SCBadgeView.m
 *  Sensible TableView
 *  Version: 2.2.0
 *
 *
 *	THIS SOURCE CODE AND ANY ACCOMPANYING DOCUMENTATION ARE PROTECTED BY UNITED STATES 
 *	INTELLECTUAL PROPERTY LAW AND INTERNATIONAL TREATIES. UNAUTHORIZED REPRODUCTION OR 
 *	DISTRIBUTION IS SUBJECT TO CIVIL AND CRIMINAL PENALTIES. YOU SHALL NOT DEVELOP NOR
 *	MAKE AVAILABLE ANY WORK THAT COMPETES WITH A SENSIBLE COCOA PRODUCT DERIVED FROM THIS 
 *	SOURCE CODE. THIS SOURCE CODE MAY NOT BE RESOLD OR REDISTRIBUTED ON A STAND ALONE BASIS.
 *
 *	USAGE OF THIS SOURCE CODE IS BOUND BY THE LICENSE AGREEMENT PROVIDED WITH THE 
 *	DOWNLOADED PRODUCT.
 *
 *  Copyright 2010-2011 Sensible Cocoa. All rights reserved.
 *
 *
 *	This notice may not be removed from this file.
 *
 */

#import "SCBadgeView.h"


@implementation SCBadgeView

@synthesize text;
@synthesize font;
@synthesize color;

- (id)initWithFrame:(CGRect)aRect
{
	if( (self = [super initWithFrame:aRect]) )
	{
		text = nil;
		font = SC_Retain([UIFont boldSystemFontOfSize: 16]);
		color = SC_Retain([UIColor colorWithRed:140.0f/255 green:153.0f/255 blue:180.0f/255 alpha:1]);
		
		self.backgroundColor = [UIColor clearColor];
	}
	
	return self;
}

#ifndef ARC_ENABLED
- (void)dealloc
{
	[text release];
	[font release];
	[color release];
	
	[super dealloc];
}
#endif

// overrides superclass
- (void)drawRect:(CGRect)rect
{
	if(!self.text)
		return;
	
	UIColor *badgeColor = self.color;
	UIView *spview = self.superview;
	while (spview)
	{
		if([spview isKindOfClass:[UITableViewCell class]])
		{
			UITableViewCell *ownerCell = (UITableViewCell *)spview;
			
			if( (ownerCell.highlighted || ownerCell.selected) && ownerCell.selectionStyle!=UITableViewCellEditingStyleNone )
				badgeColor = [UIColor whiteColor];
			
			break;
		}
		
		spview = spview.superview;
	}
	
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSaveGState(context);
	CGContextSetFillColorWithColor(context, [badgeColor CGColor]);
	CGContextBeginPath(context);
	CGFloat radius = self.bounds.size.height / 2.0;
	CGContextAddArc(context, radius, radius, radius, M_PI/2 , 3*M_PI/2, NO);
	CGContextAddArc(context, self.bounds.size.width - radius, radius, radius, 3*M_PI/2, M_PI/2, NO);
	CGContextClosePath(context);
	CGContextFillPath(context);
	CGContextRestoreGState(context);
	
	CGContextSetBlendMode(context, kCGBlendModeClear);
	
	CGSize textSize = CGSizeMake(0, 0);
	if(self.text)
		textSize = [self.text sizeWithFont:self.font];
	CGRect textBounds = CGRectMake(round((self.bounds.size.width-textSize.width)/2), 
								   round((self.bounds.size.height-textSize.height)/2), 
								   textSize.width, textSize.height);
	[self.text drawInRect:textBounds withFont:self.font];
}

- (void)setColor:(UIColor *)_color
{
	SC_Release(color);
	color = SC_Retain(_color);
	
	[self setNeedsDisplay];
}

- (void)setText:(NSString *)_text
{
	SC_Release(text);
	text = [_text copy];
	
	[self setNeedsDisplay];
}

- (void)setFont:(UIFont *)_font
{
	SC_Release(font);
	font = SC_Retain(_font);
	
	[self setNeedsDisplay];
}

@end
