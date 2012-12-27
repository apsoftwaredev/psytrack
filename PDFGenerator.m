//
//  PDFGenerator.m
//  PsyTrack
//
//  Created by Daniel Boice on 11/13/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import "PDFGenerator.h"
#import <QuartzCore/QuartzCore.h>
#import "ClientsSelectionCell.h"
#import "SuicidaltiyCell.h"
#import "ClinicianTypeEntity.h"
#import "ClientEntity.h"
#import "ClientsSelectionCell.h"

#define LEFT_MARGIN 50
#define RIGHT_MARGIN 50
#define TOP_MARGIN 36
#define BOTTOM_MARGIN 36
#define BOTTOM_FOOTER_MARGIN 32
#define DOC_WIDTH 612
#define DOC_HEIGHT 792

@implementation PDFGenerator
@synthesize textArray;
@synthesize invisibleTextView;


- (void)createPDF:(NSString *)fileName presentationTableModel:(SCArrayOfObjectsModel *)presentationTableModel trackText:(NSString *)trackText   serviceDateTimeStr:(NSString *)serviceDateTimeStr clinician:(ClinicianEntity*)clinician forSize:(int)fontSize andFont:(NSString *)font andColor:(UIColor *)color:(BOOL)allowCopy:(BOOL)allowPrint:(NSString*)password{
    
    //create our invisibleTextView
//    invisibleTextView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
//    textArray = [[NSMutableArray alloc] init];
//    NSString *content=[self getContentFromTableModel:presentationTableModel];
    
    
    
    
//    [textArray setArray:[content componentsSeparatedByString:@" "]];
//    [invisibleTextView setText:content];
    
    
	CGContextRef pdfContext;
	CFStringRef path;
	CFURLRef url;
	CFStringRef passwordString = (__bridge CFStringRef)password;
	CGRect pageRect = CGRectMake(0, 0, DOC_WIDTH, DOC_HEIGHT);
	CFMutableDictionaryRef myDictionary = NULL;
    
    NSArray* documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
    
    NSString* documentDirectory = [documentDirectories objectAtIndex:0];
    NSString* documentDirectoryFilename = [documentDirectory stringByAppendingPathComponent:fileName];
    
    
    //                          // Creates a mutable data object for updating with binary data, like a byte array
    NSMutableData *pdfData = [NSMutableData data];
  
    
	const char *filename = [documentDirectoryFilename UTF8String];
	// Create a CFString from the filename we provide to this method when we call it
	path = CFStringCreateWithCString (NULL, filename,
									  kCFStringEncodingUTF8);
	// Create a CFURL using the CFString we just defined
	url = CFURLCreateWithFileSystemPath (NULL, path,
										 kCFURLPOSIXPathStyle, 0);
	//CFRelease (path);
	// This dictionary contains extra options mostly for 'signing' the PDF
	myDictionary = CFDictionaryCreateMutable(NULL, 0,
											 &kCFTypeDictionaryKeyCallBacks,
											 &kCFTypeDictionaryValueCallBacks);
	CFDictionarySetValue(myDictionary, kCGPDFContextTitle, (CFStringRef)fileName);
	CFDictionarySetValue(myDictionary, kCGPDFContextCreator, (CFStringRef)fileName);
	if (password != nil) CFDictionarySetValue(myDictionary, kCGPDFContextOwnerPassword, passwordString);
	if (password != nil) CFDictionarySetValue(myDictionary, kCGPDFContextUserPassword, passwordString);
	//if (![password isEqualToString:@""]) CFDictionarySetValue(myDictionary, kCGPDFContextEncryptionKeyLength, (CFStringRef)"128");
	//if (allowCopy) CFDictionarySetValue(myDictionary, kCGPDFContextAllowsCopying, kCFBooleanTrue);
	if (!allowCopy) CFDictionarySetValue(myDictionary, kCGPDFContextAllowsCopying, kCFBooleanFalse);
	//if (allowPrint) CFDictionarySetValue(myDictionary, kCGPDFContextAllowsPrinting, kCFBooleanTrue);
	if (!allowPrint) CFDictionarySetValue(myDictionary, kCGPDFContextAllowsPrinting, kCFBooleanFalse);
	
	
	// Create our PDF Context with the CFURL, the CGRect we provide, and the above defined dictionary
//	pdfContext = CGPDFContextCreateWithURL (url, &pageRect, myDictionary);
	
//      UIGraphicsBeginPDFContextToData(pdfData, aView.bounds, NULL);
//    CGContextRef pdfContext;
    
    //
    //                        CGRect pageRect = aView.bounds;
    
    // Create our PDF Context with the CFURL, the CGRect we provide, and the above defined dictionary
    
    
  
    
 

    // Cleanup our mess
		//CFRelease(passwordString);
	
	//CFRange currentRange = CFRangeMake(0, 0);
    NSString *clinicianString=nil;
    if (clinician) {
        clinicianString=clinician.combinedName;
        if (clinicianString&& clinician.clinicianType) {
            
            
            NSString *clinicianTypeString=nil;
            
            for (ClinicianTypeEntity *clinicianType in clinician.clinicianType.allObjects) {
               
                if (clinicianTypeString&&clinicianTypeString.length) {
                    
                    clinicianTypeString=[clinicianTypeString stringByAppendingFormat:@", %@",clinicianType.clinicianType];
                
                }
              
                else if ([clinicianType.clinicianType isKindOfClass:[NSString class]]&&clinicianType.clinicianType.length) {
                    clinicianTypeString=clinicianType.clinicianType;
                }
            
            }
                   
        
           if ([clinicianString isKindOfClass:[NSString class]] &&clinicianTypeString&&clinicianTypeString.length) {
                clinicianString=[clinicianString stringByAppendingFormat:@" (%@)",clinicianTypeString ];
            }
        }
        clinicianString=[@"Provider: " stringByAppendingString:clinicianString];
        
    }
    NSString *clientIDCodeStr=nil;
    if (presentationTableModel && presentationTableModel.sectionCount>0) {
        SCTableViewSection *firstSection=(SCTableViewSection *)[presentationTableModel sectionAtIndex:0];
        if (firstSection.cellCount>0) {
            SCTableViewCell *clientCell=(SCTableViewCell *)[firstSection cellAtIndex:0];
            
            if ([clientCell isKindOfClass:[ClientsSelectionCell class]]) {
                ClientsSelectionCell *clientSelectionCell=(ClientsSelectionCell *)clientCell;
                ClientEntity *clientObject=(ClientEntity *)clientSelectionCell.clientObject;
                if (clientObject &&clientObject.clientIDCode) {
                    clientIDCodeStr= clientObject.clientIDCode;
                    
                }
               
                if (firstSection.cellCount>1) {
                    SCLabelCell *ageCell=(SCLabelCell *)[firstSection cellAtIndex:1];
                    if (ageCell && [ageCell isKindOfClass:[SCLabelCell class]]&& ageCell.label.text && (![ageCell.label.text isEqualToString:@"choose client"]||[ageCell.label.text isEqualToString:@"no birthdate"])&&clientIDCodeStr &&clientObject.dateOfBirth) {
                    
                        
                            NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
                            [dateFormatter setDateFormat:@"M/d/yyyy"];
                            clientIDCodeStr =[clientIDCodeStr stringByAppendingFormat:@"  (DOB: %@, Age: %@)",[dateFormatter stringFromDate: clientObject.dateOfBirth], ageCell.label.text];
                        
                            dateFormatter=nil;
                        
                        
                    }
                    
                }
            }
            
        }
       
        
    }
    CGRect pageBounds = CGRectMake(0,
                               0,
                               DOC_WIDTH,
                               DOC_HEIGHT );
    
      UIGraphicsBeginPDFContextToData(pdfData, pageBounds, NULL);
  
       pdfContext=UIGraphicsGetCurrentContext();
    
    int pageCount=0;
    
    NSString *presentationTableModelString=[self getContentFromTableModel:presentationTableModel];
    
    DLog(@"print presentation string %@",presentationTableModelString);
    //
    // Clean up
    
    
    //		if ([invisibleTextView.text length] > 0) [[self stringToDraw:font fontSize:fontSize] drawInRect:bounds withFont:[UIFont fontWithName:font size:fontSize]];
    //		CGContextRestoreGState(pdfContext);
    //		UIGraphicsPopContext();
    //create our invisibleTextView
    invisibleTextView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, DOC_WIDTH-RIGHT_MARGIN-LEFT_MARGIN, DOC_HEIGHT-BOTTOM_FOOTER_MARGIN-BOTTOM_MARGIN-TOP_MARGIN)];
    textArray = [[NSMutableArray alloc] init];
    
    [textArray setArray:[presentationTableModelString componentsSeparatedByString:@" "]];
    [invisibleTextView setText:presentationTableModelString];
    UIFont *normalFont=[UIFont fontWithName:@"Georgia-Bold" size:10.0];
    UIFont *titleFont=[UIFont fontWithName:@"Georgia-Bold" size:14.0];
	
    
    NSMutableAttributedString *titleStr = [[NSMutableAttributedString alloc] initWithString:@"Client Interaction Process Notes\n"];
   
    CGMutablePathRef newPath = CGPathCreateMutable();
    CGPathAddRect(newPath, NULL, CGRectMake(RIGHT_MARGIN,
                                            TOP_MARGIN,
                                            DOC_WIDTH-RIGHT_MARGIN-LEFT_MARGIN,
                                            DOC_HEIGHT-TOP_MARGIN-BOTTOM_MARGIN ));
    
    
    [titleStr addAttribute:NSFontAttributeName value:titleFont range:NSMakeRange(0, [titleStr length])];
    
    
    
    CTTextAlignment theAlignment = kCTCenterTextAlignment;
    CFIndex theNumberOfSettings = 1;
    CTParagraphStyleSetting theSettings[1] = {{ kCTParagraphStyleSpecifierAlignment, sizeof(CTTextAlignment), &theAlignment }};
    CTParagraphStyleRef theParagraphRef = CTParagraphStyleCreate(theSettings, theNumberOfSettings);
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:(__bridge id)theParagraphRef, (id)kCTParagraphStyleAttributeName, nil];
    
    [titleStr addAttributes:attributes range:NSMakeRange(0,[titleStr length])];
    //
    //        [str drawInRect:bounds];
    
    
    // create the framesetter and render text
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)titleStr);
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter,
                                                CFRangeMake(0, [titleStr length]), newPath, NULL);
    CGFloat titleLineHeight=titleFont.lineHeight;
    

	do {
        pageCount++;
		CGContextBeginPage (pdfContext, &pageRect);
		
      
//		CGContextSaveGState(pdfContext);
//		UIGraphicsPushContext(pdfContext);
		
//		CGContextTranslateCTM(pdfContext, 0, bounds.origin.y);
//		CGContextScaleCTM(pdfContext, 1, -1);
//		CGContextTranslateCTM(pdfContext, 0, -(bounds.origin.y + bounds.size.height));
        
        // Flip the coordinate system
//        CGContextSetTextMatrix(pdfContext, CGAffineTransformIdentity);
//        CGContextTranslateCTM(pdfContext, 0, bounds.size.height);
//        CGContextScaleCTM(pdfContext, 1.0, -1.0);

        
               CTFrameDraw(frame, pdfContext);
        
        
       
        
        
       
        
        
        if (clientIDCodeStr&&[clientIDCodeStr isKindOfClass:[NSString class]]) {
            
            
            
            
            
            NSMutableAttributedString *clientIDCodeAttrString = [[NSMutableAttributedString alloc] initWithString:[@"Client: " stringByAppendingString:clientIDCodeStr]];
            
            
            
            [clientIDCodeAttrString addAttribute:NSFontAttributeName value:normalFont range:NSMakeRange(0, [clientIDCodeAttrString length])];
            
            CGRect clientBounds = CGRectMake(LEFT_MARGIN,
                                               TOP_MARGIN-titleLineHeight,
                                               DOC_WIDTH - RIGHT_MARGIN - LEFT_MARGIN,
                                               DOC_HEIGHT - TOP_MARGIN - BOTTOM_MARGIN);
            
            CGMutablePathRef clientPath = CGPathCreateMutable();
            CGPathAddRect(clientPath, NULL, clientBounds );
            
            [clientIDCodeAttrString addAttributes:attributes range:NSMakeRange(0,[clientIDCodeAttrString length])];
            
            CTFramesetterRef clientframesetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)clientIDCodeAttrString);
            CTFrameRef clientFrame = CTFramesetterCreateFrame(clientframesetter,
                                                                   CFRangeMake(0, [clientIDCodeAttrString length]), clientPath, NULL);
            
            CTFrameDraw(clientFrame, pdfContext);
            clientIDCodeAttrString=nil;
            CFRelease(clientFrame);
            CFRelease(clientPath);
            CFRelease(clientframesetter);
        }

        
        
        if (serviceDateTimeStr&&[serviceDateTimeStr isKindOfClass:[NSString class]]) {
            
            
            
            
            
            NSMutableAttributedString *serviceDateString = [[NSMutableAttributedString alloc] initWithString:[@"Service Date: " stringByAppendingString:serviceDateTimeStr]];
            
            
            
            [serviceDateString addAttribute:NSFontAttributeName value:normalFont range:NSMakeRange(0, [serviceDateString length])];
            
            CGRect clinicanBounds = CGRectMake(LEFT_MARGIN,
                                               TOP_MARGIN-normalFont.lineHeight-titleLineHeight,
                                               DOC_WIDTH - RIGHT_MARGIN - LEFT_MARGIN,
                                                DOC_HEIGHT - TOP_MARGIN - BOTTOM_MARGIN);
            
            CGMutablePathRef serviceDatePath = CGPathCreateMutable();
            CGPathAddRect(serviceDatePath, NULL, clinicanBounds );
            
            [serviceDateString addAttributes:attributes range:NSMakeRange(0,[serviceDateString length])];
            
            CTFramesetterRef serviceDateframesetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)serviceDateString);
            CTFrameRef serviceDateFrame = CTFramesetterCreateFrame(serviceDateframesetter,
                                                                CFRangeMake(0, [serviceDateString length]), serviceDatePath, NULL);
            
            CTFrameDraw(serviceDateFrame, pdfContext);
            serviceDateString=nil;
            CFRelease(serviceDateFrame);
            CFRelease(serviceDatePath);
            CFRelease(serviceDateframesetter);
        }

        if (clinicianString&&clinicianString.length) {
      
        
        
       
       
        NSMutableAttributedString *clinicianStr = [[NSMutableAttributedString alloc] initWithString:clinicianString];
        
         
            
        [clinicianStr addAttribute:NSFontAttributeName value:normalFont range:NSMakeRange(0, [clinicianStr length])];
        
        CGRect clinicanBounds = CGRectMake(LEFT_MARGIN,
                                               TOP_MARGIN-normalFont.lineHeight*2-titleLineHeight,
                                               DOC_WIDTH - RIGHT_MARGIN - LEFT_MARGIN,
                                                DOC_HEIGHT - TOP_MARGIN - BOTTOM_MARGIN);
       
         CGMutablePathRef clinicianPath = CGPathCreateMutable();
        CGPathAddRect(clinicianPath, NULL, clinicanBounds );
               
        [clinicianStr addAttributes:attributes range:NSMakeRange(0,[clinicianStr length])];
        
        CTFramesetterRef clinicanframesetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)clinicianStr);
        CTFrameRef clinicanframe = CTFramesetterCreateFrame(clinicanframesetter,
                                                    CFRangeMake(0, [clinicianStr length]), clinicianPath, NULL);
        
        CTFrameDraw(clinicanframe, pdfContext);
            clinicianStr=nil;
        CFRelease(clinicanframe);
        CFRelease(clinicianPath);
        CFRelease(clinicanframesetter);
        }
        //		if ([invisibleTextView.text length] > 0) [[self stringToDraw:font fontSize:fontSize] drawInRect:bounds withFont:[UIFont fontWithName:font size:fontSize]];
