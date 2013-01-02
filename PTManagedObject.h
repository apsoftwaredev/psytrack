//
//  PTManagedObject.h
//  PsyTrack
//
//  Created by Daniel Boice on 1/1/13.
//  Copyright (c) 2013 PsycheWeb LLC. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface PTManagedObject : NSManagedObject


+(BOOL)deletesInvalidObjectsAfterFailedSave;


-(void)repairForError:(NSError *)error;
@end
