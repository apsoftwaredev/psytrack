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
@dynamic keyDate;

@synthesize tempPhoneNumber;

- (void)setStringToPrimitiveData:(NSString *)strValue forKey:(NSString *)key 
{
    
    PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
    
    if (appDelegate.okayToDecryptBool) {
        
        
        
        
        
        NSDictionary *encryptedDataDictionary=[appDelegate encryptStringToEncryptedData:(NSString *)strValue withKeyDate:self.keyDate];
        //NSLog(@"encrypted dictionary right after set %@",encryptedDataDictionary);
        NSData *encryptedData;
        NSDate *encryptedKeyDate;
        if ([encryptedDataDictionary.allKeys containsObject:@"encryptedData"]) {
            encryptedData=[encryptedDataDictionary valueForKey:@"encryptedData"];
            
            
            if ([encryptedDataDictionary.allKeys containsObject:@"keyDate"]) {
                //NSLog(@"all keys are %@",[encryptedDataDictionary allKeys]);
                
                encryptedKeyDate=[encryptedDataDictionary valueForKey:@"keyDate"];
                //NSLog(@"key date is client entity %@",encryptedKeyDate);
            }
        }
        
        
        if (encryptedData.length) {
            [self willChangeValueForKey:key];
            [self setPrimitiveValue:encryptedData forKey:key];
            [self didChangeValueForKey:key];
        }
        
        
        
        if (![encryptedKeyDate isEqualToDate:self.keyDate]) {
            [self willChangeValueForKey:@"keyDate"];
            [self setPrimitiveValue:encryptedKeyDate forKey:@"keyDate"];
            [self didChangeValueForKey:@"keyDate"];
            
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
        
        [self willAccessValueForKey:@"keyDate"];
        NSDate *tmpKeyDate=self.keyDate;
        [self didAccessValueForKey:@"keyDate"];
        
        NSData *strData=[appDelegate decryptDataToPlainDataUsingKeyEntityWithDate:tmpKeyDate encryptedData:primitiveData];
        
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
