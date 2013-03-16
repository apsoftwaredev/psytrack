//
//  UILabel+Helpers.m
//  About
//
//  Created by Oliver Drobnik on 2/18/10.
//  Copyright 2010 Drobnik.com. All rights reserved.
//

#import "UILabel+Helpers.h"

@implementation UILabel (Helpers)

+ (UILabel *) autosizedLabelToFitText:(NSString *)text withFont:(UIFont *)font constrainedToSize:(CGSize)size
{
    UILabel *retLabel = [[UILabel alloc] init];
    retLabel.font = font;
    retLabel.numberOfLines = 0;     // multi-line

    CGSize sizeNeeded = [text sizeWithFont:font constrainedToSize:size];
    retLabel.frame = CGRectMake(0, 0, size.width, sizeNeeded.height);     // we use the maximum width, aligment is set with textAlignment
    retLabel.text = text;

    retLabel.opaque = NO;
    retLabel.backgroundColor = [UIColor clearColor];

    return retLabel;
}


@end
