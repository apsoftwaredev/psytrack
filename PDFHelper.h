//
//  PDFHelper.h
//  PDFDemo
//
//  Created by Friendlydeveloper on 29.07.11.
//  Copyright 2011 www.codingsessions.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PDFHelper : NSObject {
    UITextView *invisibleTextView;
    NSMutableArray *textArray;
    
    BOOL done;
}

- (void)createPDF:(NSString *)fileName withContent:(NSString *)content forSize:(int)fontSize andFont:(NSString *)font andColor:(UIColor *)color:(BOOL)allowCopy:(BOOL)allowPrint:(NSString*)password;

- (NSString *)stringToDraw:(NSString *)font fontSize:(int)fontSize;

@property (nonatomic, retain) UITextView *invisibleTextView;
@property (nonatomic, retain) NSMutableArray *textArray;

@end
