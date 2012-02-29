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
	
//	id <DTSingleQuestionViewDataSource> delegate;
	
	DTSingleQuestionContentView *_questionAnswerView;
}

@property (nonatomic, assign) NSUInteger currentQuestion;
@property (nonatomic, strong, readonly) DTSingleQuestionContentView *questionAnswerView;


@property (nonatomic, strong) NSString *question;
@property (nonatomic, strong) NSString *text;

@property (nonatomic, weak) id <DTSingleQuestionViewDataSource> delegate;


@end
