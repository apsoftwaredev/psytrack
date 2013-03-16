//
//  DTAboutViewController.m
//  About
//
//  Created by Oliver Drobnik on 2/13/10.
//  Copyright 2010 Drobnik.com. All rights reserved.
//

#import "DTAboutViewController.h"
#import "NSString+Helpers.h"
#import "DTAboutDocumentViewController.h"
#import "DTAppScrollerView.h"
#import "DTApp.h"
#import "DTFAQTable.h"
#import "DTInfoManager.h"
#import "UILabel+Helpers.h"
#import <QuartzCore/QuartzCore.h>
#import "UIView+Helpers.h"
#import "DTButton.h"
#import "PTTAppDelegate.h"

@interface DTAboutViewController ()

@property (nonatomic, retain) DTLayoutDefinition *layout;
@property (nonatomic, retain) NSMutableArray *commandsForShowingActionSheet;
@property (nonatomic, retain) NSMutableDictionary *customViews;

- (void) openTwitterAppForFollowingUser:(NSString *)twitterUserName;
- (void) openReviewPageInAppStoreForAppWithID:(NSUInteger)appID;
- (void) openExternalMailWithAddress:(NSString *)address subject:(NSString *)subject body:(NSString *)body;
- (void) openWebViewForURL:(NSURL *)url allowFullScreen:(BOOL)allowFullScreen;

- (void) showInAppEmailWithAddress:(NSString *)address subject:(NSString *)subject body:(NSString *)body;
- (void) performAboutAction:(NSString *)action withObject:(id)object;

- (BOOL) hasInAppMailAndCanSendWithIt;

- (UIView *) viewForDictionary:(NSDictionary *)dictionary atIndexPath:(NSIndexPath *)indexPath;

@end

@implementation DTAboutViewController
@synthesize layout = _layout, commandsForShowingActionSheet, delegate, customViews;
@synthesize backgroundView, cellEdgeInsets;

#pragma mark Init / Memory
- (id) initWithLayout:(DTLayoutDefinition *)layout
{
    self = [super init];
    if (self)
    {
        if (layout)
        {
            self.layout = layout;
        }
        else
        {
            // load default localized plist
            self.layout = [DTLayoutDefinition layoutNamed:@"about"];
        }

        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        //_tableView = self.tableView;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = YES;
        _tableView.autoresizingMask = self.view.autoresizingMask;
        [self.view addSubview:_tableView];

        self.view.backgroundColor = [UIColor clearColor];

        _tableView.backgroundColor = self.view.backgroundColor;         //[UIColor clearColor];
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

        if (_tableView.style == UITableViewStylePlain)
        {
            cellEdgeInsets = UIEdgeInsetsMake(5.0, 9.0, 5.0, 9.0);
        }
        else
        {
            cellEdgeInsets = UIEdgeInsetsZero;
        }

        delegate = self;

        // notification when apps list has been updated
        @try
        {
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(layoutDefinitionUpdated:) name:@"DTInfoManagerLayoutUpdated" object:nil];
        }
        @catch (NSException *exception)
        {
            //do nothhihg
        }
    }

    return self;
}


- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    // prevent scrolling if table view is less than screen size
    if (_tableView.contentSize.height < _tableView.bounds.size.height)
    {
        _tableView.delaysContentTouches = YES;
        _tableView.scrollEnabled = NO;
    }
}


- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // Hide the navigation controller
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}


- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;     // all supported
}


#pragma mark Helpers

/*
   - (NSDictionary *)findRowInStructureWithTitle:(NSString *)title
   {
   NSArray *rows = [layoutDictionary objectForKey:@"Rows"];

   for (NSDictionary *oneRow in rows)
   {
   NSString *rowTitle = [oneRow objectForKey:@"Title"];

   if ([rowTitle isEqualToString:title])
   {
   return oneRow;
   }
   }

   return nil; // nothing found
   }
 */

