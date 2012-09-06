//
//  PDFRenderer.h
//  PsyTrack
//
//  Created by Daniel Boice on 6/24/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "CoreText/CoreText.h"
#import "TrainingProgramEntity.h"


@interface PDFRenderer : NSObject 

+(void)drawMonthlyPracticumLogPDF:(NSString*)fileName month:(NSDate *)monthToDisplay trainingProgram:(TrainingProgramEntity *)trainingProgramGiven password:(NSString *) filePassword amended:(BOOL)markAmended ;




+(void)drawAllHoursReportPDF:(NSString*)fileName  password:(NSString *) filePassword;

+(void)drawText;

+(void)drawLineFromPoint:(CGPoint)from toPoint:(CGPoint)to;

+(void)drawImage:(UIImage*)image inRect:(CGRect)rect;

+(void)drawText:(NSString*)textToDraw inFrame:(CGRect)frameRect font:(UIFont *)stringFont;

+(void)drawLabels;

+(void)drawLogo;


+(void)drawTableAt:(CGPoint)origin 
     withRowHeight:(int)rowHeight 
    andColumnWidth:(int)columnWidth 
       andRowCount:(int)numberOfRows 
    andColumnCount:(int)numberOfColumns;


+(void)drawTableDataAt:(CGPoint)origin 
         withRowHeight:(int)rowHeight 
        andColumnWidth:(int)columnWidth 
           andRowCount:(int)numberOfRows 
        andColumnCount:(int)numberOfColumns;

+(void)editTemplate;

CGFloat GetLineHeightForFont(CTFontRef iFont);

+(void)drawPageNumber:(NSInteger )pageNum totalPages:(NSInteger)totalPages;
@end
