//
//  CSVFile.h
//  psyTrainTrack
//
//  Created by Daniel Boice on 12/18/11.
//  Copyright (c) 2011 PsycheWeb LLC. All rights reserved.
//


#import <foundation/Foundation.h>


@interface TabFile : NSObject
{
    NSArray *data;
}

- (id)initWithContentsOfString:(NSString *)s;
- (id)initWithContentsOfURL:(NSURL *)url encoding:(NSStringEncoding)enc;
- (NSString *)objectAtIndex:(unsigned int)i;
- (unsigned int)count;

@end