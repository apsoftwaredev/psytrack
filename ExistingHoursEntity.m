//
//  ExistingHoursEntity.m
//  PsyTrack
//
//  Created by Daniel Boice on 4/4/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import "ExistingHoursEntity.h"
#import "PTTAppDelegate.h"

@implementation ExistingHoursEntity

@dynamic endDate;
@dynamic startDate;
@dynamic notes;
@dynamic keyDate;
@dynamic supportActivities;
@dynamic assessments;
@dynamic supervision;
@dynamic directInterventions;
@synthesize tempNotes;




- (void) awakeFromInsert 
{
    [super awakeFromInsert];
    
    //set the default date to the current date if it isn't already set to another date, assuming the client wasn't added on june 6, 2006 at 11:11:11 AM MST
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
    
    [dateFormatter setDateFormat:@"H:m:ss yyyy M d"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"MST"]];
    NSDate *referenceDate=[dateFormatter dateFromString:[NSString stringWithFormat:@"%i:%i:%i %i %i %i",11,11,11,2006,6,6]];
    //NSLog(@"reference date %@",referenceDate);
    
    NSTimeInterval thirtyDays=60*60*24*30;
    NSDate *currentDate=[NSDate date];
    
    
    [self willAccessValueForKey:@"startDate"];
    if ([(NSDate *)self.startDate isEqualToDate:referenceDate]) {
        [self didAccessValueForKey:@"startDate"];
        [self willChangeValueForKey:(NSString *)@"startDate"];
        self.startDate = [currentDate dateByAddingTimeInterval:-thirtyDays];
        [self didChangeValueForKey:(NSString *)@"startDate"];
    }

    [self willAccessValueForKey:@"endDate"];
    if ([(NSDate *)self.endDate isEqualToDate:referenceDate]) {
        [self didAccessValueForKey:@"endDate"];
        [self willChangeValueForKey:(NSString *)@"endDate"];
        self.endDate = currentDate;
        [self didChangeValueForKey:(NSString *)@"endDate"];
    }

}
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


@end
