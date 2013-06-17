//
//  DrugNameObjectSelectionCell.h
//  PsyTrack Clinician Tools
//  Version: 1.5.2
//
//  Created by Daniel Boice on 3/25/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DrugProductEntity.h"
@interface DrugNameObjectSelectionCell : SCObjectSelectionCell

@property (nonatomic, strong) DrugProductEntity *drugProduct;

- (void) doneButtonTappedInDetailView:(NSManagedObject *)selectedObject withValue:(BOOL)hasValue;
@end
