//
//  MigrationHistoryEntity.m
//  PsyTrack Clinician Tools
//
//  Created by Daniel Boice on 3/23/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import "MigrationHistoryEntity.h"
#import "DemographicProfileEntity.h"
#import "PTTAppDelegate.h"

@implementation MigrationHistoryEntity

@dynamic arrivedDate;
@dynamic notes;
@dynamic keyString;
@dynamic migratedFrom;
@dynamic migratedTo;
@dynamic demographicProfile;

@synthesize tempNotes,tempMigratedFrom,tempMigratedTo;



-(void)rekeyEncryptedAttributes{
    [self willAccessValueForKey:@"notes"];
    
    NSString *notesStr=[NSString stringWithString:self.notes];
    [self didAccessValueForKey:@"notes"];
    
     [self willAccessValueForKey:@"migratedFrom"];
    NSString *migratedFromStr=[NSString stringWithString:self.migratedFrom];
     [self didAccessValueForKey:@"migratedFrom"];
    
    [self willAccessValueForKey:@"migratedTo"];
    NSString *migratedToStr=[NSString stringWithString:self.migratedTo];
    [self didAccessValueForKey:@"migratedTo"];
    
    if (notesStr &&notesStr.length) {
        [self setStringToPrimitiveData:(NSString *)notesStr forKey:(NSString *)@"notes" keyString:nil];
        
        
    }
   
 
    
   
    if (migratedFromStr && migratedFromStr.length) {
        [self setStringToPrimitiveData:(NSString *)migratedFromStr forKey:(NSString *)@"migratedFrom" keyString:self.keyString];
        
       
    }
   
    
    
    if (migratedToStr&&migratedToStr.length) {
        [self setStringToPrimitiveData:(NSString *)migratedToStr forKey:(NSString *)@"migratedTo" keyString:self.keyString];
        
        
    }
  
    
    
    
}



- (void)setStringToPrimitiveData:(NSString *)strValue forKey:(NSString *)key keyString:(NSString *)keyStringToSet
{
    
    PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
    
    if ( strValue && strValue.length) {
        
        
        
        
        
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
    [self willAccessValueForKey:@"keyString"];
    [self setStringToPrimitiveData:(NSString *)notes forKey:@"notes" keyString:self.keyString];
    [self didAccessValueForKey:@"keyString"];
    self.tempNotes=notes;
}


-(NSString *)migratedFrom{
    
    NSString *tempStr;
    [self willAccessValueForKey:@"tempMigratedFrom"];
    
    
    if (!self.tempMigratedFrom ||!self.tempMigratedFrom.length) {
        
        [self didAccessValueForKey:@"tempMigratedFrom"];
        PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
        
        
        [self willAccessValueForKey:@"migratedFrom"];
        
        
        NSData *primitiveData=[self primitiveValueForKey:@"migratedFrom"];
        [self didAccessValueForKey:@"migratedFrom"];
        if (!primitiveData ||!primitiveData.length||[appDelegate isAppLocked] ) {
            return nil;
        }
        [self willAccessValueForKey:@"keyString"];
        NSString *tmpKeyString=self.keyString;
        [self didAccessValueForKey:@"keyString"];
        
        NSData *strData=[appDelegate decryptDataToPlainDataUsingKeyEntityWithString:tmpKeyString encryptedData:primitiveData];
        
        tempStr=[appDelegate convertDataToString:strData];
        
        [self willChangeValueForKey:@"tempMigratedFrom"];
        
        self.tempMigratedFrom=tempStr;
        [self didChangeValueForKey:@"tempMigratedFrom"];
        
        
    }
    else 
    {
        tempStr=self.tempMigratedFrom;
        [self didAccessValueForKey:@"tempMigratedFrom"];
    }
    
    
    
    
    return tempStr;
    
    
    
    
    
    
}
-(void)setMigratedFrom:(NSString *)migratedFrom{
    [self willAccessValueForKey:@"keyString"];
    [self setStringToPrimitiveData:(NSString *)migratedFrom forKey:@"migratedFrom" keyString:self.keyString];
    [self didAccessValueForKey:@"keyString"];
    self.tempMigratedFrom=migratedFrom;
}
-(NSString *)migratedTo{
    
    NSString *tempStr;
    [self willAccessValueForKey:@"tempMigratedTo"];
    
    
    if (!self.tempMigratedTo ||!self.tempMigratedTo.length) {
        
        [self didAccessValueForKey:@"tempMigratedTo"];
        PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
        
        
        [self willAccessValueForKey:@"migratedTo"];
        
        
        NSData *primitiveData=[self primitiveValueForKey:@"migratedTo"];
        [self didAccessValueForKey:@"migratedTo"];
        if (!primitiveData ||!primitiveData.length||[appDelegate isAppLocked] ) {
            return nil;
        }
        [self willAccessValueForKey:@"keyString"];
        NSString *tmpKeyString=self.keyString;
        [self didAccessValueForKey:@"keyString"];
        
        NSData *strData=[appDelegate decryptDataToPlainDataUsingKeyEntityWithString:tmpKeyString encryptedData:primitiveData];
        
        tempStr=[appDelegate convertDataToString:strData];
        
        [self willChangeValueForKey:@"tempMigratedTo"];
        
        self.tempMigratedTo=tempStr;
        [self didChangeValueForKey:@"tempMigratedTo"];
        
        
    }
    else 
    {
        tempStr=self.tempMigratedTo;
        [self didAccessValueForKey:@"tempMigratedTo"];
    }
    
    
    
    
    return tempStr;
    
    
    
    
    
    
}
-(void)setMigratedTo:(NSString *)migratedTo{
    [self willAccessValueForKey:@"keyString"];
    [self setStringToPrimitiveData:(NSString *)migratedTo forKey:@"migratedTo" keyString:self.keyString];
    [self didAccessValueForKey:@"keyString"];
    self.tempMigratedTo=migratedTo;
}


@end
