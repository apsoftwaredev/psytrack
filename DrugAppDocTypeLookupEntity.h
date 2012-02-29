//
//  DrugAppDocTypeLookupEntity.h
//  psyTrainTrack
//
//  Created by Daniel Boice on 12/31/11.
//  Copyright (c) 2011 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class DrugAppDocEntity;

@interface DrugAppDocTypeLookupEntity : NSManagedObject

@property (nonatomic, strong) NSString * appDocType;
@property (nonatomic, strong) NSNumber * sortOrder;
@property (nonatomic, strong) NSSet *applicationDocuments;
@end

@interface DrugAppDocTypeLookupEntity (CoreDataGeneratedAccessors)

- (void)addApplicationDocumentsObject:(DrugAppDocEntity *)value;
- (void)removeApplicationDocumentsObject:(DrugAppDocEntity *)value;
- (void)addApplicationDocuments:(NSSet *)values;
- (void)removeApplicationDocuments:(NSSet *)values;

@end
