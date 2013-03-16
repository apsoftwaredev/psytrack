//
//  DTButton.m
//  About
//
//  Created by Oliver Drobnik on 2/19/10.
//  Copyright 2010 Drobnik.com. All rights reserved.
//

#import "DTButton.h"

@implementation DTButton
@synthesize style;

- (void) setup
{
    gradientLayer = [[CAGradientLayer alloc] init];

    // Set its bounds to be the same of its parent
    [gradientLayer setBounds:[self bounds]];

    // Center the layer inside the parent layer
    [gradientLayer setPosition:
     CGPointMake([self bounds].size.width / 2, [self bounds].size.height / 2)];

    // Insert the layer at position zero to make sure the text of the button is not obscured
    [[self layer] insertSublayer:gradientLayer atIndex:0];

    // Set the layer's corner radius
    [[self layer] setCornerRadius:8.0f];

    // Turn on masking
    [[self layer] setMasksToBounds:YES];

    // Display a border around the button
    // with a 1.0 pixel width
    [[self layer] setBorderWidth:2.0f];

    self.highlighted = NO;

    self.adjustsImageWhenHighlighted = YES;
}


- (id) initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        // Initialization code
        [self setup];
    }

    return self;
}


- (void) layoutSubviews
{
    [super layoutSubviews];
    gradientLayer.frame = self.bounds;
}


- (void) adjustGradientColors
{
    switch (style)
    {
        case DTButtonStyleBotBlue:
        {
            if (self.highlighted)
            {
                [gradientLayer setColors:[NSArray arrayWithObjects:(id)[UIColor colorWithRed : 8.0 / 255.0 green : 59.0 / 255.0 blue : 90.0 / 255.0 alpha : 1.0].CGColor,
                                          (id)[UIColor colorWithRed : 16.0 / 255.0 green : 80.0 / 255.0 blue : 139.0 / 255.0 alpha : 1.0].CGColor, nil]];
            }
            else
            {
                [gradientLayer setColors:[NSArray arrayWithObjects:(id)[UIColor colorWithRed : 78.0 / 255.0 green : 158.0 / 255.0 blue : 206.0 / 255.0 alpha : 1.0].CGColor,
                                          (id)[UIColor colorWithRed : 13.0 / 255.0 green : 76.0 / 255.0 blue : 136.0 / 255.0 alpha : 1.0].CGColor, nil]];
            }

            break;
        }
        case DTButtonStyleBotGreen:
        {
            if (self.highlighted)
            {
                [gradientLayer setColors:[NSArray arrayWithObjects:(id)[UIColor colorWithRed : 46.0 / 255.0 green : 72.0 / 255.0 blue : 6.0 / 255.0 alpha : 1.0].CGColor,
                                          (id)[UIColor colorWithRed : 60.0 / 255.0 green : 90.0 / 255.0 blue : 13.0 / 255.0 alpha : 1.0].CGColor, nil]];
            }
            else
            {
                [gradientLayer setColors:[NSArray arrayWithObjects:(id)[UIColor colorWithRed : 140.0 / 255.0 green : 179.0 / 255.0 blue : 51.0 / 255.0 alpha : 1.0].CGColor,
                                          (id)[UIColor colorWithRed : 83.0 / 255.0 green : 110.0 / 255.0 blue : 39.0 / 255.0 alpha : 1.0].CGColor, nil]];
            }

            break;
        }
        case DTButtonStyleBotRed:
        {
            if (self.highlighted)
            {
                [gradientLayer setColors:[NSArray arrayWithObjects:(id)[UIColor colorWithRed : 83.0 / 255.0 green : 0 / 255.0 blue : 0 / 255.0 alpha : 1.0].CGColor,
                                          (id)[UIColor colorWithRed : 89.0 / 255.0 green : 1.0 / 255.0 blue : 1.0 / 255.0 alpha : 1.0].CGColor, nil]];
            }
            else
            {
                [gradientLayer setColors:[NSArray arrayWithObjects:(id)[UIColor colorWithRed : 160.0 / 255.0 green : 1.0 / 255.0 blue : 1.0 / 255.0 alpha : 1.0].CGColor,
                                          (id)[UIColor colorWithRed : 108.0 / 255.0 green : 27.0 / 255.0 blue : 27.0 / 255.0 alpha : 1.0].CGColor, nil]];
            }

            break;
        }
        case DTButtonStyleBotGray:
        {
            if (self.highlighted)
            {
                [gradientLayer setColors:[NSArray arrayWithObjects:(id)[UIColor colorWithRed : 47.0 / 255.0 green : 48.0 / 255.0 blue : 49.0 / 255.0 alpha : 1.0].CGColor,
                                          (id)[UIColor colorWithRed : 67.0 / 255.0 green : 67.0 / 255.0 blue : 70.0 / 255.0 alpha : 1.0].CGColor, nil]];
            }
            else
            {
                [gradientLayer setColors:[NSArray arrayWithObjects:(id)[UIColor colorWithRed : 111.0 / 255.0 green : 114.0 / 255.0 blue : 116.0 / 255.0 alpha : 1.0].CGColor,
                                          (id)[UIColor colorWithRed : 69.0 / 255.0 green : 69.0 / 255.0 blue : 71.0 / 255.0 alpha : 1.0].CGColor, nil]];
            }

            break;
        }
        default:
            break;
    } /* switch */
}


- (void) setHighlighted:(BOOL)newHighlighted
{
    [super setHighlighted:newHighlighted];

    [self adjustGradientColors];
}


- (void) setStyle:(DTButtonStyle)newStyle
{
    if (newStyle != style)
    {
        style = newStyle;
        [self adjustGradientColors];
    }
}


- (void) drawRect:(CGRect)rect
{
    // Drawing code

    [super drawRect:rect];

    CGContextRef ctx = UIGraphicsGetCurrentContext();

    [[UIColor whiteColor] set];
    CGContextFillRect( ctx, CGRectMake(0, 0, self.bounds.size.width, 5.0) );
}


@end
