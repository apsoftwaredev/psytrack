//
//  backup.m
//  PsyTrack Clinician Tools
//
//  Created by Daniel Boice on 2/29/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import "backup.h"
#import "PTTEncryption.m"
@implementation backup



-(void)backupProject{

    NSString *path=@"/Users/dan/newdev/dFile-001.sqlite";
    NSData *data=[NSData dataWithContentsOfFile:path];
    
    NSString *symetricString=@"8qfnbyfalVvdjf093uPmsdj30mz98fI6";
    NSData *symetricData=[symetricString dataUsingEncoding: [NSString defaultCStringEncoding] ];
    
    PTTEncryption *encryption=[[PTTEncryption alloc]init];
    
    NSData * encryptedData=encryptedData=(NSData *) [encryption doCipher:data key:symetricData context:kCCEncrypt padding:(CCOptions *) kCCOptionPKCS7Padding];
    
    NSString *encryptedPath=@"/Users/dan/iphoneprojects/breathe/pt.zpk";
    [encryptedData writeToFile:encryptedPath atomically:YES];




}
@end
