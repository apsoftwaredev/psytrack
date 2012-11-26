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
    
    BOOL done;
}

- (void)createPDF:(NSString *)fileName withContent:(NSString *)content forSize:(int)fontSize andFont:(NSString *)font andColor:(UIColor *)color:(BOOL)allowCopy:(BOOL)allowPrint:(NSString*)password;

- (NSString *)stringToDraw:(NSString *)font fontSize:(int)fontSize;


- (void)createPDF:(NSString *)fileName presentationTableModel:(SCArrayOfObjectsModel *)presentationTableModel firstDetaiTableModel:(SCArrayOfObjectsModel *)firstDetailTableModel serviceDateTimeStr:(NSString *)serviceDateTimeStr clinician:(ClinicianEntity*)clinician forSize:(int)fontSize andFont:(NSString *)font andColor:(UIColor *)color:(BOOL)allowCopy:(BOOL)allowPrint:(NSString*)password;

@property (nonatomic, retain) UITextView *invisibleTextView;
@property (nonatomic, retain) NSMutableArray *textArray;


@end
