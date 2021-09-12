/*
 *  TabFile.m
 *  psyTrack Clinician Tools
 *  Version: 1.0
 *
 *
 The MIT License (MIT)
 Copyright © 2011- 2021 Daniel Boice
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 *
 *  Created by Daniel Boice on 12/18/11.
 *  Copyright (c) 2011 PsycheWeb LLC. All rights reserved.
 *
 *
 *	This notice may not be removed from this file.
 *
 */
#import "TabFile.h"

@implementation TabFile

- (id) initWithContentsOfString:(NSString *)s
{
    if ( (self = [super init]) )
    {
        NSString *stringWithReturn = [NSString stringWithFormat:@"%c",13];
        s = [s stringByReplacingOccurrencesOfString:stringWithReturn withString:@"\t"];
        s = [s stringByReplacingOccurrencesOfString:@"\n" withString:@"\t"];

        data = [s componentsSeparatedByString:@"\t"];
    }

    return self;
}


- (id) initWithContentsOfURL:(NSURL *)url encoding:(NSStringEncoding)enc
{
    return [self initWithContentsOfString:[NSString stringWithContentsOfURL:url encoding:enc error:NULL]];
}


- (NSString *) description
{
    return [NSString stringWithFormat:@"<%@: %p> (data = %@)", [self class], self, [data componentsJoinedByString:@"\t"]];
}


- (NSString *) objectAtIndex:(unsigned int)i
{
    return data ? [data objectAtIndex:i] : nil;
}


- (unsigned int) count
{
    return data ? [data count] : 0U;
}


@end
