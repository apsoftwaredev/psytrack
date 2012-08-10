//
//  ReferralEntity.m
//  PsyTrack
//
//  Created by Daniel Boice on 3/25/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import "ReferralEntity.h"
#import "ClientEntity.h"
#import "ClinicianEntity.h"
#import "PTTAppDelegate.h"

@implementation ReferralEntity

@dynamic referralDate;
@dynamic order;
@dynamic notes;
@dynamic referralInOrOut;
@dynamic keyString;
@dynamic clinician;
@dynamic client;
@dynamic otherSource;
@synthesize tempNotes;

- (void) awakeFromInsert 
{
    [super awakeFromInsert];
    
    //set the default date to the current date if it isn't already set to another date, assuming the client wasn't added on june 6, 2006 at 11:11:11 AM MST
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
    
    [dateFormatter setDateFormat:@"H:m:ss yyyy M d"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"MST"]];
    NSDate *referenceDate=[dateFormatter dateFromString:[NSString stringWithFormat:@"%i:%i:%i %i %i %i",11,11,11,2006,6,6]];
    //DLog(@"reference date %@",referenceDate);
    [self willAccessValueForKey:@"referralDate"];
    if ([(NSDate *)self.referralDate isEqualToDate:referenceDate]) {
        [self didAccessValueForKey:@"referralDate"];
        [self willChangeValueForKey:(NSString *)@"referralDate"];
        self.referralDate = [NSDate date];
        [self didChangeValueForKey:(NSString *)@"referralDate"];
    }
}




- (void)setStringToPrimitiveData:(NSString *)strValue forKey:(NSString *)key 
{
    
    PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
    
    if (strValue && strValue.length ) {
        
        
        
        
        
        NSDictionary *encryptedDataDictionary=[appDelegate encryptStringToEncryptedData:(NSString *)strValue withKeyString:self.keyString];
        //DLog(@"encrypted dictionary right after set %@",encryptedDataDictionary);
        NSData *encryptedData;
        NSString *encryptedKeyString;
        if ([encryptedDataDictionary.allKeys containsObject:@"encryptedData"]) {
            encryptedData=[encryptedDataDictionary valueForKey:@"encryptedData"];
            
            
            if ([encryptedDataDictionary.allKeys containsObject:@"keyString"]) {
                //DLog(@"all keys are %@",[encryptedDataDictionary allKeys]);
                
                encryptedKeyString=[encryptedDataDictionary valueForKey:@"keyString"];
                //DLog(@"key date is client entity %@",encryptedkeyString);
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
-(NSString *)notes{
    
    NSString *tempStr;
    [self willAccessValueForKey:@"tempNotes"];
    
    
    if (!self.tempNotes ||!self.tempNotes.length) {
        
        [self didAccessValueForKey:@"tempNotes"];
        PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
        
        
        [self willAccessValueForKey:@"notes"];
        
        
        NSData *primitiveData=[self primitiveValueForKey:@"notes"];
        [self didAccessValueForKey:@"notes"];
        if (!primitiveData ||!primitiveData.length  ) {
            return nil;
        }
        [self willAccessValueForKey:@"keyString"];
        NSString *tmpKeyString=self.keyString;
        [self didAccessValueForKey:@"keyString"];
        
        NSData *strData=[appDelegate decryptDataToPlainDataUsingKeyEntityWithString:tmpKeyString encryptedData:primitiveData];
        
        tempStr=[appDelegate convertDataToString:strData];
        
        [self willChangeValueForKey:@"tempNotes"];
        
        self.tempNotes=tempStr;
        [self didChangeValueForKey:@"tempNotes"];
        
        
    }
    else 
    {
        tempStr=self.tempNotes;
        [self didAccessValueForKey:@"tempNotes"];
    }
    
    
    
    
    return tempStr;
    
    
    
    
    
    
}
-(void)setNotes:(NSString *)notes{
    
    [self setStringToPrimitiveData:(NSString *)notes forKey:@"notes"];
    
    self.tempNotes=notes;
}


@end
