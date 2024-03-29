//
//  DisorderSpecifierEntity.h
//  PsyTrack Clinician Tools
//  Version: 1.5.4
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class DiagnosisHistoryEntity, DisorderEntity;

@interface DisorderSpecifierEntity : NSManagedObject

@property (nonatomic, retain) NSNumber *order;
@property (nonatomic, retain) NSString *specifier;
@property (nonatomic, retain) NSSet *diagnosisHistory;
@property (nonatomic, retain) DisorderEntity *disorder;
@end

@interface DisorderSpecifierEntity (CoreDataGeneratedAccessors)

- (void) addDiagnosisHistoryObject:(DiagnosisHistoryEntity *)value;
- (void) removeDiagnosisHistoryObject:(DiagnosisHistoryEntity *)value;
- (void) addDiagnosisHistory:(NSSet *)values;
- (void) removeDiagnosisHistory:(NSSet *)values;

@end