//		CGContextRestoreGState(pdfContext);
//		UIGraphicsPopContext();
        
        
        //set up context
        UIColor *redColor=[UIColor redColor];
        CGContextSetLineWidth(pdfContext, 0.3);
        CGContextSetStrokeColorWithColor(pdfContext, redColor.CGColor);
        
        //line1
        CGContextMoveToPoint(pdfContext, 10,DOC_HEIGHT- TOP_MARGIN-normalFont.lineHeight*3-titleLineHeight-5);
        CGContextAddLineToPoint(pdfContext, DOC_WIDTH-10, DOC_HEIGHT- TOP_MARGIN-normalFont.lineHeight*3-titleLineHeight-5);
        

        
        
        //finished drawing
        CGContextStrokePath(pdfContext);
        
        DLog(@"track text is  %@",trackText);
        if (pageCount==1 && trackText) {
            
            NSMutableAttributedString *trackTextAttStr = [[NSMutableAttributedString alloc] initWithString:trackText];
            
            
            
            [trackTextAttStr addAttribute:NSFontAttributeName value:normalFont range:NSMakeRange(0, [trackText length])];
            
            CGRect clinicanBounds = CGRectMake(LEFT_MARGIN,
                                               TOP_MARGIN-normalFont.lineHeight*3-titleLineHeight-10,
                                               DOC_WIDTH - RIGHT_MARGIN - LEFT_MARGIN,
                                               DOC_HEIGHT - TOP_MARGIN - BOTTOM_MARGIN);
            
            CGMutablePathRef trackTextPath = CGPathCreateMutable();
            CGPathAddRect(trackTextPath, NULL, clinicanBounds );
            
            [trackTextAttStr addAttributes:attributes range:NSMakeRange(0,[trackTextAttStr length])];
            
            CTFramesetterRef trackTextframesetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)trackTextAttStr);
            CTFrameRef trackTextframe = CTFramesetterCreateFrame(trackTextframesetter,
                                                                CFRangeMake(0, [trackTextAttStr length]), trackTextPath, NULL);
            
            CTFrameDraw(trackTextframe, pdfContext);
            
            CFRelease(trackTextframe);
            CFRelease(trackTextPath);
            CFRelease(trackTextframesetter);
            trackTextAttStr=nil;
        }
        
               
            
