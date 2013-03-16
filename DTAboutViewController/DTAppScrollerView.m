//
//  DTAppScrollerView.m
//  About
//
//  Created by Oliver Drobnik on 2/15/10.
//  Copyright 2010 Drobnik.com. All rights reserved.
//

#import "DTAppScrollerView.h"
#import "DTApp.h"
#import "UIImage+Helpers.h"
#import "DTPageControl.h"
#import <QuartzCore/QuartzCore.h>

@implementation DTAppScrollerView
@synthesize delegate;

- (id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        CGRect scrollFrame = frame;
        scrollFrame.size.height -= 26.0;

        CGRect pageFrame = frame;
        pageFrame.origin.y = scrollFrame.origin.y + scrollFrame.size.height;
        pageFrame.size.height = 26.0;

        _scrollView = [[UIScrollView alloc] initWithFrame:scrollFrame];
        [self addSubview:_scrollView];
        _scrollView.delegate = self;

        _pageControl = [[DTPageControl alloc] initWithFrame:pageFrame];
        [self addSubview:_pageControl];
        [_pageControl addTarget:self action:@selector(pageControlChanged:) forControlEvents:UIControlEventValueChanged];

        _pageControl.numberOfPages = 1;
        _pageControl.currentPage = 0;
        [_pageControl updateCurrentPageDisplay];

        _scrollView.backgroundColor = [UIColor colorWithWhite:23.0 / 255.0 alpha:1.0];
        _pageControl.backgroundColor = _scrollView.backgroundColor;

        self.clipsToBounds = YES;

        _scrollView.pagingEnabled = YES;
        _scrollView.alwaysBounceHorizontal = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.scrollEnabled = YES;

        // resizing support

        _scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _pageControl.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        @try
        {
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appIconLoaded:) name:@"DTAppLoadedIcon" object:nil];
        }
        @catch (NSException *exception)
        {
            //do nothing
        }
    }

    return self;
}


- (void) reloadData
{
    // remove existing icons and labels
    for (UIView *oneView in [NSArray arrayWithArray : _scrollView.subviews])
    {
        if ([oneView isKindOfClass:[UIButton class]] ||
            [oneView isKindOfClass:[UILabel class]])
        {
            [oneView removeFromSuperview];
        }
    }

    [_apps removeAllObjects];

    // we don't want the icons to move if this is called in animation block
    [CATransaction begin];
    [CATransaction setDisableActions:YES];

    appButtonLookup = [[NSMutableDictionary alloc] init];
    _apps = [[NSMutableArray alloc] init];

    NSUInteger numApps = [delegate numberOfAppsInAppScroller:self];
    NSUInteger iconsPerPage = trunc(self.bounds.size.width / 80.0);

    CGFloat spacePerIcon = round(self.bounds.size.width / (CGFloat)iconsPerPage);
    CGFloat leftMargin = (spacePerIcon - 57.0) / 2.0;

    int pages = ceilf( (numApps / (float)iconsPerPage) );

    for (int i = 0; i < numApps; i++)
    {
        DTApp *oneApp = [delegate appScroller:self appForIndex:i];
        UIImage *icon = [oneApp iconImage];

        UIButton *appIconButton = [UIButton buttonWithType:UIButtonTypeCustom];

        CGRect frame = CGRectMake( (CGFloat)i * spacePerIcon + leftMargin, 19.0, 57.0, 57.0 );
        appIconButton.frame = frame;
        [_scrollView addSubview:appIconButton];
        appIconButton.tag = i;
        [appIconButton addTarget:self action:@selector(appPushed:) forControlEvents:UIControlEventTouchUpInside];
        if (icon)
        {
            [appIconButton setBackgroundImage:icon forState:UIControlStateNormal];
        }
        else
        {
            UIActivityIndicatorView *act = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];

            // center on button
            CGRect frame = act.frame;
            frame.origin.x = round( (appIconButton.bounds.size.width - frame.size.width) / 2.0 );
            frame.origin.y = round( (appIconButton.bounds.size.height - frame.size.height) / 2.0 );
            act.frame = frame;

            [appIconButton addSubview:act];
            [act startAnimating];
        }

        frame.origin.x = round( (CGFloat)i * spacePerIcon );
        frame.size.width = spacePerIcon;
        frame.origin.y = 81.0;
        frame.size.height = 16.0;

        UILabel *appTitleLabel = [[UILabel alloc] initWithFrame:frame];
        appTitleLabel.textAlignment = UITextAlignmentCenter;
        appTitleLabel.font = [UIFont boldSystemFontOfSize:11.0];
        appTitleLabel.textColor = [UIColor lightGrayColor];
        appTitleLabel.text = oneApp.name;
        appTitleLabel.opaque = NO;
        appTitleLabel.backgroundColor = [UIColor clearColor];
        [_scrollView addSubview:appTitleLabel];

        [appButtonLookup setObject:appIconButton forKey:oneApp.name];
        [_apps addObject:oneApp];

        if ([delegate respondsToSelector:@selector(appScroller:willDisplayButton:forApp:)])
        {
            [delegate appScroller:self willDisplayButton:appIconButton forApp:oneApp];
        }
    }

    _scrollView.contentSize = CGSizeMake(self.bounds.size.width * (CGFloat)pages, _scrollView.frame.size.height);
    _pageControl.numberOfPages = pages;

    [CATransaction commit];
}


- (void) layoutSubviews
{
    [super layoutSubviews];

    if (_scrollView.dragging || _scrollView.decelerating || dotUpdating)
    {
        return;
    }

    // layoutSubviews is also called during scrolling, but we only want to do setup once
    if (![_scrollView.subviews count])
    {
        [self reloadData];
        //		[_scrollView.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
    }
}


- (void) setFrame:(CGRect)newFrame
{
    if ( !CGRectEqualToRect(newFrame, self.frame) )
    {
        [super setFrame:newFrame];

        [_scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [self reloadData];
    }
}


/*
   - (void) didMoveToSuperview
   {
   [super didMoveToSuperview];

   [self setup];
   }
 */

- (void) dealloc
{
    @try
    {
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }
    @catch (NSException *exception)
    {
        //do nothinbg
    }
}


- (void) appPushed:(id)sender
{
    UIButton *button = sender;

    [delegate appScroller:self didSelectAppForIndex:button.tag];
}


#pragma mark ScrollView
- (void) scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (dotUpdating)
    {
        CGFloat page = round(_scrollView.contentOffset.x / _scrollView.bounds.size.width);
        _pageControl.currentPage = page;
        [_pageControl setNeedsDisplay];
    }
}


- (void) scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    dotUpdating = YES;
}


#pragma mark Page Control
- (void) pageControlChanged:(DTPageControl *)sender
{
    dotUpdating = NO;
    [_scrollView scrollRectToVisible:CGRectMake(sender.currentPage * _scrollView.bounds.size.width, 0, _scrollView.bounds.size.width, _scrollView.bounds.size.height) animated:YES];
}


#pragma mark Notifications

- (void) appIconLoaded:(NSNotification *)notification
{
    DTApp *app = [[notification userInfo] objectForKey:@"App"];

    if ([_apps containsObject:app])
    {
        return;
    }

    UIButton *appIconButton = [appButtonLookup objectForKey:app.name];
    [appIconButton setBackgroundImage:app.iconImage forState:UIControlStateNormal];

    for (UIView *oneView in appIconButton.subviews)
    {
        if ([oneView isKindOfClass:[UIActivityIndicatorView class]])
        {
            [(UIActivityIndicatorView *)oneView stopAnimating];
        }
    }
}


@end
