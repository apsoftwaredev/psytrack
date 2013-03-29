//
//  UIDownloadBar.h
//  Old Radio
//
//  Created by Yuliya Sosnenko on 7/8/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//
//http://www.developers-life.com/progress-bar-download-file-on-iphone.html
//https://github.com/sakrist/UIDownloadBar

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AWSiOSSDK/AmazonServiceRequest.h>
#import "AmazonClientManager.h"


@class UIProgressView;
@protocol UIDownloadBarDelegate;

@interface UIDownloadBar : UIProgressView <AmazonServiceRequestDelegate>{
    
    NSMutableData *receivedData;
    NSString *localFilename;
   
    float bytesReceived_;
    long long expectedBytes;

    BOOL operationFinished, operationFailed, operationBreaked;
    BOOL operationIsOK;
    BOOL appendIfExist;
    FILE *downFile;
    NSString *fileUrlPath;
    NSString *possibleFilename;

    float percentComplete;
    
    BOOL           isExecuting;
    BOOL           isFinished;
    
    NSString *bucketName;
    NSString *keyName;
    S3GetObjectRequest *objectRequest;
    
    AmazonS3Client *awsConnection;
    AmazonCredentials *credentials;
}

- (UIDownloadBar *) initWithSaveToFolderPath:(NSString *)localFolderPath progressBarFrame:(CGRect)frame timeout:(NSInteger)timeout delegate:(id)theDelegate  bucketNameGiven:(NSString *)bucketNameGiven remoteFileName:(NSString * )remoteFileName;

@property (assign) BOOL operationIsOK;
@property (assign) BOOL appendIfExist;
@property (nonatomic, copy) NSString *fileUrlPath;

@property (nonatomic, readonly) NSMutableData *receivedData;

@property (weak) id<UIDownloadBarDelegate> delegate;

@property (nonatomic, readonly) float percentComplete;
@property (nonatomic, retain) NSString *possibleFilename;
@property (nonatomic, assign) float bytesReceived;

- (void) forceStop;

- (void) forceContinue;

-(void)start;

-(AmazonS3Client *)getAWSConnection;
-(S3GetObjectRequest* )getObjectRequest;


@end

@protocol UIDownloadBarDelegate<NSObject>

@optional
- (void) downloadBar:(UIDownloadBar *)downloadBar didFinishWithData:(NSData *)fileData suggestedFilename:(NSString *)filename;
- (void) downloadBar:(UIDownloadBar *)downloadBar didFailWithError:(NSError *)error;
- (void) downloadBarUpdated:(UIDownloadBar *)downloadBar;

@end
