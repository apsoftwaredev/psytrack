//
//  SiteEntity.m
//  PsyTrack
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import "SiteEntity.h"
#import "ClinicianEntity.h"
#import "ExistingHoursEntity.h"
#import "TimeTrackEntity.h"


@implementation SiteEntity

@dynamic siteName;
@dynamic location;
@dynamic order;
@dynamic notes;
@dynamic started;
@dynamic ended;
@dynamic defaultSite;
@dynamic settingType;
@dynamic supervisor;
@dynamic timeTracks;
@dynamic existingHours;

@end
