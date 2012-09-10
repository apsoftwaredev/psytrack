//
//  MedicationReviewEntity.m
//  PsyTrack
//
//  Created by Daniel Boice on 3/27/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import "MedicationReviewEntity.h"
#import "ClinicianEntity.h"
#import "MedicationEntity.h"
#import "PTTAppDelegate.h"

@implementation MedicationReviewEntity

@dynamic doseChange;
@dynamic nextReview;
@dynamic adherence;
@dynamic dosage;
@dynamic notes;
@dynamic satisfaction;
@dynamic sxChange;
@dynamic logDate;
@dynamic lastDose;
@dynamic keyString;
@dynamic medication;
@dynamic sideEffects;
@dynamic prescriber;
@dynamic frequency;
@synthesize tempNotes;




- (void) awakeFromInsert 
{
    [super awakeFromInsert];
    
    //set the default date to the current date if it isn't already set to another date, assuming the client wasn't added on june 6, 2006 at 11:11:11 AM MST
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
    
    [dateFormatter setDateFormat:@"H:m:ss yyyy M d"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"MST"]];
    NSDate *referenceDate=[dateFormatter dateFromString:[NSString stringWithFormat:@"%i:%i:%i %i %i %i",11,11,11,2006,6,6]];
    
    [self willAccessValueForKey:@"logDate"];
    if ([(NSDate *)self.logDate isEqualToDate:referenceDate]) {
        [self didAccessValueForKey:@"logDate"];
        [self willChangeValueForKey:(NSString *)@"logDate"];
        self.logDate = [NSDate date];
        [self didChangeValueForKey:(NSString *)@"logDate"];
    }
}


-(void)rekeyEncryptedAttributes{
    [self willAccessValueForKey:@"notes"];
    if (self.notes) {
        [self setStringToPrimitiveData:(NSString *)self.notes forKey:(NSString *)@"notes" keyString:nil];
        
        
    }
    [self didAccessValueForKey:@"notes"];
    
}


- (void)setStringToPrimitiveData:(NSString *)strValue forKey:(NSString *)key keyString:(NSString *)keyStringToSet
{
    
    PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
    
    if (strValue && strValue.length ) {
        
        
        
        
        
        NSDictionary *encryptedDataDictionary=[appDelegate encryptStringToEncryptedData:(NSString *)strValue withKeyString:keyStringToSet];
        
        NSData *encryptedData;
        NSString *encryptedKeyString;
        if ([encryptedDataDictionary.allKeys containsObject:@"encryptedData"]) {
            encryptedData=[encryptedDataDictionary valueForKey:@"encryptedData"];
            
            
            if ([encryptedDataDictionary.allKeys containsObject:@"keyString"]) {
                
                
                encryptedKeyString=[encryptedDataDictionary valueForKey:@"keyString"];
                
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
        
        if (!primitiveData ||!primitiveData.length ) {
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
    
    [self setStringToPrimitiveData:(NSString *)notes forKey:@"notes" keyString:(NSString *)self.keyString];
    
    self.tempNotes=notes;
}



@end
