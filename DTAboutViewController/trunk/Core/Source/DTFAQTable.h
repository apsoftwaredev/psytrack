//
//  DTFAQTable.h
//  About
//
//  Created by Oliver Drobnik on 2/16/10.
//  Copyright 2010 Drobnik.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DTSingleQuestionView.h"

@interface DTFAQTable : UIView <UITableViewDelegate, UITableViewDataSource, DTSingleQuestionViewDataSource>
{
    UITableView *_tableView;

    NSArray *faqs;

    UINavigationController *navController;

    BOOL useTextViews;
    CGFloat rowHeight;
}

@property (nonatomic, retain) UINavigationController *navController;
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) NSArray *faqs;
@property (nonatomic, assign) BOOL useTextViews;
@property (nonatomic, assign) CGFloat rowHeight;

- (void) sizeToShowRows:(NSInteger)rows;

@end
