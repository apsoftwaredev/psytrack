//
//  CountryEntity.h
//  PsyTrack Clinician Tools
//  Version: 1.5.5
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface CountryEntity : NSManagedObject

@property (nonatomic, retain) NSString *country;
@property (nonatomic, retain) NSString *code;
@property (nonatomic, retain) NSSet *governingBody;
@end

@interface CountryEntity (CoreDataGeneratedAccessors)

- (void) addGoverningBodyObject:(NSManagedObject *)value;
- (void) removeGoverningBodyObject:(NSManagedObject *)value;
- (void) addGoverningBody:(NSSet *)values;
- (void) removeGoverningBody:(NSSet *)values;

@end
