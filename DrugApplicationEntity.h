/*
 *  DrugApplicationEntity.h
 *  psyTrack Clinician Tools
 *  Version: 1.5.4
 *
 *
 The MIT License (MIT)
 Copyright © 2011- 2021 Daniel Boice
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 *
 *  Created by Daniel Boice on  12/31/11.
 *  Copyright (c) 2011 PsycheWeb LLC. All rights reserved.
 *
 *
 *	This notice may not be removed from this file.
 *
 */
#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class DrugChemicalTypeLookupEntity, DrugEntity, DrugProductEntity, DrugRegActionDateEntity, DrugReviewClassLookupEntity;

@interface DrugApplicationEntity : NSManagedObject

@property (nonatomic, strong) NSString *sponsorApplicant;
@property (nonatomic, strong) NSString *applType;
@property (nonatomic, strong) NSString *currentPatentFlag;
@property (nonatomic, strong) NSString *actionType;
@property (nonatomic, strong) NSString *orphan_Code;
@property (nonatomic, strong) NSString *applNo;
@property (nonatomic, strong) NSString *mostRecentLabelAvailableFlag;
@property (nonatomic, strong) NSString *ther_Potential;
@property (nonatomic, strong) NSNumber *chemical_Type;
@property (nonatomic, strong) DrugReviewClassLookupEntity *reviewClass;
@property (nonatomic, strong) NSSet *reglatoryActions;
@property (nonatomic, strong) DrugEntity *drugGroup;
@property (nonatomic, strong) NSSet *products;
@property (nonatomic, strong) DrugChemicalTypeLookupEntity *chemType;
@end

@interface DrugApplicationEntity (CoreDataGeneratedAccessors)

- (void) addReglatoryActionsObject:(DrugRegActionDateEntity *)value;
- (void) removeReglatoryActionsObject:(DrugRegActionDateEntity *)value;
- (void) addReglatoryActions:(NSSet *)values;
- (void) removeReglatoryActions:(NSSet *)values;

- (void) addProductsObject:(DrugProductEntity *)value;
- (void) removeProductsObject:(DrugProductEntity *)value;
- (void) addProducts:(NSSet *)values;
- (void) removeProducts:(NSSet *)values;

@end
