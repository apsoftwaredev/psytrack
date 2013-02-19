//
//  SiteSettingTypeEntity.h
//  PsyTrack Clinician Tools
//  Version: 1.05
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "PTManagedObjectContext.h"
#import "PTManagedObject.h"



@class GrantEntity, SiteEntity;

@interface SiteSettingTypeEntity : PTManagedObject

@property (nonatomic, retain) NSNumber * order;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSString * settingTypeName;
@property (nonatomic, retain) NSSet *site;
@property (nonatomic, retain) NSSet *grants;
@end

@interface SiteSettingTypeEntity (CoreDataGeneratedAccessors)

- (void)addSiteObject:(SiteEntity *)value;
- (void)removeSiteObject:(SiteEntity *)value;
- (void)addSite:(NSSet *)values;
- (void)removeSite:(NSSet *)values;

- (void)addGrantsObject:(GrantEntity *)value;
- (void)removeGrantsObject:(GrantEntity *)value;
- (void)addGrants:(NSSet *)values;
- (void)removeGrants:(NSSet *)values;

@end
