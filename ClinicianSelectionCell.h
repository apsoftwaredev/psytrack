//
//  ClinicianSelectionCell.h
//  PsyTrack
//
//  Created by Daniel Boice on 3/27/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import "SCTableViewCell.h"
#import "ClinicianEntity.h"
@interface ClinicianSelectionCell : SCObjectSelectionCell{

    ClinicianEntity *clinicianObject_;
    BOOL hasChangedClinicians_;

}


@property (nonatomic,strong)  ClinicianEntity *clinicianObject;
@property (nonatomic, readwrite)  BOOL hasChangedClinicians;
-(void)doneButtonTappedInDetailView:(NSObject *)selectedObject  withValue:(BOOL)hasValue;

@end
