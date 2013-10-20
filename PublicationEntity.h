//
//  PublicationEntity.h
//  PsyTrack Clinician Tools
//  Version: 1.5.3
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "PTManagedObjectContext.h"
#import "PTManagedObject.h"

@class ClinicianEntity, ExpertTestemonyEntity, PresentationEntity, PublicationTypeEntity;

@interface PublicationEntity : PTManagedObject

@property (nonatomic, retain) NSString *shortT;
@property (nonatomic, retain) NSString *isbnDOI;
@property (nonatomic, retain) NSString *address;
@property (nonatomic, retain) NSDate *datePublished;
@property (nonatomic, retain) NSString *citeKey;
@property (nonatomic, retain) NSString *url;
@property (nonatomic, retain) NSString *edition;
@property (nonatomic, retain) NSString *chapter;
@property (nonatomic, retain) NSString *type;
@property (nonatomic, retain) NSString *series;
@property (nonatomic, retain) NSString *volume;
@property (nonatomic, retain) NSString *update;
@property (nonatomic, retain) NSString *howPublished;
@property (nonatomic, retain) NSString *lastChecked;
@property (nonatomic, retain) NSString *organization;
@property (nonatomic, retain) NSString *school;
@property (nonatomic, retain) NSNumber *order;
@property (nonatomic, retain) NSString *institution;
@property (nonatomic, retain) NSString *pageNumbers;
@property (nonatomic, retain) NSString *group;
@property (nonatomic, retain) NSString *publisher;
@property (nonatomic, retain) NSString *month;
@property (nonatomic, retain) NSString *keywords;
@property (nonatomic, retain) NSString *authors;
@property (nonatomic, retain) NSString *urlDate;
@property (nonatomic, retain) NSString *sortWord;
@property (nonatomic, retain) NSString *bibtex;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *publicationTitle;
@property (nonatomic, retain) NSString *notes;
@property (nonatomic, retain) NSString *volumeTitle;
@property (nonatomic, retain) NSSet *subject;
@property (nonatomic, retain) ClinicianEntity *clinician;
@property (nonatomic, retain) PublicationTypeEntity *publicationType;
@property (nonatomic, retain) ExpertTestemonyEntity *expertTestemony;
@property (nonatomic, retain) NSSet *presentations;
@property (nonatomic, retain) NSManagedObject *teachingExperience;
@end

@interface PublicationEntity (CoreDataGeneratedAccessors)

- (void) addSubjectObject:(NSManagedObject *)value;
- (void) removeSubjectObject:(NSManagedObject *)value;
- (void) addSubject:(NSSet *)values;
- (void) removeSubject:(NSSet *)values;

- (void) addPresentationsObject:(PresentationEntity *)value;
- (void) removePresentationsObject:(PresentationEntity *)value;
- (void) addPresentations:(NSSet *)values;
- (void) removePresentations:(NSSet *)values;

@end
