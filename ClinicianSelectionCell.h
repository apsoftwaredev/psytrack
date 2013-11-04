//
//  ClinicianSelectionCell.h
//  PsyTrack Clinician Tools
//  Version: 1.5.4
//
//  Created by Daniel Boice on 3/27/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//
#import <UIKit/UIKit.h>

#import "ClinicianEntity.h"

@interface ClinicianSelectionCell : SCObjectSelectionCell {
    ClinicianEntity *clinicianObject_;
    BOOL hasChangedClinicians_;
    BOOL usePrescriber;
    BOOL multiSelect;
    NSMutableArray *cliniciansArray_;
}

@property (nonatomic,strong) NSMutableArray *cliniciansArray;
@property (nonatomic,strong)  ClinicianEntity *clinicianObject;
@property (nonatomic, readwrite)  BOOL hasChangedClinicians;
- (void) doneButtonTappedInDetailView:(NSManagedObject *)selectedObject selectedItems:(NSArray *)selectedItems withValue:(BOOL)hasValue;

@end
