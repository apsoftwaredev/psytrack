//
//  ClientEntity.m
//  PsyTrack
//
//  Created by Daniel Boice on 6/7/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import "ClientEntity.h"
#import "DemographicProfileEntity.h"
#import "LogEntity.h"
#import "MedicationEntity.h"
#import "PhoneEntity.h"
#import "ReferralEntity.h"
#import "VitalsEntity.h"
#import "PTTAppDelegate.h"
#import "ClientGroupEntity.h"

@implementation ClientEntity

@dynamic clientIDCode;
@dynamic initials;
@dynamic dateOfBirth;
@dynamic keyString;
@dynamic fData;
@dynamic notes;
@dynamic order;
@dynamic dateAdded;
@dynamic currentClient;
@dynamic medicationHistory;
@dynamic diagnoses;
@dynamic vitals;
@dynamic accomodations;
@dynamic demographicInfo;
@dynamic logs;
@dynamic phoneNumbers;
@dynamic supervisonFeedback;
@dynamic clientPresentations;
@dynamic referrals;
@dynamic groups;
@dynamic substancesUse;

@synthesize tempClientIDCode;
@synthesize tempInitials;
@synthesize tempDateOfBirth;
@synthesize tempNotes;






- (void) awakeFromInsert 
{
    [super awakeFromInsert];
    
    //set the default date to the current date if it isn't already set to another date, assuming the client wasn't added on june 6, 2006 at 11:11:11 AM MST
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
    
    [dateFormatter setDateFormat:@"H:m:ss yyyy M d"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"MST"]];
    NSDate *referenceDate=[dateFormatter dateFromString:[NSString stringWithFormat:@"%i:%i:%i %i %i %i",11,11,11,2006,6,6]];
    
    [self willAccessValueForKey:@"dateAdded"];
    if ([(NSDate *)self.dateAdded isEqualToDate:referenceDate]) {
        [self didAccessValueForKey:@"dateAdded"];
        [self willChangeValueForKey:(NSString *)@"dateAdded"];
        self.dateAdded = [NSDate date];
        [self didChangeValueForKey:(NSString *)@"dateAdded"];
    }
    
    
    NSManagedObjectContext * managedObjectContext = [(PTTAppDelegate *)[UIApplication sharedApplication].delegate managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
NSEntityDescription *entity = [NSEntityDescription entityForName:@"ClientGroupEntity" inManagedObjectContext:managedObjectContext];
[fetchRequest setEntity:entity];

NSPredicate *predicate = [NSPredicate predicateWithFormat:@"addNewClients == %@", [NSNumber numberWithBool:YES]];
[fetchRequest setPredicate:predicate];

NSError *error = nil;
NSArray *fetchedObjects = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
if (fetchedObjects) {
    [self willAccessValueForKey:@"groups"];
    NSMutableSet *groupsMutableSet=(NSMutableSet *)[self mutableSetValueForKey:@"groups"];
    [self didAccessValueForKey:@"groups"];
    
    for (ClientGroupEntity *clientGroup in fetchedObjects) {
        [self willChangeValueForKey:@"groups"];
        [groupsMutableSet addObject:clientGroup];
        [self didChangeValueForKey:@"groups"];
        
        
    }
    fetchRequest=nil;
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

//-(void)awakeFromFetch{
//
//    PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
//    
//    NSData *unencryptedData=[appDelegate decryptDataToPlainDataUsingKeyEntityWithDate:self.keyDate encryptedData:self.fData];
//
//    
//    NSDictionary *dictionaryFromDecryptedData=[NSKeyedUnarchiver unarchiveObjectWithData:unencryptedData];
//    
//    if (dictionaryFromDecryptedData) {
//        
//        id obj = [dictionaryFromDecryptedData objectForKey:@"clientIDCode"];
//        
//        if (obj) {
//        
//            self.clientIDCode=[dictionaryFromDecryptedData valueForKey:@"clientIDCode"];
//            
//        }
//        obj=nil;
//        
//        obj = [dictionaryFromDecryptedData objectForKey:@"dateOfBirth"];
//        
//        if (obj) {
//            
//            self.dateOfBirth=[dictionaryFromDecryptedData valueForKey:@"dateOfBirth"];
//            
//        }
//        
//        obj = [dictionaryFromDecryptedData objectForKey:@"initials"];
//        
//        if (obj) {
//            
//            self.dateOfBirth=[dictionaryFromDecryptedData valueForKey:@"initials"];
//            
//        }
//        
//        obj=nil;
//        
//        if (obj) {
//            
//            self.notes=[dictionaryFromDecryptedData valueForKey:@"notes"];
//            
//        }
//        
//    }
//        //                    
//        
//        
//
//
//
//}

-(void)rekeyEncryptedAttributes{
     
    NSDate *dateOfBirthDt=nil;
    NSString *notesStr=nil;
    
    NSString *clientIDCodeStr=nil;
    NSString *initialsStr=nil;
    
    [self willAccessValueForKey:@"notes"];
    if (self.notes) {
         notesStr=[NSString stringWithString:self.notes];
    }
      [self didAccessValueForKey:@"notes"];
    
    [self willAccessValueForKey:@"clientIDCode"];
    if (self.clientIDCode) {
         clientIDCodeStr=[NSString stringWithString:self.clientIDCode];
    }
   
    [self didAccessValueForKey:@"clientIDCode"];

    
    [self willAccessValueForKey:@"initials"];
   
    if (self.initials){
        initialsStr=[NSString stringWithString:self.initials];
    }
    
    [self didAccessValueForKey:@"initials"];
    
    [self willAccessValueForKey:@"dateOfBirth"];
    if (self.dateOfBirth) {
        
        dateOfBirthDt=self.dateOfBirth;
    }
    [self didAccessValueForKey:@"dateOfBirth"];
    
    
    if (dateOfBirthDt) {
        [self setDateToPrimitiveData:(NSDate *)dateOfBirthDt  forKey:(NSString *)@"dateOfBirth" keyString:nil];
    }
   
    
    
   
    if (notesStr) {
        [self setNotes:notesStr];
    }
  
    
   
        if (clientIDCodeStr) {
            
            [self setClientIDCode:clientIDCodeStr];
        }
      
    
    if (initialsStr) {
        [self setInitials:initialsStr];

    }

    
   
    
    
}


-(void)setInitials:(NSString *)initials{
    
    [self willAccessValueForKey:@"keyString"];
    [self setStringToPrimitiveData:(NSString *)initials forKey:@"initials" keyString:self.keyString];
    [self  didAccessValueForKey:@"keyString"];
    self.tempInitials=initials;
    
}
-(void)setNotes:(NSString *)notes{
    
     [self willAccessValueForKey:@"keyString"];
    [self setStringToPrimitiveData:(NSString *)notes forKey:@"notes" keyString:self.keyString];
     [self  didAccessValueForKey:@"keyString"];
    self.tempNotes=notes;
}

- (void)setClientIDCode:(NSString *)clientIDCode
{
    
     [self willAccessValueForKey:@"keyString"];
    [self setStringToPrimitiveData:(NSString *)clientIDCode forKey:@"clientIDCode" keyString:self.keyString];
     [self  didAccessValueForKey:@"keyString"];
    self.tempClientIDCode=clientIDCode;
    
    
    
    
    
} 

-(void)setDateOfBirth:(NSDate *)dateOfBirth{
     [self willAccessValueForKey:@"keyString"];
    [self setDateToPrimitiveData:(NSDate *)dateOfBirth forKey:(NSString *)@"dateOfBirth" keyString:self.keyString];
    [self  didAccessValueForKey:@"keyString"];
    self.tempDateOfBirth=dateOfBirth;
    
}
//-(void){
//
//    NSString *clientIDCodeStr=self.clientIDCode;
//    NSDate *dateOfBirthDate=self.dateOfBirth;
//    NSString *initialsStr=self.initials;
//    NSString *notesStr=self.notes;
//    
//    if (!clientIDCodeStr.length) {
//        clientIDCodeStr=[NSString string];
//    }
//    if (!dateOfBirthDate) {
//        dateOfBirthDate=[NSDate date];
//    }
//    
//    if (!initialsStr.length) {
//        initialsStr=[NSString string];
//    }
//    
//    if (!notesStr.length) {
//        notesStr=[NSString string];
//    }
//    
//    NSDictionary *fDataDictionary=[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:clientIDCodeStr,dateOfBirthDate,notesStr,initialsStr, nil] forKeys:[NSArray arrayWithObjects:@"clientIDCode",@"dateOfBirth", @"notes",@"initials", nil]];
//    
//     PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
//    NSData * keyedArchiveData = [NSKeyedArchiver archivedDataWithRootObject:fDataDictionary];
//
//   NSDictionary *encryptedDataDic= [appDelegate encryptDataToEncryptedData:keyedArchiveData withKeyDate:self.keyDate];
//    
//    NSDate *keyDate=[encryptedDataDic valueForKey:@"keyDate"];
//    
//    NSData *encryptedData=[encryptedDataDic valueForKey:@"encryptedData"];
//    if (encryptedData.length) {
//        [self willAccessValueForKey:@"fData"];
//        [self setPrimitiveValue:encryptedData forKey:@"fData"];
//        [self didAccessValueForKey:@"fData"];
//    }
//    self.keyDate=keyDate;
//    
//    self.clientIDCode=nil;
//    self.dateOfBirth=nil;
//    self.notes=nil;
//    self.initials=nil;
//    
//    
//    
//    
////    if (encryptedKeyDate) {
////    [self willChangeValueForKey:@"keyDate"]; 
////    
////    
////    [self setPrimitiveValue:encryptedKeyDate forKey:@"keyDate"];
////    
////    [self didChangeValueForKey:@"keyDate"];
////    
////    
////}
//
//
//}


- (void)setStringToPrimitiveData:(NSString *)strValue forKey:(NSString *)key keyString:(NSString *)keyStringToSet
{
    
    PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
    
    if (strValue&& strValue.length) {
        
        
        
        
        [self willAccessValueForKey:@"keyString"];
        NSDictionary *encryptedDataDictionary=[appDelegate encryptStringToEncryptedData:(NSString *)strValue withKeyString:keyStringToSet];
        
        NSData *encryptedData=nil;
        NSString *encryptedKeyString=nil;
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



-(NSString *)initials{
    
    NSString *tempStr;
    [self willAccessValueForKey:@"tempInitials"];
    
    
    if (!self.tempInitials ||!self.tempInitials.length) {
        
        [self didAccessValueForKey:@"tempInitials"];
        PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
        
        
        [self willAccessValueForKey:@"initials"];
        
        
        NSData *primitiveData=[self primitiveValueForKey:@"initials"];
        [self didAccessValueForKey:@"initials"];
        
        if (!primitiveData ||!primitiveData.length) {
            return nil;
        }
        
        [self willAccessValueForKey:@"keyString"];
        NSString *tmpKeyString=self.keyString;
        [self didAccessValueForKey:@"keyString"];
        
        NSData *strData=[appDelegate decryptDataToPlainDataUsingKeyEntityWithString:tmpKeyString encryptedData:primitiveData];
        
        tempStr=[appDelegate convertDataToString:strData];
        
        [self willChangeValueForKey:@"tempInitials"];
        
        self.tempInitials=tempStr;
        [self didChangeValueForKey:@"tempInitials"];
        
        
    }
    else 
    {
        tempStr=self.tempInitials;
        [self didAccessValueForKey:@"tempInitials"];
    }
    
    
    
    
    return tempStr;
    
    
    
    
    
    
}
-(NSString *)clientIDCode{
    //
    
    NSString *tempStr;
    [self willAccessValueForKey:@"tempClientIDCode"];
    
    
    if (!self.tempClientIDCode ||!self.tempClientIDCode.length) {
        
        [self didAccessValueForKey:@"tempClientIDCode"];
        PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
        
        
        [self willAccessValueForKey:@"clientIDCode"];
        
        
        NSData *primitiveData=[self primitiveValueForKey:@"clientIDCode"];
        
        
        if (!primitiveData ||!primitiveData.length) {
            return nil;
        }
        [self didAccessValueForKey:@"clientIDCode"];
        
        [self willAccessValueForKey:@"keyString"];
        NSString *tmpKeyString=self.keyString;
        [self didAccessValueForKey:@"keyString"];
        if(tmpKeyString && tmpKeyString.length){
            NSData *strData=[appDelegate decryptDataToPlainDataUsingKeyEntityWithString:tmpKeyString encryptedData:primitiveData];
            
            

            tempStr=[appDelegate convertDataToString:strData];
            
            
            [self willChangeValueForKey:@"tempClientIDCode"];
            
            self.tempClientIDCode=tempStr;
            [self didChangeValueForKey:@"tempClientIDCode"];
        }
        
    }
    else 
    {
        tempStr=self.tempClientIDCode;
        [self didAccessValueForKey:@"tempClientIDCode"];
    }
    
    
    
    
    return tempStr;
    
    
}





-(NSDate *)dateOfBirth{
    
    NSDate *newDate;
    [self willAccessValueForKey:@"tempDateOfBirth"];
    
    
    if (!self.tempDateOfBirth) {
        
        [self didAccessValueForKey:@"tempDateOfBirth"];
        PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
        
        
        [self willAccessValueForKey:@"dateOfBirth"];
        
        
        NSData *primitiveData=[self primitiveValueForKey:@"dateOfBirth"];
        
        [self didAccessValueForKey:@"dateOfBirth"];
        if (!primitiveData ||!primitiveData.length) {
            return nil;
        }
        [self willAccessValueForKey:@"keyString"];
        NSString *tmpKeyString=self.keyString;
        [self didAccessValueForKey:@"keyString"];
        
        NSData *dateData=[appDelegate decryptDataToPlainDataUsingKeyEntityWithString:tmpKeyString encryptedData:primitiveData];
        
        
        newDate=[appDelegate convertDataToDate:dateData];
        
        [self willChangeValueForKey:@"tempDateOfBirth"];
        
        self.tempDateOfBirth=newDate;
        [self didChangeValueForKey:@"tempDateOfBirth"];
        
        
    }
    else 
    {
        newDate=self.tempDateOfBirth;
        [self didAccessValueForKey:@"tempDateOfBirth"];
    }
    
    
    
    
    
    
    
    return newDate;
    
    
}
- (void)setDateToPrimitiveData:(NSDate *)dateToConvert forKey:(NSString *)key keyString:(NSString *)keyStringToSet
{
    
    PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
    
    if (appDelegate.okayToDecryptBool && dateToConvert) {
        
        
        
        
        
        NSData * dateData = [NSKeyedArchiver archivedDataWithRootObject:dateToConvert];
        
        
        NSDictionary *encryptedDataDictionary=[appDelegate encryptDataToEncryptedData:dateData withKeyString:keyStringToSet];
        
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
        
        
        [self willAccessValueForKey:self.keyString];
        if (![encryptedKeyString isEqualToString:self.keyString]) {
            [self didAccessValueForKey:@"keyString"];
            [self willChangeValueForKey:@"keyString"];
            [self setPrimitiveValue:encryptedKeyString forKey:@"keyString"];
            [self didChangeValueForKey:@"keyString"];
            
        }
        
        
        
        
        
        
    }
}
@end
