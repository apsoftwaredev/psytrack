//
//  DTSingleQuestionContentView.h
//  About
//
//  Created by Oliver Drobnik on 12/20/11.
//  Copyright (c) 2011 Drobnik.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DTSingleQuestionContentView : UIView
{
	UILabel *_questionLabel;
	UITextView *_answerTextView;
	
	NSString *_questionText;
	NSString *_answerText;
	
	BOOL _firstLayoutDone;
}

@property (nonatomic, copy) NSString *questionText;
@property (nonatomic, copy) NSString *answerText;

- (void)flashScrollIndicatorIfNecessary;

@end
