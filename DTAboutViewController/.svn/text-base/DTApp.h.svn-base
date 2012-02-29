//
//  DTApp.h
//  About
//
//  Created by Oliver Drobnik on 2/15/10.
//  Copyright 2010 Drobnik.com. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DTApp : NSObject 
{
	NSString *name;
	NSString *iconBasename;
	NSString *detailURL;
	NSString *iconURL;
	NSString *launchURL;
	
	UIImage *iconImage;
	
	// downloading of image
	NSURLConnection *iconDownloadConnection;
	NSMutableData *receivedIconData;
}

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *iconBasename;
@property (nonatomic, retain) NSString *detailURL;
@property (nonatomic, retain) NSString *iconURL;
@property (nonatomic, retain) NSString *launchURL;

@property (nonatomic, retain) UIImage *iconImage;


- (UIImage *)iconImage;
- (BOOL)isInstalled;

+ (DTApp *)appFromDictionary:(NSDictionary *)dictionary;

@end
