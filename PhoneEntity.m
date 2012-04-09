//
//  PhoneEntity.m
//  PsyTrack Clinician Tools
//
//  Created by Daniel Boice on 3/20/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import "PhoneEntity.h"
#import "ClientEntity.h"
#import "PTTAppDelegate.h"


@implementation PhoneEntity

@dynamic phoneName;
@dynamic order;
@dynamic extention;
@dynamic phoneNumber;
@dynamic client;
@dynamic keyString;

@synthesize tempPhoneNumber;


- (void)setStringToPrimitiveData:(NSString *)strValue forKey:(NSString *)key 
{
    
    PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
    
    if (appDelegate.okayToDecryptBool) {
        
        
        
        
        
        NSDictionary *encryptedDataDictionary=[appDelegate encryptStringToEncryptedData:(NSString *)strValue withKeyString:self.keyString];
        //NSLog(@"encrypted dictionary right after set %@",encryptedDataDictionary);
        NSData *encryptedData;
        NSString *encryptedKeyString;
        if ([encryptedDataDictionary.allKeys containsObject:@"encryptedData"]) {
            encryptedData=[encryptedDataDictionary valueForKey:@"encryptedData"];
            
            
            if ([encryptedDataDictionary.allKeys containsObject:@"keyString"]) {
                //NSLog(@"all keys are %@",[encryptedDataDictionary allKeys]);
                
                encryptedKeyString=[encryptedDataDictionary valueForKey:@"keyString"];
                //NSLog(@"key date is client entity %@",encryptedkeyString);
            }
        }
        
        
        if (encryptedData.length) {
            [self willChangeValueForKey:key];
            [self setPrimitiveValue:encryptedData forKey:key];
            [self didChangeValueForKey:key];
        }
        
        
        [self willAccessValueForKey:@"keyString"];
        if (![encryptedKeyString isEqualToString:self.keyString]) {
            [self didAccessValueForKey:@"keyString"];
            [self willChangeValueForKey:@"keyString"];
            [self setPrimitiveValue:encryptedKeyString forKey:@"keyString"];
            [self didChangeValueForKey:@"keyString"];
            
        }
        
        
        
        
        
        
    }
}

-(NSString *)phoneNumber{
    
    NSString *tempStr;
    [self willAccessValueForKey:@"tempPhoneNumber"];
    
    
    if (!self.tempPhoneNumber ||!self.tempPhoneNumber.length) {
        
        [self didAccessValueForKey:@"tempPhoneNumber"];
        PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
        
        
        [self willAccessValueForKey:@"phoneNumber"];
        
        
        NSData *primitiveData=[self primitiveValueForKey:@"phoneNumber"];
        [self didAccessValueForKey:@"phoneNumber"];
        
        [self willAccessValueForKey:@"keyString"];
        NSString *tmpKeyString=self.keyString;
        [self didAccessValueForKey:@"keyString"];
        
        NSData *strData=[appDelegate decryptDataToPlainDataUsingKeyEntityWithString:tmpKeyString encryptedData:primitiveData];
        
        tempStr=[appDelegate convertDataToString:strData];
        
        [self willChangeValueForKey:@"tempPhoneNumber"];
        
        self.tempPhoneNumber=tempStr;
        [self didChangeValueForKey:@"tempPhoneNumber"];
        
        
    }
    else 
    {
        tempStr=self.tempPhoneNumber;
        [self didAccessValueForKey:@"tempPhoneNumber"];
    }
    
    
    
    
    return tempStr;
    
    
    
    
    
    
}
-(void)setPhoneNumber:(NSString *)phoneNumber{
    
    [self setStringToPrimitiveData:(NSString *)phoneNumber forKey:@"phoneNumber"];
    
    self.tempPhoneNumber=phoneNumber;
}

@end