- (CGFloat) cellWidth
{
    CGFloat maxWidth = self.view.bounds.size.width - cellEdgeInsets.left - cellEdgeInsets.right;
    if (_tableView.style == UITableViewStyleGrouped)
    {
        maxWidth -= 20.0;
    }

    return maxWidth;
}


- (UIView *) viewForDictionary:(NSDictionary *)dictionary atIndexPath:(NSIndexPath *)indexPath
{
    NSString *title = NSLocalizedString([dictionary objectForKey:@"Title"], @"DTAboutViewController");
    NSString *type = [dictionary objectForKey:@"Type"];

    UIView *contentView = nil;

    CGFloat maxWidth = [self cellWidth];

    if ([type isEqualToString:@"Image"])
    {
        NSURL *imageURL = [NSURL URLWithString:[dictionary objectForKey:@"ImageURL"]];

        if ([imageURL isFileURL])
        {
            NSString *fileName = [imageURL resourceSpecifier];
            NSString *localizedPath = [[NSBundle mainBundle] pathForResource:fileName ofType:nil];

            UIImage *image = [UIImage imageWithContentsOfFile:localizedPath];
            contentView = [[UIImageView alloc] initWithImage:image];
            contentView.contentMode = UIViewContentModeScaleAspectFit;
        }
        else
        {
            NSData *data = [NSData dataWithContentsOfURL:imageURL];
            UIImage *image = [UIImage imageWithData:data];
            contentView = [[UIImageView alloc] initWithImage:image];
        }
    }

    if ([type isEqualToString:@"AppScroller"])
    {
        if (!_appScrollerView)
        {
            _appScrollerView = [[DTAppScrollerView alloc] initWithFrame:CGRectMake(0, 0, maxWidth, 130.0)];
            _appScrollerView.delegate = self;
            [_appScrollerView setRoundedCornersWithRadius:10.0 borderWidth:2.0 borderColor:nil];
        }

        contentView = _appScrollerView;
    }

    if ([type isEqualToString:@"Text"])
    {
        UIFont *usedFont = nil;

        int style = [[dictionary objectForKey:@"TextStyle"] intValue];

        switch (style)
        {
            case 0:
                usedFont = [UIFont systemFontOfSize:14.0];
                break;
            case 1:
                usedFont = [UIFont boldSystemFontOfSize:14.0];
                break;
            default:
                break;
        }

        UILabel *label = [UILabel autosizedLabelToFitText:[NSLocalizedString(title, @"DTAboutViewController") stringBySubstitutingInfoTokens] withFont:usedFont constrainedToSize:CGSizeMake(maxWidth, 480.0)];
        label.textAlignment = UITextAlignmentCenter;

        if (delegate && [delegate respondsToSelector:@selector(aboutViewController:didSetupLabel:forTextStyle:)])
        {
            [delegate aboutViewController:self didSetupLabel:label forTextStyle:style];
        }

        contentView = label;
    }

    if ([type isEqualToString:@"Button"])
    {
        DTButtonStyle style = [[dictionary objectForKey:@"ButtonStyle"] intValue];

        UIButton *button;

        if (style)
        {
            button = [[DTButton alloc] initWithFrame:CGRectMake(0, 0, maxWidth, 45.0)];
            ( (DTButton *)button ).style = style;
            [button setTitleShadowColor:[UIColor colorWithWhite:0 alpha:0.50] forState:UIControlStateNormal];
            button.titleLabel.shadowOffset = CGSizeMake(0, -1);
            button.titleLabel.font = [UIFont boldSystemFontOfSize:14.0];
        }
        else
        {
            button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        }

        [button setTitle:title forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonPushed:) forControlEvents:UIControlEventTouchUpInside];
        button.frame = CGRectMake(0, 0, maxWidth, 40.0);

        contentView = button;
    }

    if ([type isEqualToString:@"Table"])
    {
        DTFAQTable *faq = [[DTFAQTable alloc] initWithFrame:CGRectMake(0, 0, maxWidth, 300.0)];
        faq.navController = self.navigationController;
        [faq setRoundedCornersWithRadius:10.0 borderWidth:2.0 borderColor:nil];

        faq.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(2.5, 5.0, 2.5, 2.5);
        faq.useTextViews = [[dictionary objectForKey:@"UseTextViews"] boolValue];

        NSInteger rowHeight = [[dictionary objectForKey:@"RowHeight"] integerValue];
        if (rowHeight)
        {
            faq.rowHeight = rowHeight;
        }
        else
        {
            // default
            faq.rowHeight = 60.0;
        }

        NSInteger showRows = [[dictionary objectForKey:@"ShowRows"] integerValue];
        if (showRows)
        {
            [faq sizeToShowRows:showRows];
        }

        NSURL *rowsURL = [NSURL URLWithString:[dictionary objectForKey:@"RowsURL"]];

        if ([rowsURL isFileURL])
        {
            NSString *fileName = [rowsURL resourceSpecifier];
            NSString *localizedPath = [[NSBundle mainBundle] pathForResource:fileName ofType:nil];

            faq.faqs = [NSArray arrayWithContentsOfFile:localizedPath];
        }
        else
        {
            faq.faqs = [NSArray arrayWithContentsOfURL:rowsURL];
        }

        contentView = faq;
    }

    if (!contentView && delegate && [delegate respondsToSelector:@selector(aboutViewController:customViewForDictionary:)])
    {
        contentView = [delegate aboutViewController:self customViewForDictionary:dictionary];
    }

    contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

    return contentView;
}


