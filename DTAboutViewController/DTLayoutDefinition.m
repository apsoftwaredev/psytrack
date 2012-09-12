//
//  DTLayoutDefinition.m
//  About
//
//  Created by Oliver Drobnik on 4/30/10.
//  Copyright 2010 Drobnik.com. All rights reserved.
//

#import "DTLayoutDefinition.h"


static NSMutableDictionary *_cachedLayouts = nil;


@interface DTLayoutDefinition ()

@property (nonatomic, strong) NSDictionary *dictionary;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSDate *lastModifiedDate;

@end




@implementation DTLayoutDefinition

@synthesize dictionary = _dictionary, lastModifiedDate = _lastModifiedDate, name = _name;

- (id)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if (self)
	{
		self.dictionary = dictionary;
	}
	
	return self;
}

- (id)initWithContentsOfFile:(NSString *)path
{
    
	NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:path];
	
    // Get name of plist
    NSString *name = [[path lastPathComponent] stringByDeletingPathExtension];
	
	if (self=[self initWithDictionary:dictionary])
	{
		// get last modified from file
		NSError *error;
		NSDictionary *attributes = [[NSFileManager defaultManager] attributesOfItemAtPath:path error:&error];
		if (attributes) 
		{
			self.lastModifiedDate = [attributes fileModificationDate];
		}
		else
		{
//			
		
			
			return nil;
		}
		
		// check age versus TTL
		if (!isRefreshing && self.lastModifiedDate)
		{
			NSDateComponents *comps = [[NSCalendar currentCalendar] components:NSDayCalendarUnit fromDate:self.lastModifiedDate toDate:[NSDate date] options:0];
			NSInteger daysAgo = [comps day];
			
			NSInteger ttl = [[dictionary objectForKey:@"TTL"] integerValue];
			
			// ttl of 0 means that we refresh every time
			if (daysAgo >= ttl)
			{
				isRefreshing = YES;
				[self performSelectorInBackground:@selector(refreshFromServer:) withObject:name];
			}
		}
	}
	
	return self;
}


- (void) updateDictionary:(NSDictionary *)dictionary
{
	self.dictionary = dictionary;
	self.lastModifiedDate = [NSDate date];
	
	isRefreshing = NO;
	
	[[NSNotificationCenter defaultCenter] postNotificationName:@"DTInfoManagerLayoutUpdated" object:self userInfo:nil];
}



- (void) refreshFromServer:(NSString *)name
{
	

	
	// get URL for updating
	NSString *url = [_dictionary objectForKey:@"updateURL"];
	
	if (!url)
	{
		return;
	}
	
	NSURL *updateURL = [NSURL URLWithString:url];
	
	if (updateURL)
	{
		NSDictionary *tmpDictionary = [NSDictionary dictionaryWithContentsOfURL:updateURL];
		
		if (tmpDictionary)
		{
			// save in cache
			NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
			NSString *cacheDirectory = [paths objectAtIndex:0];
			NSString *filePath = [[cacheDirectory stringByAppendingPathComponent:name] stringByAppendingPathExtension:@"plist"];
			[tmpDictionary writeToFile:filePath atomically:YES];
			
			[self performSelectorOnMainThread:@selector(updateDictionary:) withObject:tmpDictionary waitUntilDone:YES];
		}
//		else
//		{
//			
//		}
	}
	

}




+ (DTLayoutDefinition *)layoutNamed:(NSString *)name
{
	DTLayoutDefinition *layout = nil;
	
	// try class-wide cache
	if (_cachedLayouts)
	{
		layout = [_cachedLayouts objectForKey:name];
	}
	else 
	{
		_cachedLayouts = [[NSMutableDictionary alloc] init];
	}
	
	if (!layout)
	{
		// try cache folder
		NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
		NSString *cacheDirectory = [paths objectAtIndex:0];
		NSString *filePath = [[cacheDirectory stringByAppendingPathComponent:name] stringByAppendingPathExtension:@"plist"];
		
		NSFileManager *fileManager = [NSFileManager defaultManager];
		
		if ([fileManager fileExistsAtPath:filePath])
		{
			layout = [[DTLayoutDefinition alloc] initWithContentsOfFile:filePath];
		}
		else
		{
			// nothing in cache, load pre-bundled (possibly localized) file
			filePath = [[NSBundle mainBundle] pathForResource:name ofType:@"plist"];
			layout = [[DTLayoutDefinition alloc] initWithContentsOfFile:filePath];
		}
		
		// if we managed to load a layout, then cache it in-memory
		if (layout)
		{
			layout.name = name;
			[_cachedLayouts setObject:layout forKey:name];
		}
	}
	
	return layout;
}

#pragma mark Layout Row Handling
- (NSUInteger)numberOfRows
{
	NSArray *rowsArray = [_dictionary objectForKey:@"Rows"];
	return [rowsArray count];	
}

- (NSDictionary *)rowDictionaryAtIndex:(NSUInteger)index
{
	NSArray *rowsArray = [_dictionary objectForKey:@"Rows"];
	return [rowsArray objectAtIndex:index];	
}



@end
