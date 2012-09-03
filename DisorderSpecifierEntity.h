//
//  DisorderSpecifierEntity.h
//  PsyTrack
//
//  Created by Daniel Boice on 9/3/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class DiagnosisHistoryEntity, DisorderEntity;

@interface DisorderSpecifierEntity : NSManagedObject

@property (nonatomic, retain) NSString * specifier;
@property (nonatomic, retain) NSNumber * order;
@property (nonatomic, retain) DisorderEntity *disorder;
@property (nonatomic, retain) NSSet *diagnosisHistory;
@end

@interface DisorderSpecifierEntity (CoreDataGeneratedAccessors)

- (void)addDiagnosisHistoryObject:(DiagnosisHistoryEntity *)value;
- (void)removeDiagnosisHistoryObject:(DiagnosisHistoryEntity *)value;
- (void)addDiagnosisHistory:(NSSet *)values;
- (void)removeDiagnosisHistory:(NSSet *)values;

@end
