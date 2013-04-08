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
#import <AWSiOSSDK/AmazonEndpoints.h>

@implementation UIDownloadBar

@synthesize receivedData,
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

    // Puts the file as an object in the bucket.

    awsConnection = [self getAWSConnection];

    objectRequest = [self getObjectRequest];
    BOOL objExistsInBucket = NO;
    if (awsConnection)
    {
        NSArray *objectsInBucket = [awsConnection listObjectsInBucket:bucketName];

        for (id obj in objectsInBucket)
        {
            if ([obj isKindOfClass:[S3ObjectSummary class]])
            {
                S3ObjectSummary *objSummary = (S3ObjectSummary *)obj;

                NSString *objectStr = (NSString *)objSummary.key;

                if (objectStr && keyName && [objectStr isEqualToString:keyName])
                {
                    objExistsInBucket = YES;
                    break;
                }
            }
        }
    }

    if (!objExistsInBucket)
    {
        [self request:(AmazonServiceRequest *)objectRequest didFailWithError:nil];
        return;
    }
    else if (objectRequest && awsConnection)
    {
        [objectRequest setRangeStart:bytesReceived_ rangeEnd:expectedBytes];
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
        [awsConnection getObject:objectRequest];
    }
}


- (UIDownloadBar *) initWithSaveToFolderPath:(NSString *)localFolderPath progressBarFrame:(CGRect)frame timeout:(NSInteger)timeout delegate:(id)theDelegate bucketNameGiven:(NSString *)bucketNameGiven remoteFileName:(NSString *)remoteFileName
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.delegate = theDelegate;
        fileUrlPath = localFolderPath;
        isExecuting = NO;
        isFinished = NO;

        bucketName = bucketNameGiven;
        keyName = remoteFileName;

        self.bytesReceived = percentComplete = 0;
//        localFilename = [[[fileURL absoluteString] lastPathComponent] copy];
        receivedData = [[NSMutableData alloc] initWithLength:0];
        self.progress = 0.0;
        self.backgroundColor = [UIColor clearColor];
//        DownloadRequest = [[NSURLRequest alloc] initWithURL:fileURL cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:timeout];
//        DownloadConnection = [[NSURLConnection alloc] initWithRequest:DownloadRequest delegate:self startImmediately:YES];

//        if (DownloadConnection == nil)
//        {
//            [self.delegate downloadBar:self didFailWithError:[NSError errorWithDomain:@"UIDownloadBar Error" code:1 userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"NSURLConnection Failed", NSLocalizedDescriptionKey, nil]]];
//        }
    }

    return self;
}


- (void) initialize
{
    self.hidden = NO;
    self.progress = 0.0;
}


- (void) start
{
    // Makes sure that start method always runs on the main thread.
    if (![NSThread isMainThread])
    {
        [self performSelectorOnMainThread:@selector(start) withObject:nil waitUntilDone:NO];
        return;
    }

    [self willChangeValueForKey:@"isExecuting"];
    isExecuting = YES;
    [self didChangeValueForKey:@"isExecuting"];

    [self performSelectorOnMainThread:@selector(initialize) withObject:nil waitUntilDone:NO];

    /********************************************/

    awsConnection = [self getAWSConnection];

    // Puts the file as an object in the bucket.

    S3GetObjectRequest *downloadRequest = [self getObjectRequest];

    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    if (downloadRequest)
    {
        [awsConnection getObject:downloadRequest];
    }
}


- (AmazonS3Client *) getAWSConnection
{
    if (!credentials)
    {
        credentials = [[AmazonCredentials alloc] initWithAccessKey:ACCESS_KEY_ID withSecretKey:SECRET_KEY];
    }

    if (!awsConnection)
    {
        awsConnection = [[AmazonS3Client alloc] initWithCredentials:credentials];
    }

    return awsConnection;
}


