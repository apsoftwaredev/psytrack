//
//  DisorderSpecifierEntity.h
//  PsyTrack
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "PTManagedObjectContext.h"
#import "PTManagedObject.h"



@class DiagnosisHistoryEntity, DisorderEntity;

@interface DisorderSpecifierEntity : PTManagedObject

@property (nonatomic, retain) NSNumber * order;
@property (nonatomic, retain) NSString * specifier;
@property (nonatomic, retain) NSSet *diagnosisHistory;
@property (nonatomic, retain) DisorderEntity *disorder;
@end

@interface DisorderSpecifierEntity (CoreDataGeneratedAccessors)

- (void)addDiagnosisHistoryObject:(DiagnosisHistoryEntity *)value;
- (void)removeDiagnosisHistoryObject:(DiagnosisHistoryEntity *)value;
- (void)addDiagnosisHistory:(NSSet *)values;
- (void)removeDiagnosisHistory:(NSSet *)values;

@end
