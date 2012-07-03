//
//  PDFRenderer.m
//  PsyTrack
//
//  Created by Daniel Boice on 6/24/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import "PDFRenderer.h"

#import "MonthlyPracticumLogTableViewController.h"
#import "PTTAppDelegate.h"
#import <QuartzCore/QuartzCore.h>

#define LEFT_MARGIN 0
#define RIGHT_MARGIN 0
#define TOP_MARGIN 0
#define BOTTOM_MARGIN 0
#define BOTTOM_FOOTER_MARGIN 0
#define DOC_WIDTH 612
#define DOC_HEIGHT 792




@implementation PDFRenderer


+(void)drawPDF:(NSString*)fileName
{
// Create the PDF context using the default page size of 612 x 792.
//UIGraphicsBeginPDFContextToFile(fileName, CGRectZero, nil);
//// Mark the beginning of a new page.
//UIGraphicsBeginPDFPageWithInfo(CGRectMake(0, 0, DOC_WIDTH, DOC_HEIGHT), nil);

//    PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
    
//
//    NSArray* objects = [[NSBundle mainBundle] loadNibNamed:@"MonthlyPracticumLogView" owner:nil options:nil];
//    
//    UIView* mainView = [objects objectAtIndex:0];

    MonthlyPracticumLogTableViewController *monthlyPracticumLogTVC=[[MonthlyPracticumLogTableViewController alloc]initWithNibName:@"MonthlyPracticumLogTableViewController" bundle:[NSBundle mainBundle]];
    
    [monthlyPracticumLogTVC loadView];
    [monthlyPracticumLogTVC viewDidLoad];
    [self createPDFfromUIView:monthlyPracticumLogTVC.view saveToDocumentsWithFileName:@"test2.pdf"];


// Close the PDF context and write the contents out.
//UIGraphicsEndPDFContext();
}
+(void)editTemplate{

    PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
    


    NSString *newFilePath = [[appDelegate applicationDocumentsDirectoryString]stringByAppendingPathComponent:@"monthlyPracticumLog.pdf"];
    NSString *templatePath = [[NSBundle mainBundle] pathForResource:@"may2012.pdf" ofType:nil];
    
    //create empty pdf file;
    UIGraphicsBeginPDFContextToFile(newFilePath, CGRectMake(0, 0, DOC_WIDTH, DOC_HEIGHT), nil);
    
    CFURLRef url = CFURLCreateWithFileSystemPath (NULL, (__bridge CFStringRef)templatePath, kCFURLPOSIXPathStyle, 0);
    
    //open template file
    CGPDFDocumentRef templateDocument = CGPDFDocumentCreateWithURL(url);
    CFRelease(url);
    
    //get amount of pages in template
    size_t count = CGPDFDocumentGetNumberOfPages(templateDocument);
    
    //for each page in template
    for (size_t pageNumber = 1; pageNumber <= count; pageNumber++) {
        //get bounds of template page
        CGPDFPageRef templatePage = CGPDFDocumentGetPage(templateDocument, pageNumber);
        CGRect templatePageBounds = CGPDFPageGetBoxRect(templatePage, kCGPDFCropBox);
        
        //create empty page with corresponding bounds in new document
        UIGraphicsBeginPDFPageWithInfo(templatePageBounds, nil);
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        //flip context due to different origins
        CGContextTranslateCTM(context, 0.0, templatePageBounds.size.height);
        CGContextScaleCTM(context, 0.73, -0.73);
        
        //copy content of template page on the corresponding page in new file
        CGContextDrawPDFPage(context, templatePage);
        
        //flip context back
        CGContextTranslateCTM(context, 0.0, templatePageBounds.size.height);
        CGContextScaleCTM(context, 0.73, -0.73);
        
        /* Here you can do any drawings */
        [@"Test" drawAtPoint:CGPointMake(200, 300) withFont:[UIFont systemFontOfSize:20]];
    }
    CGPDFDocumentRelease(templateDocument);
    UIGraphicsEndPDFContext();








}

