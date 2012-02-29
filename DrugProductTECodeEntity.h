//
//  DrugProductTECodeEntity.h
//  psyTrainTrack
//
//  Created by Daniel Boice on 12/31/11.
//  Copyright (c) 2011 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class DrugProductEntity;

@interface DrugProductTECodeEntity : NSManagedObject

@property (nonatomic, strong) NSString * applNo;
@property (nonatomic, strong) NSNumber * tESequence;
@property (nonatomic, strong) NSString * tECode;
@property (nonatomic, strong) NSString * productMktStatus;
@property (nonatomic, strong) NSString * productNo;
@property (nonatomic, strong) DrugProductEntity *product;

@end
