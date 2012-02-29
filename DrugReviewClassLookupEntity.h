//
//  DrugReviewClassLookupEntity.h
//  psyTrainTrack
//
//  Created by Daniel Boice on 12/31/11.
//  Copyright (c) 2011 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class DrugApplicationEntity;

@interface DrugReviewClassLookupEntity : NSManagedObject

@property (nonatomic, strong) NSString * shortDesc;
@property (nonatomic, strong) NSString * reviewCode;
@property (nonatomic, strong) NSString * reviewClassID;
@property (nonatomic, strong) NSString * longDesc;
@property (nonatomic, strong) DrugApplicationEntity *appl;

@end