//            UIGraphicsPushContext(pdfContext);
//            CGContextSaveGState(pdfContext);
//            CGContextTranslateCTM(pdfContext, 0, bounds.origin.y);
//            CGContextScaleCTM(pdfContext, 1, -1);
//            CGContextTranslateCTM(pdfContext, 0, -(bounds.origin.y + bounds.size.height));
            if ([invisibleTextView.text length] > 0)
            {
               // [[self stringToDraw:font fontSize:12 drawInRect:bounds] drawInRect:bounds withFont:[UIFont fontWithName:@"Times New Roman" size:12.0]];
                
                
//                [@"test" drawInRect:bounds withFont:[UIFont fontWithName:@"Times New Roman" size:12.0]];
                               CGRect bounds = CGRectMake(LEFT_MARGIN,
                                           TOP_MARGIN-normalFont.lineHeight*5-titleLineHeight-10,
                                           DOC_WIDTH - RIGHT_MARGIN - LEFT_MARGIN,
                                           DOC_HEIGHT - TOP_MARGIN - BOTTOM_MARGIN);
               
                
                NSMutableAttributedString *textAttStr = [[NSMutableAttributedString alloc] initWithString:[self stringToDraw:font fontSize:12 drawInRect:bounds]];
                
                
                
//                [textAttStr addAttribute:NSFontAttributeName value:normalFont range:NSMakeRange(0, [trackText length])];
                

                
                CGMutablePathRef trackTextPath = CGPathCreateMutable();
                CGPathAddRect(trackTextPath, NULL, bounds );
                
//                [textAttStr addAttributes:attributes range:NSMakeRange(0,[textAttStr length])];
                
                CTFramesetterRef trackTextframesetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)textAttStr);
                CTFrameRef trackTextframe = CTFramesetterCreateFrame(trackTextframesetter,
                                                                     CFRangeMake(0, [textAttStr length]), trackTextPath, NULL);
                
                CTFrameDraw(trackTextframe, pdfContext);
                textAttStr=nil;
                CFRelease(trackTextframe);
                CFRelease(trackTextPath);
                CFRelease(trackTextframesetter);
                
            }
            else
            {
                done=YES;
            }