#pragma mark Properties
- (NSMutableArray *) commandsForShowingActionSheet
{
    if (!commandsForShowingActionSheet)
    {
        commandsForShowingActionSheet = [[NSMutableArray alloc] init];
    }

    return commandsForShowingActionSheet;
}


- (NSMutableDictionary *) customViews
{
    if (!customViews)
    {
        customViews = [[NSMutableDictionary alloc] init];
    }

    return customViews;
}


- (void) setBackgroundView:(UIView *)newBackgroundView
{
    if (backgroundView != newBackgroundView)
    {
    }

    if (newBackgroundView)
    {
        backgroundView = newBackgroundView;
        [self.view insertSubview:backgroundView atIndex:0];         // bottommost

        _tableView.opaque = NO;
        _tableView.backgroundColor = [UIColor clearColor];
    }
    else
    {
        _tableView.opaque = YES;
        self.view.opaque = YES;
    }
}


#pragma mark Table view methods
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView.style == UITableViewStyleGrouped)
    {
        return [_layout numberOfRows];
    }
    else
    {
        return 1;
    }
}


- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.style == UITableViewStylePlain)
    {
        return [_layout numberOfRows];
    }
    else
    {
        return 1;
    }
}


- (UITableViewCell *) tableView:(UITableView *)tableView configureCellForDict:(NSDictionary *)rowDict atIndexPath:(NSIndexPath *)indexPath
{
    // workaround for iOS 5 bug
    NSString *customKey = [NSString stringWithFormat:@"%d-%d", indexPath.section, indexPath.row];     // we cache our custom views, indexPath is the key

    NSUInteger index;

    if (tableView.style == UITableViewStyleGrouped)
    {
        index = indexPath.section;
    }
    else
    {
        index = indexPath.row;
    }

    // only certain custom types are reusable
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:customKey];

    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:customKey];

        UIView *customView = [customViews objectForKey:customKey];

        if (!customView && [delegate respondsToSelector:@selector(aboutViewController:customViewForDictionary:)])
        {
            customView = [delegate aboutViewController:self customViewForDictionary:rowDict];
            customView.tag = index;

            [self.customViews setObject:customView forKey:customKey];
        }

        if (customView)
        {
            BOOL shouldNotWrap = [[rowDict objectForKey:@"IgnoreCellInsets"] boolValue];

            customView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
            cell.contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
            cell.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
            cell.clipsToBounds = YES;

            if (shouldNotWrap)
            {
                customView.frame = cell.contentView.bounds;
                [cell.contentView addSubview:customView];
            }
            else
            {
                [cell.contentView addSubview:customView];

                CGRect frame = cell.contentView.bounds;

                frame.origin.x = cellEdgeInsets.left;
                frame.origin.y = cellEdgeInsets.top;
                frame.size.width -= cellEdgeInsets.left + cellEdgeInsets.right;
                frame.size.height -= cellEdgeInsets.top + cellEdgeInsets.bottom;

                customView.frame = frame;
            }
        }

        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }

    return cell;
}


