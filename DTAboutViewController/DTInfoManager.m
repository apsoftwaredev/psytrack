//
//  DTInfoManager.m
//  About
//
//  Created by Oliver on 17.02.10.
//  Copyright 2010 Drobnik.com. All rights reserved.
//

#import "DTInfoManager.h"
#import "DTApp.h"
#import "DTLayoutDefinition.h"

@interface DTInfoManager ()

@property (nonatomic, retain) NSMutableDictionary *lastRefreshDates;
@property (nonatomic, retain) NSMutableDictionary *cachedDictionaries;


@end



@implementation DTInfoManager
@synthesize lastRefreshDates = _lastRefreshDates, cachedDictionaries = _cachedDictionaries;
@synthesize apps,appsUpdateURL,appsLastRefreshedDate;

static DTInfoManager *_sharedInstance = nil;




+ (DTInfoManager *)sharedManager
{
	if (!_sharedInstance)
	{
		_sharedInstance = [[DTInfoManager alloc] init];
	}
	
	return _sharedInstance;
}


- (id) init
{
	self = [super init];
	if (self)
	{
		queue = [[NSOperationQueue alloc] init];
	}
	
	return self;
}



 #pragma mark Apps Info
 - (void) parseAppsDictionary:(NSDictionary *)appsDict
 {
 NSArray *appsArray = [appsDict objectForKey:@"apps"];
 NSMutableArray *tmpArray = [NSMutableArray array];
 
 for (NSDictionary *oneAppDict in appsArray)
 {
 DTApp *newApp = [[DTApp alloc] init];
 [newApp setValuesForKeysWithDictionary:oneAppDict];
 [tmpArray addObject:newApp];

 }
 
 self.apps = [NSArray arrayWithArray:tmpArray];
 
 NSString *url = [appsDict objectForKey:@"updateURL"];
 self.appsUpdateURL = [NSURL URLWithString:url];
 }
 
 - (void) loadAppsInfo
 {
 NSDictionary *appsDict = nil;
 
 // try cache
 NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
 NSString *cacheDirectory = [paths objectAtIndex:0];
 NSString *apps_file = [cacheDirectory stringByAppendingPathComponent:@"apps.plist"];
 
 NSFileManager *fileManager = [NSFileManager defaultManager];
 
 if ([fileManager fileExistsAtPath:apps_file])
 {
 appsDict = [NSDictionary dictionaryWithContentsOfFile:apps_file];
 
 // get last modified from file
 NSError *error;
 NSDictionary *attributes = [[NSFileManager defaultManager] attributesOfItemAtPath:apps_file error:&error];
 if (attributes) 
 {
 self.appsLastRefreshedDate = [attributes fileModificationDate];
 }
 }
 else
 {
 // nothing in cache, load pre-bundled info file
 NSString *path = [[NSBundle mainBundle] pathForResource:@"apps" ofType:@"plist"];
 appsDict = [NSDictionary dictionaryWithContentsOfFile:path];
 
 // get last modified from file
 NSError *error;
 NSDictionary *attributes = [[NSFileManager defaultManager] attributesOfItemAtPath:path error:&error];
 if (attributes) 
 {
 self.appsLastRefreshedDate = [attributes fileModificationDate];
 }
 
 }
 
 [self parseAppsDictionary:appsDict];
 
 NSDateComponents *comps = [[NSCalendar currentCalendar] components:NSDayCalendarUnit fromDate:self.appsLastRefreshedDate toDate:[NSDate date] options:0];
 NSInteger daysAgo = [comps day];
 
 if (daysAgo > [[appsDict objectForKey:@"TTL"] integerValue])
 {
 [self performSelectorInBackground:@selector(refreshAppsDict) withObject:nil];
 }
 }
 
 
 - (void) refreshAppsDict
 {

 
 if (appsUpdateURL)
 {
 NSDictionary *appsDict = [NSDictionary dictionaryWithContentsOfURL:appsUpdateURL];
 
 if (appsDict)
 {
 [self parseAppsDictionary:appsDict];
 
 // save in cache
 NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
 NSString *cacheDirectory = [paths objectAtIndex:0];
 NSString *apps_file = [cacheDirectory stringByAppendingPathComponent:@"apps.plist"];
 [appsDict writeToFile:apps_file atomically:YES];
 
 [[NSNotificationCenter defaultCenter] postNotificationName:@"DTInfoManagerAppsInfoUpdated" object:nil userInfo:nil];
 }
 else
 {
 
 }
 
 }
 

 }
 




