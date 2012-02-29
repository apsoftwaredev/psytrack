//
//  DTAboutViewController.h
//  About
//
//  Created by Oliver Drobnik on 2/13/10.
//  Copyright 2010 Drobnik.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "DTAppScrollerView.h"
#import "DTInfoManager.h"
#import "DTLayoutDefinition.h"

@class DTAboutViewController;


@protocol DTAboutViewControllerDelegate <NSObject>

@optional

- (UIView *)aboutViewController:(DTAboutViewController *)aboutViewController customViewForDictionary:(NSDictionary *)dictionary;
- (void)aboutViewController:(DTAboutViewController *)aboutViewController performCustomAction:(NSString *)action withObject:(id)object;
- (void)aboutViewController:(DTAboutViewController *)aboutViewController didSetupLabel:(UILabel *)label forTextStyle:(NSUInteger)style;

@end




@interface DTAboutViewController : UIViewController 
			<UIActionSheetDelegate, MFMailComposeViewControllerDelegate, 
				UITableViewDelegate, UITableViewDataSource, DTAboutViewControllerDelegate,
				DTAppScrollerViewDelegate>
{
	DTLayoutDefinition *_layout;
	
//	id <DTAboutViewControllerDelegate> delegate;
	
	
	NSMutableDictionary *customViews;
	
	UIView *backgroundView;
	UIEdgeInsets cellEdgeInsets;
	
	// internal
	NSMutableArray *commandsForShowingActionSheet;
	UITableView *_tableView;
	DTAppScrollerView *_appScrollerView;
	
}

@property (nonatomic, weak) id <DTAboutViewControllerDelegate> delegate;
@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, assign) UIEdgeInsets cellEdgeInsets;


- (id)initWithLayout:(DTLayoutDefinition *)layout;
- (CGFloat)cellWidth;

@end
