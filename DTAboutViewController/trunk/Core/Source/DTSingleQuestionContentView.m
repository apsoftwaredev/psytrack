//
//  DTSingleQuestionContentView.m
//  About
//
//  Created by Oliver Drobnik on 12/20/11.
//  Copyright (c) 2011 Drobnik.com. All rights reserved.
//

#import "DTSingleQuestionContentView.h"

@implementation DTSingleQuestionContentView

- (id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _answerTextView = [[UITextView alloc] initWithFrame:CGRectZero];
        _answerTextView.font = [UIFont systemFontOfSize:13.0];
        _answerTextView.dataDetectorTypes = UIDataDetectorTypeAll;
        _answerTextView.editable = NO;
        [self addSubview:_answerTextView];

        _questionLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _questionLabel.font = [UIFont boldSystemFontOfSize:13.0];
        _questionLabel.numberOfLines = 0;
        _questionLabel.backgroundColor = [UIColor clearColor];
        [_answerTextView addSubview:_questionLabel];
    }

    return self;
}


- (void) dealloc
{
    [_questionLabel release];
    [_answerTextView release];

    [super dealloc];
}


- (void) didMoveToSuperview
{
    _answerTextView.contentOffset = CGPointMake(0, -_answerTextView.contentInset.top);
}


- (void) layoutSubviews
{
    [super layoutSubviews];

    // get size for question
    CGSize neededSize = [_questionLabel.text sizeWithFont:_questionLabel.font constrainedToSize:CGSizeMake(self.bounds.size.width - 18.0, 0)];
    CGRect labelRect = CGRectMake(9.0, 9.0, self.bounds.size.width - 18.0, neededSize.height + 18.0);

    // answer covers entire view with some space for question
    _answerTextView.frame = self.bounds;
    _answerTextView.contentInset = UIEdgeInsetsMake(CGRectGetMaxY(labelRect), 0, 0, 0);
    labelRect.origin.y -= _answerTextView.contentInset.top;
    _questionLabel.frame = labelRect;

    // only on first layout set scroll to top
    if (!_firstLayoutDone)
    {
        _answerTextView.contentOffset = CGPointMake(0, -_answerTextView.contentInset.top);
        _firstLayoutDone = YES;
    }
}


- (void) flashScrollIndicatorIfNecessary
{
    if (_answerTextView.contentSize.height + _answerTextView.contentInset.top > _answerTextView.bounds.size.height)
    {
        [_answerTextView flashScrollIndicators];
    }
}


#pragma mark Properties
- (void) setQuestionText:(NSString *)questionText
{
    if (_questionText != questionText)
    {
        [_questionText release];
        _questionText = [questionText copy];

        _questionLabel.text = _questionText;
        _firstLayoutDone = NO;

        [self setNeedsLayout];
    }
}


- (void) setAnswerText:(NSString *)answerText
{
    if (_answerText != answerText)
    {
        [_answerText release];
        _answerText = [answerText copy];

        _answerTextView.text = _answerText;
        _firstLayoutDone = NO;

        [self setNeedsLayout];
    }
}


@synthesize questionText = _questionText;
@synthesize answerText = _answerText;

@end
