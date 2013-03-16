/*
 *  TabFile.m
 *  psyTrack Clinician Tools
 *  Version: 1.0
 *
 *
 *	THIS SOURCE CODE AND ANY ACCOMPANYING DOCUMENTATION ARE PROTECTED BY UNITED STATES
 *	INTELLECTUAL PROPERTY LAW AND INTERNATIONAL TREATIES. UNAUTHORIZED REPRODUCTION OR
 *	DISTRIBUTION IS SUBJECT TO CIVIL AND CRIMINAL PENALTIES.
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