+(void)drawPDFOld:(NSString*)fileName
{
    // Create the PDF context using the default page size of 612 x 792.
    UIGraphicsBeginPDFContextToFile(fileName, CGRectZero, nil);
    // Mark the beginning of a new page.
    UIGraphicsBeginPDFPageWithInfo(CGRectMake(0, 0, 612, 792), nil);
    
    [self drawText:@"Hello World" inFrame:CGRectMake(0, 0, 300, 50) font:nil];
    
    CGPoint from = CGPointMake(0, 0);
    CGPoint to = CGPointMake(200, 300);
    [PDFRenderer drawLineFromPoint:from toPoint:to];
    
    UIImage* logo = [UIImage imageNamed:@"ray-logo.png"];
    CGRect frame = CGRectMake(20, 100, 300, 60);
    
    [PDFRenderer drawImage:logo inRect:frame];
    
    [self drawLabels];
    [self drawLogo];
    
    // Close the PDF context and write the contents out.
    UIGraphicsEndPDFContext();
}

+(void)drawText
{
    
    NSString* textToDraw = @"Hello World";
    CFStringRef stringRef = (__bridge CFStringRef)textToDraw;
    // Prepare the text using a Core Text Framesetter
    CFAttributedStringRef currentText = CFAttributedStringCreate(NULL, stringRef, NULL);
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString(currentText);
    
    
    CGRect frameRect = CGRectMake(0, 0, 300, 50);
    CGMutablePathRef framePath = CGPathCreateMutable();
    CGPathAddRect(framePath, NULL, frameRect);
    
    // Get the frame that will do the rendering.
    CFRange currentRange = CFRangeMake(0, 0);
    CTFrameRef frameRef = CTFramesetterCreateFrame(framesetter, currentRange, framePath, NULL);
    CGPathRelease(framePath);
    
    // Get the graphics context.
    CGContextRef    currentContext = UIGraphicsGetCurrentContext();
    
    // Put the text matrix into a known state. This ensures
    // that no old scaling factors are left in place.
    CGContextSetTextMatrix(currentContext, CGAffineTransformIdentity);
    
    
    // Core Text draws from the bottom-left corner up, so flip
    // the current transform prior to drawing.
    CGContextTranslateCTM(currentContext, 0, 100);
    CGContextScaleCTM(currentContext, 1.0, -1.0);
    
    // Draw the frame.
    CTFrameDraw(frameRef, currentContext);
    CFRelease(currentText);
    CFRelease(frameRef);
    CFRelease(stringRef);
    CFRelease(framesetter);
}

+(void)drawLineFromPoint:(CGPoint)from toPoint:(CGPoint)to
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(context, 2.0);
    
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    
    CGFloat components[] = {0.2, 0.2, 0.2, 0.3};
    
    CGColorRef color = CGColorCreate(colorspace, components);
    
    CGContextSetStrokeColorWithColor(context, color);
    
    
    CGContextMoveToPoint(context, from.x, from.y);
    CGContextAddLineToPoint(context, to.x, to.y);
    
    CGContextStrokePath(context);
    CGColorSpaceRelease(colorspace);
    CGColorRelease(color);
    
}


+(void)drawImage:(UIImage*)image inRect:(CGRect)rect
{
    
    [image drawInRect:rect];
    
}




+(void)drawText:(NSString*)textToDraw inFrame:(CGRect)frameRect font:(UIFont *)stringFont
{
    
    CFStringRef stringRef = (__bridge CFStringRef)textToDraw;
    // Prepare the text using a Core Text Framesetter
    
    
    // create a font, quasi systemFontWithSize:24.0
	CTFontRef strUIFont = CTFontCreateWithName((__bridge CFStringRef)stringFont.fontName, 
                                               stringFont.pointSize, 
                                               NULL);
    
    

	// pack it into attributes dictionary
	NSDictionary *attributesDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                    (__bridge id)strUIFont, (id)kCTFontAttributeName,
                                     nil];
    
    
