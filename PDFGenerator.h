//
//  PDFGenerator.h
//  PsyTrack
//
//  Created by Daniel Boice on 11/13/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreText/CoreText.h>
#import "ClinicianEntity.h"



@interface PDFGenerator : NSObject{
    
    UITextView *invisibleTextView;
    NSMutableArray *textArray;
    BOOL isSupportActivity;
    BOOL done;
}

- (NSString *)stringToDraw:(NSString *)font fontSize:(int)fontSize drawInRect:(CGRect)bounds;


- (void)createPDF:(NSString *)fileName presentationTableModel:(SCArrayOfObjectsModel *)presentationTableModel trackText:(NSString *)trackText  serviceDateTimeStr:(NSString *)serviceDateTimeStr clinician:(ClinicianEntity*)clinician forSize:(int)fontSize andFont:(NSString *)font andColor:(UIColor *)color allowCopy:(BOOL)allowCopy allowPrint:(BOOL)allowPrint password:(NSString*)password reportTitle:(NSString*)reportTitle isSupportActivity:(BOOL)supportActivity;

@property (nonatomic, retain) UITextView *invisibleTextView;
@property (nonatomic, retain) NSMutableArray *textArray;

@end
