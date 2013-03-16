//
//  PDFHelper.m
//  PDFDemo
//
//  Created by Friendlydeveloper on 29.07.11.
//  Copyright 2011 www.codingsessions.com. All rights reserved.
//

#import "PDFHelper.h"
#import <QuartzCore/QuartzCore.h>

#define LEFT_MARGIN 50
#define RIGHT_MARGIN 50
#define TOP_MARGIN 36
#define BOTTOM_MARGIN 36
#define BOTTOM_FOOTER_MARGIN 32
#define DOC_WIDTH 612
#define DOC_HEIGHT 792

@implementation PDFHelper
@synthesize textArray;
@synthesize invisibleTextView;

- (void) createPDF:(NSString *)fileName withContent:(NSString *)content forSize:(int)fontSize andFont:(NSString *)font andColor:(UIColor *)color:(BOOL)allowCopy:(BOOL)allowPrint:(NSString *)password
{
    //create our invisibleTextView
    invisibleTextView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    textArray = [[NSMutableArray alloc] init];

    [textArray setArray:[content componentsSeparatedByString:@" "]];
    [invisibleTextView setText:content];

    CGContextRef pdfContext;
    CFStringRef path;
    CFURLRef url;
    CFStringRef passwordString = (CFStringRef)password;
    CGRect pageRect = CGRectMake(0, 0, DOC_WIDTH, DOC_HEIGHT);
    CFMutableDictionaryRef myDictionary = NULL;
    const char *filename = [fileName UTF8String];
    // Create a CFString from the filename we provide to this method when we call it
    path = CFStringCreateWithCString(NULL, filename,
                                     kCFStringEncodingUTF8);
    // Create a CFURL using the CFString we just defined
    url = CFURLCreateWithFileSystemPath(NULL, path,
                                        kCFURLPOSIXPathStyle, 0);
    //CFRelease (path);
    // This dictionary contains extra options mostly for 'signing' the PDF
    myDictionary = CFDictionaryCreateMutable(NULL, 0,
                                             &kCFTypeDictionaryKeyCallBacks,
                                             &kCFTypeDictionaryValueCallBacks);
    CFDictionarySetValue(myDictionary, kCGPDFContextTitle, (CFStringRef)fileName);
    CFDictionarySetValue(myDictionary, kCGPDFContextCreator, (CFStringRef)fileName);
    if (password != nil)
    {
        CFDictionarySetValue(myDictionary, kCGPDFContextOwnerPassword, passwordString);
    }

    if (password != nil)
    {
        CFDictionarySetValue(myDictionary, kCGPDFContextUserPassword, passwordString);
    }

    //if (![password isEqualToString:@""]) CFDictionarySetValue(myDictionary, kCGPDFContextEncryptionKeyLength, (CFStringRef)"128");
    //if (allowCopy) CFDictionarySetValue(myDictionary, kCGPDFContextAllowsCopying, kCFBooleanTrue);
    if (!allowCopy)
    {
        CFDictionarySetValue(myDictionary, kCGPDFContextAllowsCopying, kCFBooleanFalse);
    }

    //if (allowPrint) CFDictionarySetValue(myDictionary, kCGPDFContextAllowsPrinting, kCFBooleanTrue);
    if (!allowPrint)
    {
        CFDictionarySetValue(myDictionary, kCGPDFContextAllowsPrinting, kCFBooleanFalse);
    }

    // Create our PDF Context with the CFURL, the CGRect we provide, and the above defined dictionary
    pdfContext = CGPDFContextCreateWithURL(url, &pageRect, myDictionary);
    // Cleanup our mess
    CFRelease(myDictionary);
    CFRelease(url);
    //CFRelease(passwordString);

    //CFRange currentRange = CFRangeMake(0, 0);

    do
    {
        CGContextBeginPage(pdfContext, &pageRect);

        CGRect bounds = CGRectMake(LEFT_MARGIN,
                                   TOP_MARGIN,
                                   DOC_WIDTH - RIGHT_MARGIN - LEFT_MARGIN,
                                   DOC_HEIGHT - TOP_MARGIN - BOTTOM_MARGIN);

        UIGraphicsPushContext(pdfContext);
        CGContextSaveGState(pdfContext);
        CGContextTranslateCTM(pdfContext, 0, bounds.origin.y);
        CGContextScaleCTM(pdfContext, 1, -1);
        CGContextTranslateCTM( pdfContext, 0, -(bounds.origin.y + bounds.size.height) );
        if ([invisibleTextView.text length] > 0)
        {
            [[self stringToDraw:font fontSize:fontSize] drawInRect:bounds withFont:[UIFont fontWithName:font size:fontSize]];
        }

        CGContextRestoreGState(pdfContext);
        UIGraphicsPopContext();

        CGContextEndPage(pdfContext);
    }
    while (!done);

    // We are done with our context now, so we release it
    CGContextRelease(pdfContext);
    CFRelease(path);
}


