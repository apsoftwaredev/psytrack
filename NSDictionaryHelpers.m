/*
 *  NSDictionaryHelpers.m
 *  psyTrack Clinician Tools
 *  Version: 1.05
 *
 *
 *	THIS SOURCE CODE AND ANY ACCOMPANYING DOCUMENTATION ARE PROTECTED BY UNITED STATES
 *	INTELLECTUAL PROPERTY LAW AND INTERNATIONAL TREATIES. UNAUTHORIZED REPRODUCTION OR
 *	DISTRIBUTION IS SUBJECT TO CIVIL AND CRIMINAL PENALTIES.
 *
 *  Created by Daniel Boice on 2/20/12.
 *  Copyright (c) 2011 PsycheWeb LLC. All rights reserved.
 *
 *
 *	This notice may not be removed from this file.
 *
 */
//this helper was downloaded from coccanetics.com website and edited slightly for ARC (bridges)

#import "NSDictionaryHelpers.h"

@implementation NSDictionary (Helpers)

+ (NSDictionary *) dictionaryWithContentsOfData:(NSData *)data
{
    // uses toll-free bridging for data into CFDataRef and CFPropertyList into NSDictionary
    CFPropertyListRef plist = CFPropertyListCreateFromXMLData(kCFAllocatorDefault, (__bridge CFDataRef)data,
                                                              kCFPropertyListImmutable,
                                                              NULL);
    // we check if it is the correct type and only return it if it is
    if ([(__bridge id)plist isKindOfClass :[NSDictionary class]])
    {
        return (__bridge_transfer NSDictionary *)plist;
    }
    else
    {
        // clean up ref
        CFRelease(plist);
        return nil;
    }
}


@end