- (void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [_tableView reloadData];
}


- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger index;

    if (tableView.style == UITableViewStyleGrouped)
    {
        index = indexPath.section;
    }
    else
    {
        index = indexPath.row;
    }

    NSDictionary *rowDict = [_layout rowDictionaryAtIndex:index];

    NSString *customKey = [NSString stringWithFormat:@"%d-%d", indexPath.section, indexPath.row];     // we cache our custom views, indexPath
    UIView *customView = [customViews objectForKey:customKey];

    if (!customView)
    {
        customView = [self viewForDictionary:rowDict atIndexPath:indexPath];
        if (customView)
        {
            [self.customViews setObject:customView forKey:customKey];
            customView.tag = index;
            CGFloat height = customView.bounds.size.height;             // + cellEdgeInsets.top + cellEdgeInsets.bottom;

            BOOL shouldNotWrap = [[rowDict objectForKey:@"IgnoreCellInsets"] boolValue];

            if (!shouldNotWrap)
            {
                height += cellEdgeInsets.top + cellEdgeInsets.bottom;
            }

            return height;
        }
    }
    else
    {
        CGFloat height = customView.bounds.size.height;        // + cellEdgeInsets.top + cellEdgeInsets.bottom;

        BOOL shouldNotWrap = [[rowDict objectForKey:@"IgnoreCellInsets"] boolValue];

        if (!shouldNotWrap)
        {
            height += cellEdgeInsets.top + cellEdgeInsets.bottom;
        }

        return height;
    }

    return 0;
}


- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger index;

    if (tableView.style == UITableViewStyleGrouped)
    {
        index = indexPath.section;
    }
    else
    {
        index = indexPath.row;
    }

    NSDictionary *rowDict = [_layout rowDictionaryAtIndex:index];

    return [self tableView:tableView configureCellForDict:rowDict atIndexPath:indexPath];
}


- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    NSUInteger index;

    if (tableView.style == UITableViewStyleGrouped)
    {
        index = indexPath.section;
    }
    else
    {
        index = indexPath.row;
    }

    NSDictionary *rowDict = [_layout rowDictionaryAtIndex:index];

    NSString *rowAction = [rowDict objectForKey:@"Action"];
    NSArray *actionRows = [rowDict objectForKey:@"ActionRows"];

    [self performAboutAction:rowAction withObject:actionRows];
}


#pragma mark External App Handling

