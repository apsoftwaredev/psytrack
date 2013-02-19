//
//  LanguageEntity.h
//  PsyTrack Clinician Tools
//  Version: 1.05
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "PTManagedObjectContext.h"
#import "PTManagedObject.h"




@interface LanguageEntity : PTManagedObject

@property (nonatomic, retain) NSString * language;
@property (nonatomic, retain) NSNumber * order;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSSet *languagesSpoken;
@end

@interface LanguageEntity (CoreDataGeneratedAccessors)

- (void)addLanguagesSpokenObject:(NSManagedObject *)value;
- (void)removeLanguagesSpokenObject:(NSManagedObject *)value;
- (void)addLanguagesSpoken:(NSSet *)values;
- (void)removeLanguagesSpoken:(NSSet *)values;

@end
