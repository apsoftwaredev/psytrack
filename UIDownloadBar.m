//
//  UIDownloadBar.m
//  Old Radio
//
//  Created by Yuliya Sosnenko on 7/8/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//http://www.developers-life.com/progress-bar-download-file-on-iphone.html
//https://github.com/sakrist/UIDownloadBar
//edited by Dan Boice 2/28/2012

#import "UIDownloadBar.h"
#import "PTTAppDelegate.h"

@implementation UIDownloadBar

@synthesize DownloadRequest,
DownloadConnection,
receivedData,
delegate,
percentComplete,
operationIsOK,
appendIfExist,
fileUrlPath,
possibleFilename,
bytesReceived = bytesReceived_;

- (void) forceStop
{
    operationBreaked = YES;
}


- (void) forceContinue
{
    operationBreaked = NO;

    //NSLog(@"%f",bytesReceived_);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:downloadUrl];

    [request addValue:[NSString stringWithFormat:@"bytes=%.0f-", bytesReceived_ ] forHTTPHeaderField:@"Range"];

    DownloadConnection = [NSURLConnection connectionWithRequest:request
                                                       delegate:self];
}


- (UIDownloadBar *) initWithURL:(NSURL *)fileURL saveToFolderPath:(NSString *)localFolderPath progressBarFrame:(CGRect)frame timeout:(NSInteger)timeout delegate:(id)theDelegate
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.delegate = theDelegate;
        fileUrlPath = localFolderPath;

        downloadUrl = fileURL;
        self.bytesReceived = percentComplete = 0;
        localFilename = [[[fileURL absoluteString] lastPathComponent] copy];
        receivedData = [[NSMutableData alloc] initWithLength:0];
        self.progress = 0.0;
        self.backgroundColor = [UIColor clearColor];
        DownloadRequest = [[NSURLRequest alloc] initWithURL:fileURL cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:timeout];
        DownloadConnection = [[NSURLConnection alloc] initWithRequest:DownloadRequest delegate:self startImmediately:YES];

        if (DownloadConnection == nil)
        {
            [self.delegate downloadBar:self didFailWithError:[NSError errorWithDomain:@"UIDownloadBar Error" code:1 userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"NSURLConnection Failed", NSLocalizedDescriptionKey, nil]]];
        }
    }

    return self;
}


- (void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    if (!operationBreaked)
    {
        [self.receivedData appendData:data];

        float receivedLen = [data length];
        self.bytesReceived = (bytesReceived_ + receivedLen);

        if (expectedBytes != NSURLResponseUnknownLength)
        {
            self.progress = ( (bytesReceived_ / (float)expectedBytes) * 100 ) / 100;
            percentComplete = self.progress * 100;
        }

        ////NSLog(@" Data receiving... Percent complete: %f", percentComplete);

        [self.delegate downloadBarUpdated:self];
    }
    else
    {
        [connection cancel];
        //NSLog(@" STOP !!!!  Receiving data was stoped");
//        PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
//
//        [appDelegate displayNotification: @"Download stopped" forDuration:3.0 location:kPTTScreenLocationTop inView:nil];
    }
}


- (void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [self.delegate downloadBar:self didFailWithError:error];
    operationFailed = YES;
}


//- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
//	expectedBytes = [response expectedContentLength];
//	//NSLog(@"DID RECEIVE RESPONSE");
//}

- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    //NSLog(@"[DO::didReceiveData] %d operation", (int)self);
    //NSLog(@"[DO::didReceiveData] ddb: %.2f, wdb: %.2f, ratio: %.2f",
//		  (float)bytesReceived_,
//		  (float)expectedBytes,
//		  (float)bytesReceived_ / (float)expectedBytes);

    NSHTTPURLResponse *r = (NSHTTPURLResponse *)response;
    NSDictionary *headers = [r allHeaderFields];
    //NSLog(@"[DO::didReceiveResponse] response headers: %@", headers);
    if (headers)
    {
        if ([headers objectForKey:@"Content-Range"])
        {
            NSString *contentRange = [headers objectForKey:@"Content-Range"];
            //NSLog(@"Content-Range: %@", contentRange);
            NSRange range = [contentRange rangeOfString:@"/"];
            NSString *totalBytesCount = [contentRange substringFromIndex:range.location + 1];
            expectedBytes = [totalBytesCount floatValue];
        }
        else if ([headers objectForKey:@"Content-Length"])
        {
            //NSLog(@"Content-Length: %@", [headers objectForKey: @"Content-Length"]);
            expectedBytes = [[headers objectForKey:@"Content-Length"] floatValue];
        }
        else
        {
            expectedBytes = -1;
        }

        if ([@"Identity" isEqualToString :[headers objectForKey:@"Transfer-Encoding"]])
        {
            expectedBytes = bytesReceived_;
            operationFinished = YES;
        }
    }
}


- (void) connectionDidFinishLoading:(NSURLConnection *)connection
{
    [self.delegate downloadBar:self didFinishWithData:self.receivedData suggestedFilename:localFilename];
    operationFinished = YES;
    //NSLog(@"Connection did finish loading...%@",localFilename);

    DownloadConnection = nil;
    DownloadRequest = nil;

    //[connection release];
}


- (void) dealloc
{
    DownloadRequest = nil;
    DownloadConnection = nil;
    receivedData = nil;
    localFilename = nil;
    downloadUrl = nil;

    fileUrlPath = nil;
    possibleFilename = nil;
}


@end
