//
//  DTSingleQuestionView.h
//  About
//
//  Created by Oliver Drobnik on 2/16/10.
//  Copyright 2010 Drobnik.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DTSingleQuestionView, DTSingleQuestionContentView;

@protocol DTSingleQuestionViewDataSource <NSObject>

- (NSInteger) numberOfQuestionsInSingleQuestionView:(DTSingleQuestionView *)singleQuestionView;
- (NSDictionary *) singleQuestionView:(DTSingleQuestionView *)singleQuestionView dictionaryForQuestionAtIndex:(NSInteger)index;

@end

@interface DTSingleQuestionView : UIViewController 
{
	NSString *question;
	NSString *text;
	
	NSUInteger currentQuestion;
	
	UISegmentedControl *segmentedControl;
	
	id <DTSingleQuestionViewDataSource> delegate;
	
	DTSingleQuestionContentView *_questionAnswerView;
}

@property (nonatomic, assign) NSUInteger currentQuestion;
@property (nonatomic, retain, readonly) DTSingleQuestionContentView *questionAnswerView;


@property (nonatomic, retain) NSString *question;
@property (nonatomic, retain) NSString *text;

@property (nonatomic, assign) id <DTSingleQuestionViewDataSource> delegate;


@end