//	// make the attributed string
//	NSAttributedString *stringToDraw = [[NSAttributedString alloc] initWithString:string
//                                                                       attributes:attributesDict];
//    
    CFAttributedStringRef currentText = CFAttributedStringCreate(NULL, stringRef, (__bridge CFDictionaryRef)attributesDict);
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString(currentText);
    
    // Get the graphics context.
    CGContextRef    currentContext = UIGraphicsGetCurrentContext();
    
    CGRect newFrameframe= CGRectMake(frameRect.origin.x,frameRect.origin.y, frameRect.size.width, frameRect.size.height);
    
    
    
    CGMutablePathRef framePath = CGPathCreateMutable();
    CGPathAddRect(framePath, NULL, newFrameframe);
    
    // Get the frame that will do the rendering.
    CFRange currentRange = CFRangeMake(0, 0);
    CTFrameRef frameRef = CTFramesetterCreateFrame(framesetter, currentRange, framePath, NULL);
    CGPathRelease(framePath);
    
   
    // Put the text matrix into a known state. This ensures
    // that no old scaling factors are left in place.
    CGContextSetTextMatrix(currentContext, CGAffineTransformIdentity);
    
    
    // Core Text draws from the bottom-left corner up, so flip
    // the current transform prior to drawing.
    CGContextTranslateCTM(currentContext, -5, newFrameframe.origin.y*2);
    CGContextScaleCTM(currentContext, 1.0, -1.0);
    
    // Draw the frame.
    CTFrameDraw(frameRef, currentContext);
    
    CGContextScaleCTM(currentContext, 1.0, -1.0);
    CGContextTranslateCTM(currentContext, 0, (-1)*newFrameframe.origin.y*2);
    
    CFRelease(currentText);
    CFRelease(frameRef);
    CFRelease(stringRef);
    CFRelease(framesetter);
}


+(void)drawLabelText:(UILabel *)label
{
    
    CFStringRef stringRef = (__bridge CFStringRef)label.text;
    // Prepare the text using a Core Text Framesetter
    
    
    // create a font, quasi systemFontWithSize:24.0
	CTFontRef strUIFont = CTFontCreateWithName((__bridge CFStringRef)label.font.fontName, 
                                               label.font.pointSize, 
                                               NULL);
    
    //    create attributed string
    CFMutableAttributedStringRef attrStr = CFAttributedStringCreateMutable(kCFAllocatorDefault, 0);
    CFAttributedStringReplaceString (attrStr, CFRangeMake(0, 0), (CFStringRef) stringRef);
    
    
    //    create paragraph style and assign text alignment to it
    CTTextAlignment alignment = kCTJustifiedTextAlignment;
    
    if (label.textAlignment==UITextAlignmentCenter) {
        alignment=kCTCenterTextAlignment;
    }
    
    
    CTParagraphStyleSetting _settings[] = {    {kCTParagraphStyleSpecifierAlignment, sizeof(alignment), &alignment} };
    CTParagraphStyleRef paragraphStyle = CTParagraphStyleCreate(_settings, sizeof(_settings) / sizeof(_settings[0]));
    
    //    set paragraph style attribute
    CFAttributedStringSetAttribute(attrStr, CFRangeMake(0, CFAttributedStringGetLength(attrStr)), kCTParagraphStyleAttributeName, paragraphStyle);
    
    //    set font attribute
    CFAttributedStringSetAttribute(attrStr, CFRangeMake(0, CFAttributedStringGetLength(attrStr)), kCTFontAttributeName, strUIFont);
    
    //    release paragraph style and font
    CFRelease(paragraphStyle);
   

    
	// pack it into attributes dictionary
	NSDictionary *attributesDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                    (__bridge id)strUIFont, (id)kCTFontAttributeName,
                                    nil];
    
    
    //	// make the attributed string
    //	NSAttributedString *stringToDraw = [[NSAttributedString alloc] initWithString:string
    //                                                                       attributes:attributesDict];
    //    
    CFAttributedStringRef currentText = CFAttributedStringCreate(NULL, CFAttributedStringGetString(attrStr), (__bridge CFDictionaryRef)attributesDict);
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString(currentText);
    
    // Get the graphics context.
    CGContextRef    currentContext = UIGraphicsGetCurrentContext();
    
    
    
    
    CGMutablePathRef framePath = CGPathCreateMutable();
    CGPathAddRect(framePath, NULL, label.frame);
    
    // Get the frame that will do the rendering.
    CFRange currentRange = CFRangeMake(0, 0);
    CTFrameRef frameRef = CTFramesetterCreateFrame(framesetter, currentRange, framePath, NULL);
    CGPathRelease(framePath);
    
    
    // Put the text matrix into a known state. This ensures
    // that no old scaling factors are left in place.
    CGContextSetTextMatrix(currentContext, CGAffineTransformIdentity);
    
    
    // Core Text draws from the bottom-left corner up, so flip
    // the current transform prior to drawing.
    CGContextTranslateCTM(currentContext, -5, label.frame.origin.y*2);
    CGContextScaleCTM(currentContext, 1.0, -1.0);
    
    // Draw the frame.
    CTFrameDraw(frameRef, currentContext);
    
    CGContextScaleCTM(currentContext, 1.0, -1.0);
    CGContextTranslateCTM(currentContext, 0, (-1)*label.frame.origin.y*2);
    
     CFRelease(strUIFont);
    CFRelease(frameRef);
    CFRelease(currentText);
    CFRelease(attrStr);
    CFRelease(framesetter);
}


