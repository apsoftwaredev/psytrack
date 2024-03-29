//
//  PTManagedObject.h
//  PsyTrack Clinician Tools
//  Version: 1.5.3
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface PTManagedObject : NSManagedObject

+ (BOOL) deletesInvalidObjectsAfterFailedSave;

- (void) repairForError:(NSError *)error;
@end
