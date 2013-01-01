//
//  FeedbackTopicEntity.h
//  PsyTrack
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "PTManagedObjectContext.h"

@class SupervisionFeedbackEntity;

@interface FeedbackTopicEntity : NSManagedObject

@property (nonatomic, retain) NSString * topic;
@property (nonatomic, retain) NSNumber * order;
@property (nonatomic, retain) NSSet *supervisionFeedback;
@end

@interface FeedbackTopicEntity (CoreDataGeneratedAccessors)

- (void)addSupervisionFeedbackObject:(SupervisionFeedbackEntity *)value;
- (void)removeSupervisionFeedbackObject:(SupervisionFeedbackEntity *)value;
- (void)addSupervisionFeedback:(NSSet *)values;
- (void)removeSupervisionFeedback:(NSSet *)values;

@end