+(void)createPDFfromUIView:(UIView*)aView saveToDocumentsWithFileName:(NSString*)aFilename
{
    // Creates a mutable data object for updating with binary data, like a byte array
    NSMutableData *pdfData = [NSMutableData data];
    
    // Points the pdf converter to the mutable data object and to the UIView to be converted
    UIGraphicsBeginPDFContextToData(pdfData, aView.bounds, nil);
    UIGraphicsBeginPDFPage();
    CGContextRef pdfContext = UIGraphicsGetCurrentContext();
    
    
    // draws rect to the view and thus this is captured by UIGraphicsBeginPDFContextToData
    
    [aView.layer renderInContext:pdfContext];
    
    // remove PDF rendering context
    UIGraphicsEndPDFContext();
    
    // Retrieves the document directories from the iOS device
    NSArray* documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
    
    NSString* documentDirectory = [documentDirectories objectAtIndex:0];
    NSString* documentDirectoryFilename = [documentDirectory stringByAppendingPathComponent:aFilename];
    
    // instructs the mutable data object to write its context to a file on disk
    [pdfData writeToFile:documentDirectoryFilename atomically:YES];
    NSLog(@"documentDirectoryFileName: %@",documentDirectoryFilename);
}
+(void)drawLabels
{
    NSArray* objects = [[NSBundle mainBundle] loadNibNamed:@"MonthlyPracticumLogView" owner:nil options:nil];
    
    UIView* mainView = [objects objectAtIndex:0];
        
    for (UIView* view in [mainView subviews]) {
        if([view isKindOfClass:[UILabel class]])
        {
            UILabel* label = (UILabel*)view;
                       
            [self drawText:label.text inFrame:(CGRect)label.frame font:(UIFont *)label.font];
        }
    }
    
}


+(void)drawLogo
{
    
    NSArray* objects = [[NSBundle mainBundle] loadNibNamed:@"InvoiceView" owner:nil options:nil];
    
    UIView* mainView = [objects objectAtIndex:0];
    
    for (UIView* view in [mainView subviews]) {
        if([view isKindOfClass:[UIImageView class]])
        {
            
            UIImage* logo = [UIImage imageNamed:@"ray-logo.png"];
            [self drawImage:logo inRect:view.frame];
        }
    }
    
}


+(void)drawTableAt:(CGPoint)origin 
     withRowHeight:(int)rowHeight 
    andColumnWidth:(int)columnWidth 
       andRowCount:(int)numberOfRows 
    andColumnCount:(int)numberOfColumns

{
    
    for (int i = 0; i <= numberOfRows; i++) {
        
        int newOrigin = origin.y + (rowHeight*i);
        
        
        CGPoint from = CGPointMake(origin.x, newOrigin);
        CGPoint to = CGPointMake(origin.x + (numberOfColumns*columnWidth), newOrigin);
        
        [self drawLineFromPoint:from toPoint:to];
        
        
    }
    
    for (int i = 0; i <= numberOfColumns; i++) {
        
        int newOrigin = origin.x + (columnWidth*i);
        
        
        CGPoint from = CGPointMake(newOrigin, origin.y);
        CGPoint to = CGPointMake(newOrigin, origin.y +(numberOfRows*rowHeight));
        
        [self drawLineFromPoint:from toPoint:to];
        
        
    }
}

