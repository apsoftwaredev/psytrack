//
//  DTLayoutDefinition.h
//  About
//
//  Created by Oliver Drobnik on 4/30/10.
//  Copyright 2010 Drobnik.com. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DTLayoutDefinition : NSObject 
{
	NSString *_name;
	NSDictionary *_dictionary;
	NSDate *_lastModifiedDate;
	
	BOOL isRefreshing;
}

- (id)initWithDictionary:(NSDictionary *)dictionary;

+ (DTLayoutDefinition *)layoutNamed:(NSString *)name;

- (NSUInteger)numberOfRows;
- (NSDictionary *)rowDictionaryAtIndex:(NSUInteger)index;


@property (nonatomic, strong, readonly) NSString *name;
@property (nonatomic, strong, readonly) NSDictionary *dictionary;
@property (nonatomic, strong, readonly) NSDate *lastModifiedDate;



@end