//            CGContextRestoreGState(pdfContext);
//            UIGraphicsPopContext();
        
		      
		if (pageCount>50) {
            //just as a control
            done=YES;
        }
		
		CGContextEndPage (pdfContext);
		
	}
	while (!done);
	
   
 
    // remove PDF rendering context
    UIGraphicsEndPDFContext();
    CFRelease(frame);
    titleStr=nil;
    titleFont=nil;
    CFRelease(framesetter);
    invisibleTextView.text=nil;
    CFRelease(newPath);
    
    //begin
    
    
    //create empty pdf file;
    UIGraphicsBeginPDFContextToFile(documentDirectoryFilename, CGRectMake(0,
                                                                          0,
                                                                          DOC_WIDTH ,
                                                                          DOC_HEIGHT), (__bridge NSDictionary *)(myDictionary));
    
    CGDataProviderRef dataProvider=CGDataProviderCreateWithCFData((__bridge CFDataRef)pdfData);
    //open template file
    
    CGPDFDocumentRef templateDocument = CGPDFDocumentCreateWithProvider(dataProvider);
    
    
    //get amount of pages in template
    size_t count = CGPDFDocumentGetNumberOfPages(templateDocument);
    CGContextRef context = UIGraphicsGetCurrentContext();
    //for each page in template
    for (size_t pageNumber = 1; pageNumber <= count; pageNumber++) {
        //get bounds of template page
        CGPDFPageRef templatePage = CGPDFDocumentGetPage(templateDocument, pageNumber);
        CGRect templatePageBounds = CGPDFPageGetBoxRect(templatePage, kCGPDFCropBox);
        
        //create empty page with corresponding bounds in new document
        UIGraphicsBeginPDFPageWithInfo(templatePageBounds, nil);
        
        
        //flip context due to different origins
        CGContextTranslateCTM(context, 0, templatePageBounds.size.height);
        CGContextScaleCTM(context, 0.99, -0.99);
        
        
        //copy content of template page on the corresponding page in new file
        CGContextDrawPDFPage(context, templatePage);
        
        
        //flip context back
        CGContextTranslateCTM(context, 0, templatePageBounds.size.height);
        CGContextScaleCTM(context, 0.99, -0.99);
        
        /* Here you can do any drawings */
        [self drawPageNumber:pageNumber totalPages:count];
        
        
        
        
        
    }
    CFRelease(myDictionary);
    CFRelease(path);
    CFRelease(url);
        CGPDFDocumentRelease(templateDocument);
    UIGraphicsEndPDFContext();
    CGDataProviderRelease(dataProvider);
    pdfData=nil;

    
    
    
    
}