- (void) openTwitterAppForFollowingUser:(NSString *)twitterUserName
{
    if (!twitterUserName)
    {
        return;
    }

    twitterUserName = [twitterUserName stringByUrlEncoding];

//	UIApplication *app = [UIApplication sharedApplication];

//    // Tweetbot App: http://tapbots.com/blog/development/tweetbot-url-scheme
//	NSURL *tweetbotURL = [NSURL URLWithString:[NSString stringWithFormat:@"tweetbot:///user_profile/%@", twitterUserName]];
//	if ([app canOpenURL:tweetbotURL])
//	{
//		[app openURL:tweetbotURL];
//		return;
//	}
//
//    // Twitter App: http://developer.atebits.com/tweetie-iphone/protocol-reference/
//	NSURL *twitterURL = [NSURL URLWithString:[NSString stringWithFormat:@"twitter://user?screen_name=%@", twitterUserName]];
//	if ([app canOpenURL:twitterURL])
//	{
//		[app openURL:twitterURL];
//		return;
//	}
//
//
//	// Birdfeed: http://birdfeed.tumblr.com/post/172994970/url-scheme
//	NSURL *birdfeedURL = [NSURL URLWithString:[NSString stringWithFormat:@"x-birdfeed://user?screen_name=%@", twitterUserName]];
//	if ([app canOpenURL:birdfeedURL])
//	{
//		[app openURL:birdfeedURL];
//		return;
//	}
//
//
//	// Twittelator: http://www.stone.com/Twittelator/Twittelator_API.html
//	NSURL *twittelatorURL = [NSURL URLWithString:[NSString stringWithFormat:@"twit:///user?screen_name=%@", twitterUserName]];
//	if ([app canOpenURL:twittelatorURL])
//	{
//		[app openURL:twittelatorURL];
//		return;
//	}
//
//
//	// Icebird: http://icebirdapp.com/developerdocumentation/
//	NSURL *icebirdURL = [NSURL URLWithString:[NSString stringWithFormat:@"icebird://user?screen_name=%@", twitterUserName]];
//	if ([app canOpenURL:icebirdURL])
//	{
//		[app openURL:icebirdURL];
//		return;
//	}
//
//
//	// Fluttr: no docs
//	NSURL *fluttrURL = [NSURL URLWithString:[NSString stringWithFormat:@"fluttr://user/%@", twitterUserName]];
//	if ([app canOpenURL:fluttrURL])
//	{
//		[app openURL:fluttrURL];
//		return;
//	}
//
//
//	// SimplyTweet: http://motionobj.com/blog/url-schemes-in-simplytweet-23
//	NSURL *simplytweetURL = [NSURL URLWithString:[NSString stringWithFormat:@"simplytweet:?link=http://twitter.com/%@", twitterUserName]];
//	if ([app canOpenURL:simplytweetURL])
//	{
//		[app openURL:simplytweetURL];
//		return;
//	}
//
//
//	// Tweetings: http://tweetings.net/iphone/scheme.html
//	NSURL *tweetingsURL = [NSURL URLWithString:[NSString stringWithFormat:@"tweetings:///user?screen_name=%@", twitterUserName]];
//	if ([app canOpenURL:tweetingsURL])
//	{
//		[app openURL:tweetingsURL];
//		return;
//	}
//
//
//	// Echofon: http://echofon.com/twitter/iphone/guide.html
//	NSURL *echofonURL = [NSURL URLWithString:[NSString stringWithFormat:@"echofon:///user_timeline?%@", twitterUserName]];
//	if ([app canOpenURL:echofonURL])
//	{
//		[app openURL:echofonURL];
//		return;
//	}
//

    // --- Fallback: Mobile Twitter in Safari
    NSURL *safariURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://mobile.twitter.com/%@", twitterUserName]];
    [self openWebViewForURL:safariURL allowFullScreen:NO];
}


- (void) openReviewPageInAppStoreForAppWithID:(NSUInteger)appID
{
    if (!appID)
    {
        return;
    }

    UIApplication *app = [UIApplication sharedApplication];

    NSString *str = [NSString stringWithFormat:@"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%d", appID];
    NSURL *url = [NSURL URLWithString:str];

    if ([app canOpenURL:url])
    {
        [app openURL:url];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"In Simulator" message:@"This only works on device" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
    }
}


- (void) openExternalURL:(NSURL *)url
{
    // TO DO: ask delegate if we should show an action sheet with confirmation to go to external url

    UIApplication *app = [UIApplication sharedApplication];

    if ([app canOpenURL:url])
    {
        [app openURL:url];
    }
}


- (void) openWebViewForURL:(NSURL *)url allowFullScreen:(BOOL)allowFullScreen
{
    // TO DO: ask delegate if we should show an action sheet with confirmation to go to external url

    if ([url isFileURL])
    {
        NSString *fileName = [url resourceSpecifier];
        NSString *localizedPath = [[NSBundle mainBundle] pathForResource:fileName ofType:nil];

        url = [NSURL fileURLWithPath:localizedPath];
    }

    DTAboutDocumentViewController *docViewer = [[DTAboutDocumentViewController alloc] initWithDocumentURL:url];
    docViewer.fullScreenViewing = allowFullScreen;
    [self.navigationController pushViewController:docViewer animated:YES];
}