- (NSString *) stringToDraw:(NSString *)font fontSize:(int)fontSize
{
    CGSize tempSize;
    CGSize theTextSize;
    tempSize.width = DOC_WIDTH - RIGHT_MARGIN - LEFT_MARGIN;
    tempSize.height = 10000000; //DOC_HEIGHT - TOP_MARGIN - BOTTOM_MARGIN;

    theTextSize = [invisibleTextView.text sizeWithFont:[UIFont fontWithName:font size:fontSize] constrainedToSize:tempSize];

    //NSLog(@"size.width:%f, size.height:%f", theTextSize.width, theTextSize.height);

    if (theTextSize.height > DOC_HEIGHT - TOP_MARGIN - BOTTOM_MARGIN)
    {
        //NSLog(@"Text exceeds bounds");
        BOOL match = NO;
        int wordCount = 0;
        float currentHeight = 0.0f;
        float previousHeight = 0.0f;
        NSString *returnString = [[[NSString alloc] init]autorelease];
        NSString *tempReturnString = [[[NSString alloc] init]autorelease];

        do
        {
            if ([textArray count] > wordCount + 1)
            {
                returnString = (wordCount > 0) ? [returnString stringByAppendingString:[NSString stringWithFormat:@" %@", [textArray objectAtIndex:wordCount]]] : [NSString stringWithFormat:@"%@", [textArray objectAtIndex:wordCount]];
                theTextSize = [returnString sizeWithFont:[UIFont fontWithName:font size:fontSize] constrainedToSize:CGSizeMake(DOC_WIDTH - RIGHT_MARGIN - LEFT_MARGIN, DOC_HEIGHT - TOP_MARGIN - BOTTOM_MARGIN)];
                //NSLog(@"Currentsize.width:%f, Currentsize.height:%f", theTextSize.width, theTextSize.height);
                currentHeight = theTextSize.height;

                if (theTextSize.height >= DOC_HEIGHT - TOP_MARGIN - BOTTOM_MARGIN)
                {
                    match = YES;
                    //NSLog(@"MATCH");
                }

                if (currentHeight == previousHeight && currentHeight > 700.0f)                   //sometimes the above is not accurate and the height is shorter than we think (because of large fonts)
                {                       //NSLog(@"FIXMATCH");
                    match = YES;
                    wordCount--;
                    returnString = tempReturnString;
                }

                wordCount++;
            }
            else
            {
                match = YES;
            }

            previousHeight = theTextSize.height;
            tempReturnString = returnString;
        }
        while (!match);

        for (int i = 0; i < wordCount; i++)
        {
            [textArray removeObjectAtIndex:0];
        }

        if ([textArray count])
        {
            invisibleTextView.text = [textArray componentsJoinedByString:@" "];
        }
        else
        {
            invisibleTextView.text = @"";
            done = YES;
        }

        if ([returnString length] == 0)
        {
            returnString = @" ";
        }

        return returnString;
    }
    else
    {
        done = YES;
        return invisibleTextView.text;
    }

    return invisibleTextView.text;
}


- (void) dealloc
{
    [invisibleTextView release];
    [textArray release];
    [super dealloc];
}


@end
