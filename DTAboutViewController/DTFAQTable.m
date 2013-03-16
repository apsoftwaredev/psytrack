//
//  DTFAQTable.m
//  About
//
//  Created by Oliver Drobnik on 2/16/10.
//  Copyright 2010 Drobnik.com. All rights reserved.
//

#import "DTFAQTable.h"
#import <QuartzCore/QuartzCore.h>
#import "DTSingleQuestionView.h"

@implementation DTFAQTable
@synthesize navController;
@synthesize tableView = _tableView;
@synthesize faqs, useTextViews, rowHeight;

- (id) initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        // Initialization code

        _tableView = [[UITableView alloc] initWithFrame:self.bounds];
        [self addSubview:_tableView];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

        self.backgroundColor = [UIColor clearColor];
        self.opaque = NO;

        rowHeight = 44.0;         // default

        _tableView.opaque = NO;
    }

    return self;
}


/*
   - (void)drawRect:(CGRect)rect {
    // Drawing code
   }
 */

- (void) sizeToShowRows:(NSInteger)rows
{
    CGFloat heightNeeded = ( (CGFloat)rows * rowHeight );    // 1px for seperator
    CGRect frame = self.bounds;

    frame.size.height = heightNeeded;
    self.frame = frame;
}


#pragma mark table
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [faqs count];
}


- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return rowHeight;
}


- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }

    NSDictionary *rowDict = [faqs objectAtIndex:indexPath.row];

    cell.textLabel.text = [[rowDict allKeys] lastObject];
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.font = [UIFont systemFontOfSize:12.0];
    cell.backgroundColor = [UIColor whiteColor];
    cell.opaque = YES;

    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}


- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    DTSingleQuestionView *question = [[DTSingleQuestionView alloc] init];
    question.delegate = self;
    question.currentQuestion = indexPath.row;
    [navController pushViewController:question animated:YES];
}


#pragma mark DTSingleQuestionView Delegate
- (NSInteger) numberOfQuestionsInSingleQuestionView:(DTSingleQuestionView *)singleQuestionView
{
    return [faqs count];
}


- (NSDictionary *) singleQuestionView:(DTSingleQuestionView *)singleQuestionView dictionaryForQuestionAtIndex:(NSInteger)index
{
    return [faqs objectAtIndex:index];
}


@end