#pragma mark E-Mail

- (BOOL) hasInAppMailAndCanSendWithIt
{
    Class mailClass = ( NSClassFromString(@"MFMailComposeViewController") );
    if (mailClass != nil)
    {
        // We must always check whether the current device is configured for sending emails
        if ([mailClass canSendMail])
        {
            return YES;
        }
        else
        {
            return NO;
        }
    }
    else
    {
        return NO;
    }
}


- (void) showInAppEmailWithAddress:(NSString *)address subject:(NSString *)subject body:(NSString *)body
{
    MFMailComposeViewController *mailView = [[MFMailComposeViewController alloc] init];

    // make style and color same as current navigationBar
    mailView.navigationBar.tintColor = self.navigationController.navigationBar.tintColor;
    mailView.navigationBar.barStyle = self.navigationController.navigationBar.barStyle;

    if ([address length])
    {
        [mailView setToRecipients:[NSArray arrayWithObject:address]];
    }

    if ([body length])
    {
        [mailView setMessageBody:body isHTML:YES];
    }

    if ([subject length])
    {
        [mailView setSubject:subject];
    }

    mailView.mailComposeDelegate = self;

    [self presentModalViewController:mailView animated:YES];
}


- (void) openExternalMailWithAddress:(NSString *)address subject:(NSString *)subject body:(NSString *)body
{
    UIApplication *app = [UIApplication sharedApplication];

    if (!address)
    {
        address = @"";
    }

    if (!subject)
    {
        subject = @"";
    }

    if (!body)
    {
        body = @"";
    }

    NSString *email = [NSString stringWithFormat:@"mailto:%@?subject=%@&body=%@", address, [subject stringByUrlEncoding], [body stringByUrlEncoding]];
    NSURL *url = [NSURL URLWithString:email];

    [app openURL:url];
}


// Dismisses the email composition interface when users tap Cancel or Send. Proceeds to update the message field with the result of the operation.
- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    //message.hidden = NO;
    // Notifies users about errors associated with the interface
    NSString *message;
    switch (result)
    {
        case MFMailComposeResultCancelled:
            message = @"Email canceled";
            break;
        case MFMailComposeResultSaved:
            message = @"Email saved";
            break;
        case MFMailComposeResultSent:
            message = @"Email sent";
            break;
        case MFMailComposeResultFailed:
            message = @"Email failed";
            break;
        default:
            message = @"Email not sent";
            break;
    } /* switch */

    [self dismissModalViewControllerAnimated:YES];
    PTTAppDelegate *appDelegate = (PTTAppDelegate *)[UIApplication sharedApplication].delegate;
    [appDelegate displayNotification:message forDuration:2.0 location:kPTTScreenLocationTop inView:nil];
}


#pragma mark Actions
- (void) buttonPushed:(id)sender;
{
    UIButton *button = sender;

    NSDictionary *rowDict = [_layout rowDictionaryAtIndex:button.tag];

    if (rowDict)
    {
        NSString *action = [rowDict objectForKey:@"Action"];
        NSArray *actionRows = [rowDict objectForKey:@"ActionRows"];

        [self performAboutAction:action withObject:actionRows];
    }
    else
    {
    }
}

