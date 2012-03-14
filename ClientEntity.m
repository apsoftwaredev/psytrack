/*
 *  ClientEntity.m
 *  psyTrack Clinician Tools
 *  Version: 1.0
 *
 *
 *	THIS SOURCE CODE AND ANY ACCOMPANYING DOCUMENTATION ARE PROTECTED BY UNITED STATES 
 *	INTELLECTUAL PROPERTY LAW AND INTERNATIONAL TREATIES. UNAUTHORIZED REPRODUCTION OR 
 *	DISTRIBUTION IS SUBJECT TO CIVIL AND CRIMINAL PENALTIES. 
 *
 *  Created by Daniel Boice on 11/22/11.
 *  Copyright (c) 2011 PsycheWeb LLC. All rights reserved.
 *
 *
 *	This notice may not be removed from this file.
 *
 */
#import "ClientEntity.h"
#import "PTTEncryption.h"
#import "PTTAppDelegate.h"
@implementation ClientEntity

@dynamic order;
@dynamic notes;
@dynamic dateOfBirth;
@dynamic clientIDCode;
@dynamic initials;
@dynamic dateAdded;
@dynamic demographicInfo;
@dynamic referrals;
@dynamic supportActivitiesDelivered;
@dynamic interventionsDelivered;
@dynamic clientAndMentalState;
@dynamic diagnosis;
@dynamic keyDate;

@dynamic clientIDcodeDC;

-(void) awakeFromFetch{
//PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;

NSLog(@"client id code is %@",self.clientIDCode);






}
- (void) awakeFromInsert 
{
    [super awakeFromInsert];
    
    //set the default date to the current date if it isn't already set to another date, assuming the client wasn't added on june 6, 2006 at 11:11:11 AM MST
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
    
    [dateFormatter setDateFormat:@"H:m:ss yyyy M d"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"MST"]];
    NSDate *referenceDate=[dateFormatter dateFromString:[NSString stringWithFormat:@"%i:%i:%i %i %i %i",11,11,11,2006,6,6]];
    NSLog(@"reference date %@",referenceDate);
    if ([(NSDate *)self.dateAdded isEqualToDate:referenceDate]) {
        self.dateAdded = [NSDate date];
       
    }
    
//    PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
    
    
//    [self willAccessValueForKey:@"clientIDCode"];
//    
//    NSData *primitiveData=[self primitiveValueForKey:@"clientIDCode"];
//    
//    NSData *strData=[appDelegate decryptDataToPlainData:primitiveData];
//    
//    NSString *newStr=[appDelegate convertDataToString:strData];
//    
//    self.clientIDCode=newStr;
//    [self didAccessValueForKey:@"clientIDCode"];
}



- (void)setClientIDCode:(NSString *)clientIDCode
{
    
    PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
    
    if (appDelegate.okayToDecryptBool) {
   
    
    [self willChangeValueForKey:@"clientIDCode"];
    
    
        NSMutableDictionary *encryptedDataDictionary=[appDelegate encryptStringToEncryptedData:(NSString *)clientIDCode];
     NSLog(@"encrypted dictionary right after set %@",encryptedDataDictionary);
        NSData *encryptedData;
        NSDate *encryptedKeyDate;
        if ([encryptedDataDictionary.allKeys containsObject:@"encryptedData"]) {
            encryptedData=[encryptedDataDictionary valueForKey:@"encryptedData"];
            
            
            if ([encryptedDataDictionary.allKeys containsObject:@"keyDate"]) {
                NSLog(@"all keys are %@",[encryptedDataDictionary allKeys]);
                
                encryptedKeyDate=[encryptedDataDictionary valueForKey:@"keyDate"];
                NSLog(@"key date is client entity %@",encryptedKeyDate);
            }
        }
        
        
    
    [self setPrimitiveValue:encryptedData forKey:@"clientIDCode"];     
    
    
    
    [self didChangeValueForKey:@"clientIDCode"];
        
       
        if (encryptedKeyDate) {
            [self willChangeValueForKey:@"keyDate"]; 
            
        
            [self setPrimitiveValue:encryptedKeyDate forKey:@"keyDate"];
            
            [self didChangeValueForKey:@"keyDate"];
             NSLog(@"encrypted key date is %@",encryptedKeyDate);
            
        }
       
        
    }
}
-(void)willSave{
    
    
//    if (encryptedKeyDate) {
//    [self willChangeValueForKey:@"keyDate"]; 
//    
//    
//    [self setPrimitiveValue:encryptedKeyDate forKey:@"keyDate"];
//    
//    [self didChangeValueForKey:@"keyDate"];
//    NSLog(@"encrypted key date is %@",encryptedKeyDate);
//    
//}


}
- (void)setPrimitiveStringValue:(NSString *)strValue forKey:(NSString *)key 
{
    
    PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
    
    if (appDelegate.okayToDecryptBool) {
        
        
        [self willChangeValueForKey:@"clientIDCode"];
        
        
        NSMutableDictionary *encryptedDataDictionary=[appDelegate encryptStringToEncryptedData:(NSString *)strValue];
        NSLog(@"encrypted dictionary right after set %@",encryptedDataDictionary);
        NSData *encryptedData;
        NSDate *encryptedKeyDate;
        if ([encryptedDataDictionary.allKeys containsObject:@"encryptedData"]) {
            encryptedData=[encryptedDataDictionary valueForKey:@"encryptedData"];
            
            
            if ([encryptedDataDictionary.allKeys containsObject:@"keyDate"]) {
                NSLog(@"all keys are %@",[encryptedDataDictionary allKeys]);
                
                encryptedKeyDate=[encryptedDataDictionary valueForKey:@"keyDate"];
                NSLog(@"key date is client entity %@",encryptedKeyDate);
            }
        }
        
        
        
        [self setPrimitiveValue:encryptedData forKey:key];     
        
        
        
        [self didChangeValueForKey:key];
        
        
        
        
        
    }
}


//-(NSString *)clientIDCode{
////
//PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
//
//
//[self willAccessValueForKey:@"clientIDCode"];
//
//    
//NSData *primitiveData=[self primitiveValueForKey:@"clientIDCode"];
//
//NSData *strData=[appDelegate decryptDataToPlainData:primitiveData];
//
//NSString *newStr=[appDelegate convertDataToString:strData];
//
//
//
//
//return newStr;
//
//}


@end
