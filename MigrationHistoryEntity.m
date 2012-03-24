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
@dynamic keyDate;
@dynamic migratedFrom;
@dynamic migratedTo;
@dynamic demographicProfile;

@synthesize tempNotes,tempMigratedFrom,tempMigratedTo;


- (void)setStringToPrimitiveData:(NSString *)strValue forKey:(NSString *)key 
{
    
    PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
    
    if (appDelegate.okayToDecryptBool) {
        
        
        
        
        
        NSDictionary *encryptedDataDictionary=[appDelegate encryptStringToEncryptedData:(NSString *)strValue withKeyDate:self.keyDate];
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
-(NSString *)notes{
    
    NSString *tempStr;
    [self willAccessValueForKey:@"tempNotes"];
    
    
    if (!self.tempNotes ||!self.tempNotes.length) {
        
        [self didAccessValueForKey:@"tempNotes"];
        PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
        
        
        [self willAccessValueForKey:@"notes"];
        
        
        NSData *primitiveData=[self primitiveValueForKey:@"notes"];
        [self didAccessValueForKey:@"notes"];
        
        [self willAccessValueForKey:@"keyDate"];
        NSDate *tmpKeyDate=self.keyDate;
        [self didAccessValueForKey:@"keyDate"];
        
        NSData *strData=[appDelegate decryptDataToPlainDataUsingKeyEntityWithDate:tmpKeyDate encryptedData:primitiveData];
        
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

-(NSString *)migratedFrom{
    
    NSString *tempStr;
    [self willAccessValueForKey:@"tempMigratedFrom"];
    
    
    if (!self.tempMigratedFrom ||!self.tempMigratedFrom.length) {
        
        [self didAccessValueForKey:@"tempMigratedFrom"];
        PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
        
        
        [self willAccessValueForKey:@"migratedFrom"];
        
        
        NSData *primitiveData=[self primitiveValueForKey:@"migratedFrom"];
        [self didAccessValueForKey:@"migratedFrom"];
        
        [self willAccessValueForKey:@"keyDate"];
        NSDate *tmpKeyDate=self.keyDate;
        [self didAccessValueForKey:@"keyDate"];
        
        NSData *strData=[appDelegate decryptDataToPlainDataUsingKeyEntityWithDate:tmpKeyDate encryptedData:primitiveData];
        
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
    
    [self setStringToPrimitiveData:(NSString *)migratedFrom forKey:@"migratedFrom"];
    
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
        
        [self willAccessValueForKey:@"keyDate"];
        NSDate *tmpKeyDate=self.keyDate;
        [self didAccessValueForKey:@"keyDate"];
        
        NSData *strData=[appDelegate decryptDataToPlainDataUsingKeyEntityWithDate:tmpKeyDate encryptedData:primitiveData];
        
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
    
    [self setStringToPrimitiveData:(NSString *)migratedTo forKey:@"migratedTo"];
    
    self.tempMigratedTo=migratedTo;
}


@end