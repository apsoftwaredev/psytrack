//
//  InstrumentPublisherEntity.h
//  PsyTrack Clinician Tools
//  Version: 1.5.5
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class BatteryEntity, InstrumentEntity;

@interface InstrumentPublisherEntity : NSManagedObject

@property (nonatomic, retain) NSNumber *order;
@property (nonatomic, retain) NSString *notes;
@property (nonatomic, retain) NSString *publisherName;
@property (nonatomic, retain) NSSet *instrument;
@property (nonatomic, retain) NSSet *battery;
@end

@interface InstrumentPublisherEntity (CoreDataGeneratedAccessors)

- (void) addInstrumentObject:(InstrumentEntity *)value;
- (void) removeInstrumentObject:(InstrumentEntity *)value;
- (void) addInstrument:(NSSet *)values;
- (void) removeInstrument:(NSSet *)values;

- (void) addBatteryObject:(BatteryEntity *)value;
- (void) removeBatteryObject:(BatteryEntity *)value;
- (void) addBattery:(NSSet *)values;
- (void) removeBattery:(NSSet *)values;

@end
