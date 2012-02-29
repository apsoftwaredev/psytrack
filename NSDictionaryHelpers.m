//
//  NSDictionaryHelper.m
//  PsyTrack Clinician Tools
//
//  Created by Daniel Boice on 2/20/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import "NSDictionaryHelpers.h"

@implementation NSDictionary (Helpers)

+ (NSDictionary *)dictionaryWithContentsOfData:(NSData *)data
{
	// uses toll-free bridging for data into CFDataRef and CFPropertyList into NSDictionary
	CFPropertyListRef plist =  CFPropertyListCreateFromXMLData(kCFAllocatorDefault, (__bridge CFDataRef)data,
															   kCFPropertyListImmutable,
															   NULL);
	// we check if it is the correct type and only return it if it is
	if ([(__bridge id)plist isKindOfClass:[NSDictionary class]])
	{
		return (__bridge NSDictionary *)plist ;
	}
	else
	{
		// clean up ref
		CFRelease(plist);
		return nil;
	}
}

@end