//
//  PublicationEntity.h
//  PsyTrack
//
//  Created by Daniel Boice on 9/17/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ClinicianEntity;

@interface PublicationEntity : NSManagedObject

@property (nonatomic, retain) NSString * short;
@property (nonatomic, retain) NSString * isbnDOI;
@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSDate * datePublished;
@property (nonatomic, retain) NSString * citeKey;
@property (nonatomic, retain) NSString * url;
@property (nonatomic, retain) NSString * edition;
@property (nonatomic, retain) NSString * chapter;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSString * series;
@property (nonatomic, retain) NSString * volume;
@property (nonatomic, retain) NSString * update;
@property (nonatomic, retain) NSString * howPublished;
@property (nonatomic, retain) NSString * lastChecked;
@property (nonatomic, retain) NSString * organization;
@property (nonatomic, retain) NSString * school;
@property (nonatomic, retain) NSNumber * order;
@property (nonatomic, retain) NSString * institution;
@property (nonatomic, retain) NSString * pageNumbers;
@property (nonatomic, retain) NSString * group;
@property (nonatomic, retain) NSString * publisher;
@property (nonatomic, retain) NSString * month;
@property (nonatomic, retain) NSString * keywords;
@property (nonatomic, retain) NSString * authors;
@property (nonatomic, retain) NSString * urlDate;
@property (nonatomic, retain) NSString * sortWord;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSString * publicationTitle;
@property (nonatomic, retain) NSString * volumeTitle;
@property (nonatomic, retain) ClinicianEntity *clinician;
@property (nonatomic, retain) NSManagedObject *publicationType;
@property (nonatomic, retain) NSManagedObject *expertTestemony;
@property (nonatomic, retain) NSSet *presentations;
@property (nonatomic, retain) NSManagedObject *teachingExperience;
@end

@interface PublicationEntity (CoreDataGeneratedAccessors)

- (void)addPresentationsObject:(NSManagedObject *)value;
- (void)removePresentationsObject:(NSManagedObject *)value;
- (void)addPresentations:(NSSet *)values;
- (void)removePresentations:(NSSet *)values;

@end