+(void)drawTableDataAt:(CGPoint)origin 
         withRowHeight:(int)rowHeight 
        andColumnWidth:(int)columnWidth 
           andRowCount:(int)numberOfRows 
        andColumnCount:(int)numberOfColumns
{
    int padding = 10; 
    
    NSArray* headers = [NSArray arrayWithObjects:@"Quantity", @"Description", @"Unit price", @"Total", nil];
    NSArray* invoiceInfo1 = [NSArray arrayWithObjects:@"1", @"Development", @"$1000", @"$1000", nil];
    NSArray* invoiceInfo2 = [NSArray arrayWithObjects:@"1", @"Development", @"$1000", @"$1000", nil];
    NSArray* invoiceInfo3 = [NSArray arrayWithObjects:@"1", @"Development", @"$1000", @"$1000", nil];
    NSArray* invoiceInfo4 = [NSArray arrayWithObjects:@"1", @"Development", @"$1000", @"$1000", nil];
    
    NSArray* allInfo = [NSArray arrayWithObjects:headers, invoiceInfo1, invoiceInfo2, invoiceInfo3, invoiceInfo4, nil];
    
    for(int i = 0; i < [allInfo count]; i++)
    {
        NSArray* infoToDraw = [allInfo objectAtIndex:i];
        
        for (int j = 0; j < numberOfColumns; j++) 
        {
            
            int newOriginX = origin.x + (j*columnWidth);
            int newOriginY = origin.y + ((i+1)*rowHeight);
            
            CGRect frame = CGRectMake(newOriginX + padding, newOriginY + padding, columnWidth, rowHeight);
            
            
            [self drawText:[infoToDraw objectAtIndex:j] inFrame:frame font:nil];
        }
        
    }
    
}


+(CGFloat )adjustToCenterVertically:(CGRect )frame font:(CTFontRef )iFont{

    CGFloat fontLineHeight=GetLineHeightForFont(iFont);
    
    
    CGFloat frameHeight=frame.size.height;
    
    CGFloat newStartingYPoint=((frameHeight /2)-(fontLineHeight/2))+frame.origin.y;




    return newStartingYPoint;

}

+(CGFloat )adjustToCenterHorizontally:(CGRect )frame context:(CGContextRef )context string:(NSString * )str {
    
    NSLog(@"frame is %g",frame.size.width);
    CGFloat frameWidth=frame.size.width;
    CGFloat textWidth=[self widthOfText:context string:str];
    NSLog(@"textWidth %g",textWidth);
    CGFloat newStartingXPoint=(frameWidth/2)-(textWidth/2);
    
    
    
    return newStartingXPoint;
    
}




+(CGFloat )widthOfText:(CGContextRef )contxt string:(NSString *)str {
    
    CGFloat sizeToReturn= 0;

    CGPoint textStartPosition= CGContextGetTextPosition(contxt);
    NSLog(@"start point is %g",textStartPosition);
    
    CGContextSetTextDrawingMode(contxt, kCGTextInvisible);
    CGContextSetTextPosition(contxt, 0, 0);
    
    CGContextShowText(contxt,[str cStringUsingEncoding:[NSString defaultCStringEncoding]], str.length);
   
    CGPoint textEndPosition=CGContextGetTextPosition(contxt);
    
     CGContextSetTextDrawingMode(contxt, kCGTextFill);
    NSLog(@"text end position is %g",textEndPosition);
    sizeToReturn=textEndPosition.x-textStartPosition.x;
    
    return sizeToReturn;
}



CGFloat GetLineHeightForFont(CTFontRef iFont)
{
    CGFloat lineHeight = 0.0;
    
    if (iFont!=NULL) {
    
    
    // Get the ascent from the font, already scaled for the font's size
    lineHeight += CTFontGetAscent(iFont);
    
    // Get the descent from the font, already scaled for the font's size
    lineHeight += CTFontGetDescent(iFont);
    
    // Get the leading from the font, already scaled for the font's size
    lineHeight += CTFontGetLeading(iFont);
        
    }
    return lineHeight;
}




@end