- (NSDictionary *) dictionaryFromCachedPropertyListWithName:(NSString *)fileName
{
	NSDictionary *dictionary = nil;
	NSDate *lastRefreshedDate = nil;
	
	// try in-memory cache
	dictionary = [self.cachedDictionaries objectForKey:fileName];
	
	if (dictionary)
	{
		lastRefreshedDate = [self.lastRefreshDates objectForKey:fileName];
	}
	else 
	{
		// try cache
		NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
		NSString *cacheDirectory = [paths objectAtIndex:0];
		NSString *filePath = [cacheDirectory stringByAppendingPathComponent:fileName];
		
		NSFileManager *fileManager = [NSFileManager defaultManager];
		
		if ([fileManager fileExistsAtPath:filePath])
		{
			dictionary = [NSDictionary dictionaryWithContentsOfFile:filePath];
			
			// get last modified from file
			NSError *error;
			NSDictionary *attributes = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:&error];
			if (attributes) 
			{
				lastRefreshedDate = [attributes fileModificationDate];
				[self.lastRefreshDates setObject:lastRefreshedDate forKey:fileName];
				[self.cachedDictionaries setObject:dictionary forKey:fileName];
			}
		}
		else
		{
			// nothing in cache, load pre-bundled (possibly localized) file
			NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:nil];
			dictionary = [NSDictionary dictionaryWithContentsOfFile:path];
			
			// get last modified from file
			NSError *error;
			NSDictionary *attributes = [[NSFileManager defaultManager] attributesOfItemAtPath:path error:&error];
			if (attributes) 
			{
				lastRefreshedDate = [attributes fileModificationDate];
				[self.lastRefreshDates setObject:lastRefreshedDate forKey:fileName];
				[self.cachedDictionaries setObject:dictionary forKey:fileName];
			}
		}
	}
	
	// check age versus TTL
	if (lastRefreshedDate)
	{
		NSDateComponents *comps = [[NSCalendar currentCalendar] components:NSDayCalendarUnit fromDate:lastRefreshedDate toDate:[NSDate date] options:0];
		NSInteger daysAgo = [comps day];
		
		NSInteger ttl = [[dictionary objectForKey:@"TTL"] integerValue];
		
		if (ttl && daysAgo > ttl)
		{
			// remove modification date to nil to prevent double refreshing
			
			[self.lastRefreshDates removeObjectForKey:fileName];
			
			[self performSelectorInBackground:@selector(refreshDictionaryWithName:) withObject:fileName];
		}
	}
	
	return dictionary;
}

- (void) refreshDictionaryWithName:(NSString *)fileName
{
	

	
	// get dictionary to refresh
	NSDictionary *dictionary = [self.cachedDictionaries objectForKey:fileName];
	
	// get URL for updating
	NSString *url = [dictionary objectForKey:@"updateURL"];
	
	if (!url)
	{
		return;
	}
	
	NSURL *updateURL = [NSURL URLWithString:url];
	
	if (updateURL)
	{
		dictionary = [NSDictionary dictionaryWithContentsOfURL:updateURL];
		
		if (dictionary)
		{
			// save in cache
			NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
			NSString *cacheDirectory = [paths objectAtIndex:0];
			NSString *filePath = [cacheDirectory stringByAppendingPathComponent:fileName];
			[dictionary writeToFile:filePath atomically:YES];
			
			[self.lastRefreshDates setObject:[NSDate date] forKey:fileName];
			
			
			[[NSNotificationCenter defaultCenter] postNotificationName:@"DTInfoManagerDictionaryUpdated" object:nil userInfo:nil];
		}
//		else
//		{
//			
//		}
	}
	
	
}

 
#pragma mark Apps 

- (NSUInteger)numberOfApps
{
	DTLayoutDefinition *appsLayout = [DTLayoutDefinition layoutNamed:@"apps"];
	NSDictionary *appsDict = appsLayout.dictionary;
	apps = [appsDict objectForKey:@"apps"];
	
	return [apps count];
}

- (DTApp *)appAtIndex:(NSUInteger)index
{
	DTLayoutDefinition *appsLayout = [DTLayoutDefinition layoutNamed:@"apps"];
	NSDictionary *appsDict = appsLayout.dictionary;
	apps = [appsDict objectForKey:@"apps"];
	
	DTApp *tmpApp = [DTApp appFromDictionary:[apps objectAtIndex:index]];
	return  tmpApp;
}


#pragma mark Properties
- (NSMutableDictionary *)lastRefreshDates
{
	if (!_lastRefreshDates)
	{
		_lastRefreshDates = [[NSMutableDictionary alloc] init];
		
	}
	
	return _lastRefreshDates;
}

- (NSMutableDictionary *)cachedDictionaries
{
	if (!_cachedDictionaries)
	{
		_cachedDictionaries = [[NSMutableDictionary alloc] init];
		
	}
	
	return _cachedDictionaries;
}

@end
