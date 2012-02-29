//
//  DrugAppDocEntity.h
//  psyTrainTrack
//
//  Created by Daniel Boice on 12/31/11.
//  Copyright (c) 2011 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class DrugAppDocTypeLookupEntity, DrugRegActionDateEntity;

@interface DrugAppDocEntity : NSManagedObject

@property (nonatomic, strong) NSString * docUrl;
@property (nonatomic, strong) NSString * applNo;
@property (nonatomic, strong) NSDate * docDate;
@property (nonatomic, strong) NSString * seqNo;
@property (nonatomic, strong) NSNumber * appDocID;
@property (nonatomic, strong) NSString * actionType;
@property (nonatomic, strong) NSString * docTitle;
@property (nonatomic, strong) NSString * docType;
@property (nonatomic, strong) NSNumber * duplicateCounter;
@property (nonatomic, strong) DrugRegActionDateEntity *regAction;
@property (nonatomic, strong) DrugAppDocTypeLookupEntity *documentType;

@end