-(void)drawPageNumber:(NSInteger )pageNum totalPages:(NSInteger )totalPages{
    
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
    
    [dateFormatter setDateFormat:@"h:mm aa M/d/yyyy"];
    
    NSString *pageString=[NSString stringWithFormat:@"Page %d of %d (Generated %@) ",pageNum,totalPages,[dateFormatter stringFromDate:[NSDate date]]];
    UIFont *theFont =[UIFont fontWithName:@"Georgia" size:10.0];
    
    CGSize maxSize= CGSizeMake(1122, 132);
    
    CGSize pageStringSize = [pageString sizeWithFont:theFont constrainedToSize:maxSize lineBreakMode:UILineBreakModeClip];
    
    CGRect stringRect =CGRectMake(((DOC_WIDTH- pageStringSize.width)/2), ((DOC_HEIGHT-BOTTOM_FOOTER_MARGIN-pageStringSize.height)), pageStringSize.width, pageStringSize.height);
    
    
    [pageString drawInRect:stringRect withFont:theFont];
    dateFormatter=nil;
}

-(NSString *)getContentFromTableModel:(SCArrayOfObjectsModel *)tableModel{

    NSString *returnString=nil;
    
    
   
    for (NSInteger i=2; i<tableModel.sectionCount-1; i++) {
        
        SCTableViewSection *section=(SCTableViewSection *)[tableModel sectionAtIndex:i];
         BOOL addedScaleText=NO;
        BOOL addedOrientationText=NO;
        for (NSInteger p=0; p<section.cellCount; p++) {
            SCTableViewCell *cell=(SCTableViewCell *)[section cellAtIndex:p];
           
            NSString *textLabelText=[NSString string];
            NSString *labelText=[NSString string];
           
            if( [cell respondsToSelector:@selector(textLabel) ]) {
                
                textLabelText=cell.textLabel.text;
                
                
            }
            
           

            if ([cell isKindOfClass:[SCControlCell class]]){
                
                UIView *labelView=[cell viewWithTag:71];
                
                if ([labelView isKindOfClass:[UILabel class]]){
                    
                    UILabel *textLabel=(UILabel *)labelView;
                    
                    textLabelText=textLabel.text;
                    
                    
                }
                
                UIView *segmentedView=(UIView *)[cell viewWithTag:70];
                if ([segmentedView isKindOfClass:[UISegmentedControl class]]){
                    
                    UISegmentedControl *segmentedControl=(UISegmentedControl *)segmentedView;
                    if(segmentedControl.selectedSegmentIndex!=-1){
                        if (!addedScaleText) {
                            addedScaleText=YES;
                            if (textLabelText) {
                                if (i==2) {
                                    textLabelText=[@"Client subjective ratings (Scale values range from 0 to 10). \n" stringByAppendingString:textLabelText];
                                }
                                else{
                                
                                textLabelText=[@"Clinician subjective ratings (Scale values range from 0 to 10). \n" stringByAppendingString:textLabelText];
                                }
                            
                            }
                            
                        }
                        labelText=[NSString stringWithFormat:@"%i",segmentedControl.selectedSegmentIndex];
                    }else{
                    
                        textLabelText=nil;
                        labelText=nil;
                        continue;
                    
                    }
                    
                }
                
                
            }

            if ([cell isKindOfClass:[SuicidaltiyCell class]]) {
                SuicidaltiyCell *suicidalityCell=(SuicidaltiyCell*)cell;
                textLabelText=suicidalityCell.titleLabel.text;
                
                labelText=[suicidalityCell getSelectedVariables];
                
                
            }
            
            
            if ([cell isKindOfClass:[SCTextFieldCell class]]) {
                SCTextFieldCell *textFieldCell=(SCTextFieldCell *)cell;
                labelText=textFieldCell.textField.text;
                
                if (!labelText||!labelText.length) {
                    textLabelText=nil;
                    continue;
                }
            }
            
            if ([cell isKindOfClass:[SCTextViewCell class]]) {
                SCTextViewCell *textViewCell=(SCTextViewCell *)cell;
                labelText=textViewCell.textView.text;
                
                if (!labelText||!labelText.length) {
                    textLabelText=nil;
                    continue;
                }
            }
            
            if ([cell isKindOfClass:[SCNumericTextFieldCell class]]) {
                SCNumericTextFieldCell *numericTextFieldCell=(SCNumericTextFieldCell *)cell;
                labelText=numericTextFieldCell.textField.text;
                
                if (!labelText||!labelText.length) {
                    textLabelText=nil;
                    continue;
                }
            }
           
            if ([cell isKindOfClass:[SCSelectionCell class]]) {
                SCSelectionCell *selectionCell=(SCSelectionCell *)cell;
                labelText=selectionCell.label.text;
                
                if (!labelText||!labelText.length) {
                    textLabelText=nil;
                    continue;
                }
            }
           
            if ([cell isKindOfClass:[SCSegmentedCell class]]) {
                SCSegmentedCell *segmentedCell=(SCSegmentedCell *)cell;
                
                if(segmentedCell.segmentedControl.selectedSegmentIndex!=-1){
                    if (!addedScaleText) {
                        addedOrientationText=YES;
                        if (textLabelText) {
                            if (i==5 &&p==0) {
                                textLabelText=[@"Client Orientation. \n" stringByAppendingString:textLabelText];
                            }
                        
                        }
                        
                    }
                }
                if (segmentedCell.segmentedControl.selectedSegmentIndex==0) {
                    labelText=@"yes";
                    
                }
                else if (segmentedCell.segmentedControl.selectedSegmentIndex==1)
                {
                
                        labelText=@"no";
                
                }
                if (!labelText||!labelText.length) {
                    textLabelText=nil;
                    continue;
                }
            }
            
            if (returnString &&returnString.length&&textLabelText) {
               
                if (p==0||[cell isKindOfClass:[SCTextViewCell class]]||[cell isKindOfClass:[SCTextFieldCell class]]) {
                    
                    returnString=[[returnString stringByAppendingFormat:@"\n\n"]stringByAppendingString:(labelText)?[textLabelText stringByAppendingFormat:@": %@",labelText ]:[NSString string]];
                }
                else if([cell isKindOfClass:[SuicidaltiyCell class]]){
                    if (p==10) {
                        returnString=[[returnString stringByAppendingFormat:@"\n\n"]stringByAppendingString:(labelText)?[textLabelText stringByAppendingFormat:@": %@",labelText ]:[NSString string]];
                    }
                    else{
                    
                    returnString=[[returnString stringByAppendingFormat:@"\n"]stringByAppendingString:(labelText)?[textLabelText stringByAppendingFormat:@": %@",labelText ]:[NSString string]];
                    }
                
                
                
                }
                else{
                    returnString=[[returnString stringByAppendingFormat:@"; "]stringByAppendingString:(labelText)?[textLabelText stringByAppendingFormat:@": %@",labelText ]:[NSString string]];
                }
            }
            else{
             returnString=[textLabelText stringByAppendingFormat:@": %@",labelText ];
            }
            }
        
        
    }
    
   
    if (!returnString) {
        returnString=@"no return string";
    }

    return returnString;


}