- (void) performAboutAction:(NSString *)action withObject:(id)object
{
    if (!action)
    {
        return;
    }

    NSArray *components = [action componentsSeparatedByString:@"|"];

    NSString *command = [[components objectAtIndex:0] lowercaseString];

    if ([command isEqualToString:@"actionsheet"])
    {
        UIActionSheet *actionSheet = [[UIActionSheet alloc] init];
        [self.commandsForShowingActionSheet removeAllObjects];

        NSArray *rows = object;

        for (NSDictionary *oneRow in rows)
        {
            NSString *title = NSLocalizedString([oneRow objectForKey:@"Title"], @"DTAboutViewController");
            [actionSheet addButtonWithTitle:title];
            NSString *action = [oneRow objectForKey:@"Action"];
            [commandsForShowingActionSheet addObject:action];
        }

        [actionSheet addButtonWithTitle:NSLocalizedString(@"Cancel", @"DTAboutViewController")];
        [actionSheet setCancelButtonIndex:[rows count]];

        actionSheet.delegate = self;

        [actionSheet showInView:self.view];
    }
    else if ([command isEqualToString:@"opentwitter"])
    {
        NSString *twitterName = [components lastObject];
        [self openTwitterAppForFollowingUser:twitterName];
    }
    else if ([command isEqualToString:@"openreview"])
    {
        NSString *rawAppID = [[components lastObject] stringBySubstitutingInfoTokens];
        NSUInteger applicationID = [rawAppID intValue];
        [self openReviewPageInAppStoreForAppWithID:applicationID];
    }
    else if ([command isEqualToString:@"openmail"])
    {
        NSString *address = [components count] > 1 ? [components objectAtIndex:1] : nil;
        NSString *subject = [components count] > 2 ? [NSLocalizedString([components objectAtIndex:2], @"DTAboutViewController") stringBySubstitutingInfoTokens] : nil;
        NSString *body = [components count] > 3 ? [NSLocalizedString([components objectAtIndex:3], @"DTAboutViewController") stringBySubstitutingInfoTokens] : nil;

        if ([self hasInAppMailAndCanSendWithIt])
        {
            [self showInAppEmailWithAddress:address subject:subject body:body];
        }
        else
        {
            [self openExternalMailWithAddress:address subject:subject body:body];
        }
    }
    else if ([command isEqualToString:@"openurl"])
    {
        NSString *str = [components lastObject];
        [self openExternalURL:[NSURL URLWithString:str]];
    }
    else if ([command isEqualToString:@"openwebview"])
    {
        NSString *str = [components lastObject];
        [self openWebViewForURL:[NSURL URLWithString:str] allowFullScreen:NO];
    }
    else if (delegate && [delegate respondsToSelector:@selector(aboutViewController:performCustomAction:withObject:)])
    {
        [delegate aboutViewController:self performCustomAction:action withObject:object];
    }
    else
    {
    }
}


#pragma mark Action Sheets
- (void) actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex < [self.commandsForShowingActionSheet count])
    {
        NSString *command = [self.commandsForShowingActionSheet objectAtIndex:buttonIndex];
        [self performAboutAction:command withObject:nil];
    }
}


#pragma mark -
#pragma mark DTAppScrollerView

- (NSUInteger) numberOfAppsInAppScroller:(DTAppScrollerView *)appScroller
{
    return [[DTInfoManager sharedManager] numberOfApps];
}


- (DTApp *) appScroller:(DTAppScrollerView *)appScroller appForIndex:(NSUInteger)index
{
    return [[DTInfoManager sharedManager] appAtIndex:index];
}


- (void) appScroller:(DTAppScrollerView *)appScroller didSelectAppForIndex:(NSUInteger)index
{
    DTApp *app = [self appScroller:appScroller appForIndex:index];

    [self openExternalURL:[NSURL URLWithString:app.detailURL]];
}


- (void) appScroller:(DTAppScrollerView *)appScroller willDisplayButton:(UIButton *)button forApp:(DTApp *)app
{
    if ([app isInstalled])
    {
        button.userInteractionEnabled = NO;
    }
    else
    {
        [button setImage:[UIImage imageNamed:@"app_violator.png"] forState:UIControlStateNormal];
    }
}


#pragma mark Notifications
- (void) layoutDefinitionUpdated:(NSNotification *)notification
{
    DTLayoutDefinition *layout = [notification object];

    if ([layout.name isEqualToString:@"apps"])
    {
        // reload contents of scroller
        [_appScrollerView reloadData];
    }
}


@end
