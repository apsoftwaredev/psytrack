//
//  NSDataExtentionAES256.h
//  PsyTrack Clinician Tools
//
//  Created by Daniel Boice on 2/19/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (AES256)


- (NSData *)AES256DecryptData:(NSData *)data WithKey:(NSString *)key;
- (NSData *)AES256EncryptData:(NSData *)data WithKey:(NSString *)key;
@end