- (void)createPDF:(NSString *)fileName withContent:(NSString *)content forSize:(int)fontSize andFont:(NSString *)font andColor:(UIColor *)color:(BOOL)allowCopy:(BOOL)allowPrint:(NSString*)password {
    
    //create our invisibleTextView
    invisibleTextView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    textArray = [[NSMutableArray alloc] init];
    
    [textArray setArray:[content componentsSeparatedByString:@" "]];
    [invisibleTextView setText:content];
    
    
	CGContextRef pdfContext;
	CFStringRef path;
	CFURLRef url;
	CFStringRef passwordString = (__bridge CFStringRef)password;
	CGRect pageRect = CGRectMake(0, 0, DOC_WIDTH, DOC_HEIGHT);
	CFMutableDictionaryRef myDictionary = NULL;
	const char *filename = [fileName UTF8String];
	// Create a CFString from the filename we provide to this method when we call it
	path = CFStringCreateWithCString (NULL, filename,
									  kCFStringEncodingUTF8);
	// Create a CFURL using the CFString we just defined
	url = CFURLCreateWithFileSystemPath (NULL, path,
										 kCFURLPOSIXPathStyle, 0);
	//CFRelease (path);
	// This dictionary contains extra options mostly for 'signing' the PDF
	myDictionary = CFDictionaryCreateMutable(NULL, 0,
											 &kCFTypeDictionaryKeyCallBacks,
											 &kCFTypeDictionaryValueCallBacks);
	CFDictionarySetValue(myDictionary, kCGPDFContextTitle, (CFStringRef)fileName);
	CFDictionarySetValue(myDictionary, kCGPDFContextCreator, (CFStringRef)fileName);
	if (password != nil) CFDictionarySetValue(myDictionary, kCGPDFContextOwnerPassword, passwordString);
	if (password != nil) CFDictionarySetValue(myDictionary, kCGPDFContextUserPassword, passwordString);
	//if (![password isEqualToString:@""]) CFDictionarySetValue(myDictionary, kCGPDFContextEncryptionKeyLength, (CFStringRef)"128");
	//if (allowCopy) CFDictionarySetValue(myDictionary, kCGPDFContextAllowsCopying, kCFBooleanTrue);
	if (!allowCopy) CFDictionarySetValue(myDictionary, kCGPDFContextAllowsCopying, kCFBooleanFalse);
	//if (allowPrint) CFDictionarySetValue(myDictionary, kCGPDFContextAllowsPrinting, kCFBooleanTrue);
	if (!allowPrint) CFDictionarySetValue(myDictionary, kCGPDFContextAllowsPrinting, kCFBooleanFalse);
	
	
	// Create our PDF Context with the CFURL, the CGRect we provide, and the above defined dictionary
	pdfContext = CGPDFContextCreateWithURL (url, &pageRect, myDictionary);
	// Cleanup our mess
	CFRelease(myDictionary);
	CFRelease(url);
	//CFRelease(passwordString);
	
	//CFRange currentRange = CFRangeMake(0, 0);
	
	do {
		CGContextBeginPage (pdfContext, &pageRect);
		
		CGRect bounds = CGRectMake(LEFT_MARGIN,
								   TOP_MARGIN,
								   DOC_WIDTH - RIGHT_MARGIN - LEFT_MARGIN,
								   DOC_HEIGHT - TOP_MARGIN - BOTTOM_MARGIN);
		
		UIGraphicsPushContext(pdfContext);
		CGContextSaveGState(pdfContext);
		CGContextTranslateCTM(pdfContext, 0, bounds.origin.y);
		CGContextScaleCTM(pdfContext, 1, -1);
		CGContextTranslateCTM(pdfContext, 0, -(bounds.origin.y + bounds.size.height));
		if ([invisibleTextView.text length] > 0) [[self stringToDraw:font fontSize:fontSize drawInRect:bounds] drawInRect:bounds withFont:[UIFont fontWithName:font size:fontSize]];
		CGContextRestoreGState(pdfContext);
		UIGraphicsPopContext();
		
		CGContextEndPage (pdfContext);
	}
	while (!done);
	
	// We are done with our context now, so we release it
	CGContextRelease (pdfContext);
	CFRelease(path);
    
    
}

