//
//  DTApp.m
//  About
//
//  Created by Oliver Drobnik on 2/15/10.
//  Copyright 2010 Drobnik.com. All rights reserved.
//

#import "DTApp.h"
#import "UIImage+Helpers.h"

@implementation DTApp

@synthesize name, iconBasename, detailURL, iconURL, launchURL, iconImage;

+ (DTApp *) appFromDictionary:(NSDictionary *)dictionary
{
    DTApp *tmpApp = [[DTApp alloc] init];
    [tmpApp setValuesForKeysWithDictionary:dictionary];

    return tmpApp;
}


- (NSString *) cachedFileName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cacheDirectory = [paths objectAtIndex:0];
    return [cacheDirectory stringByAppendingPathComponent:iconBasename];
}


- (UIImage *) iconImage
{
    if (!iconImage)
    {
        // try cache
        NSString *cacheFileName = [self cachedFileName];

        if ([[NSFileManager defaultManager] fileExistsAtPath:cacheFileName])
        {
            UIImage *originalImage = [UIImage imageWithContentsOfFile:cacheFileName];
            self.iconImage = [UIImage imageWithImage:originalImage scaledToSize:CGSizeMake(57.0, 57.0)];
            return iconImage;
        }

        if (iconURL && iconURL.length && !iconDownloadConnection)
        {
            NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:iconURL]];
            iconDownloadConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        }

        // fallback: try app bundle
        UIImage *originalImage = [UIImage imageNamed:iconBasename];
        if (originalImage)
        {
            return [UIImage imageWithImage:originalImage scaledToSize:CGSizeMake(57.0, 57.0)];
        }
        else
        {
            return nil;
        }
    }

    return iconImage;
}


- (BOOL) isInstalled
{
    if (launchURL && [launchURL length])
    {
        NSURL *url = [NSURL URLWithString:[launchURL stringByAppendingString:@"://"]];
        return [[UIApplication sharedApplication] canOpenURL:url];
    }
    else
    {
        return NO;
    }
}


#pragma mark NSURLConnection Delegate
- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    // every forward resets the received data
    receivedIconData = nil; receivedIconData = nil;
}


- (void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    if (!receivedIconData)
    {
        receivedIconData = [[NSMutableData alloc] init];
    }

    [receivedIconData appendData:data];
}


- (void) connectionDidFinishLoading:(NSURLConnection *)connection
{
    UIImage *newIcon = [UIImage imageWithData:receivedIconData];
    self.iconImage = newIcon;

    [receivedIconData writeToFile:[self cachedFileName] atomically:NO];
    receivedIconData = nil; receivedIconData = nil;
    iconDownloadConnection = nil; iconDownloadConnection = nil;
    @try
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"DTAppLoadedIcon" object:nil userInfo:[NSDictionary dictionaryWithObject:self forKey:@"App"]];
    }
    @catch (NSException *exception)
    {
        //do nothing
    }
}


- (void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    receivedIconData = nil; receivedIconData = nil;
    iconDownloadConnection = nil; iconDownloadConnection = nil;
}


@end