- (S3GetObjectRequest *) getObjectRequest
{
    if (!objectRequest)
    {
        NSArray *objectsInBucket = [awsConnection listObjectsInBucket:bucketName];
        BOOL objExistsInBucket = NO;
        for (id obj in objectsInBucket)
        {
            if ([obj isKindOfClass:[S3ObjectSummary class]])
            {
                S3ObjectSummary *objSummary = (S3ObjectSummary *)obj;

                NSString *objectStr = (NSString *)objSummary.key;

                if (objectStr && keyName && [objectStr isEqualToString:keyName])
                {
                    objExistsInBucket = YES;
                    break;
                }
            }
        }

        if (objExistsInBucket)
        {
            objectRequest = [[S3GetObjectRequest alloc] initWithKey:keyName withBucket:bucketName];
            objectRequest.endpoint = @"https://s3.amazonaws.com";
            [objectRequest setDelegate:self];
        }
    }

    return objectRequest;
}


- (BOOL) isConcurrent
{
    return YES;
}


- (BOOL) isExecuting
{
    return isExecuting;
}


- (BOOL) isFinished
{
    return isFinished;
}


#pragma mark - AmazonServiceRequestDelegate Implementations

- (void) request:(AmazonServiceRequest *)request didCompleteWithResponse:(AmazonServiceResponse *)response
{
    [self.delegate downloadBar:self didFinishWithData:self.receivedData suggestedFilename:localFilename];
    operationFinished = YES;
    //NSLog(@"Connection did finish loading...%@",localFilename);

    [self finish];
}


- (void) request:(AmazonServiceRequest *)request didReceiveResponse:(NSURLResponse *)response
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
            if (range.location != NSNotFound)
            {
                NSString *totalBytesCount = [contentRange substringFromIndex:range.location + 1];
                expectedBytes = [totalBytesCount floatValue];
            }
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


- (void) request:(AmazonServiceRequest *)request didReceiveData:(NSData *)data
{
    // The progress bar for downlaod is just an estimate. In order to accurately reflect the progress bar, you need to first retrieve the file size.
    if (!operationBreaked)
    {
        [self.receivedData appendData:data];

        float receivedLen = [data length];
        self.bytesReceived = (bytesReceived_ + receivedLen);

        if (expectedBytes != NSURLResponseUnknownLength)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
//                 [self updateProgressView:[NSNumber numberWithFloat:(float)[data length] / 150 / 1024] ];

                               self.progress = ( (bytesReceived_ / (float)expectedBytes) * 100 ) / 100;

                               percentComplete = self.progress * 100;

                               [self.delegate downloadBarUpdated:self];
                           }


                           );
        }

        ////NSLog(@" Data receiving... Percent complete: %f", percentComplete);
    }
    else
    {
        [request cancel];
        //NSLog(@" STOP !!!!  Receiving data was stoped");
        //        PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
        //
        //        [appDelegate displayNotification: @"Download stopped" forDuration:3.0 location:kPTTScreenLocationTop inView:nil];
    }
}


- (void) request:(AmazonServiceRequest *)request didFailWithError:(NSError *)error
{
    [self.delegate downloadBar:self didFailWithError:error];
    operationFailed = YES;

    [self finish];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}


- (void) request:(AmazonServiceRequest *)request didFailWithServiceException:(NSException *)exception
{
    DLog(@"%@", exception);

    [self.delegate downloadBar:self didFailWithError:nil];
    [self finish];
}


#pragma mark - Helper Methods

- (void) finish
{
    [self willChangeValueForKey:@"isExecuting"];
    [self willChangeValueForKey:@"isFinished"];

    isExecuting = NO;
    isFinished = YES;

    [self didChangeValueForKey:@"isExecuting"];
    [self didChangeValueForKey:@"isFinished"];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}


- (void) hideProgressView
{
    self.hidden = YES;
}


- (void) dealloc
{
    receivedData = nil;
    localFilename = nil;

    fileUrlPath = nil;
    possibleFilename = nil;
}


@end
