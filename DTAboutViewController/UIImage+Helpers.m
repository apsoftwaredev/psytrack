//
//  UIImage+Helpers.m
//  ASiST
//
//  Created by Oliver on 11.09.09.
//  Copyright 2009 Drobnik.com. All rights reserved.
//

#import "UIImage+Helpers.h"

@implementation UIImage (Helpers)

static void addRoundedRectToPath(CGContextRef context, CGRect rect, float ovalWidth, float ovalHeight)
{
    float fw, fh;
    if (ovalWidth == 0 || ovalHeight == 0)
    {
        CGContextAddRect(context, rect);
        return;
    }

    CGContextSaveGState(context);
    CGContextTranslateCTM( context, CGRectGetMinX(rect), CGRectGetMinY(rect) );
    CGContextScaleCTM(context, ovalWidth, ovalHeight);
    fw = CGRectGetWidth(rect) / ovalWidth;
    fh = CGRectGetHeight(rect) / ovalHeight;
    CGContextMoveToPoint(context, fw, fh / 2);
    CGContextAddArcToPoint(context, fw, fh, fw / 2, fh, 1);
    CGContextAddArcToPoint(context, 0, fh, 0, fh / 2, 1);
    CGContextAddArcToPoint(context, 0, 0, fw / 2, 0, 1);
    CGContextAddArcToPoint(context, fw, 0, fw, fh / 2, 1);
    CGContextClosePath(context);
    CGContextRestoreGState(context);
}


+ (UIImage *) makeRoundCornerImage:(UIImage *)img cornerWidth:(int)cornerWidth cornerHeight:(int)cornerHeight
{
    UIImage *newImage = nil;

    if ( nil != img)
    {
        int w = img.size.width;
        int h = img.size.height;

        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGContextRef context = CGBitmapContextCreate(NULL, w, h, 8, 4 * w, colorSpace, kCGBitmapAlphaInfoMask);

        CGContextBeginPath(context);
        CGRect rect = CGRectMake(0, 0, img.size.width, img.size.height);
        addRoundedRectToPath(context, rect, cornerWidth, cornerHeight);
        CGContextClosePath(context);
        CGContextClip(context);

        CGContextDrawImage(context, CGRectMake(0, 0, w, h), img.CGImage);

        CGImageRef imageMasked = CGBitmapContextCreateImage(context);
        CGContextRelease(context);
        CGColorSpaceRelease(colorSpace);

        newImage = [UIImage imageWithCGImage:imageMasked];
        CGImageRelease(imageMasked);
    }

    return newImage;
}


- (UIImage *) imageByMaskingWithImage:(UIImage *)maskImage
{
    CGImageRef maskRef = maskImage.CGImage;

    CGImageRef mask = CGImageMaskCreate(CGImageGetWidth(maskRef),
                                        CGImageGetHeight(maskRef),
                                        CGImageGetBitsPerComponent(maskRef),
                                        CGImageGetBitsPerPixel(maskRef),
                                        CGImageGetBytesPerRow(maskRef),
                                        CGImageGetDataProvider(maskRef), NULL, false);

    CGImageRef masked = CGImageCreateWithMask([self CGImage], mask);
    CGImageRelease(mask);
    UIImage *retImage = [UIImage imageWithCGImage:masked];
    CGImageRelease(masked);
    return retImage;
}


+ (CGContextRef) newBitmapContextWithSize:(CGSize)size
{
    int pixelsWide = size.width;
    int pixelsHigh = size.height;
    CGContextRef context = NULL;
    CGColorSpaceRef colorSpace;
    void *bitmapData;
    int bitmapByteCount;
    int bitmapBytesPerRow;

    bitmapBytesPerRow = (pixelsWide * 4);  // 1
    bitmapByteCount = (bitmapBytesPerRow * pixelsHigh);

    colorSpace = CGColorSpaceCreateDeviceRGB();  // modification from sample
    bitmapData = malloc( bitmapByteCount );

    memset(bitmapData, 0, bitmapByteCount);      // black 100% transparent
    if (bitmapData == NULL)
    {
        CGColorSpaceRelease( colorSpace );
        fprintf(stderr, "Memory not allocated!");
        return NULL;
    }

    context = CGBitmapContextCreate(bitmapData,
                                    pixelsWide,
                                    pixelsHigh,
                                    8,                                           // bits per component
                                    bitmapBytesPerRow,
                                    colorSpace,
                                    kCGBitmapAlphaInfoMask);
    if (context == NULL)
    {
        CGColorSpaceRelease( colorSpace );
        free(bitmapData);
        fprintf(stderr, "Context not created!");
        return NULL;
    }

    CGColorSpaceRelease( colorSpace );
    free(bitmapData);
    return context;
}


// made thread-safe
+ (UIImage *) imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;
{
    CGContextRef bitmapContext = [UIImage newBitmapContextWithSize:newSize];

    CGContextDrawImage(bitmapContext, CGRectMake(0,0,newSize.width,newSize.height), image.CGImage);
    CGImageRef cImage = CGBitmapContextCreateImage(bitmapContext);
    UIImage *newImage = [UIImage imageWithCGImage:cImage];

    CGContextRelease(bitmapContext);
    CGImageRelease(cImage);

    return newImage;
}

- (UIImage *) scaleImageToSize:(CGSize)newSize
{
    return [UIImage imageWithImage:self scaledToSize:newSize];
}


@end
