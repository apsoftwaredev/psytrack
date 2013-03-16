//
//  DTPageControl.m
//  About
//
//  Created by Oliver Drobnik on 2/16/10.
//  Copyright 2010 Drobnik.com. All rights reserved.
//

#import "DTPageControl.h"

@implementation DTPageControl
@synthesize dotSelectedImage, dotImage;

- (id) initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
    }

    return self;
}


- (void) updateDots
{
    if (!dotImage || !dotSelectedImage)
    {
        return;
    }

    int idx = 0;
    for (UIView *oneView in self.subviews)
    {
        if ([oneView isKindOfClass:[ UIImageView class] ] )
        {
            if (idx == self.currentPage)
            {
                ( (UIImageView *)oneView ).image = dotSelectedImage;
            }
            else
            {
                ( (UIImageView *)oneView ).image = dotImage;
            }

            CGRect frame = oneView.bounds;
            frame.size = ( (UIImageView *)oneView ).image.size;
            oneView.bounds = frame;

            idx++;
        }
    }
}


/** override to update dots */
- (void) setCurrentPage:(NSInteger)currentPage
{
    if (currentPage != [super currentPage])
    {
        [super setCurrentPage:currentPage];

        // update dot views
        [self updateDots];

        // redraw
        [self setNeedsDisplay];
    }
}


- (void) setNumberOfPages:(NSInteger)newNumber
{
    if (newNumber != [super numberOfPages])
    {
        [super setNumberOfPages:newNumber];

        // update dot views
        [self updateDots];

        // redraw
        [self setNeedsDisplay];
    }
}


/** override to update dots */
- (void) updateCurrentPageDisplay
{
    [super updateCurrentPageDisplay];

    // update dot views
    [self updateDots];

    [self setNeedsDisplay];
}


- (void) drawRect:(CGRect)rect
{
    if (self.numberOfPages == 1)
    {
        CGContextRef ctx = UIGraphicsGetCurrentContext();

        CGSize dotSize;

        if (dotImage)
        {
            dotSize = dotImage.size;
        }
        else
        {
            dotSize = CGSizeMake(6.0, 6.0);
        }

        CGFloat widthNeeded = self.numberOfPages * dotSize.width + (self.numberOfPages - 1) * 10.0;

        CGFloat x = (self.bounds.size.width - widthNeeded) / 2.0;

        for (int i = 0; i < self.numberOfPages; i++)
        {
            CGRect circleRect = CGRectMake(x, (self.bounds.size.height - dotSize.height) / 2.0, dotSize.width, dotSize.height);
            CGContextSetGrayFillColor(ctx, 1.0, 1.0);

            x += circleRect.size.width + 10.0;
            CGContextFillEllipseInRect(ctx, circleRect);
        }
    }
}


- (void) dealloc
{
    [super dealloc];
}


@end
