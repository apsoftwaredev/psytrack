//
//  DisorderEntity.m
//  PsyTrack
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import "DisorderEntity.h"
#import "AdditionalSymptomNameEntity.h"
#import "DiagnosisHistoryEntity.h"
#import "DisorderSpecifierEntity.h"
#import "DisorderSubCategoryEntity.h"
#import "DisorderSystemEntity.h"


@implementation DisorderEntity

@dynamic order;
@dynamic code;
@dynamic notes;
@dynamic disorderName;
@dynamic desc;
@dynamic category;
@dynamic classificationSystem;
@dynamic symptoms;
@dynamic diagnoses;
@dynamic specifiers;
@dynamic subCategory;


-(BOOL)validateValue:(__autoreleasing id *)value forKey:(NSString *)key error:(NSError *__autoreleasing *)error
{
    if ( ![self.managedObjectContext isKindOfClass:[PTManagedObjectContext class]] ) {
        return YES;
    }
    else {
        return [super validateValue:value forKey:key error:error];
    }
}

@end
