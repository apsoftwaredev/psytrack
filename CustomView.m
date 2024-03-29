/*
     File: CustomView.m
   Abstract: The custom view holding the image and title for the custom picker.
   Version: 2.10

   Disclaimer: IMPORTANT:  This Apple software is supplied to you by Apple
   Inc. ("Apple") in consideration of your agreement to the following
   terms, and your use, installation, modification or redistribution of
   this Apple software constitutes acceptance of these terms.  If you do
   not agree with these terms, please do not use, install, modify or
   redistribute this Apple software.

   In consideration of your agreement to abide by the following terms, and
   subject to these terms, Apple grants you a personal, non-exclusive
   license, under Apple's copyrights in this original Apple software (the
   "Apple Software"), to use, reproduce, modify and redistribute the Apple
   Software, with or without modifications, in source and/or binary forms;
   provided that if you redistribute the Apple Software in its entirety and
   without modifications, you must retain this notice and the following
   text and disclaimers in all such redistributions of the Apple Software.
   Neither the name, trademarks, service marks or logos of Apple Inc. may
   be used to endorse or promote products derived from the Apple Software
   without specific prior written permission from Apple.  Except as
   expressly stated in this notice, no other rights or licenses, express or
   implied, are granted by Apple herein, including but not limited to any
   patent rights that may be infringed by your derivative works or by other
   works in which the Apple Software may be incorporated.

   The Apple Software is provided by Apple on an "AS IS" basis.  APPLE
   MAKES NO WARRANTIES, EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION
   THE IMPLIED WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY AND FITNESS
   FOR A PARTICULAR PURPOSE, REGARDING THE APPLE SOFTWARE OR ITS USE AND
   OPERATION ALONE OR IN COMBINATION WITH YOUR PRODUCTS.

   IN NO EVENT SHALL APPLE BE LIABLE FOR ANY SPECIAL, INDIRECT, INCIDENTAL
   OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
   SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
   INTERRUPTION) ARISING IN ANY WAY OUT OF THE USE, REPRODUCTION,
   MODIFICATION AND/OR DISTRIBUTION OF THE APPLE SOFTWARE, HOWEVER CAUSED
   AND WHETHER UNDER THEORY OF CONTRACT, TORT (INCLUDING NEGLIGENCE),
   STRICT LIABILITY OR OTHERWISE, EVEN IF APPLE HAS BEEN ADVISED OF THE
   POSSIBILITY OF SUCH DAMAGE.

   Copyright (C) 2011 Apple Inc. All Rights Reserved.

 */

#import "CustomView.h"

#define MAIN_FONT_SIZE 18
#define MIN_MAIN_FONT_SIZE 16

@implementation CustomView

@synthesize title, imagePath;

const CGFloat kViewWidth = 200;
const CGFloat kViewHeight = 44;

+ (CGFloat) viewWidth
{
    return kViewWidth;
}


+ (CGFloat) viewHeight
{
    return kViewHeight;
}


- (id) initWithFrame:(CGRect)frame
{
    // use predetermined frame size
    self = [super initWithFrame:CGRectMake(0.0, 0.0, kViewWidth, kViewHeight)];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];            // make the background transparent
    }

    return self;
}


- (void) drawRect:(CGRect)rect
{
    // draw the image and title using their draw methods
    UIImage *image = [UIImage imageNamed:self.imagePath];

    CGFloat yCoord = (self.bounds.size.height - image.size.height) / 2;
    CGPoint point = CGPointMake(10.0, yCoord);
    [image drawAtPoint:point];

    yCoord = (self.bounds.size.height - MAIN_FONT_SIZE) / 2;
    point = CGPointMake(10.0 + image.size.width + 10.0, yCoord);
    [self.title drawAtPoint:point
                   forWidth:self.bounds.size.width
                   withFont:[UIFont systemFontOfSize:MAIN_FONT_SIZE]
                minFontSize:MIN_MAIN_FONT_SIZE
             actualFontSize:NULL
              lineBreakMode:UILineBreakModeTailTruncation
         baselineAdjustment:UIBaselineAdjustmentAlignBaselines];
}


// Enable accessibility for this view.
- (BOOL) isAccessibilityElement
{
    return YES;
}


// Return a string that describes this view.
- (NSString *) accessibilityLabel
{
    return self.title;
}


@end
