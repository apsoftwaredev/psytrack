//
//  DemographicProfileEntity.m
//  PsyTrack Clinician Tools
//
//  Created by Daniel Boice on 3/15/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import "DemographicProfileEntity.h"
#import "ClientEntity.h"
#import "ClinicianEntity.h"
#import "PTTAppDelegate.h"

@implementation DemographicProfileEntity

@dynamic sex;
@dynamic sexualOrientation;
@dynamic profileNotes;
@dynamic order;
@dynamic militaryService;
@dynamic educationLevel;
@dynamic substancesUse;
@dynamic client;
@dynamic disabilities;
@dynamic spiritualBeliefs;
@dynamic immigrationHistory;
@dynamic clinician;
@dynamic interpersonal;
@dynamic gender;
@dynamic languagesSpoken;
@dynamic employmentStatus;
@dynamic cultureGroups;
@dynamic ethnicities;
@dynamic additionalVariables;
@dynamic developmental;
@dynamic significantLifeEvents;
@dynamic races;
@dynamic keyDate;

@synthesize tempProfileNotes;
@synthesize tempSex;

-(void)setProfileNotes:(NSString *)notes{
    
    [self setStringToPrimitiveData:(NSString *)notes forKey:@"profileNotes"];
    
    self.tempProfileNotes=notes;
}

-(void)setSex:(NSString *)sex{
    
    [self setStringToPrimitiveData:(NSString *)sex forKey:@"sex"];
    
    self.tempSex=sex;
}


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
-(NSString *)profileNotes{
    //
    
    NSString *tempStr;
    [self willAccessValueForKey:@"tempProfileNotes"];
    
    
    if (!self.tempProfileNotes ||!self.tempProfileNotes.length) {
        
        [self didAccessValueForKey:@"tempProfileNotes"];
        PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
        
        
        [self willAccessValueForKey:@"profileNotes"];
        
        
        NSData *primitiveData=[self primitiveValueForKey:@"profileNotes"];
        
        [self didAccessValueForKey:@"profileNotes"];
        
        [self willAccessValueForKey:@"keyDate"];
        NSDate *tmpKeyDate=self.keyDate;
        [self didAccessValueForKey:@"keyDate"];
        
        NSData *strData=[appDelegate decryptDataToPlainDataUsingKeyEntityWithDate:tmpKeyDate encryptedData:primitiveData];
        
        tempStr=[appDelegate convertDataToString:strData];
        
        [self willChangeValueForKey:@"tempProfileNotes"];
        
        self.tempProfileNotes=tempStr;
        [self didChangeValueForKey:@"tempProfileNotes"];
        
        
    }
    else 
    {
        tempStr=self.tempProfileNotes;
        [self didAccessValueForKey:@"tempProfileNotes"];
    }
    
    
    
    
    return tempStr;
    
    
}

-(NSString *)sex{
    //
    
    NSString *tempStr;
    [self willAccessValueForKey:@"tempSex"];
    
    
    if (!self.tempSex ||!self.tempSex.length) {
        
        [self didAccessValueForKey:@"tempSex"];
        PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
        
        
        [self willAccessValueForKey:@"sex"];
        
        
        NSData *primitiveData=[self primitiveValueForKey:@"sex"];
        
        [self didAccessValueForKey:@"sex"];
        
        [self willAccessValueForKey:@"keyDate"];
        NSDate *tmpKeyDate=self.keyDate;
        [self didAccessValueForKey:@"keyDate"];
        
        NSData *strData=[appDelegate decryptDataToPlainDataUsingKeyEntityWithDate:tmpKeyDate encryptedData:primitiveData];
        
        tempStr=[appDelegate convertDataToString:strData];
        
        [self willChangeValueForKey:@"tempSex"];
        
        self.tempSex=tempStr;
        [self didChangeValueForKey:@"tempSex"];
        
        
    }
    else 
    {
        tempStr=self.tempSex;
        [self didAccessValueForKey:@"tempSex"];
    }
    
    
    
    
    return tempStr;
    
    
}




@end
