//
//  DTAppScrollerView.h
//  About
//
//  Created by Oliver Drobnik on 2/15/10.
//  Copyright 2010 Drobnik.com. All rights reserved.
//

#import <UIKit/UIKit.h>


@class DTAppScrollerView, DTApp, DTPageControl;

@protocol DTAppScrollerViewDelegate <NSObject>

- (NSUInteger) numberOfAppsInAppScroller:(DTAppScrollerView *)appScroller;
- (DTApp *) appScroller:(DTAppScrollerView *)appScroller appForIndex:(NSUInteger)index;
- (void) appScroller:(DTAppScrollerView *)appScroller didSelectAppForIndex:(NSUInteger)index;

@optional

- (void) appScroller:(DTAppScrollerView *)appScroller willDisplayButton:(UIButton *)button forApp:(DTApp *)app;


@end



@interface DTAppScrollerView : UIView <UIScrollViewDelegate> 
{
	id <DTAppScrollerViewDelegate> delegate;
	
	UIScrollView *_scrollView;
	DTPageControl *_pageControl;
	
	// internal
	NSMutableArray *_apps;
	NSMutableDictionary *appButtonLookup;
	BOOL dotUpdating;
}


@property (nonatomic, assign) id <DTAppScrollerViewDelegate> delegate;

// method to reload the app icons from delegate
- (void)reloadData;

@end