- (NSString *)stringToDraw:(NSString *)font fontSize:(int)fontSize drawInRect:(CGRect )bounds {
	CGSize tempSize;
    CGSize theTextSize;
    tempSize.width = bounds.size.width;
    tempSize.height = bounds.size.height;//DOC_HEIGHT - TOP_MARGIN - BOTTOM_MARGIN;
	
    theTextSize = [invisibleTextView.text sizeWithFont: [UIFont fontWithName:font size:fontSize] constrainedToSize: tempSize];
	
	//NSLog(@"size.width:%f, size.height:%f", theTextSize.width, theTextSize.height);
	
	if (theTextSize.height >= bounds.size.height-1) {
		//NSLog(@"Text exceeds bounds");
		BOOL match = NO;
		int wordCount = 0;
		float currentHeight = 0.0f;
		float previousHeight = 0.0f;
		NSString *returnString = [NSString string];
		NSString *tempReturnString = [NSString string];
		
		do {
			if ([textArray count] > wordCount + 1) {
				returnString = (wordCount > 0) ? [returnString stringByAppendingString:[NSString stringWithFormat:@" %@", [textArray objectAtIndex:wordCount]]] : [NSString stringWithFormat:@"%@", [textArray objectAtIndex:wordCount]];
				theTextSize = [returnString sizeWithFont: [UIFont fontWithName:font size:fontSize] constrainedToSize: CGSizeMake(DOC_WIDTH - RIGHT_MARGIN - LEFT_MARGIN, bounds.size.height)];
				//NSLog(@"Currentsize.width:%f, Currentsize.height:%f", theTextSize.width, theTextSize.height);
				currentHeight = theTextSize.height;
				
				if (theTextSize.height > bounds.size.height) {
					match = YES;
					//NSLog(@"MATCH");
				}
				
				if (currentHeight == previousHeight && currentHeight > 575.0f) { //sometimes the above is not accurate and the height is shorter than we think (because of large fonts)
					//NSLog(@"FIXMATCH");
					match = YES;
					
//                    wordCount ++;
					returnString = tempReturnString;
				}
                
              
				wordCount ++;
			}
			else {
				match = YES;
			}
			previousHeight = theTextSize.height;
			tempReturnString = returnString;
		}
		while (!match);
		 
		for (int i = 0; i < wordCount-1; i++) {
            //this is so if the last object in the return string is an object with new lines is not cut off at the bottom of the page
            if (i==wordCount-2) {
               NSString * objectInTextArray=[textArray objectAtIndex:0];
               
                
                NSRange range = [objectInTextArray rangeOfString:@"\n\n" options:NSBackwardsSearch ];
                
                if (range.location!=NSNotFound) {
                    objectInTextArray=[objectInTextArray substringFromIndex:range.location+2];
                    [textArray removeObjectAtIndex:0];
                    [textArray insertObject:objectInTextArray atIndex:0];
                    
                }
                else{
                [textArray removeObjectAtIndex:0];
                }
                
                
            }
            else{
                [textArray removeObjectAtIndex:0];
            }
            
		}
		
		if ([textArray count]) {
			invisibleTextView.text = [textArray componentsJoinedByString:@" "];
            
             
		}
		else {
			invisibleTextView.text = @"";
			done = YES;
		}
		
		if ([returnString length] == 0) returnString = @" ";
		
        if([returnString hasSuffix:@":"])
        {
            returnString =[returnString stringByAppendingString:@"has colon"];
        
            NSRange range = [returnString rangeOfString:@"\n\n" options:NSBackwardsSearch ];

            if (range.location!=NSNotFound) {
                returnString=[returnString substringToIndex:range.location];
                
            }
        
        
        }
		
		return returnString;
	}
	else {
		done = YES;
        if([invisibleTextView.text hasSuffix:@":"]){invisibleTextView.text =[invisibleTextView.text stringByAppendingString:@"has colon"];}
		
		return invisibleTextView.text;
	}
	
	return invisibleTextView.text;
}


@end
