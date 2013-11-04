//
//  DrugProductEntity.h
//  PsyTrack Clinician Tools
//  Version: 1.5.4
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface DrugProductEntity : NSManagedObject

@property (nonatomic, retain) NSString *activeIngredient;
@property (nonatomic, retain) NSString *applNo;
@property (nonatomic, retain) NSString *dosage;
@property (nonatomic, retain) NSString *drugName;
@property (nonatomic, retain) NSString *form;
@property (nonatomic, retain) NSNumber *productMktStatus;
@property (nonatomic, retain) NSString *productNo;
@property (nonatomic, retain) NSString *referenceDrug;
@property (nonatomic, retain) NSString *tECode;

@end
