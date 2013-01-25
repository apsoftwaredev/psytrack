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
	NSMutableDictionary *_lastRefreshDates;
}

+ (DTInfoManager *)sharedManager;

- (NSUInteger)numberOfApps;
- (DTApp *)appAtIndex:(NSUInteger)index;

//- (NSDictionary *) dictionaryFromCachedPropertyListWithName:(NSString *)fileName;

@end
