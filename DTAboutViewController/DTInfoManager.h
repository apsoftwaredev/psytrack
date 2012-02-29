//
//  DTInfoManager.h
//  About
//
//  Created by Oliver on 17.02.10.
//  Copyright 2010 Drobnik.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DTAppScrollerView.h"

@interface DTInfoManager : NSObject
{
	NSOperationQueue *queue;

	NSMutableDictionary *_cachedDictionaries;
	NSMutableDictionary *_lastRefreshDates;\
    
    NSArray *apps;
    NSURL * appsUpdateURL;
    NSDate *appsLastRefreshedDate;
}


@property (nonatomic, strong) NSArray *apps;
@property (nonatomic, strong) NSURL *appsUpdateURL;
@property (nonatomic, strong) NSDate *appsLastRefreshedDate;

+ (DTInfoManager *)sharedManager;

- (NSUInteger)numberOfApps;
- (DTApp *)appAtIndex:(NSUInteger)index;

- (NSDictionary *) dictionaryFromCachedPropertyListWithName:(NSString *)fileName;

@end
